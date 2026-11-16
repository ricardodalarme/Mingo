// The system prompt of the mascot, assembled from the pieces in this folder. Each piece holds its text in both languages.
import { ACTIONS } from './actions.ts';
import { BASE } from './base.ts';
import { CONTEXT_HEADING } from './context.ts';
import { MODES } from './modes.ts';
import { type PronounOptions, pronounRule } from './pronouns.ts';

export type PromptOptions = PronounOptions & {
  /** What the person let the mascot read, one line per fact. */
  context?: string;
  /** Whether the tool list is offered with this request. */
  actions?: boolean;
};

/** The prompt for [locale] and [mode]; without [options] it is the plain one, with no pronouns, tools or context. */
export function systemPrompt(locale: string, mode: string, options: PromptOptions | null = null): string {
  const lang = locale.startsWith('pt') ? 'pt' : 'en';
  let prompt = BASE[lang] + (MODES[mode]?.[lang] ?? '');
  if (!options) return prompt;
  prompt += pronounRule(lang === 'pt', options);
  if (options.actions) prompt += ACTIONS[lang];
  if (options.context) prompt += CONTEXT_HEADING[lang] + options.context;
  return prompt;
}
