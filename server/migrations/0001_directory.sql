-- The directory: the only lookup that spans accounts (Architecture 06 §3).
-- It holds sign-in keys and account IDs only; emails and everything else live in the account's Durable Object,
-- which can be stored in the EU (Architecture 09).

CREATE TABLE account (
  id TEXT PRIMARY KEY,               -- our UUID
  created_at INTEGER NOT NULL,       -- epoch ms
  jurisdiction TEXT NOT NULL DEFAULT 'default'  -- 'default' or 'eu'; chosen at creation, never changed
);

-- (provider, subject) is unique, so one Apple ID or Google account can never open two accounts.
CREATE TABLE account_key (
  provider TEXT NOT NULL,            -- 'apple', 'google' ('test' only on dev)
  subject TEXT NOT NULL,             -- the provider's stable user ID (`sub`)
  account_id TEXT NOT NULL REFERENCES account(id),
  created_at INTEGER NOT NULL,
  PRIMARY KEY (provider, subject)
);
CREATE INDEX account_key_account ON account_key(account_id);
