-- Deleted accounts, IDs only (Architecture 09 §7 item 8). An account ID here can never be opened again, even if a
-- restore from an older copy of this database (D1 Time Travel) brings its rows back.
CREATE TABLE deleted_account (
  id TEXT PRIMARY KEY,
  deleted_at INTEGER NOT NULL
);
