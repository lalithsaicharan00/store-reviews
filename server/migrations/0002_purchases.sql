-- Which account a store purchase is linked to, so one purchase can't unlock two accounts (Architecture 02 §3.5).
-- Deleting an account removes its rows, so the same purchase can be restored on a new account (01 §3.7).
CREATE TABLE purchase (
  store TEXT NOT NULL,               -- 'apple' ('google' later)
  original_id TEXT NOT NULL,         -- Apple originalTransactionId
  account_id TEXT NOT NULL REFERENCES account(id),
  created_at INTEGER NOT NULL,
  PRIMARY KEY (store, original_id)
);
CREATE INDEX purchase_account ON purchase(account_id);
