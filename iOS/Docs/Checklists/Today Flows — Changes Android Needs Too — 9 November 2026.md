# Today Flows — Changes Android Needs Too — 9 November 2026

Written by Claude (Claude Code), 9 November 2026, at the user's request: "note down the updates … in a separate page.
Whatever we have updated, if those kind of updates also need in the Android, so just note them down … If it is only
related to iOS, just you can ignore it."

These are the changes made while reviewing the iPhone Figma file's Today flows (8–87, page `54:5580` of
`zLgBjb7M7Fp6UN0pg7J3a8`) that are about **what the app does or says**, so they apply to Android too (the two apps
behave the same: the user, 11 Oct 2026). iPhone-only fixes (swipe capsules, sheet glass, calendar popover size,
alert surface, iOS text sizes, iCloud wording) are left out. The full log is
[Today Flows — iPhone Review](<Today Flows — iPhone Review — 9 November 2026.md>).

Each item says whether it is a **new decision** to build on Android, or a **bug found in the iPhone file** that the
Android Figma file and app should be checked for (the iPhone file was copied from Android's, so the same slip may be
there).

## New decision

1. **The day's title is a date on every day but today** (Android A119, Rulebook "Starting again", 9 Nov 2026). Today
   says **Today**; yesterday says **8 Nov**, tomorrow **10 Nov**, any other day the same: the day's number, a space,
   the month's three letters with only the first a capital. Never "Yesterday" or "Tomorrow", no weekday. Only the
   words change; the bar, its ring and its count stay. **Build on Android.**
2. **Day details for another day is titled by that day's date,** never "Today" (flow 38). Follows from 1.

## Check the Android file and app for these

3. **Free, no Plus on Today.** The "Plus is waiting for payment" notice was deleted from the iPhone's Today page (the
   app is free; Plus comes later as new features). Remove it from Android's Today flows too.
4. **Cut-down rows say "max", and minutes are "mins"** (the user's point 9): "0 of 2 cups max", "0 of 30 mins max",
   "12:40 of 30 mins max". "Limit reached · 2 of 2 cups" and "Over the limit · 42 of 30 mins" have no "max" (they
   already say it's a limit), but still use "mins".
5. **A part-done row fills by its own numbers:** 1/3 a third, 1/4 steps a quarter, 12/20 min 60 %. Every part-done
   fill in the iPhone file was 40 % whatever its count.
6. **The day bar's count follows every change:** reaching a goal adds one (4/13 → 5/13); a skipped day or a paused
   habit leaves the total (4/13 → 4/12); undo puts it back; a task done on Today counts (A86). Many screens had the
   count of a different moment, and "N left" disagreeing with the rows (Water at 5 of 8 counted as done).
7. **Undo · Note stay until a new log is made.** Closing a milestone pop-up, a milestone bar timing out or the band
   appearing doesn't remove them; only a log on another row (or Undo) does (flows 66, 68–73, 76, 77, 85).
8. **A timer's milestone plays when the clock crosses the goal,** not when ⏸ is tapped (flows 62, 66).
9. **A pop-up's next milestone uses the title's words:** under "26 weeks of goals met" the next is "52 weeks of goals
   met", never "52 weeks in a row" (flows 71, 72). "Every month since …" counts back from today (six months to
   November start in June).
10. **A row for a day that ended unmet shows no streak** (A113, ST-1a): yesterday missed, no 🔥 on yesterday's row or
    on today's (flows 37, 86; Skincare at 3/4 too). Already an Android rule; the iPhone screens had broken it.
11. **A milestone's streak matches the milestone:** a row reaching "30 days in a row" shows 🔥29 before and 🔥30
    after, never 🔥4 → 🔥30 (flows 62, 63, 76).
12. **A quit habit's "Since" date matches its run clock** (30d → "Since 10 Oct" on 9 Nov). Several screens disagreed.
    Note: flows 11–48 treat today as 21 Oct and the milestone flows as 9 Nov; each flow is consistent with itself.
13. **A folded time of day's icons are its own habits,** in their order and colours, with "+N" only when there are
    more than three (flow 80).
14. **Showing Quitting never hides Anytime.** Screens had drawn Quitting by renaming the Anytime section, so Read,
    Call family and Water vanished (flow 64).
15. **A task on Today is its own row,** at the end of its section; it must never be drawn over a habit's row (flows
    17, 31).
16. **A new item is added with Add, an existing one saved with Save:** New Time of Day ends in Add, Edit Time of Day
    in Save (flow 55).
17. **"Discard this note?" is destructive:** Discard in the red that Delete uses, Cancel plain (flow 36; D9's rule for
    Delete, applied to Discard).
18. **A row's second line wraps instead of being cut:** "Over the limit · 42 of 30 mins" lost its limit when cut at
    one line (flow 48; the Rulebook's 31 Oct rule). The iPhone's Habit row component still cuts; Android's should be
    checked too.
19. **A notice's dismiss is its ✕,** never "Not now" or "Dismiss" (flows 42–46): notes and labels still said
    "Not now hides it for 7 days".
20. **Pausing until a date opens on tomorrow** and selects the day tapped (flow 22): the calendar copies all had 25
    selected.
21. **The day bar's middle keeps one width** (the user, 10 Nov 2026: changing width "will cause layout shift"). Going
    from Today to a date, or between dates, the ring, the words and the count stay where they are: the words sit in a
    slot as wide as the widest date ("28 May") and are centred in it.
22. **A cut-down row's state is a band, not words in its goal line** (the user, 10 Nov 2026; waiting for the user's look
    at the iPhone's Figma before it becomes an Android decision). The line under the name is only the limit ("2 of 2
    cups max", "42 of 30 mins max"); "Limit reached" and "Over the limit" move to a neutral band under the row, in the
    milestone band's place, with an hourglass and no medal, colour or sparkle. Past the limit the streak goes; at the
    limit it stays. This replaces A41's and A105's "Limit reached · 2 of 2 cups" on Android once approved.

