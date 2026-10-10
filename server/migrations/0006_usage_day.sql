-- Daily counts for the report (Current Work 78, Free Sync — One Device at a Time §4 S7): no account IDs, no content.
-- metric: 'syncing_free' / 'syncing_plus' (accounts that synced that day, counted once each by their Durable Object),
-- 'replaced_device' (a free sign-in that signed another device out).
CREATE TABLE usage_day (
  day TEXT NOT NULL,
  metric TEXT NOT NULL,
  n INTEGER NOT NULL,
  PRIMARY KEY (day, metric)
);
