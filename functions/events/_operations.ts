import { operation } from '../_lib/graphql.ts';

export const claimNotification = operation<{ claimNotification: { token: string }[] }, { id: string }>(
  `mutation ($id: uuid!) { claimNotification(args: { notification_id: $id }) { token } }`,
);

export const completeNotification = operation<unknown, { id: string; dead: string[] }>(
  `mutation ($id: uuid!, $dead: jsonb!) { completeNotification(args: { notification_id: $id, failed_tokens: $dead }) { id } }`,
);

export const queuedFileDeletions = operation<
  { fileDeletions: { fileId: string }[] },
  { before: string; limit: number }
>(
  `query ($before: timestamptz!, $limit: Int!) { fileDeletions(where: { queuedAt: { _lt: $before } }, limit: $limit) { fileId } }`,
);

export const dequeueFileDeletion = operation<unknown, { id: string }>(
  `mutation ($id: uuid!) { deleteFileDeletionsByPk(fileId: $id) { fileId } }`,
);

export const runJob = operation<{ runJob: { affected: number }[] }, { job: string }>(
  `mutation ($job: String!) { runJob(args: { job: $job }) { affected } }`,
);
