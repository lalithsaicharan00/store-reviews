# Settings — What People Need There

Written by Claude (Claude Code), 29 September 2026. Build Plan #61. The avatar on Today opened nothing, and two settings the app already honours (when the day ends, the first day of the week) could not be changed. The Feature Ledger decides most of it: [C170](<../Feature Ledger.md#c170>) configurable day boundary (21 apps), [C038](<../Feature Ledger.md#c038>) week starts correct everywhere (36 apps), [C157](<../Feature Ledger.md#c157>) and [C207](<../Feature Ledger.md#c207>) guilt mechanics and unused surfaces can be switched off, [C288](<../Feature Ledger.md#c288>) a way back after declining notifications, [C075](<../Feature Ledger.md#c075>) a searchable help screen (37 apps, Certain), [C036](<../Feature Ledger.md#c036>) a support channel (63 apps, Certain), [C085](<../Feature Ledger.md#c085>) privacy stated plainly, and [C236](<../Feature Ledger.md#c236>) a free limit that announces itself.

## Answer

A sheet from the avatar, applied at once, with only these:

1. **Plan:** Free, "3 of 5 habits", and Plus… (C236, C110: the limit is never a surprise).
2. **Day Ends At, from midnight to noon.** Anything logged before it counts for the day before. Not capped at 5 am: night shifts end at 8 am.
3. **Week Starts On, any day.** Not fixed by region.
4. **Times of Day**, the same editor as on Today (C142: settings is where people look for it).
5. **Show Streaks**, on by default. Off hides the flame on Today; streaks are still counted and shown on the habit's page.
6. **Notifications:** when they're off for the app, say so and link straight to iOS Settings (C288).
7. **How It Works**: short, searchable answers that name the exact place to tap (C075). **Contact Support** once an address exists (C036).
8. **Privacy:** "Your habits stay on this iPhone. No account, no ads and no tracking." (true of the free app today; C085, C218).

## What the reviews say

Scans of 1,238,784 App Store and Play Store reviews (`Research/Temp/scan.py` and a keyword pass), with the samples read by hand.

| Theme | Reviews | Apps | Mean ★ |
|---|---|---|---|
| Choose when the day ends or resets | 576 | 70 | 3.83 |
| Choose the first day of the week | 181 | 49 | 3.75 |
| Help, instructions, a tutorial or FAQ missing | 482 | 67 | 2.69 |
| Hide or turn off streaks (stress, guilt) | 77 | 23 | 3.96 |

**The day's end.** Of the times people name, 1–4 am lead (94 mentions), then 5–8 am (42), many from shift workers: "Since I work night shifts, my day ends at 8:00 AM. Could you kindly check if this feature can be implemented?" (Habit Tracker, `12646626749`); "I go to bed at 5am and want to check off my successes for the day but the app is reset for a new day already" (Finch, `12076823283`); "it would be helpful if the finch day ended later, maybe 3am, rather than midnight" (Finch, `8732228595`). Where the setting exists it's recommended to others: "I recommend going in settings and changing the time the day starts and end so you won't mess up your streak on accident" (Finch, 5★, `11453299551`). The ledger records caps that failed: 11:45, 5 am, "5–10 am" (C170). Hence midnight to noon, in whole hours.

**The week's start.** "Recent change to this app where starting day of the week is set by region 'according to local custom' spoils this app for me" (Productive, 1★, `1764087912`); "If I choose to run 3x a week, and I do this on Tuesday, Thursday & Sunday, it doesn't count" (Productive, 4★, `1370025811`). Monday and Sunday dominate; Saturday is asked for too (ShineDay, `4385664490`). Hence all seven, defaulting to the phone's region but always changeable.

**Streaks, optional.** "Please provide an update where I can turn off the streak counter!" (Finch, 4★, `14035312424`); "I wish there was a way to remove the streak counter" (ShineDay, 4★, `8582609673`). Where it's offered it's praised: "I LOVE that I can disable the 'streaks' feature in preferences. While streaks … are supposed to be motivating, they do the opposite for me" (Finch, 5★, `11507675536`); "I love that you can enable/disable streaks" (HabitKit, 5★, `12277559306`). Streaks are also among the most-praised mechanics (C024, 30 apps), so the default stays on.

**Help.** "No instructions — I just purchased this app … It may well be a five star app, but without instructions it's useless me" (Habit Tracker, 1★, `12893999772`); "there aren't any instructions or a Q&A section. This makes it frustrating to use so I'm going to delete" (Habit Tracker, 2★, `13513202791`); "how do I delete a habit I've created. Super basic, right?" (Habit Tracker, 1★, `9216012935`). The answers cover what reviews show people can't find: undo, backfilling, deleting a log, skip vs pause, how streaks and percentages count, a day that ends after midnight.

## Reasoned from first principles

- **A sheet, applied at once:** the avatar opens an account-and-settings sheet across iOS; values save as they change, like iOS Settings, and Done closes it.
- **Nothing changes the past:** entries store the day they count for, so a new day end or week start never moves a logged day (the footer says so). Weekly goals and streaks are recounted with the new week, which is what the setting is for.
- **Few rows:** every row answers a documented need; nothing speculative (C006: stay minimal).

## Not built, and why

- **A support address:** the Contact Support row is ready and hides until an address is set (`AppInfo.supportEmail`); it must exist and answer before release (C036).
- **Passcode lock** (C017, Strong but minor), **language picker** (C255: needs localisation first), **export and backup** (next loop), **sounds and haptics** (next loop, which adds its switch here).

## Limits

Keyword counts are floors. The layout is reasoned, not tested with people.
