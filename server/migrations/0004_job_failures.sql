-- Background jobs that failed (nightly snapshots), for the daily report (Architecture 06 §10). One row per failure;
-- Cloudflare retries the job itself. Holds the account ID only, never data.
CREATE TABLE job_failure (
  at INTEGER NOT NULL,
  kind TEXT NOT NULL,
  account_id TEXT,
  message TEXT NOT NULL
);
CREATE INDEX job_failure_at ON job_failure(at);
