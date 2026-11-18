import { hasBearer, isTrigger, matchesSecret } from './auth.ts';
import type { EnvName } from './env.ts';
import { fail, type Req, type Res } from './http.ts';
import { log, reasonOf } from './log.ts';

/** Who may call a function: any signed-in person, a trigger of this project, or a service that sends a shared secret. */
export type Guard = { kind: 'bearer' } | { kind: 'trigger' } | { kind: 'secret'; header: string; env: EnvName };

export type HandlerOptions = { method: 'POST'; guard: Guard };

const allows = (req: Req, guard: Guard): boolean => {
  switch (guard.kind) {
    case 'bearer':
      return hasBearer(req);
    case 'trigger':
      return isTrigger(req);
    case 'secret':
      return matchesSecret(req, guard.header, guard.env);
  }
};

/**
 * Wraps a function so it answers the wrong method with 405 and a caller the guard refuses with 401, and so a throw is
 * logged and answered with 500 instead of reaching the platform as an unexplained error.
 */
export function handler(options: HandlerOptions, run: (req: Req, res: Res) => Promise<unknown>) {
  return async (req: Req, res: Res): Promise<void> => {
    if (req.method !== options.method) return fail(res, 'METHOD_NOT_ALLOWED');
    if (!allows(req, options.guard)) return fail(res, 'UNAUTHORIZED');
    try {
      await run(req, res);
    } catch (error) {
      log.error('handler_failed', { reason: reasonOf(error) });
      if (res.headersSent) return res.end();
      fail(res, 'INTERNAL');
    }
  };
}
