import { ignoreError } from '../_lib/async.ts';
import { asAdmin, asCaller, operation } from '../_lib/graphql.ts';
import type { Req } from '../_lib/http.ts';

const TAKE_TURN = operation<{ takeChatTurn: { id: string }[] }>(`mutation { takeChatTurn { id } }`);

const DELETE_TURN = operation<unknown, { id: string }>(`mutation ($id: uuid!) { deleteChatTurnsByPk(id: $id) { id } }`);

/**
 * Takes a turn from the caller's daily allowance, as the caller, so the token is verified by the GraphQL engine and
 * the person's own setting applies. Resolves null when the chat is switched off or today's allowance is gone, and
 * rejects when the engine refuses the caller.
 */
export async function takeTurn(req: Req): Promise<string | null> {
  const { takeChatTurn } = await asCaller(req, TAKE_TURN);
  return takeChatTurn[0]?.id ?? null;
}

/** Gives a turn back when no reply was produced. */
export const refundTurn = (turnId: string): Promise<void> =>
  asAdmin(DELETE_TURN, { id: turnId }).then(ignoreError, ignoreError);
