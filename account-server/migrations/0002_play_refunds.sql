-- Google Play refunds reach the account within seconds (README, "Refunds"; 16 Oct 2026). Google Play's Real-time
-- developer notifications arrive through Pub/Sub; the Voided Purchases API is read every hour as the backstop.

-- Every purchase Google has voided (refunded, revoked or charged back): only the token's SHA-256, never the token. A void
-- is final, so the token never counts again, even if it reaches us later or another account sends it.
CREATE TABLE voided_purchases (
  token_hash  TEXT PRIMARY KEY,
  voided_at   INTEGER NOT NULL,                -- when we learned it
  source      TEXT NOT NULL CHECK (source IN ('notification', 'voided_api', 'check'))
);

-- Pub/Sub messages already handled (Google: "check messageId for uniqueness"), kept 30 days.
CREATE TABLE play_notifications (
  message_id  TEXT PRIMARY KEY,
  received_at INTEGER NOT NULL
);

-- Small values the Worker keeps between runs: the Voided Purchases API's cursor ('voided_until', milliseconds).
CREATE TABLE worker_state (
  key         TEXT PRIMARY KEY,
  value       TEXT NOT NULL
);
