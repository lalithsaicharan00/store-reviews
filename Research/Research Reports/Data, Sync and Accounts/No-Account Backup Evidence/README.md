# No-Account Backup Evidence

Evidence for [Without an Account — iCloud and Google Drive Backup, or Only This Phone](<../Without an Account — iCloud and Google Drive Backup, or Only This Phone.md>)
(Claude, 10 Oct 2026, Current Work 77).

| File | What it is |
|---|---|
| `scan.py` | The screen: every review in `App Store Reviews/`, `Play Store Reviews/` and `Native Store Reviews/` (1,487,223), six patterns. Run from `Research/`; writes `Temp/no-account-backup/matches.jsonl` (not kept here; re-run to rebuild it) |
| `keys.json` | Reading key (IC…, GD…, LO…, NO…, AC…, LS…) → review ID, for the 2,505 third-party matches |
| `codes.txt` | The hand coding of all 2,505: one line per review, its codes; the code list is at the top and the iCloud-dislike sub-codes at the bottom |
| `keys-native.json`, `codes-native.txt` | The same for the 363-review sample of the big companies' own apps |
| `tally.py`, `stats.txt` | Validation (no unknown or duplicate keys) and every count and mean in the report |
| `verify.py` | Checks each quote in the report word for word against the review files |

Codes: `want_cloud` (asks for cloud backup or iCloud/Drive sync), `praise_cloud`, `noacct_praise`, `fail` (cloud
sync or backup failed), `fail_loss` (lost data despite a cloud copy), `loss_local` (lost data kept only on the phone)
with its cause (`cause_bug`, `cause_device`, `cause_delete`), `fear_local`, `want_account`, `acct_dislike`,
`acct_fail` (lost data or access despite an account), `icloud_dislike`, `icloud_prefer` (prefers their own iCloud or
Drive to the app's account), `multi` (about using more than one device), `local_praise`, `want_file_backup`,
`offline_want`, `praise_account`, `saved_*`, `off` (off topic).
