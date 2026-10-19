-- Where the habits live (Rulebook D16; Current Work 138, 19 Oct 2026). The account remembers which cloud holds the
-- habits, so a new device signing in goes there by itself, or says plainly that they're somewhere it can't open (an
-- iPhone's iCloud from Android) or in a different Google account. Never an email: only the cloud account's private ID,
-- as the device's sync binds to it ("gdrive:" and a SHA-256 of Google's fixed account ID; "icloud:" and CloudKit's user
-- record name for our container, which no other app sees). Deleted with the account. Never a habit.

ALTER TABLE accounts ADD COLUMN cloud TEXT CHECK (cloud IN ('google_drive', 'icloud'));
ALTER TABLE accounts ADD COLUMN cloud_key TEXT;
-- The kind of device that last synced there ("from an iPhone") and when, in milliseconds since 1970 (UTC).
ALTER TABLE accounts ADD COLUMN cloud_device TEXT CHECK (cloud_device IN ('android', 'iphone', 'ipad'));
ALTER TABLE accounts ADD COLUMN cloud_at INTEGER;
