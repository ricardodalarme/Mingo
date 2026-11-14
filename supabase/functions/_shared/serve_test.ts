import { assertEquals } from "jsr:@std/assert@1";

// db.ts opens its connection lazily, so a placeholder URL is enough to import it.
Deno.env.set("SUPABASE_DB_URL", "postgres://user:pass@localhost:5432/db");
const { guarded } = await import("./serve.ts");

const request = new Request("https://example.test/fn");

Deno.test("guarded passes a normal response through", async () => {
  const response = await guarded("demo", () => new Response("ok", { status: 201 }))(request);
  assertEquals(response.status, 201);
  assertEquals(await response.text(), "ok");
});

Deno.test("guarded turns a thrown error into a JSON 500 without its message", async () => {
  const lines: string[] = [];
  const realLog = console.log;
  console.log = (line: string) => lines.push(line);
  try {
    const failing = guarded("demo", () => {
      throw Object.assign(new Error("secret value 123"), { code: "23505" });
    });
    const response = await failing(request);

    assertEquals(response.status, 500);
    assertEquals(await response.json(), { error: "INTERNAL" });
  } finally {
    console.log = realLog;
  }
  assertEquals(lines.length, 1);
  assertEquals(JSON.parse(lines[0]), { event: "unhandled_error", function: "demo", type: "Error", code: "23505" });
});

Deno.test("guarded also catches a rejected promise", async () => {
  const response = await guarded("demo", () => Promise.reject(new TypeError("boom")))(request);
  assertEquals(response.status, 500);
});
