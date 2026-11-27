# Server and Accounts — iPhone Designs — 21 November 2026

Written by Claude (Claude Code), 21 November 2026. The iPhone Figma work that follows from the switch to a server with
accounts (Android A124–A127): iCloud goes, every person has an account (anonymous unless they sign in with Apple or
Google), Plus is one purchase that follows the account. Figma: the iOS app file (`zLgBjb7M7Fp6UN0pg7J3a8`).

## Onboarding (page `1:5`)

- [ ] Delete flows 3 · Back with a backup file, 5 · iCloud is off, 6 · Wrong file, 7 · Backup from a newer version
- [ ] Delete the *Looking in iCloud* screens (1.2, 2.2, 4.3, 5.3)
- [ ] Empty Today: remove Restore from a Backup; New Habit only
- [ ] New component: Welcome (Continue with Apple, Continue with Google, Continue Without an Account); Apple's and
      Google's buttons in their makers' own required look
- [ ] Apple's and Google's sign-in sheets, drawn as Native UI (we don't build them)
- [ ] Flows: new without an account; new with an account; back with an account; back on the same iPhone with no account
      (key kept in the Keychain, to be checked on the phone); no internet while signing in
- [ ] No Internet: words about signing in, not iCloud
- Open: Welcome's line above the buttons; draw the same-iPhone flow now or after testing; no internet shows Try Again only
  (recommended) or also Continue Without an Account

## Settings (page `781:34017`) — don't forget

- [ ] **Export My Data** stays: all habits and logs in one file, readable in Excel or Numbers (A127)
- [ ] **Import** stays, as a quiet row; the *This File Isn't a Backup* and *Update to Open This Backup* alerts move here
      from onboarding (A127)
- [ ] The backup file no longer carries Plus (drop `plus` from `manifest.json`)
- [ ] iCloud page and Backup & Sync's iCloud parts go
- [ ] Account: sign in with Apple or Google later; shows who is signed in
- [ ] Delete My Data: erases the account and everything on the server; the phone keeps its copy unless they erase it too
- [ ] Signing in later when the phone already has habits and the account has others: merge both, never replace (system
      design question)

## Plus (page `1166:15123`)

- [ ] The screen right after buying: ask for an account so Plus and the habits come to every device (buying never waits
      for an account)
- [ ] At a limit: Get Plus or Watch an Ad (4 habits, 2 routines; Year in Pixels per habit)
