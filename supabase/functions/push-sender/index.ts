// Drains the notification outbox. Invoked every minute by pg_cron through private.invoke_edge_function, with the project secret key in the apikey header.
// Preferences (muted types, daily cap, fight and time-away silence) are decided in SQL by
// private.claim_notifications; this function only delivers. Payloads are generic: type + ref id, never content.
// Requires secret FCM_SERVICE_ACCOUNT (Firebase service account JSON). Without it, nothing is claimed.
// Delivery outcomes: 2xx = sent; 400/404 = dead token (counted against the device); anything else (401, 403, 429, 5xx,
// network) = transient: the job is left unsent and claim_notifications retries it in 5 minutes (max 5 attempts).
import { isServiceCaller } from "../_shared/auth.ts";
import { json, log, sql } from "../_shared/db.ts";
import { serve } from "../_shared/serve.ts";
import { accessToken, loadAccount } from "./fcm.ts";

type Job = { outbox_id: string; type: string; ref_id: string | null; tokens: string[] };

serve("push-sender", async (req) => {
  if (!(await isServiceCaller(req))) return json({ error: "UNAUTHORIZED" }, 401);
  const account = loadAccount(Deno.env.get("FCM_SERVICE_ACCOUNT"));
  if (account === null) return json({ skipped: "FCM_SERVICE_ACCOUNT not set" });
  if (account === "invalid") {
    log("push_config_invalid");
    return json({ error: "FCM_SERVICE_ACCOUNT_INVALID" }, 500);
  }
  const jobs = await sql<Job[]>`select * from private.claim_notifications(50)`;
  if (jobs.length === 0) return json({ sent: 0 });

  let bearer: string;
  try {
    bearer = await accessToken(account);
  } catch (_e) {
    // Jobs stay unsent; the 5-minute lease set by claim_notifications makes them retry.
    log("push_auth_failed", { jobs: jobs.length });
    return json({ error: "FCM_AUTH_FAILED", retrying: jobs.length }, 502);
  }

  let sent = 0, retrying = 0;
  for (const job of jobs) {
    const dead: string[] = [];
    let delivered = 0, transient = 0;
    for (const token of job.tokens) {
      try {
        // Data-only message: the app renders the localized text for the type.
        const res = await fetch(`https://fcm.googleapis.com/v1/projects/${account.project_id}/messages:send`, {
          method: "POST",
          signal: AbortSignal.timeout(10_000),
          headers: { authorization: `Bearer ${bearer}`, "content-type": "application/json" },
          body: JSON.stringify({
            message: {
              token,
              data: { type: job.type, ref: job.ref_id ?? "", id: job.outbox_id },
              apns: { payload: { aps: { "mutable-content": 1, "content-available": 1 } } },
              android: { priority: "high" },
            },
          }),
        });
        if (res.ok) delivered++;
        else if (res.status === 404 || res.status === 400) dead.push(token);
        else transient++;
      } catch (_e) {
        transient++;
      }
    }
    if (delivered === 0 && transient > 0) {
      retrying++; // leave the job unsent
      continue;
    }
    await sql`select private.complete_notification(${job.outbox_id}, ${dead})`;
    sent++;
  }
  log("push_batch", { sent, retrying });
  return json({ sent, retrying });
});
