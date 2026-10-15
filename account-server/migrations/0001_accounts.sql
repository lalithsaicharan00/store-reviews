-- The Plus account (Rulebook D16, Android A15, Current Work 110). Only what the account needs: who it is (Google's or
-- Apple's fixed ID, never the email: a masked hint only), its purchases as checked with the store, and its family.
-- Never a habit. Times are milliseconds since 1970 (UTC).

CREATE TABLE accounts (
  id          TEXT PRIMARY KEY,                -- random, ours; what the app and the family rows see
  provider    TEXT NOT NULL CHECK (provider IN ('google', 'apple')),
  subject     TEXT NOT NULL,                   -- the provider's fixed account ID (`sub`)
  name        TEXT NOT NULL,                   -- the first name the family sees ("Lee's family")
  email_hint  TEXT,                            -- "l•••••@gmail.com", never the whole address
  created_at  INTEGER NOT NULL,
  seen_at     INTEGER NOT NULL,
  UNIQUE (provider, subject)
);

-- A signed-in device. The app holds the token; we keep only its SHA-256.
CREATE TABLE sessions (
  token_hash  TEXT PRIMARY KEY,
  account_id  TEXT NOT NULL REFERENCES accounts(id) ON DELETE CASCADE,
  created_at  INTEGER NOT NULL,
  used_at     INTEGER NOT NULL
);
CREATE INDEX sessions_account ON sessions(account_id);

-- A store purchase checked with Google Play. One purchase belongs to one account at a time; deleting the account frees
-- it (the purchase itself stays with Google), so signing in again brings Plus back.
CREATE TABLE purchases (
  token_hash  TEXT PRIMARY KEY,
  token       TEXT NOT NULL,                   -- Google's purchase token, needed to check it again (refunds)
  account_id  TEXT NOT NULL REFERENCES accounts(id) ON DELETE CASCADE,
  store       TEXT NOT NULL CHECK (store IN ('google')),
  product     TEXT NOT NULL,
  order_id    TEXT,
  active      INTEGER NOT NULL,                -- 1 bought, 0 refunded or cancelled
  test        INTEGER NOT NULL DEFAULT 0,      -- a license tester's purchase
  checked_at  INTEGER NOT NULL
);
CREATE INDEX purchases_account ON purchases(account_id);

-- Plus Family: the buyer (owner) and up to 5 more.
CREATE TABLE families (
  id          TEXT PRIMARY KEY,
  owner_id    TEXT NOT NULL UNIQUE REFERENCES accounts(id) ON DELETE CASCADE,
  created_at  INTEGER NOT NULL
);

-- Someone in a family who isn't its owner. One family per person.
CREATE TABLE members (
  account_id  TEXT PRIMARY KEY REFERENCES accounts(id) ON DELETE CASCADE,
  family_id   TEXT NOT NULL REFERENCES families(id) ON DELETE CASCADE,
  joined_at   INTEGER NOT NULL
);
CREATE INDEX members_family ON members(family_id);

-- A single-use invite link (Figma 7: "Works once, for 7 days"). At most one open invite per family.
CREATE TABLE invites (
  token       TEXT PRIMARY KEY,
  family_id   TEXT,                            -- null once the family is gone (the invite then reads "cancelled")
  owner_name  TEXT NOT NULL,                   -- kept so a link to a family that ended still says whose it was
  created_at  INTEGER NOT NULL,
  ends_at     INTEGER NOT NULL,
  state       TEXT NOT NULL CHECK (state IN ('open', 'used', 'cancelled', 'ended')),
  used_by     TEXT
);
CREATE UNIQUE INDEX invites_one_open ON invites(family_id) WHERE state = 'open';
CREATE INDEX invites_family ON invites(family_id);
