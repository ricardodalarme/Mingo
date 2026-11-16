// Queues and jobs that only Functions and cron touch, and the data export.
export const tables = {
  'private.file_deletions': {
    name: 'fileDeletions',
    eventTriggers: [
      {
        name: 'delete_file',
        definition: { enable_manual: true, insert: { columns: '*' } },
        // A file that still cannot be removed after six tries stays queued for the daily sweep.
        retry_conf: { interval_sec: 300, num_retries: 5, timeout_sec: 30 },
        webhook: '{{NHOST_FUNCTIONS_URL}}/events/delete-file',
        headers: [{ name: 'nhost-webhook-secret', value_from_env: 'NHOST_WEBHOOK_SECRET' }],
      },
    ],
  },
  'private.job_runs': { name: 'jobRuns' },
  'private.export_requests': { name: 'exportRequests' },

  export_documents: {},
};

export const functions = {
  'private.run_job': {},
  export_user_data: {},
};
