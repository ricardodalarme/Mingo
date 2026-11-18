import { operation } from '../_lib/graphql.ts';

export const ownSettings = operation<{ userSettings: { userId: string }[] }>(`{ userSettings { userId } }`);

export const exportUserData = operation<{ exportUserData: { data: unknown }[] }, { user: string }>(
  `mutation ($user: uuid!) { exportUserData(args: { userId: $user }) { data } }`,
);

export const assignFileOwner = operation<unknown, { id: string; user: string }>(
  `mutation ($id: uuid!, $user: uuid!) { updateFile(pk_columns: {id: $id}, _set: {uploadedByUserId: $user}) { id } }`,
);

export const clearExportRequests = operation<unknown, { user: string }>(
  `mutation ($user: uuid!) { deleteExportRequests(where: { userId: { _eq: $user } }) { affected_rows } }`,
);

export const removeFileRow = operation<unknown, { id: string }>(`mutation ($id: uuid!) { deleteFile(id: $id) { id } }`);
