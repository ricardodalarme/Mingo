// What the mascot may read to answer well. Every loader runs as the caller, so the database permissions decide what is
// readable: nothing the partner keeps private can come back, and an annoyance, a Tempero row or a repair draft is never
// asked for. A loader runs only when the request names it; a journal entry only when the request lists its id.
/** Runs a GraphQL query as the caller, so the caller's permissions apply. */
export type CallerQuery = (query: string, variables?: Record<string, unknown>) => Promise<any>;

export const CONTEXT_FLAGS = ['slips', 'mood', 'week', 'dates', 'lists', 'logistics', 'rituals', 'plan'] as const;
export type ContextFlag = (typeof CONTEXT_FLAGS)[number];

const UUID = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
const clip = (value: unknown, max = 140) => String(value ?? '').replace(/\s+/g, ' ').trim().slice(0, max);

type Loader = { query: string; lines: (data: any) => string[] };

const LOADERS: Record<ContextFlag, Loader> = {
  slips: {
    query: `{ slips(order_by: { createdAt: desc }, limit: 8) { body } cards(where: { status: { _eq: sent } }, order_by: { sentAt: desc }, limit: 2) { items { body } } }`,
    lines: (d) => [
      ...d.slips.map((s: any) => `slip: ${clip(s.body)}`),
      ...d.cards.flatMap((c: any) => c.items.map((i: any) => `card item: ${clip(i.body)}`)),
    ],
  },
  mood: {
    query: `{ moods(order_by: { day: desc }, limit: 7) { day mood } temperatureChecks(order_by: { createdAt: desc }, limit: 3) { level createdAt } }`,
    lines: (d) => [
      ...d.moods.map((m: any) => `mood ${m.day}: ${m.mood}`),
      ...d.temperatureChecks.map((t: any) => `temperature ${clip(t.createdAt, 10)}: ${t.level}`),
    ],
  },
  week: {
    query: `{ weeklyReview(args: {}) { slips activeDays streakDays moodsLogged ritualsDone cardsSent cardsReceived lowData missing } }`,
    lines: (d) => d.weeklyReview.map((w: any) => `this week: ${w.slips} slips, ${w.activeDays} active days, ${w.moodsLogged} moods, ${w.ritualsDone} rituals, ${w.cardsSent} cards sent, ${w.cardsReceived} received${w.lowData ? ', little data' : ''}`),
  },
  dates: {
    query: `{ importantDates(where: { hidden: { _eq: false } }, limit: 10) { title month day } }`,
    lines: (d) => d.importantDates.map((x: any) => `date: ${clip(x.title, 80)} (${x.day}/${x.month})`),
  },
  lists: {
    query: `{ lists(limit: 5) { title items(limit: 6) { title status } } }`,
    lines: (d) => d.lists.map((l: any) => `list ${clip(l.title, 60)}: ${l.items.map((i: any) => clip(i.title, 40)).join(', ')}`),
  },
  logistics: {
    query: `{ logisticItems(where: { doneAt: { _is_null: true } }, limit: 10) { title dueOn } }`,
    lines: (d) => d.logisticItems.map((x: any) => `task: ${clip(x.title, 80)}${x.dueOn ? ` (due ${x.dueOn})` : ''}`),
  },
  rituals: {
    query: `{ rituals(where: { archivedAt: { _is_null: true } }, limit: 8) { title cadence } }`,
    lines: (d) => d.rituals.map((r: any) => `ritual: ${clip(r.title, 60)} (${r.cadence})`),
  },
  plan: {
    query: `{ plusStates { hasPlus chatMessagesLeftToday chatMessagesLimit } }`,
    lines: (d) => d.plusStates.map((p: any) => `plan: ${p.hasPlus ? 'Plus' : 'Free'}, ${p.chatMessagesLeftToday} of ${p.chatMessagesLimit} chat messages left today`),
  },
};

export type Context = { text: string; pronouns: string | null; partnerPronouns: string | null; partnerName: string | null };

/** The pronouns the person and their partner use, as the person stated them; never guessed. */
async function loadPronouns(asCaller: CallerQuery): Promise<Omit<Context, 'text'>> {
  const data = await asCaller(`{ userSettings { userId partnerPronouns partnerName } profiles { id pronouns } }`);
  const settings = data.userSettings[0];
  const own = data.profiles.find((p: any) => p.id === settings?.userId);
  const partner = data.profiles.find((p: any) => p.id !== settings?.userId);
  return {
    pronouns: own?.pronouns ?? null,
    partnerPronouns: settings?.partnerPronouns ?? partner?.pronouns ?? null,
    partnerName: settings?.partnerName ? clip(settings.partnerName, 40) : null,
  };
}

/**
 * Loads the pronouns always and the named blocks on request. A block that fails is left out, so the chat still answers.
 * [journalEntryIds] are read only when the caller owns them, which the database enforces.
 */
export async function loadContext(asCaller: CallerQuery, flags: unknown, journalEntryIds: unknown = []): Promise<Context> {
  const wanted = (Array.isArray(flags) ? flags : []).filter((f): f is ContextFlag => CONTEXT_FLAGS.includes(f));
  const lines: string[] = [];
  const base = await loadPronouns(asCaller).catch(() => ({ pronouns: null, partnerPronouns: null, partnerName: null }));
  await Promise.all(
    [...new Set(wanted)].map(async (flag) => {
      try {
        lines.push(...LOADERS[flag].lines(await asCaller(LOADERS[flag].query)));
      } catch {
        /* left out */
      }
    }),
  );
  const ids = (Array.isArray(journalEntryIds) ? journalEntryIds : []).filter((id) => typeof id === 'string' && UUID.test(id)).slice(0, 3);
  if (ids.length) {
    try {
      const data = await asCaller(`query ($ids: [uuid!]!) { journalEntries(where: { id: { _in: $ids } }) { entryDate body } }`, { ids });
      lines.push(...data.journalEntries.map((e: any) => `diary ${e.entryDate} (shared by the person for this chat): ${clip(e.body, 600)}`));
    } catch {
      /* left out */
    }
  }
  return { ...base, text: lines.join('\n') };
}
