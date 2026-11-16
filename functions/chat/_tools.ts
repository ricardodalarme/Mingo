// The actions the mascot may suggest. The function only validates and relays them as `action` events: it never writes
// data. The app runs each one, asking the person first when `confirm` is true (it reaches the partner or changes both).

type Field =
  | { type: 'string'; max: number; optional?: true; values?: readonly string[] }
  | { type: 'integer'; min: number; max: number; optional?: true }
  | { type: 'boolean'; optional?: true }
  | { type: 'date'; optional?: true }
  | { type: 'time'; optional?: true };

export type ToolSpec = { confirm: boolean; description: string; params: Record<string, Field> };

const defineTools = <const T extends Record<string, ToolSpec>>(tools: T) => tools;

type FieldValue<F> = F extends { type: 'string'; values: readonly (infer V)[] }
  ? V
  : F extends { type: 'integer' }
    ? number
    : F extends { type: 'boolean' }
      ? boolean
      : string;
type Optional<P> = { [K in keyof P]: P[K] extends { optional: true } ? K : never }[keyof P];
/** The arguments of a tool, read from its parameter schema: required keys are required, `optional` ones may be missing. */
export type ToolArgs<P> = { [K in Exclude<keyof P, Optional<P>>]: FieldValue<P[K]> } & { [K in Optional<P>]?: FieldValue<P[K]> };

const MOODS = ['happy', 'tired', 'sad', 'stressed', 'loving', 'playful'] as const;
const GAMES = ['me_or_you', 'how_well', 'twenty_questions', 'never_have_we', 'compliments', 'mission'] as const;
const TARGETS = ['partner_fact', 'date', 'memory', 'commitment'] as const;
function text(max: number): { readonly type: 'string'; readonly max: number };
function text(max: number, optional: true): { readonly type: 'string'; readonly max: number; readonly optional: true };
function text(max: number, optional?: true) {
  return optional ? ({ type: 'string', max, optional } as const) : ({ type: 'string', max } as const);
}

export const TOOLS = defineTools({
  search_slips: { confirm: false, description: 'Look for the person\'s own slips by a word.', params: { query: text(80) } },
  create_private_slip: { confirm: false, description: 'Save a small good thing the partner did, private to the person.', params: { body: text(280), feeling: text(200, true) } },
  send_slip_to_partner: { confirm: true, description: 'Send one slip to the partner as a card.', params: { body: text(280) } },
  log_mood: { confirm: false, description: 'Record the person\'s mood today, kept private.', params: { mood: { type: 'string', max: 12, values: MOODS } } },
  share_mood: { confirm: true, description: 'Share the person\'s mood today with the partner.', params: { mood: { type: 'string', max: 12, values: MOODS } } },
  draft_card: { confirm: false, description: 'Start a draft of the weekly card with a note.', params: { note: text(500) } },
  send_card: { confirm: true, description: 'Send the weekly card to the partner.', params: { note: text(500, true) } },
  create_private_reminder: { confirm: false, description: 'A reminder only on the person\'s device.', params: { title: text(80), date: { type: 'date', optional: true } } },
  create_shared_date: { confirm: true, description: 'Save a date both people will see.', params: { title: text(80), month: { type: 'integer', min: 1, max: 12 }, day: { type: 'integer', min: 1, max: 31 }, year: { type: 'integer', min: 1900, max: 2200, optional: true }, yearly: { type: 'boolean', optional: true } } },
  add_to_private_list: { confirm: false, description: 'Add an item to a private list.', params: { list_title: text(80), item: text(120) } },
  create_calendar_event: { confirm: true, description: 'Add an event to the device calendar.', params: { title: text(80), date: { type: 'date' }, time: { type: 'time', optional: true } } },
  draft_logistic_item: { confirm: false, description: 'A private draft of a task for the household.', params: { title: text(120), due_on: { type: 'date', optional: true } } },
  add_logistic_item_for_both: { confirm: true, description: 'Add a task both people will see.', params: { title: text(120), due_on: { type: 'date', optional: true } } },
  suggest_couple_question: { confirm: false, description: 'Suggest a question to talk about; nothing is sent.', params: { question: text(200) } },
  invite_to_game: { confirm: true, description: 'Invite the partner to a game.', params: { game: { type: 'string', max: 20, values: GAMES } } },
  save_private_memory: { confirm: false, description: 'Keep a memory private to the person.', params: { title: text(160), body: text(1000, true), happened_on: { type: 'date', optional: true } } },
  share_memory: { confirm: true, description: 'Propose a memory to the partner.', params: { title: text(160), body: text(1000, true), happened_on: { type: 'date', optional: true } } },
  save_learning: { confirm: false, description: 'Suggest something to remember; kept only after the person confirms in the app.', params: { target: { type: 'string', max: 20, values: TARGETS }, text: text(200) } },
  send_repair_card: { confirm: true, description: 'Send a short repair message to the partner.', params: { message: text(280) } },
  suggest_notification_change: { confirm: false, description: 'Suggest a notification setting; nothing changes yet.', params: { setting: { type: 'string', max: 20, values: ['enabled', 'card_day', 'card_hour', 'daily_max'] }, value: text(20) } },
  change_widget_or_time: { confirm: true, description: 'Change a widget or the card time.', params: { setting: { type: 'string', max: 24, values: ['widget_on_lock_screen', 'widget_show_names', 'card_day', 'card_hour'] }, value: text(20) } },
  open_purchase: { confirm: true, description: 'Open the Plus purchase screen.', params: {} },
  change_distance_count: { confirm: true, description: 'Change the day the distance count starts from.', params: { start_date: { type: 'date', optional: true } } },
  draft_note: { confirm: false, description: 'Draft a short note for the partner; nothing is sent.', params: { body: text(280) } },
  send_note_or_drawing: { confirm: true, description: 'Send a short note to the partner.', params: { kind: { type: 'string', max: 8, values: ['note'] }, body: text(280) } },
});

export type ToolName = keyof typeof TOOLS;
const isToolName = (name: string): name is ToolName => Object.hasOwn(TOOLS, name);

const DATE = /^\d{4}-\d{2}-\d{2}$/;
const TIME = /^([01]\d|2[0-3]):[0-5]\d$/;

function check(field: Field, value: unknown): unknown {
  if (value === undefined || value === null) return field.optional ? undefined : null;
  switch (field.type) {
    case 'string': {
      if (typeof value !== 'string') return null;
      const trimmed = value.trim();
      if (!trimmed || trimmed.length > field.max) return null;
      return field.values && !field.values.includes(trimmed) ? null : trimmed;
    }
    case 'integer':
      return Number.isInteger(value) && (value as number) >= field.min && (value as number) <= field.max ? value : null;
    case 'boolean':
      return typeof value === 'boolean' ? value : null;
    case 'date':
      return typeof value === 'string' && DATE.test(value) && !Number.isNaN(Date.parse(value)) ? value : null;
    case 'time':
      return typeof value === 'string' && TIME.test(value) ? value : null;
  }
}

export type Action = {
  [N in ToolName]: { tool: N; args: ToolArgs<(typeof TOOLS)[N]['params']>; confirm: boolean };
}[ToolName];

/** The action for a tool call, or null when the tool is unknown or an argument is missing, extra or out of bounds. */
export function validateAction(name: string, raw: unknown): Action | null {
  if (!isToolName(name)) return null;
  const spec: ToolSpec = TOOLS[name];
  if (!raw || typeof raw !== 'object' || Array.isArray(raw)) return null;
  const input = raw as Record<string, unknown>;
  if (Object.keys(input).some((key) => !Object.hasOwn(spec.params, key))) return null;
  const args: Record<string, unknown> = {};
  for (const [key, field] of Object.entries(spec.params)) {
    const value = check(field, input[key]);
    if (value === null) return null;
    if (value !== undefined) args[key] = value;
  }
  return { tool: name, args, confirm: spec.confirm } as Action;
}

/** The tool list in the OpenAI-compatible `tools` format. */
export function toolDefinitions() {
  return Object.entries(TOOLS).map(([name, spec]) => ({
    type: 'function',
    function: {
      name,
      description: spec.description,
      parameters: {
        type: 'object',
        additionalProperties: false,
        properties: Object.fromEntries(Object.entries(spec.params).map(([key, field]) => [key, jsonType(field)])),
        required: Object.entries(spec.params).filter(([, field]) => !field.optional).map(([key]) => key),
      },
    },
  }));
}

function jsonType(field: Field): Record<string, unknown> {
  switch (field.type) {
    case 'string': return { type: 'string', maxLength: field.max, ...(field.values ? { enum: field.values } : {}) };
    case 'integer': return { type: 'integer', minimum: field.min, maximum: field.max };
    case 'boolean': return { type: 'boolean' };
    case 'date': return { type: 'string', description: 'YYYY-MM-DD' };
    case 'time': return { type: 'string', description: 'HH:MM' };
  }
}
