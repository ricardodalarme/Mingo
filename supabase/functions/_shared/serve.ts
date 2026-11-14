import { json, log } from "./db.ts";

type Handler = (req: Request) => Response | Promise<Response>;

// Wraps a handler so an unexpected failure answers with a JSON error instead of the platform's bare 500, and leaves one
// log line with the function and the error kind. The message and stack are left out because they can carry personal data.
export const guarded = (name: string, handler: Handler): Handler => async (req) => {
  try {
    return await handler(req);
  } catch (error) {
    const code = (error as { code?: unknown })?.code;
    log("unhandled_error", {
      function: name,
      type: error instanceof Error ? error.name : typeof error,
      code: typeof code === "string" ? code : "",
    });
    return json({ error: "INTERNAL" }, 500);
  }
};

export const serve = (name: string, handler: Handler) => Deno.serve(guarded(name, handler));
