import { type Res, statusOf } from '../_lib/http.ts';
import type { ChatErrorCode, ChatEvent } from './_relay.ts';

const toFrame = (event: ChatEvent) => `data: ${JSON.stringify(event)}\n\n`;

/** Sends a single error event and ends the response, with the HTTP status of the error. */
export function endWithError(res: Res, code: ChatErrorCode): void {
  res.status(statusOf(code));
  res.setHeader('content-type', 'text/event-stream');
  res.setHeader('cache-control', 'no-store');
  res.write(toFrame({ type: 'error', code }));
  res.end();
}

/** Opens a streamed response and returns the function that sends one event. */
export function openStream(res: Res): (event: ChatEvent) => void {
  res.status(200);
  res.setHeader('content-type', 'text/event-stream');
  res.setHeader('cache-control', 'no-store');
  res.setHeader('x-accel-buffering', 'no');
  res.flushHeaders?.();
  return (event) => res.write(toFrame(event));
}
