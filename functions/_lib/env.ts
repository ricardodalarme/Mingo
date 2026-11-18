export type EnvName =
  | 'NHOST_ADMIN_SECRET'
  | 'NHOST_GRAPHQL_URL'
  | 'NHOST_STORAGE_URL'
  | 'NHOST_WEBHOOK_SECRET'
  | 'FCM_SERVICE_ACCOUNT'
  | 'REVENUECAT_WEBHOOK_AUTH'
  | 'CHAT_API_URL'
  | 'CHAT_API_KEY'
  | 'CHAT_MODEL'
  | 'CHAT_TOOLS'
  | 'CHAT_EXTRA_BODY'
  | 'CHAT_EXTRA_HEADERS';

/** Thrown when a variable the function cannot run without is missing. */
export class ConfigError extends Error {}

/** The value of a variable, or undefined when it is unset or empty. */
export const env = (name: EnvName): string | undefined => process.env[name] || undefined;

/** The value of a variable that must be set. */
export function requireEnv(name: EnvName): string {
  const value = env(name);
  if (!value) throw new ConfigError(`${name} is not set`);
  return value;
}

/** A JSON object from a variable, or an empty object when it is unset or not an object. */
export function jsonEnv(name: EnvName): Record<string, unknown> {
  try {
    const value: unknown = JSON.parse(env(name) ?? '{}');
    return value && typeof value === 'object' && !Array.isArray(value) ? (value as Record<string, unknown>) : {};
  } catch {
    return {};
  }
}
