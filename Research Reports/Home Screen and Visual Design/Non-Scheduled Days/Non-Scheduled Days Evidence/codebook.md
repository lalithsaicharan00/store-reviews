# Weekday-schedule display codebook
One line per candidate in codes/<batch>.txt: `idx<TAB>CODES<TAB>short note`. A review can carry several codes.
"Off day" = a day the habit is not scheduled (e.g. a Mon/Thu/Fri habit on Tuesday), or a rest day the user sets.

| Code | Meaning |
|---|---|
| MISS- | Off days shown or counted as missed / failed / red / X / empty in history, calendar or week view (complaint) |
| STRK- | Streak breaks or resets because of off days (complaint) |
| PCT- | Percentage / success rate / stats dragged down by off days (complaint) |
| OFF+ | Praise: off days don't count against streak or stats; streak follows the schedule |
| TODAY- | Complaint: habits not due today still appear in the Today list (clutter, confusion) |
| HIDE+ | Praise: only habits due today appear; off-day habits hidden from Today |
| HIDER | Request: hide habits on days they're not scheduled |
| SEE | Wants to see or reach non-due habits anyway (see upcoming, do early, do on another day, "show all") |
| EXTRA | Wants to log a habit on an off day (bonus / make-up), or complains it can't be ticked |
| GREY+ | Praise: off days shown distinctly in history (grey, dash, blank, dot, "rest") |
| GREYR | Request / wish: off days shown distinctly in history instead of as misses |
| HISTR | Wants history/calendar that only shows scheduled days, or other schedule-aware history view |
| SKIPR | Request for a manual skip / rest-day / vacation / freeze so a day doesn't count (workaround need) |
| SKIP+ | Praise for skip / rest-day / freeze feature |
| FLEX | Wants "X times a week" (any days) instead of fixed weekdays, or says fixed days don't fit life |
| SCHR | Requests weekday scheduling (missing feature) |
| SCH+ | Praises weekday scheduling (feature present, no display detail) |
| SCH- | Weekday scheduling buggy / wrong day / hard to set |
| X | Not relevant (calendar/work schedules, "day off" at work, spam, other meanings) |

Context tag (computed, not coded): habit app / native app / non-habit Play app.
| SKIP- | Against skip / rest-day marks (e.g. "cheating", hides a real break) |
| GREY- | Off-day marker is confusing, looks like a completion, or inflates the streak |
| NOCHK | Should not be able to tick a habit on a day it is not scheduled (opposite of EXTRA) |
| CALOFF | (Calendar/planner context) wants rest / non-working days visibly marked in the calendar (colour, 休, red dates). Analogue evidence, not habit-specific |
| SEE+ | Praise: can see upcoming / future days habits (planning view) |
