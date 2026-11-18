const SECOND = 1000;
const MINUTE = 60 * SECOND;
export const HOUR_MS = 60 * MINUTE;

/** Time limits for the calls a function makes, in milliseconds. Starter projects stop a function after 10 seconds. */
export const TIMEOUT_MS = {
  graphql: 20 * SECOND,
  storage: 20 * SECOND,
  upload: 30 * SECOND,
  model: 30 * SECOND,
  push: 10 * SECOND,
} as const;

/** The most characters of an error message that reach the logs. */
export const LOG_REASON_MAX = 120;
