import { ME, and, inMyCouple, meOrPartner, mine, or } from './_shared.mjs';

// storage.files: a person reads what they uploaded and what a partner shared with them through a row that owns the file.
export const storageFiles = {
  object: { bucket: 'bucket_id' },
  array: {
    avatarOf: { table: 'profiles', column: 'avatar_file_id' },
    memories: { table: 'memories', column: 'photo_file_id' },
    partnerMessages: { table: 'partner_messages', column: 'media_file_id' },
    couplePhotos: { table: 'couple_photos', column: 'file_id' },
  },
  roles: {
    user: {
      select: {
        columns: '*',
        filter: or(
          mine('uploaded_by_user_id'),
          { avatarOf: meOrPartner },
          // A shared memory photo is the partner's to read only after the memory was accepted.
          { memories: and(inMyCouple, { accepted_at: { _is_null: false } }) },
          { partnerMessages: mine('recipient_id') },
          { couplePhotos: inMyCouple },
        ),
      },
      insert: {
        columns: ['id', 'bucket_id', 'name', 'size', 'mime_type', 'metadata'],
        check: { bucket_id: { _in: ['avatars', 'slips', 'memories', 'messages', 'couple-photos'] } },
        set: { uploaded_by_user_id: ME },
      },
      delete: { filter: mine('uploaded_by_user_id') },
    },
  },
};
