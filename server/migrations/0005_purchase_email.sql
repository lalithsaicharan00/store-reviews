-- The one email: a purchase confirmation, at most once per purchase, ever (Email Delivery Decision §2). Keyed by store
-- and purchase ID, with no account ID or address: restores, new accounts, account linking and replayed store
-- notifications find the row and send nothing more.
CREATE TABLE purchase_email (
  store TEXT NOT NULL,
  original_id TEXT NOT NULL,
  status TEXT NOT NULL,              -- pending, sent, cancelled, failed
  reason TEXT,                       -- why cancelled or failed (no_account, refunded, no_address, provider)
  attempts INTEGER NOT NULL DEFAULT 0,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL,
  PRIMARY KEY (store, original_id)
);
CREATE INDEX purchase_email_pending ON purchase_email(status, created_at);
