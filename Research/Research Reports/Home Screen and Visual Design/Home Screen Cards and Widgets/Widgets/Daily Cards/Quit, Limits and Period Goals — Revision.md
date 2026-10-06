# Quit, Limits and Period Goals — Revision

Written by Codex, 5 October 2026. Research and editable design revision for Current Work item **9**. Audited remote main: `f0e52f46d8ef4641b247aa8b243d1728777b3440`. This supersedes the original quit/slip-count card and contribution-only period subtitle in the daily-card study. App implementation and iPhone acceptance remain open (U9).

## What changed

Open the [focused revision panel in Figma](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=560-4241). The accepted shared card remains: icon and one action, habit name on its own line, value immediately beneath it, and a bottom capsule. Each study card retains 16-point outer insets and a minimum 44-point action target.

![Revised quit, limit and period-goal examples](<Images/Quit Limits and Period Goals.png>)

| Case | Main value / context | Visible action |
|---|---|---|
| Quit completely | **15d 22:36:35** on one emphasized line; **Best 45 days** in the capsule | Quiet arrow opens Record a slip |
| After a slip | **0d 00:04:12**; best run remains derived from legitimate history | Same slip route |
| Quit paused | **Paused**, without a ticking or invented current run; best remains | Same input route subject to current app eligibility; resume in the app |
| Quantity limit below | **1 of 2 cups**; emphasized **Daily limit** | Quiet `+1` |
| Quantity limit reached | **2 of 2 cups**; **Limit reached** | Still allow actual consumption to be recorded |
| Quantity limit above | **3 of 2 cups**; **Over the limit** | Same precise logging action |
| Time limit below / running | **10 of 20 min** / **12:36 of 20 min**; **Daily limit** | Quiet Play / Pause |
| Time limit reached / above | **20 of 20 min** / **25 of 20 min**; **Limit reached** / **Over the limit** | Follow actual timer state |
| Weekly total | **3 h a week** as the subtitle; **12 min today** in the capsule | Normal duration action |
| Monthly count | **10 times a month** as the subtitle; **2 checks today** in the capsule | Add exactly one check |

The user's subsequent layout correction is incorporated: the quit title is **not** moved into the icon header, and days and the clock are **not** split into two text rows. All four elapsed units are represented in one stronger line. The earlier split-counter component and its unused tokens/styles were removed from our new study.

## Compact duration notation

The recommended English Small-card format is **`15d 22:36:35`**: days, followed by hours:minutes:seconds. The elapsed line is SF Pro **17 semibold**, compared with the ordinary value line's 15 regular. The name keeps its own line. This satisfies “bigger or darker” without adding another line or compressing the outer padding.

This is a reasoned UI choice, not evidence that one string is universally preferred. Unicode CLDR provides localized narrow unit patterns for restricted space; English includes `d`, `h`, `m` and `s`, while other languages use their own labels. Apple documents colon-separated hour/minute/second positional formatting. Production should use locale-aware duration formatting and a full spoken value, such as “15 days, 22 hours, 36 minutes, 35 seconds.” Do not read `d` or colons literally to VoiceOver. [CLDR unit widths](https://cldr.unicode.org/translation/units/unit-names-and-patterns), [CLDR duration data](https://unicode.org/cldr/charts/49/by_type/units.duration.html), [Apple positional units](https://developer.apple.com/documentation/foundation/datecomponentsformatter/unitsstyle-swift.enum/positional).

International measurement notation uses lowercase `d`, `h`, `min` and `s`; the scientific minute symbol is `min`. The widget's narrower English `m` form is contextual UI notation, not a claim that `m` is the scientific time-unit symbol. Avoid treating uppercase `D/H/M/S` as a universal localization system. [BIPM SI Brochure, Table 8](https://www.bipm.org/documents/20126/41483022/SI-Brochure-9.pdf/fcf090b2-04e6-88cc-1149-c3e029ad8232).

Figma natural-width comparison at the study width of **126 points**, before copying the shared content's existing tracking:

| English string | SF Pro Semibold size | Measured width | Result |
|---|---:|---:|---|
| `15d 22h 36m 35s` | 15 | 128 | Does not fit |
| `15d 22h 36min 35s` | 15 | 142 | Does not fit |
| `15d 22h36m35s` | 15 | 120 | Fits, but smaller and more compressed |
| `15d22h36m35s` | 16 | 124 | Fits, but loses visual separation |
| **`15d 22:36:35`** | **17** | **112** | **Selected: bigger, one line, clear separation** |
| `100d 22:36:35` | 17 | 124 | Fits at this measured English scale |
| `1000d 22:36:35` | 17 | 135 | Needs an explicit adaptation |

The final reused content's tracking measures the 15-day string at 108 points; both measurements are retained rather than presented as identical setups. Very long runs, larger accessibility sizes, localized labels/digits and right-to-left layouts still require native checks. Do not clip seconds, silently round the run, indefinitely shrink type or replace all units with months. A bounded smaller semibold value or wider widget is an implementation option to validate while preserving the one-line hierarchy and full accessible value.

## Fully quit: elapsed run, best run and only slip logging

This is an **elapsed count-up**, not a countdown to a goal and not “zero slips today.” The run does not restart at midnight. The shared store already distinguishes quit runs from at-most consumption. Use that distinction instead of making a quit habit behave like a daily check or a consumption counter.

The action opens the existing Record a slip flow. Opening does not add an entry. Save records the actual selected moment once; Cancel changes nothing. A slip recorded now starts a new run now; one recorded four minutes ago shows four minutes of elapsed time immediately. A backdated event must use the store's derived chronological history; do not blindly overwrite the anchor if a later slip already exists.

`quitHistory` builds runs from start, slips and pause/resume boundaries. `quitRuns` derives current and best from those runs. Best is not a mutable number to wipe on a slip: a prior valid 45-day run remains 45 days. If the ongoing run becomes the longest, best includes it. Correcting or undoing a slip legitimately recomputes both values from history; “retain best” does not mean freeze a historically incorrect number forever (D6/U19).

Respect existing settings and unavailable states. Today uses **Since [date]** when Show Streaks is off; the widget should follow that preference rather than force a best-run display. Pause has no ongoing run, so it must not keep an apparent active clock. Locked/private, removed, future and ended habits retain the existing guarded behavior. The paused example is a layout state, not permission to bypass existing logging eligibility.

### Native live rendering

The current widget snapshot already has **`counterStart`** and **`counterValidUntil`**, and the existing widget displays relative date text. Reuse these anchors/bounds. Add best-history data and the relevant presentation preference deliberately; do not publish a preformatted seconds-old string and call it live. Compute past best once from history, then compare it with the current run cheaply (S3/S5/S8).

Apple documents date-based Text that continues updating while the widget extension is not running. Use supported system-managed time text, with event/boundary timeline updates instead of per-second extension reloads. [Dynamic widget dates](https://developer.apple.com/documentation/widgetkit/displaying-dynamic-dates), [Keeping a widget up to date](https://developer.apple.com/documentation/widgetkit/keeping-a-widget-up-to-date).

`SystemFormatStyle.DateOffset` can request day/hour/minute/second fields and controls the maximum field count. Apple's API metadata lists iOS 18 introduction, matching this app's minimum. This establishes an available live-formatting tool, **not** proof that its default output reproduces `15d 22:36:35`: including days selects calendar-unit formatting, whereas hour/minute/second fields use clock formatting. [DateOffset](https://developer.apple.com/documentation/swiftui/systemformatstyle/dateoffset), [Initializer](https://developer.apple.com/documentation/swiftui/systemformatstyle/dateoffset/init(to:allowedfields:maxfieldcount:sign:)).

Prototype the precise compact one-line rendering in WidgetKit. The app's current `Format.elapsed` treats a day as **86,400 elapsed seconds**; calendar-day formatting must not silently disagree around daylight-saving changes. A split day-prefix/HMS implementation needs validated anchor rollover and system-managed updates for both parts. Widget timelines may be delayed, so a proposed day-boundary entry alone is not an exact-second guarantee. Do not ship a frozen day prefix beside a live clock or claim a Figma sample proves ticking. Native acceptance includes 23:59:59 → 1d 00:00:00, long runs, slip changes, background/killed app, scheduled pause/end, timezone/DST and VoiceOver (U9). [Apple timeline timing](https://developer.apple.com/documentation/widgetkit/timeline).

## Daily limits, including time

The existing limit model supports amount **and duration**. The 4 October implementation commit `f041d831` added duration selection to Cut down and preserved unit/history semantics when editing existing limits. The 5 October `c9909e63` moved limits under Quit or Cut Down on Today; `3530e98` records the relevant checklist validation. It would be incorrect to assume cut down only means cups or cigarettes.

Keep the consumed-capacity fill neutral gray, but its caption is now **13 semibold in semantic foreground ink**, rather than faint 11-point regular text. Use exact comparisons against the saved daily limit:

- Below maximum: **Daily limit**.
- Equal to maximum: **Limit reached**.
- Above maximum: **Over the limit**; retain the actual amount/time and cap only the visual fill.

“Limit reached” describes consumption, not a celebration or a final failure judgment. Today remains an open period. Do not color it red, reward reaching it, block truthful logging or erase excess (U3/U16).

Social media uses the user's **20-minute example**, not a new hardcoded product default. Play follows the existing timer preference and opens the full-screen timer by default. Pause saves the session once. Reaching 20 minutes does not automatically pause, stop or truncate the session. The reached/above review examples show a stopped timer and therefore Play; if actually still running, retain Pause. Manual time entry remains available through Day details. This is manual duration tracking; no automatic Screen Time import is claimed.

## Weekly and monthly goals

Configured goal and recorded contribution are separate facts. For period-only positive goals, the subtitle now shows the configured goal using the app's plan wording: **3 h a week**, **10 times a month**. The existing capsule shows **12 min today**, **2 checks today**. There is no period-completion fill and no invented daily denominator. The monthly example represents a count goal; it is not a fabricated two-session total for a duration habit.

Use the resolved rule effective for the displayed day, including the period count/amount and the correct unit; never hardcode these examples. `HabitCopy.plan` already supplies “a week / a month” goal descriptions. `goalLine` instead describes recorded progress with “this week / this month”; do not mistake that progress string for configured-goal copy. Flexible schedules with a real daily dose continue to show actual daily progress. The separate weekly/monthly limit samples retain neutral period-limit context and today's consumed amount; they must never be treated as daily allowances.

## Evidence and implementation handoff

Remote main was refreshed and its latest **15 commits** inspected. The relevant runtime sources are identical to the prior `d4038444` baseline; newer commits primarily address test waits, merge bookkeeping and current validation/performance notes. The exact commit inventory and source hashes are in [Main Audit.json](<Main Audit.json>).

Relevant existing reports were checked: [Time Limits — Should Cut Down Allow Time](<../../../../Habit Creation/Time Limits — Should Cut Down Allow Time.md>), [Limit Habits on Today — Apart From What You Must Do](<../../../../Day Structure and Organization/Limit Habits on Today — Apart From What You Must Do.md>), and the accepted app design rules. Their evidence is attributed earlier research. The [daily review audit](<Review Audit.md>) retains 37 complete originals; this revision makes **no new review-prevalence or universal format-preference claim**. Its hierarchy follows the user's correction, with the notation choice supported by primary formatting guidance and measured geometry (W2).

The revised package contains **40 PNGs: 36 individual cards and four boards/layouts**, **29 base variants**, a separate **four-state timed-limit family**, and a paused quit component. Earlier Free/Plus catalogue sections retain their IDs and bounds. No app source or production data is changed. [Figma Audit](<Figma Audit.json>), [Export Manifest](<Export Manifest.json>), [Validation Results](<Validation Results.json>) and the [request checklist](<../../../../../../iOS/Docs/Checklists/Daily Widget — Layout and Actions — 5 October 2026.md>) separate completed research/design checks from pending native implementation.
