import * as v from 'valibot';

export const UUID = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

/** The typed value of [input] when it fits [schema], or null. */
export function parse<Schema extends v.GenericSchema>(schema: Schema, input: unknown): v.InferOutput<Schema> | null {
  const result = v.safeParse(schema, input);
  return result.success ? result.output : null;
}

/** The body of an event trigger for an inserted row: `{ event: { data: { new: row } } }`. */
export const insertedRow = <Row extends v.GenericSchema>(row: Row) =>
  v.object({ event: v.object({ data: v.object({ new: row }) }) });

/** The body of a cron trigger: `{ payload }`. */
export const cronPayload = <Payload extends v.GenericSchema>(payload: Payload) => v.object({ payload });

export const NonEmptyString = v.pipe(v.string(), v.minLength(1));
