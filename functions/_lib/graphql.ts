import { TIMEOUT_MS } from './config.ts';
import { requireEnv } from './env.ts';
import { header, type Req } from './http.ts';

/** A GraphQL document that remembers the shape of its result and, when it takes any, of its variables. */
export type Operation<Data, Variables = undefined> = {
  readonly query: string;
  readonly result?: Data;
  readonly variables?: Variables;
};

/** The trailing argument of a call: the variables when the operation takes some, nothing when it does not. */
export type VariablesArg<Variables> = Variables extends undefined ? [] : [variables: Variables];

/** Runs an operation as the caller, so the caller's permissions apply. */
export type CallerQuery = <Data, Variables>(
  operation: Operation<Data, Variables>,
  ...args: VariablesArg<Variables>
) => Promise<Data>;

/** Declares an operation with the types of what it returns and, optionally, of what it takes. */
export const operation = <Data, Variables = undefined>(query: string): Operation<Data, Variables> => ({ query });

type GraphqlResult<Data> = { data?: Data; errors?: { message: string }[] };

async function execute<Data>(headers: Record<string, string>, query: string, variables: unknown): Promise<Data> {
  const res = await fetch(requireEnv('NHOST_GRAPHQL_URL'), {
    method: 'POST',
    headers: { 'content-type': 'application/json', ...headers },
    body: JSON.stringify({ query, variables }),
    signal: AbortSignal.timeout(TIMEOUT_MS.graphql),
  });
  const body = (await res.json()) as GraphqlResult<Data>;
  if (!res.ok || body.errors?.length || !body.data) {
    throw new Error(`graphql request failed: ${body.errors?.[0]?.message ?? res.status}`);
  }
  return body.data;
}

/** Runs a system operation with the admin secret. The secret never leaves the function. */
export const asAdmin = async <Data, Variables>(
  { query }: Operation<Data, Variables>,
  ...[variables]: VariablesArg<Variables>
): Promise<Data> => execute(adminHeaders(), query, variables);

/** Runs an operation as the caller, so the caller's permissions apply. */
export const asCaller = async <Data, Variables>(
  req: Req,
  { query }: Operation<Data, Variables>,
  ...[variables]: VariablesArg<Variables>
): Promise<Data> => execute({ authorization: header(req, 'authorization') }, query, variables);

/** The headers that authorize a request to the Nhost services as an administrator. */
export const adminHeaders = (): Record<string, string> => ({
  'x-hasura-admin-secret': requireEnv('NHOST_ADMIN_SECRET'),
});

/** A [CallerQuery] that runs as the sender of [req]. */
export const callerQuery =
  (req: Req): CallerQuery =>
  (query, ...args) =>
    asCaller(req, query, ...args);
