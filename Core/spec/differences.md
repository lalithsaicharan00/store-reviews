# Differences found

What the iPhone does (12 October 2026) that looks wrong or surprising. The shared rules keep every one exactly as the
iPhone does it, and the golden cases record it so, until the user decides (Rulebook: a product rule changes only with the
user's say-so; build prompt §3.2). Each says what people would see if it changed.

| # | What the iPhone does | Where | Would a fix change what people see? | Status |
|---|---|---|---|---|
| 1 | `isDue`, `dayProgress`, `progress`, `periodTotal` and `quitRuns` took "now" from the wall clock while everything else took it from the store's clock. | HabitStore | No: in the app the store's clock is the wall clock. Only the in-app checks set another. | **Fixed** 12 Oct 2026 (Current Work 92): they take the store's clock; the app's numbers are unchanged. |
| 2 | `isComplete` asks whether a flexible goal's period is met using the habit's **current** schedule, not the schedule of the day asked (S-6). | G-7 | Only for a day under an older rule whose kind differs: an old "3 days a week" day would not count its met week as complete once the habit became "every day". Rare. | Kept; asking the user. |
| 3 | A quit habit's page statistics take a day's start as midnight **plus** the day-start hours, not the start hour on the clock (DAY-11). | `dayStartMoment` | On the two nights a year the clocks change between midnight and the day start, a run's part inside a period is an hour off in the statistics. | Kept; asking the user. |
| 4 | A habit with no start date starts on the **calendar** date it was made, not the person's day (DAY-9). | `startDay` | A habit made between midnight and the day start (before the 6 Oct 2026 form fix, which saves a start date) would start "tomorrow". | Kept: only habits made before 6 Oct 2026. |
| 5 | Days are worked out in the phone's own calendar. On a phone set to a non-Gregorian calendar (Buddhist, Japanese, …) every day's year is that calendar's (2569 for 2026 in the Buddhist calendar), and those days are saved and synced. The shared rules are Gregorian (DAY-8). | `HabitStore.calendar` | Yes, on such phones: moving to the shared rules would read their saved days differently. | Kept on the iPhone's calendar until the user decides; the switch (checkpoint 2) keeps the Swift path on a non-Gregorian phone. |
