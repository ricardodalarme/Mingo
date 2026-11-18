/** Maps [items] with at most [limit] calls of [run] in flight, keeping the order of the results. */
export async function mapLimit<Item, Result>(
  items: readonly Item[],
  limit: number,
  run: (item: Item) => Promise<Result>,
): Promise<Result[]> {
  const results = new Array<Result>(items.length);
  let next = 0;
  const worker = async () => {
    while (next < items.length) {
      const index = next++;
      results[index] = await run(items[index] as Item);
    }
  };
  await Promise.all(Array.from({ length: Math.min(limit, items.length) }, worker));
  return results;
}

/** Runs [run] up to [attempts] times, rethrowing the last failure. */
export async function retry<Result>(attempts: number, run: () => Promise<Result>): Promise<Result> {
  let failure: unknown;
  for (let attempt = 0; attempt < attempts; attempt++) {
    try {
      return await run();
    } catch (error) {
      failure = error;
    }
  }
  throw failure;
}

/** Swallows a rejection from cleanup that is allowed to fail. */
export const ignoreError = (): void => undefined;
