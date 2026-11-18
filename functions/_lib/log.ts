import { LOG_REASON_MAX } from './config.ts';

type Level = 'info' | 'warn' | 'error';
type Fields = Record<string, unknown>;

const write = (level: Level, event: string, fields: Fields = {}) =>
  // biome-ignore lint/suspicious/noConsole: the console method sets the level the platform records
  console[level](JSON.stringify({ event, ...fields }));

/** One log line per event, as JSON. Never pass message text, tokens or secrets. */
export const log = {
  info: (event: string, fields?: Fields) => write('info', event, fields),
  warn: (event: string, fields?: Fields) => write('warn', event, fields),
  error: (event: string, fields?: Fields) => write('error', event, fields),
};

/** A short reason for a log line from anything that was thrown. */
export const reasonOf = (error: unknown): string =>
  error instanceof Error ? error.message.slice(0, LOG_REASON_MAX) : 'unknown';
