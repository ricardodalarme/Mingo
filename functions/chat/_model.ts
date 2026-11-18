import { TIMEOUT_MS } from '../_lib/config.ts';
import { env, jsonEnv } from '../_lib/env.ts';
import { log } from '../_lib/log.ts';
import type { Turn } from './_request.ts';
import { toolDefinitions } from './_tools.ts';

const SAMPLING = { temperature: 0.6, max_tokens: 600 } as const;
/** The gateway routes by session; without it a request is refused before the model runs. */
const SESSION_HEADER = 'x-opencode-session';

export type ModelConfig = { url: string; key: string; model: string };

/** The model gateway from the environment, or null when it is not fully configured. */
export function modelConfig(): ModelConfig | null {
  const url = env('CHAT_API_URL');
  const key = env('CHAT_API_KEY');
  const model = env('CHAT_MODEL');
  return url && key && model ? { url, key, model } : null;
}

export type Completion = {
  prompt: string;
  history: readonly Turn[];
  message: string;
  session: string;
  actions: boolean;
  /** Aborts the call, for instance when the person closes the app. */
  signal: AbortSignal;
};

/** Starts a streamed completion, or resolves null when the gateway fails or answers without a body. */
export async function startCompletion(config: ModelConfig, input: Completion): Promise<Response | null> {
  const extraHeaders = Object.entries(jsonEnv('CHAT_EXTRA_HEADERS')).map(([name, value]) => [
    name,
    String(value).replace('{session}', input.session),
  ]);
  const response = await fetch(`${config.url.replace(/\/$/, '')}/chat/completions`, {
    method: 'POST',
    signal: AbortSignal.any([AbortSignal.timeout(TIMEOUT_MS.model), input.signal]),
    headers: {
      'content-type': 'application/json',
      authorization: `Bearer ${config.key}`,
      [SESSION_HEADER]: input.session,
      ...Object.fromEntries(extraHeaders),
    },
    body: JSON.stringify({
      model: config.model,
      messages: [
        { role: 'system', content: input.prompt },
        ...input.history.map((turn) => ({ role: turn.role === 'mascot' ? 'assistant' : 'user', content: turn.text })),
        { role: 'user', content: input.message },
      ],
      stream: true,
      ...(input.actions ? { tools: toolDefinitions() } : {}),
      ...SAMPLING,
      ...jsonEnv('CHAT_EXTRA_BODY'),
    }),
  }).catch(() => null);
  if (!response?.ok || !response.body) {
    log.error('chat_upstream_failed', { status: response?.status ?? 0 });
    return null;
  }
  return response;
}
