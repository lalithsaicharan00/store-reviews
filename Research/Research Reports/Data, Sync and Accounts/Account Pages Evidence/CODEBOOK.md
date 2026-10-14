# Account Pages — codebook

Written by Claude (Claude Code), 14 October 2026, for [The Account and Backup Pages](<../The Account and Backup Pages — Your Google Drive, and an Account Only for Plus.md>).

**How to rerun:** copy `scan.py`, `tally.py` and `verify.py` to `Research/Temp/account-pages/` and run them there, in that order
(`scan.py` writes `candidates.jsonl` from the corpora two levels up; `tally.py` and `verify.py` read it with `codes.txt`
and `quotes.tsv`). Every App Store and Play Store match was read by hand (1,064); of the built-in apps' 374 matches,
every non-family one was read (32) and 25 of the 342 family ones were sampled (all about shared calendars and lists, so
off topic). Keys are `<store><app number>#<line in reviews.jsonl>`; `verify.py` prints each quoted review's ID.

| Code | Meaning |
|---|---|
| `RESTORE_BUG` | Paid, and the store's restore didn't give it back (any device) |
| `XDEV` | Paid; Plus didn't follow to a second device, a new phone or a reinstall on the same platform |
| `XPLATFORM` | Paid on iPhone and moved to Android, or the other way; had to pay again |
| `PAID_LOST_NEW_DEVICE` | Paid; no way to sign in on the new phone, so the purchase was lost |
| `MODEL_SWITCH` | A lifetime purchase taken away when the app moved to a subscription (one app mostly) |
| `DATA_NOT_PURCHASE` | The purchase came back but the habits didn't, or the other way round |
| `CANT_FIND_RESTORE` | Couldn't find where to restore or sign in |
| `RESTORE_OK` | Restore worked (often after support) |
| `WRONG_SIGNIN_ACCOUNT` | Picked the wrong Google account, Play profile or sign-in method |
| `WEB_PURCHASE` | Bought on the web; the app didn't see it |
| `RESTORE_LABEL_NOISE` | "Restore purchase" shown when it isn't needed |
| `BACKUP_PAYWALL` | Backup or restore behind a payment |
| `FAMILY_HOW_TO_ADD` | Bought a family plan and couldn't find how to add people |
| `FAMILY_NOT_UNLOCKED` | Followed the steps; the family member didn't get it |
| `FAMILY_CROSS_PLATFORM` | Family on another platform (Android, another country) |
| `FAMILY_WANT` | Asks for a family plan |
| `FAMILY_OK` | Family sharing praised |
| `NOACC_PRAISE` | Praises needing no account |
| `FORCED_ACC` | Angry at a required account |
| `PRIVACY_ACC` | Worried about what an account or server holds |
| `WANT_ACCOUNT` | Wants an account (to keep data or a purchase across phones) |
| `ACC_LOGIN_FAIL` | An email account that couldn't be signed in to ("no account with that email") |
| `SILENT_NEW_ACCOUNT` | Signing in quietly made a new, empty account |
| `ACCOUNT_BEFORE_BUY` | Advises making an account before buying |
| `BILLING_NO_ACCOUNT` | Subscription charges with no account page to manage them |
| `OWN_CLOUD_PAY` | Resents paying for sync that runs through their own iCloud or Drive |
| `WANT_OWN_CLOUD` | Wants backup to their own cloud |
| others | One review each, named in `codes.txt` |
| `off` | Matched a pattern but not on topic |
