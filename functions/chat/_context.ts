// What the mascot may read to answer well. Every loader runs as the caller, so the database permissions decide what is
// readable: nothing the partner keeps private can come back, and an annoyance, a Spice row or a repair draft is never
// asked for. A loader runs only when the request names it; a journal entry only when the request lists its id.
import { type CallerQuery, type Operation, operation } from '../_lib/graphql.ts';

export const CONTEXT_FLAGS = ['slips', 'mood', 'week', 'dates', 'lists', 'logistics', 'rituals', 'plan'] as const;
export type ContextFlag = (typeof CONTEXT_FLAGS)[number];

export const isContextFlag = (value: unknown): value is ContextFlag => CONTEXT_FLAGS.some((flag) => flag === value);

/** The most characters of each kind of text that reaches the prompt. */
const CLIP = { default: 140, diary: 600, date: 80, task: 80, title: 60, item: 40, name: 40, day: 10 } as const;

const clip = (value: unknown, max: number = CLIP.default) =>
  String(value ?? '')
    .replace(/\s+/g, ' ')
    .trim()
    .slice(0, max);

type Loader = (caller: CallerQuery) => Promise<string[]>;

const loader =
  <Data>(query: Operation<Data>, lines: (data: Data) => string[]): Loader =>
  async (caller) =>
    lines(await caller(query));

const LOADERS: Record<ContextFlag, Loader> = {
  slips: loader(
    operation<{ slips: { body: string }[]; cards: { items: { body: string }[] }[] }>(
      `{ slips(order_by: { createdAt: desc }, limit: 8) { body } cards(where: { status: { _eq: sent } }, order_by: { sentAt: desc }, limit: 2) { items { body } } }`,
    ),
    (data) => [
      ...data.slips.map((slip) => `slip: ${clip(slip.body)}`),
      ...data.cards.flatMap((card) => card.items.map((item) => `card item: ${clip(item.body)}`)),
    ],
  ),
  mood: loader(
    operation<{
      moods: { day: string; mood: string }[];
      temperatureChecks: { level: string | number; createdAt: string }[];
    }>(
      `{ moods(order_by: { day: desc }, limit: 7) { day mood } temperatureChecks(order_by: { createdAt: desc }, limit: 3) { level createdAt } }`,
    ),
    (data) => [
      ...data.moods.map((entry) => `mood ${entry.day}: ${entry.mood}`),
      ...data.temperatureChecks.map((check) => `temperature ${clip(check.createdAt, CLIP.day)}: ${check.level}`),
    ],
  ),
  week: loader(
    operation<{
      weeklyReview: {
        slips: number;
        activeDays: number;
        moodsLogged: number;
        ritualsDone: number;
        cardsSent: number;
        cardsReceived: number;
        lowData: boolean;
      }[];
    }>(
      `{ weeklyReview(args: {}) { slips activeDays streakDays moodsLogged ritualsDone cardsSent cardsReceived lowData missing } }`,
    ),
    (data) =>
      data.weeklyReview.map(
        (week) =>
          `this week: ${week.slips} slips, ${week.activeDays} active days, ${week.moodsLogged} moods, ${week.ritualsDone} rituals, ${week.cardsSent} cards sent, ${week.cardsReceived} received${week.lowData ? ', little data' : ''}`,
      ),
  ),
  dates: loader(
    operation<{ importantDates: { title: string; month: number; day: number }[] }>(
      `{ importantDates(where: { hidden: { _eq: false } }, limit: 10) { title month day } }`,
    ),
    (data) => data.importantDates.map((date) => `date: ${clip(date.title, CLIP.date)} (${date.day}/${date.month})`),
  ),
  lists: loader(
    operation<{ lists: { title: string; items: { title: string; status: string }[] }[] }>(
      `{ lists(limit: 5) { title items(limit: 6) { title status } } }`,
    ),
    (data) =>
      data.lists.map(
        (list) =>
          `list ${clip(list.title, CLIP.title)}: ${list.items.map((item) => clip(item.title, CLIP.item)).join(', ')}`,
      ),
  ),
  logistics: loader(
    operation<{ logisticItems: { title: string; dueOn: string | null }[] }>(
      `{ logisticItems(where: { doneAt: { _is_null: true } }, limit: 10) { title dueOn } }`,
    ),
    (data) =>
      data.logisticItems.map(
        (task) => `task: ${clip(task.title, CLIP.task)}${task.dueOn ? ` (due ${task.dueOn})` : ''}`,
      ),
  ),
  rituals: loader(
    operation<{ rituals: { title: string; cadence: string }[] }>(
      `{ rituals(where: { archivedAt: { _is_null: true } }, limit: 8) { title cadence } }`,
    ),
    (data) => data.rituals.map((ritual) => `ritual: ${clip(ritual.title, CLIP.title)} (${ritual.cadence})`),
  ),
  plan: loader(
    operation<{ plusStates: { hasPlus: boolean; chatMessagesLeftToday: number; chatMessagesLimit: number }[] }>(
      `{ plusStates { hasPlus chatMessagesLeftToday chatMessagesLimit } }`,
    ),
    (data) =>
      data.plusStates.map(
        (plan) =>
          `plan: ${plan.hasPlus ? 'Plus' : 'Free'}, ${plan.chatMessagesLeftToday} of ${plan.chatMessagesLimit} chat messages left today`,
      ),
  ),
};

const PRONOUNS = operation<{
  userSettings: { userId: string; partnerPronouns: string | null; partnerName: string | null }[];
  profiles: { id: string; pronouns: string | null }[];
}>(`{ userSettings { userId partnerPronouns partnerName } profiles { id pronouns } }`);

const JOURNAL = operation<{ journalEntries: { entryDate: string; body: string }[] }, { ids: string[] }>(
  `query ($ids: [uuid!]!) { journalEntries(where: { id: { _in: $ids } }) { entryDate body } }`,
);

export type Context = {
  text: string;
  pronouns: string | null;
  partnerPronouns: string | null;
  partnerName: string | null;
};

const NO_PRONOUNS: Omit<Context, 'text'> = { pronouns: null, partnerPronouns: null, partnerName: null };

/** The pronouns the person and their partner use, as the person stated them; never guessed. */
async function loadPronouns(caller: CallerQuery): Promise<Omit<Context, 'text'>> {
  const data = await caller(PRONOUNS);
  const settings = data.userSettings[0];
  const own = data.profiles.find((profile) => profile.id === settings?.userId);
  const partner = data.profiles.find((profile) => profile.id !== settings?.userId);
  return {
    pronouns: own?.pronouns ?? null,
    partnerPronouns: settings?.partnerPronouns ?? partner?.pronouns ?? null,
    partnerName: settings?.partnerName ? clip(settings.partnerName, CLIP.name) : null,
  };
}

async function loadJournal(caller: CallerQuery, ids: readonly string[]): Promise<string[]> {
  if (ids.length === 0) return [];
  const { journalEntries } = await caller(JOURNAL, { ids: [...ids] });
  return journalEntries.map(
    (entry) => `diary ${entry.entryDate} (shared by the person for this chat): ${clip(entry.body, CLIP.diary)}`,
  );
}

/** Runs a loader that may fail: what it could not read is left out, so the chat still answers. */
const orNothing = (load: Promise<string[]>): Promise<string[]> => load.catch(() => []);

/**
 * Loads the pronouns always, and the named blocks and journal entries on request. A block that fails is left out.
 * [journalEntryIds] are read only when the caller owns them, which the database enforces.
 */
export async function loadContext(
  caller: CallerQuery,
  flags: readonly ContextFlag[],
  journalEntryIds: readonly string[],
): Promise<Context> {
  const [base, blocks, diary] = await Promise.all([
    loadPronouns(caller).catch(() => NO_PRONOUNS),
    Promise.all(flags.map((flag) => orNothing(LOADERS[flag](caller)))),
    orNothing(loadJournal(caller, journalEntryIds)),
  ]);
  return { ...base, text: [...blocks.flat(), ...diary].join('\n') };
}
