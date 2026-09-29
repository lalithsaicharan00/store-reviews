# Focus player — compact progress and fast navigation

Written by Codex, 29 September 2026.

## User requests

- [x] Remove the noticeable delay when tapping the bottom habit/Next card.
- [x] Reduce the habit icon substantially and the title slightly; keep the title centred in the same hierarchy.
- [x] Remove repeated schedule sentences such as “3 times a day” and “Every day”.
- [x] Put progress below the title: a compact bar and current/target value.
- [x] Show the period in a small distinct label (Today, This week, This month, This year).
- [x] Timed habits show elapsed time / target with its unit and period.
- [x] Apply the presentation to checks, amounts, timers, checklists and tasks; preserve limit semantics and flexible daily/period goals.
- [ ] Device UI verification: automation was stopped at the user’s explicit request. No automated test result is claimed.
- [x] Build and install the resulting app on the connected iPhone (iPhone 16, 29 September 2026).

## Investigation and implementation rationale

Direct inspection found that `navigate` waits for `store.flush()` before changing the page, then waits again when starting a timer, rejecting further navigation while busy. Timer start/stop already update memory immediately and queue ordered writes, so navigation can use those operations synchronously. Save errors remain surfaced by the existing store alert. Page transitions should update the page and index together, avoiding a second deferred animation.

The existing hero repeats the schedule, standalone oversized count, explanatory count caption, progress bar and completion message. The user's requested compact current/target plus a period badge replaces those redundant labels. Amount units, maximum limits, checklist steps, and flexible-day quotas remain meaningful and must be retained. This is based on the user's feedback and inspection, not a new research study.
