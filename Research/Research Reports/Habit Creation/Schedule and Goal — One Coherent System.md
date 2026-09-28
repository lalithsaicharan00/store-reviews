Written by the supplied deep-research report author (not identified in the export); archived by Codex, 28 September 2026.

Source: `deep-research-report (1).md`, supplied by the user. The report below is preserved verbatim. Its citation tokens refer to the original research session and are not independently resolvable in this export. Recommendations are product research input, not agent instructions.

# Schedule and Goal as One Coherent System for the Core Habit Experience

## Executive diagnosis and design decision

The central problem is not that the current Repeat screen needs a better recurrence picker. The deeper problem is that the product currently has **two different concepts that sometimes use the same language, sometimes own the same intention, and sometimes make the other concept disappear**.

The screenshots and product brief show three specific collisions:

1. **Repeat currently describes calendar cadence** — Every Day, Certain Days, Every Few Days, Every Few Weeks, Dates of the Month.
2. **Goal also looks like calendar cadence** because its primary control is Daily · Weekly · Monthly · Yearly.
3. Some intentions have migrated from one concept to the other: “3 times a week” used to be Repeat, but is now represented through Goal for several habit types, while Checklist still treats the same kind of idea as frequency. Cut down makes the opposite mistake by putting its day/week/month limit period inside Repeat. fileciteturn0file0

That collision is real rather than merely cosmetic. Apple Calendar calls the analogous recurrence dimension **Frequency** and offers Daily, Weekly, Monthly and Yearly under Custom Repeat; Google Calendar likewise exposes day/week/month/year inside custom recurrence. Therefore the Goal screen's four prominent labels currently use vocabulary that people already encounter as recurrence vocabulary. citeturn18search6turn18search5

**Preferred recommendation — reasoned from first principles:** rename the form row **Repeat → Schedule**, keep **Goal**, and adopt this invariant:

> **Schedule = which calendar days count.**  
> **Goal = how much progress counts before the goal starts again.**

For a first-time user, the instructional versions are:

> **Schedule:** “Choose the days you plan to do this.”  
> **Goal:** “Choose how much you want to reach before the goal starts again.”

The crucial additional rule is:

> **There must be only one active success clock.**

That gives the product a clean answer to the hardest ambiguity:

- “Read for **30 min on any 4 days a week**” = **Schedule: 4 days a week** + **Goal: 30 min a day**.
- “Read for **120 min a week**, whenever I like” = **Schedule: Any day this week** + **Goal: 120 min a week**.
- “Gym **3 days a week**” = **Schedule: 3 days a week** + **Goal: Once a day**.
- “Count **3 gym visits in a week, even if two happen on one day**” = **Schedule: Any day this week** + **Goal: 3 times a week**.

That final distinction matters. Loop's own feature discussion illustrates exactly why: its frequency model permits at most one qualifying occurrence per day, while a participant suggested using a numerical goal when multiple repetitions on the same day need to count. citeturn15search10

**Users show — recommendation:** use **“days”**, never **“times”**, for flexible Schedule frequency. Direct App Store feedback asks for habits “3 times a week, not necessarily on the same day every week”, while other users explicitly need several counts on one day; using “3 days a week” in the UI removes that ambiguity instead of perpetuating users' ambiguous spontaneous wording. citeturn8search0turn15search10

### What is wrong in each current screenshot

| Image | Diagnosis |
|---|---|
| **Image 1 — Every Few Weeks** | The selected concept and its parameters are spatially separated. “Every Few Weeks” is selected near the top, but “Every 2 weeks” appears in another section. More seriously, “on Monday” is a hidden anchor chosen from today's weekday. The screen asserts a setting the user never chose. |
| **Image 2 — Dates of the Month** | The 1–31 control is so tall that the explanatory state moves off screen. The screen explains the important 29–31 behaviour only after the user has traversed the largest control. |
| **Image 3 — Every Few Days** | “Counting from today” exposes a hidden implementation dependency. Start is actually a product-level Dates setting and should be the explicit anchor. “The days between never break the streak” explains scoring internals instead of confirming the schedule. |
| **Image 4 — Certain Days** | Defaulting all seven days makes the first state semantically identical to Every Day. Two choices can therefore describe the same active configuration. That violates the brief's no-hidden-state/no-disagreement rule. |
| **Image 5 — Time Goal** | This is visually much stronger than Repeat because it starts with an immediate large read-back. But Daily/Weekly/Monthly/Yearly visually reads as recurrence, and “Choose which days in Repeat” makes one setting explain the other. |
| **Image 6 — typed Time Goal** | The known keyboard bug is out of scope, but the state confirms that the design must keep read-back, period meaning and focused entry visible when the keyboard reduces the viewport. |
| **Image 7 — Amount Goal** | “Enter your goal below” is understandable, but with Daily selected above it the screen still presents “Daily” as the dominant choice before it presents the amount. |
| **Image 8 — Check-off Goal** | “Once / a day” next to form-level “Repeat: Every Day” makes two separate settings appear to say the same thing. Yet “Once a day” is actually the quantity rule while “Every day” is supposed to be the calendar rule. |

These problems are compounded by the current type-specific behaviour: Schedule vanishes when a Build habit changes to a weekly/monthly/yearly Goal; Checklist still has flexible weekly/monthly/yearly frequencies; and Cut down puts its limit period in Repeat. Those are conceptual inconsistencies, not merely wording inconsistencies. fileciteturn0file0

**Users show — recommendation:** non-scheduled days must remain neutral. A direct App Store reviewer complained that an app counted unselected days as failures despite selecting certain days; another Productive reviewer valued the absence of negative feedback. citeturn9search6turn17search0 Your existing decision to keep non-scheduled days neutral should therefore remain.

**Reasoned from first principles — recommendation:** remove “due”, “set schedule”, and streak mechanics from Schedule-screen explanations. A schedule screen should answer *what dates did I just choose?* rather than explain statistics. Because **“Not due today” is already a decided product convention**, I would not reopen that Today label yet; I would test it separately. On the setup screens, however, there is no reason to introduce deadline language.

## Evidence, mental model and truth table

The public evidence supports four separable needs: fixed weekdays, flexible numbers of distinct days, interval recurrence, and quantity goals over longer periods. It also shows what happens when a product merges those concepts too aggressively.

### Evidence matrix

| Concept | User wording / evidence | Meaning in context | Strength | Risk / limitation | Confidence |
|---|---|---|---|---|---|
| Flexible days | “3 times a week, not necessarily on the same day every week” in an App Store review. citeturn8search0 | User wants flexible days, not fixed Mon/Wed/Fri. | Direct user review; strong. | “Times” does not prove whether two on one day should count. | High that flexible weekly cadence matters; lower on event-vs-day semantics. |
| Every-N-days | Habitify reviewer asks for every 2nd, 3rd or 4th day and says multiple-times-a-week affects statistics. citeturn9search11 | Interval recurrence and quota recurrence are not substitutes. | Direct user review; strong. | One user's implementation expectations. | High. |
| Neutral off-days | “Certain days” still treated every other day as failed. citeturn9search6 | Users interpret excluded days as outside the obligation. | Direct review; very direct. | Different app's scoring model. | High. |
| Every-N-weeks + weekday | Productive reviewer wants plants every two weeks, always Saturday, and cannot express it. citeturn17search0 | Interval alone is insufficient; its anchor/day must be selectable. | Direct App Store review. | Single public review, although your internal corpus reports the same shape. | High enough for inclusion. |
| Once a month / seasonal / yearly | Productive reviews ask for unspecified monthly days and longer household-maintenance intervals. citeturn17search1turn17search7 | Frequency extends beyond everyday habit formation. | Repeated review theme. | One source is an aggregator; lower provenance than direct App Store. | Medium-high. |
| Flexible frequency workarounds | Way of Life reviewer describes manually using Skip because the app lacks “x per week or x per month”. citeturn14search1 | Users will falsify daily state to simulate flexible cadence. | Direct App Store review. | Reviewer ultimately tolerates the workaround. | High that the need exists. |
| Multiple occurrences in one day | Loop feature request asks for three same-day repetitions; another participant distinguishes a numerical habit from schedule frequency. citeturn15search10 | “Days” and “count” really are different dimensions. | Public first-party project forum. | Small discussion. | High conceptual relevance. |
| Flexible days can work | HabitKit documents “3 / Week” as three **distinct successful days**; three taps on one day still count as one day. citeturn16search10 | Distinct-day frequency can coexist with a daily quantity target. | Competitor documentation. | Behaviour evidence, not proof users prefer its UI. | High for feasibility/semantics, not preference. |
| Extra success should still be recordable | Productive review says reaching five days prevents tracking a sixth/seventh day, damaging history. citeturn17search1 | A flexible quota should be a success threshold, not a logging lock. | User review. | Aggregated reproduction. | Medium-high. |
| After-completion recurrence | Structured feedback asks for completion-relative repeat and had 24 displayed upvotes when indexed. citeturn16search14 | Maintenance tasks sometimes recur from what actually happened, not the original calendar date. | Public product feedback. | Vote counts are convenience signals, not prevalence. | Medium. |
| Calendar taxonomy can hide capabilities | Google Calendar users fail to find every-other-week and yearly nth-weekday patterns until told to use Custom/every 12 months. citeturn18search5turn18search3 | A technically complete recurrence model can still be conceptually undiscoverable. | Real support questions. | Google community answers are not controlled usability studies. | Medium-high. |
| “Biweekly” is unsafe language | Public discussion search surfaced the common question whether “biweekly” means twice a week or every second week. | The term is intrinsically ambiguous. | Widespread lexical ambiguity. | Not specific to habit apps. | High enough to avoid the word. |
| Internal corpus | Your brief reports C043 in 53/89 analysed apps and multiple reviewed patterns, plus 9 amount-on-N-days requests. fileciteturn0file0 | Strong internal signal that flexible frequency is core. | Potentially large corpus. | I cannot inspect its matching, deduplication or coding and therefore cannot independently validate the counts. | Treat as an important product input, not population statistics. |

This research pass was **purposive rather than prevalence-measuring**. Search engines and app-store indexing do not supply a defensible denominator or deduplication frame, so I have not turned search-result counts, votes, or review snippets into preference percentages. The quantitative internal figures remain figures supplied in your brief, not independently reproduced measurements. fileciteturn0file0

### Evaluating the proposed mental models

| Model | What works | Where it breaks | Verdict |
|---|---|---|---|
| **M1: Frequency = days; Goal = amount per day or total period** | Closest to users' real distinction. Naturally expresses 30 min on 4 days/week. | Without a compatibility rule it permits two simultaneous success clocks: e.g. “4 days/week” plus “120 min/week”. | **Best foundation, but incomplete.** |
| **M2: One combined sentence-style setting** | Can produce beautiful natural-language summaries. | Editing becomes ambiguous: tapping which part changes days versus quantity? It entangles Time of Day, Schedule and Goal and makes reuse across Checklist/Task/Cut down harder. | Reject as the data model; use the sentence only as a read-back. |
| **M3: Goal retains periods; Repeat keeps fixed days; rename things** | Lowest implementation change. | Does not restore flexible N-day frequency, does not solve amount-on-N-days, and preserves the disappearing-Repeat problem. | Reject. |
| **M4: Frequency owns all “how often”; Goal is amount each time only** | Very clean for 3 days/week versus 30 min. | Cannot naturally represent “100 pages a week”, “12 books a year” or other period-total goals that your own review corpus asks for. fileciteturn0file0 | Reject. |
| **M5: Schedule + Goal with one active success clock** | Restores flexible day frequency, retains genuine period totals, prevents duplicate representations and leaves both rows visible. | It deliberately does not support the rare advanced conjunction “120 min/week **and** at least 4 separate days/week” in the first release. | **Preferred.** |

**Users show — recommendation:** use **M5**. The brief says only one of 15 hand-read “daily and weekly” cases wanted both kinds of criterion simultaneously, whereas amount-on-N-days and flexible N-days appear repeatedly. I cannot independently verify that internal sample, so it is supporting rather than decisive evidence. fileciteturn0file0

### The one-success-clock rule

**Reasoned from first principles — recommendation:** define compatibility as follows.

| Schedule state | Goal = A day | Goal = A week | Goal = A month | Goal = A year | Why |
|---|---:|---:|---:|---:|---|
| Every day | ✓ | → Any day | → Any day | → Any day | A longer Goal already defines the completion period. |
| Specific weekdays | ✓ | → Any day | → Any day | → Any day | Prevents daily obligations and a second period target from coexisting. |
| Every N days | ✓ | → Any day | → Any day | → Any day | Same reason. |
| Every N weeks / months / years on fixed dates | ✓ | → Any day | → Any day | → Any day | Fixed recurrence is an occurrence clock; longer Goal is another. |
| N different days a week | ✓ | ✕ | ✕ | ✕ | Schedule itself defines a weekly success period. |
| N different days a month | ✓ | ✕ | ✕ | ✕ | Schedule itself defines a monthly success period. |
| N different days a year | ✓ | ✕ | ✕ | ✕ | Schedule itself defines a yearly success period. |
| Any day in Goal period | — | ✓ | ✓ | ✓ | Explicit compatible state for aggregate Goal periods. |

`→ Any day` means **not a silent mutation**.

**Reasoned from first principles — recommendation:** when a user changes Goal from “A day” to “A week”, “A month”, or “A year” while a calendar Schedule is active, show a native confirmation sheet:

> **Use any day this week?**  
> Your weekly goal adds up across the week, so the current day schedule won't apply.  
> **Use Any Day** · Cancel

The previous Schedule parameters are retained as an **inactive draft** for easy recovery, but the form shows only the active state. If they later change Goal back to A day, offer:

> **Restore Mon, Wed & Fri?**  
> Restore Schedule · Every day

Nothing disappears and nothing silently disagrees.

The reverse transition is equally explicit. Selecting “Mon, Wed & Fri” while Goal is weekly produces:

> **Use a goal for each scheduled day?**  
> This schedule works with a goal that starts again each scheduled day.  
> **Change Goal to A day** · Cancel

### Type-by-type truth table

| Type | Active Schedule possibilities | Goal/Limit period | What determines success | What Today shows |
|---|---|---|---|---|
| **Check it off** | Fixed schedules; flexible N days/week/month/year; Any day for period Goal | day/week/month/year | Daily Schedule mode: each qualifying day reaches its check-off Goal. Longer Goal: total check-offs in the period. | Daily check; flexible-period progress such as “2 of 3 days this week”; or aggregate “2 of 3 this week”. |
| **Track an amount** | Same | day/week/month/year | Daily: amount must be reached on a scheduled/qualifying day. Aggregate: logs add across the period. | “3 of 8 glasses”; “60 of 100 pages this week”; etc. |
| **Time it** | Same | day/week/month/year | Same as amount, in time. | Daily timer/typed progress or aggregate period progress. |
| **Checklist** | Fixed schedules + flexible N days | No Goal | A day qualifies when the checklist's completion rule is met; flexible frequency counts distinct qualifying days. | Checklist plus “2 of 3 days this week”. |
| **Cut down** | **None now** | **Limit: day/week/month** | Staying within the Limit is the only success clock. | “1 logged today · limit 2”, not “1 of 2”, because 2 is not something to reach. |
| **Quit** | None | None | Time since quit point. | Existing quit-counter behaviour. |
| **One-time task** | Once | None | Task completion. | Task on its date. |
| **Repeating task** | Fixed calendar patterns; interval; after completion | None | Each generated task occurrence. | Ordinary task; no habit progress/streak. |

**Reasoned from first principles — recommendation:** a flexible `N days/week` Schedule is capped at **N distinct days**. It never means N events. This is what makes “30 min on 4 days” possible without turning Schedule into another Goal.

**Reasoned from first principles — recommendation:** for **Check it off**, “Once a week/month/year” is canonicalised into Schedule rather than being allowed as an equivalent Goal state. For example, choosing Goal = `1 time / a week` should explicitly offer to set **Schedule: 1 day a week; Goal: Once a day**. This eliminates two identical representations. Values above one remain legitimate period Goals because multiple check-offs can occur on the same date.

## Frequency coverage, recurrence model and edge cases

RFC 5545 is useful here only as a completeness checklist: recurrence systems commonly need a base frequency, interval, weekday filters, month-day filters, month filters, ordinal positions and week-start semantics. It is not suitable as user-facing language. citeturn10search2 Apple Calendar's current recurrence model likewise demonstrates that every-N weeks with selected weekdays, every-N months, dates of month, ordinal weekday patterns and every-N years are all ordinary calendar recurrence primitives, not exotic edge cases. citeturn18search6

### The short top-level Schedule list

**Reasoned from first principles — recommendation:** instead of the current five rows plus detached detail controls, use only four main choices for Build habits with a daily Goal:

| Top-level choice | What it owns |
|---|---|
| **Every day** | The simple default |
| **Specific days** | Weekdays/weekends/arbitrary weekdays |
| **Every…** | All fixed interval/calendar recurrence |
| **A number of days** | Flexible distinct days in a week/month/year |

This avoids turning Calendar's recurrence grammar into a wall of habit-app options.

**Users show — recommendation:** keep fixed days and flexible days separate. Streaks itself documents both fixed schedules such as Monday–Friday and a “3 days per week” pattern, while direct user reviews repeatedly distinguish wanting specific days from wanting an unspecified number of days. citeturn14search0turn8search0

### Coverage decision

| Candidate | Decision | Label and controls | Default / range | Basis |
|---|---|---|---|---|
| Every day | **Now** | `Every day` | No parameters | **Users show:** ubiquitous base case. |
| Weekdays / weekends | **Now, as quick picks** | Buttons inside Specific days: `Weekdays`, `Weekends` | No separate schedule modes | **Reasoned from first principles:** common shortcuts without duplicating semantic modes. |
| Specific weekdays | **Now** | `Specific days` + seven weekday buttons | Start-date weekday selected initially | **Users show:** directly requested in reviews; Loop users also request concrete days. citeturn9search6 |
| Every N days | **Now** | `Every [N] days` | 2; 2–365 | **Users show:** direct request for 2nd/3rd/4th day recurrence. citeturn9search11 |
| Every N weeks on chosen weekday(s) | **Now** | `Every [N] weeks` + weekdays | 2; 2–52; start-date weekday initially | **Users show:** Productive's every-two-weeks Saturday complaint. citeturn17search0 |
| Every N months on a date | **Now** | `Every [N] months` → `Dates` | 2 months; start-date number | **Competitor documentation (behaviour only):** Apple Calendar supports month intervals and month dates. citeturn18search6 |
| Dates of the month | **Now** | `Every month` → `Dates` → 1–31 multi-select | Start date | **Users show:** your internal Streaks report and public competitor behaviour both support the shape. fileciteturn0file0 |
| Last day of month | **Now** | Explicit `Last day` pattern | — | **Reasoned from first principles:** avoids making “31st” secretly mean “last day”. |
| Nth weekday of month | **Now** | `On the [first…last] [weekday]` | Ordinal/day from Starts date | **Users show:** Productive reviews explicitly request first/second/last weekday patterns. citeturn17search1 |
| Yearly on date / every N years | **Now** | `Every [N] years` + date | 1 year; 1–20 | **Users show:** yearly/seasonal recurrence appears in public Productive reviews and your internal corpus. citeturn17search7turn0file0 |
| N days/week | **Now** | `[N] days a week` | 3; 1–7 | **Users show:** one of the strongest recurring requests. citeturn8search0turn16search10 |
| N days/month | **Now** | `[N] days a month` | 5; 1–28 | **Reasoned from first principles:** 28 guarantees the target is possible in every month without hidden adjustment. |
| N days/year | **Now** | `[N] days a year` | 12; 1–365 | **Users show:** “three times a year” appears in the supplied corpus; use “days” in UI to make semantics explicit. fileciteturn0file0 |
| Amount on any N days/week | **Now** | Not another option: Schedule `N days a week` + Goal `[amount] a day` | — | **Users show:** nine such requests are reported in the supplied hand-review. fileciteturn0file0 |
| N days after last completion | **Now for tasks; later for habits** | Task Schedule → `After completion` → `After [N] days/weeks/months` | 1 appropriate unit | **Users show:** Structured feedback requests this; Things and TickTick document completion-relative recurrence. citeturn16search14turn4search4turn5search1 |
| Shift rotations, e.g. 4 on / 4 off | **Later** | Future `Rotation` pattern | — | **Users show:** present in your corpus, but substantially more state and edge behaviour than the other modes. fileciteturn0file0 |
| Separate “Every Few Days” | **Never as a separate mode** | Fold into `Every…` | — | **Reasoned from first principles.** |
| Separate “Every Few Weeks” | **Never as a separate mode** | Fold into `Every…` | — | **Reasoned from first principles.** |
| “Times a day” in Schedule | **Never** | Goal owns this | — | Decided product constraint, and it is consistent with the day-vs-count model. |
| “Biweekly” label | **Never** | Say `Every 2 weeks` | — | **Reasoned from first principles:** lexical ambiguity is unnecessary when the numeric form is exact. |

**Reasoned from first principles — recommendation:** combine **Every Few Days** and **Every Few Weeks**. They are one operation: an **interval**. The unit changes; the concept does not. Google Calendar support questions are a useful warning that users can miss “every other week” when interval recurrence is hidden behind taxonomy. citeturn18search5

### Anchors and exceptional dates

**Reasoned from first principles — recommendation:** no interval may use a hidden anchor.

- `Every 3 days` says **“Every 3 days, starting Mon, 28 Sep.”**
- `Every 2 weeks on Sunday` says **“Every 2 weeks on Sun, starting with the week of 28 Sep.”**
- `Every 6 months on the 28th` says **“Every 6 months on the 28th, starting Sep 2026.”**
- Future Starts dates produce no earlier occurrences.
- Editing an existing habit retains its original anchor rather than silently re-anchoring to today.

The Dates row remains where it is; Schedule only **reads** the active Starts date. This respects the decided information architecture while making the recurrence input visible.

**Reasoned from first principles — recommendation:** selecting the 29th, 30th or 31st exposes an explicit native menu:

> **Shorter months**  
> Use the last day  
> Skip that month

For existing schedules, preserve the current “use the last day” behaviour during migration. For new schedules, keeping it as the default is reasonable for backwards consistency, but it must be shown rather than buried in footer copy. If two chosen dates collapse to the same last day, there is one scheduled day, because Schedule counts dates rather than duplicate events.

For 29 February, use the same rule:

> **Years without 29 Feb**  
> Use 28 Feb  
> Skip that year

RFC recurrence rules normally ignore invalid generated dates rather than inventing another date, which is one reason the policy should be explicit rather than presented as a universal calendar truth. citeturn10search2

**Reasoned from first principles — recommendation:** `Next: Mon, 5 Oct` is valuable for **interval and complex monthly/yearly patterns**, where it acts as a checksum for the rule. Do not add it to Every day or simple weekday patterns, where it would be redundant.

### Week start, travel and editing

**Reasoned from first principles — recommendation:** the user's week-start setting controls flexible `N days a week` and weekly Goal boundaries. Fixed weekday sets are unaffected.

For `Every N weeks`, store the recurrence from its anchor dates rather than recalculating it from the user's later display preference. Changing week start should not suddenly move “bedsheets every other Sunday” to another Sunday. RFC itself makes week-start relevant to some interval-week rules, which is exactly why the app should store a stable anchor rather than derive recurrence from UI presentation each time. citeturn10search1

**Reasoned from first principles — recommendation:** calendar-day schedules are floating local dates. Travelling should not make “Monday” become Sunday because an elapsed UTC duration crossed a timezone boundary. TickTick explicitly distinguishes fixed and floating time behaviours for scheduled items; the analogous choice here is that a habit's calendar day is local-calendar based. citeturn5search8

**Reasoned from first principles — recommendation:** switching between Schedule modes retains each mode's last entered parameters as an **inactive draft**, but only the selected mode is ever active. Thus going Every 3 days → Specific days → Every… restores 3 days without two simultaneous rules.

No-days and all-seven-days states are canonicalised:

- The Specific days mode begins with the Starts-date weekday, not all seven.
- The final selected weekday cannot leave the persisted schedule empty.
- Selecting the seventh day transforms the active state to **Every day** and VoiceOver announces that the schedule is now Every day.
- More than 7 “times a week” cannot be entered as Schedule, because there are only seven distinct dates; use Goal for event counts that can repeat on one date.

## Native iOS screen specification

Apple's HIG recommends limiting onscreen controls, keeping secondary details discoverable with minimal interaction, adapting to Dynamic Type, and placing frequently used controls where they remain comfortable to reach. Apple also recommends keeping a picker close to the field it edits rather than moving the user to another view merely to manipulate the picker. citeturn19search3turn19search0

That strongly favours **large read-back + selected row + inline parameters**, rather than the current “option list at the top, details in a detached section below”.

### Schedule screen: daily Goal

**Reasoned from first principles — recommendation:** top to bottom:

**Navigation title:** `Schedule`

**Large read-back**

> **Every day**  
> Every day is on the schedule.

Then a native List/Form:

> **SET DAYS**  
> ✓ Every day  
> Specific days  
> Every…
>
> **FLEXIBLE DAYS**  
> A number of days  
> _Choose how many different days in a week, month or year._

There is no separate bottom footer carrying the essential explanation. The dynamic sentence lives beneath the large read-back and therefore remains visible before the user reaches any large control.

### Every day state

> **Every day**  
> Every day is on the schedule.
>
> ✓ Every day  
> Specific days  
> Every…  
>
> A number of days

No parameters appear.

### Specific days state

**Reasoned from first principles — recommendation:** the parameters expand **immediately below Specific days**, not in another section.

> **Mon, Wed & Fri**  
> On Monday, Wednesday and Friday.
>
> Every day  
> ✓ Specific days  
> &nbsp;&nbsp;Weekdays Weekends  
> &nbsp;&nbsp;S M T W T F S  
> Every…  
>
> A number of days

The visual one-letter weekday controls may remain compact at standard Dynamic Type, but their accessibility labels are full day names. At accessibility sizes they wrap or become a vertical list rather than shrinking text.

Quick picks merely set the weekday values:

- Weekdays → locale-appropriate Monday–Friday only if the product defines “weekday” that way globally.
- Weekends → Saturday/Sunday.
- They are not separate frequency modes.

### Every… — days

> **Every 3 days**  
> Every 3 days, starting Mon, 28 Sep.  
> Next: Thu, 1 Oct
>
> Every day  
> Specific days  
> ✓ Every…  
> &nbsp;&nbsp;Every **3** **days ▾** [−] [+]  
> &nbsp;&nbsp;Starts Mon, 28 Sep  
> A number of days

`Starts` is read-only here because Dates remains on the form.

### Every… — weeks

> **Every 2 weeks · Sun**  
> Every 2 weeks on Sunday, starting with the week of 28 Sep.  
> Next: Sun, 11 Oct
>
> ✓ Every…  
> &nbsp;&nbsp;Every **2** **weeks ▾** [−] [+]  
> &nbsp;&nbsp;On S M T W T F S  
> &nbsp;&nbsp;Starts Mon, 28 Sep

The selected weekday initially matches the Starts date. The user can select multiple weekdays, enabling patterns such as every two weeks on Monday and Thursday.

### Every… — months

> **Every month · 1st & 15th**  
> On the 1st and 15th of every month.
>
> ✓ Every…  
> &nbsp;&nbsp;Every **1** **month ▾**  
> &nbsp;&nbsp;Pattern **Dates | Weekday**  
>
> If Dates:  
> &nbsp;&nbsp;1 … 31 multi-select grid  
> &nbsp;&nbsp;Last day
>
> If Weekday:  
> &nbsp;&nbsp;**First ▾** **Saturday ▾**

**Reasoned from first principles — recommendation:** keep the 1–31 grid inline, but put the read-back and rule explanation **above** it. The problem in Image 2 is not scrolling by itself; it is that the only meaningful explanation is below the tallest control.

For the 29th–31st, another native value row appears directly below:

> Shorter months **Use last day ▾**

### Every… — years

> **Every year · 12 Mar**  
> Every year on 12 March.  
> Next: Fri, 12 Mar 2027
>
> ✓ Every…  
> &nbsp;&nbsp;Every **1** **year ▾**  
> &nbsp;&nbsp;On **12 Mar**

For `Every 2 years`, the read-back says exactly that. Do not use “biennially”.

### A number of days state

This is the restored flexible frequency that the current Build flow has lost.

> **4 days**  
> **a week**  
> Reach the daily goal on any 4 different days each week.
>
> Every day  
> Specific days  
> Every…  
>
> ✓ A number of days  
> &nbsp;&nbsp;**4** days **a week ▾** [−] [+]

The period picker contains A week, A month, A year.

**Users show — recommendation:** the sentence says **different days**. That directly prevents the “two completions on Tuesday count as two of my three days” misunderstanding documented around flexible recurrence systems. HabitKit explicitly defines weekly completion quotas as distinct successful days, and Loop users have separately asked for multiple repetitions on one day. citeturn16search10turn15search10

Once the quota is reached, the app must **not prevent additional logging**. A Productive reviewer specifically complained that reaching the weekly day target removed the ability to record later successful days. citeturn17search1

Today can therefore progress:

> `2 of 3 days this week`

then:

> `3 of 3 days this week ✓`

and if the user continues:

> `4 days this week · goal reached`

The extra day enriches history but does not create a larger streak requirement.

### Schedule with weekly/monthly/yearly Goal

The Schedule row never disappears.

For a weekly Goal:

> **Any day**  
> **this week**  
> Your goal adds up across the week, so you can work on it on any day.
>
> ✓ Any day this week  
>
> **Use set days instead…**

Tapping that last action produces the explicit “Change Goal to A day?” transition described earlier.

This is substantially safer than today's silent removal of Repeat.

### Goal screen

**Reasoned from first principles — recommendation:** retain the strongest part of the current screen — the large read-back — but remove the recurrence-looking segmented control.

For Time:

> **20 min**  
> **a day**
>
> **Goal counts over** A day ▾  
> Starts again each scheduled day.
>
> **GOAL**  
> Scroll | Type  
> [time wheels]

For weekly:

> **2 hr**  
> **a week**
>
> **Goal counts over** A week ▾  
> Everything you log this week adds up. It starts again on Monday.
>
> **GOAL**  
> …

Apple recommends a pull-down control for a fairly short list instead of giving a picker unnecessary visual weight. citeturn19search0

**Reasoned from first principles — recommendation:** `A day · A week · A month · A year` are values of **Goal counts over**, not four unlabeled segments. The wording answers why those time units are here and avoids putting recurrence vocabulary at the visual centre of Goal.

Goal-period helper text:

- A day: `Starts again each scheduled day.`
- A week: `Everything you log this week adds up. It starts again on Monday.`
- A month: `Everything you log this month adds up. It starts again on the 1st.`
- A year: `Everything you log this year adds up. It starts again on 1 January.`

Use the user's week start and locale.

### Form

**Reasoned from first principles — recommendation:** rows become:

> Name · Icon · Colour  
>
> **Schedule** Mon, Wed & Fri  
> **Time of Day** Any Time  
> **Goal** 5 km  
> _5 km on Mon, Wed and Fri._  
>
> Dates Starts Today · Ends Never  
> Reminders

A daily Goal deliberately omits “a day” from the **form row value**, because Schedule is directly beside it. The full Goal screen still says `5 km / a day`.

Longer-period Goals retain their period because it is essential information:

> Schedule Any day this year  
> Goal 12 books a year  
> _12 books a year, on any days._

The combined sentence acts as a final cross-check, not as another setting.

### Keyboard and one-handed behaviour

**Reasoned from first principles — recommendation:** the read-back and Goal period remain above the editable field in the same scrollable Form. When a number keyboard appears, focus scrolls the active Amount field just above the keyboard; no explanatory footer is anchored beneath the keyboard.

Apple advises that controls adapt to Dynamic Type and notes that middle/lower areas are generally easier to reach one-handed. citeturn19search3 Consequently the screen should not put the only editable recurrence parameter in a tiny control adjacent to the navigation bar merely because the read-back is at the top.

## Copy system, static strings and rendered states

### Static copy deck

| Stable key | Current | Proposed | Basis |
|---|---|---|---|
| `schedule.title` | Repeat | **Schedule** | **Reasoned from first principles:** narrower than “How Often”, broader than “Days”, and does not collide with Time of Day. |
| `schedule.section.fixed` | On a set schedule | **Set days** | **Reasoned from first principles:** remove jargon. |
| `schedule.option.daily` | Every Day | **Every day** | Plain sentence case. |
| `schedule.option.weekdays` | On Certain Days | **Specific days** | Users commonly describe “specific days”; direct requests use this concept. |
| `schedule.option.interval.days` | Every Few Days | **Every…** | Unified interval concept. |
| `schedule.option.interval.weeks` | Every Few Weeks | **Merged into Every…** | Unified interval concept. |
| `schedule.option.monthDates` | On Dates of the Month | **Inside Every… → month → Dates** | Prevent top-level proliferation. |
| `schedule.section.flexible` | On any days you like | **Flexible days** | Shorter; explanatory sentence follows. |
| `schedule.option.flexWeek` | A Few Times a Week | **A number of days** | “Days” explicitly means distinct dates. |
| `schedule.option.flexMonth` | A Few Times a Month | **Merged into A number of days** | Period is a parameter. |
| `schedule.option.flexYear` | A Few Times a Year | **Merged into A number of days** | Period is a parameter. |
| `schedule.summary.everyDay` | Due every day. | **Every day is on the schedule.** | No deadline language. |
| `schedule.summary.specific` | “A set schedule: due only…” | **On {days}.** | Read back the actual state. |
| `schedule.summary.intervalDay` | “…due every 2 days, counting from today…” | **Every {n} days, starting {startDate}.** | Explicit anchor. |
| `schedule.summary.intervalWeek` | “…due every 2 weeks, on Monday.” | **Every {n} weeks on {days}, starting {anchor}.** | User-selected weekday and anchor. |
| `schedule.summary.monthDates` | “…due on these dates each month…” | **On {dates} every month.** | Direct read-back. |
| `schedule.shortMonths.label` | Footer explanation | **Shorter months** | Make it a setting. |
| `schedule.shortMonths.last` | implicit | **Use the last day** | Explicit policy. |
| `schedule.shortMonths.skip` | unavailable | **Skip that month** | Explicit alternative. |
| `goal.period.label` | none | **Goal counts over** | Explains the period's role. |
| `goal.period.day` | Daily | **A day** | Distinguishes quantity period from recurrence category. |
| `goal.period.week` | Weekly | **A week** | Same. |
| `goal.period.month` | Monthly | **A month** | Same. |
| `goal.period.year` | Yearly | **A year** | Same. |
| `goal.helper.day` | Starts fresh every day. Choose which days in Repeat. | **Starts again each scheduled day.** | No cross-screen instruction. |
| `goal.helper.week` | “Do it on any days… Sunday to Saturday…” | **Everything you log this week adds up. It starts again on {weekStart}.** | One concept per sentence. |
| `goal.helper.month` | “…this month counts…” | **Everything you log this month adds up. It starts again on the 1st.** | Same structure. |
| `goal.helper.year` | “…on 1 January.” | **Everything you log this year adds up. It starts again on {yearStart}.** | Localisable. |
| `goal.empty` | Enter your goal below | **Set your goal below.** | Shorter. |
| `goal.section.daily` | Daily goal | **Goal** | Avoid repeating period language. |
| `goal.check.help` | “On Today, each tap on ✓ counts one…” | **Each tap on ✓ adds one. The unit names what you're counting.** | Keeps interaction explanation; removes navigation framing. |
| `goal.time.help` | “On Today, ▶ starts a timer…” | **Tap ▶ on Today to start the timer. Touch and hold to add time yourself.** | Plain action wording. |
| `today.notDue` | Not due today | **Keep for now: Not due today** | Decided product convention; test separately rather than reopen without comparative evidence. |

### Dynamic templates

**Reasoned from first principles — recommendation:** these are the canonical English templates; localisation should use grammatical plural rules rather than string concatenation.

| Key | Template |
|---|---|
| `schedule.readback.interval.day` | `Every {n} {dayPlural}` |
| `schedule.readback.interval.week` | `Every {n} {weekPlural} · {shortDays}` |
| `schedule.readback.interval.month` | `Every {n} {monthPlural} · {pattern}` |
| `schedule.readback.interval.year` | `Every {n} {yearPlural} · {dateOrPattern}` |
| `schedule.summary.interval.day` | `Every {n} {days}, starting {date}.` |
| `schedule.summary.interval.week` | `Every {n} {weeks} on {days}, starting with the week of {date}.` |
| `schedule.summary.flex.week` | `Reach the daily goal on any {n} different {day/days} each week.` |
| `schedule.summary.flex.month` | `Reach the daily goal on any {n} different {day/days} each month.` |
| `schedule.summary.flex.year` | `Reach the daily goal on any {n} different {day/days} each year.` |
| `schedule.summary.month.dates` | `On the {ordinalList} of every month.` |
| `schedule.summary.month.ordinal` | `On the {ordinal} {weekday} of every month.` |
| `schedule.summary.next` | `Next: {localizedDate}` |
| `goal.readback` | `{amount} {unit}\n{aPeriod}` |
| `goal.period.week.help` | `Everything you log this week adds up. It starts again on {weekStart}.` |
| `form.summary.daily.fixed` | `{goalAmount} on {scheduleDays}.` |
| `form.summary.daily.everyDay` | `{goalAmount} every day.` |
| `form.summary.daily.flex` | `{goalAmount} on any {n} days a {period}.` |
| `form.summary.aggregate` | `{goalAmount} {aPeriod}, on any days.` |
| `today.flex.progress` | `{done} of {needed} days this {period}.` |

Pluralisation rules:

- `1 day`, `2 days`; `1 month`, `2 months`.
- The interval UI never renders `Every 1 days`; semantically equivalent states are normalised.
- Prefer **“Every 2 weeks”** as canonical copy. “Every other week” may be understood in English but creates an unnecessary second idiom, and “biweekly” is avoided entirely.
- English ordinals render `1st`, `2nd`, `3rd`, `4th`; VoiceOver speaks `first`, `second`, and so on.
- Lists use locale-aware conjunction: `Mon, Wed & Fri` in compact form and `Monday, Wednesday and Friday` in sentences.
- Date order is locale-driven: en-IN naturally renders `12 Mar`/`12 March`, while another locale may put the month first.

### Rendered examples

The following examples exercise the entire copy grammar rather than acting as additional menu choices.

| State | Rendered output |
|---|---|
| 1 | **Every day** — Every day is on the schedule. |
| 2 | **Mon** — On Monday. |
| 3 | **Mon, Wed & Fri** — On Monday, Wednesday and Friday. |
| 4 | **Weekdays** — On Monday to Friday. |
| 5 | **Weekends** — On Saturday and Sunday. |
| 6 | **Every 2 days** — Every 2 days, starting Mon, 28 Sep. |
| 7 | **Every 3 days** — Every 3 days, starting Mon, 28 Sep. |
| 8 | **Every 2 weeks · Sun** — Every 2 weeks on Sunday, starting with the week of 28 Sep. |
| 9 | **Every 3 weeks · Mon & Thu** — Every 3 weeks on Monday and Thursday. |
| 10 | **Every month · 1st** — On the 1st of every month. |
| 11 | **Every month · 1st & 15th** — On the 1st and 15th of every month. |
| 12 | **Every month · Last day** — On the last day of every month. |
| 13 | **Every month · First Sat** — On the first Saturday of every month. |
| 14 | **Every month · Last Fri** — On the last Friday of every month. |
| 15 | **Every 3 months · 28th** — Every 3 months on the 28th. |
| 16 | **Every 6 months · 28 Sep** — Every 6 months on the 28th, starting in September. |
| 17 | **Every year · 12 Mar** — Every year on 12 March. |
| 18 | **Every 2 years · 12 Mar** — Every 2 years on 12 March. |
| 19 | **1 day / a week** — Reach the daily goal on any 1 day each week. |
| 20 | **3 days / a week** — Reach the daily goal on any 3 different days each week. |
| 21 | **4 days / a week** — Reach the daily goal on any 4 different days each week. |
| 22 | **5 days / a month** — Reach the daily goal on any 5 different days each month. |
| 23 | **12 days / a year** — Reach the daily goal on any 12 different days each year. |
| 24 | **Any day / this week** — Your goal adds up across the week, so you can work on it on any day. |
| 25 | **Any day / this month** — Your goal adds up across the month, so you can work on it on any day. |
| 26 | **Any day / this year** — Your goal adds up across the year, so you can work on it on any day. |
| 27 | Goal **8 glasses / a day** — Starts again each scheduled day. |
| 28 | Goal **30 min / a day** — Starts again each scheduled day. |
| 29 | Goal **100 pages / a week** — Everything you log this week adds up. It starts again on Monday. |
| 30 | Goal **12 books / a year** — Everything you log this year adds up. It starts again on 1 January. |
| 31 | Goal **3 times / a week** — Everything you check off this week adds up. It starts again on Monday. |
| 32 | Summary: **8 glasses every day.** |
| 33 | Summary: **5 km on Mon, Wed and Fri.** |
| 34 | Summary: **30 min on any 4 days a week.** |
| 35 | Summary: **12 books a year, on any days.** |
| 36 | Task: **Every 6 months, starting 28 Sep.** |
| 37 | Task: **12 March every year.** |
| 38 | Completion-relative task: **6 weeks after completion.** |
| 39 | Monthly edge case: **On the 31st of every month. Shorter months use the last day.** |
| 40 | Flexible Today: **2 of 3 days this week.** |

**Reasoned from first principles — recommendation:** do not mention streaks in any of those Schedule summaries. The Schedule state should remain valid if the product later changes its streak presentation; “never break the streak” is an outcome of scoring, not part of what the user selected.

## Side-by-side proof across the requested real-world intentions

The following table applies the model end to end. A daily Goal's **form row value intentionally omits “a day”**; the Goal screen contains the full period read-back. This is how `Schedule: Every day` and `Goal: Once a day` stop looking like duplicate facts.

| Intention | Schedule row → Schedule read-back | Goal / Limit row → screen read-back | Combined sentence | Today |
|---|---|---|---|---|
| **Drink 8 glasses of water every day** | `Every day` → **Every day** | `8 glasses` → **8 glasses / a day** | **8 glasses every day.** | `0 of 8 glasses` progressing through the day; bare day streak. |
| **Gym 3 times a week on any days** | `3 days a week` → **3 days / a week** | `Once` → **Once / a day** | **Check it off on any 3 days a week.** | `1 of 3 days this week`; no Monday/Tuesday failure before the week is decided; weekly streak. |
| **Run 5 km Mon/Wed/Fri** | `Mon, Wed & Fri` → **Mon, Wed & Fri** | `5 km` → **5 km / a day** | **5 km on Mon, Wed and Fri.** | On scheduled day: `0 of 5 km`; other days behind the decided Not due today row; `×` streak. |
| **Read 30 min on any 4 days a week** | `4 days a week` → **4 days / a week** | `30 min` → **30 min / a day** | **30 min on any 4 days a week.** | `15 of 30 min today` plus `2 of 4 days this week`; today counts when 30 min is reached. |
| **Read 12 books a year** | `Any day this year` → **Any day / this year** | `12 books a year` → **12 books / a year** | **12 books a year, on any days.** | `5 of 12 books this year`; `yr` streak. |
| **Journal on weekdays** | `Weekdays` → **Mon–Fri** | `Once` → **Once / a day** | **Journal once on weekdays.** | Check-off on weekdays; weekend neutral; `×` streak. |
| **Water plants every 3 days** | `Every 3 days` → **Every 3 days** | `Once` → **Once / a day** | **Water plants once every 3 days.** | Appears on generated dates; `×` streak. |
| **Change bedsheets every 2 weeks on Sunday** | `Every 2 weeks · Sun` → **Every 2 weeks / Sun** | `Once` → **Once / a day** | **Change bedsheets every 2 weeks on Sunday.** | Appears only on alternate scheduled Sundays; `×` streak. |
| **Call mum once a week** | `1 day a week` → **1 day / a week** | `Once` → **Once / a day** | **Call mum on any 1 day each week.** | `0 of 1 day this week`; weekly streak. |
| **Take medication every other day** | `Every 2 days` → **Every 2 days** | `Once` → **Once / a day** | **Take medication every 2 days.** | Only interval dates are scheduled; `×` streak. |
| **Haircut every 6 weeks** | `Every 6 weeks · Mon` if Starts is Mon 28 Sep → **Every 6 weeks / Mon** | `Once` → **Once / a day** | **Haircut every 6 weeks, starting Mon, 28 Sep.** | Appears on each generated date; `×` streak. |
| **Clean the oven once a month** | `1 day a month` → **1 day / a month** | `Once` → **Once / a day** | **Clean the oven on any 1 day each month.** | Available through the month until completed; monthly streak. |
| **Deep clean on the first Saturday of the month** | `First Sat monthly` → **Every month / First Sat** | `Once` → **Once / a day** | **Deep clean on the first Saturday of every month.** | Appears on that Saturday; `×` streak. |
| **Pay rent on the 1st — task** | `1st of every month` → **Every month / 1st** | No Goal | **Pay rent on the 1st of every month.** | Ordinary task on the 1st; no habit progress/streak. |
| **Dentist every 6 months — task** | `Every 6 months · {date}` | No Goal | **Dentist every 6 months, starting {date}.** | One task occurrence every six months. |
| **Send a birthday card every 12 March — task** | `12 Mar every year` | No Goal | **Send a birthday card every year on 12 March.** | One task on 12 March. |
| **Checklist “Clean kitchen” 3 times a week** | `3 days a week` → **3 days / a week** | No Goal; `Items` stays the form row | **Finish the Clean kitchen checklist on any 3 days a week.** | Checklist plus `2 of 3 days this week`; a day counts when its checklist completes. |
| **Coffee: at most 2 a day** | No Schedule | `Limit: 2 cups a day` | **At most 2 cups a day.** | `1 logged today · limit 2`; never “1 of 2”, which would encourage reaching the limit. |
| **Alcohol: at most 5 drinks a week** | No Schedule | `Limit: 5 drinks a week` | **At most 5 drinks a week.** | `3 logged this week · limit 5`; resets at user's week boundary. |

**Reasoned from first principles — recommendation:** the phrase **“Gym 3 times a week”** requires one deliberate product interpretation. The preferred default above interprets the ordinary habit intention as three **different days**. The Schedule UI then says “3 days a week”, removing the ambiguity. A user who truly means *three countable sessions that may occur on the same day* uses:

> Schedule: **Any day this week**  
> Goal: **3 times a week**  
> Summary: **Check it off 3 times a week, on any days.**

That is not another hidden interpretation of the same control; it is a visibly different configuration.

**Users show — recommendation:** do not stop logging after a flexible weekly target has been met. The Productive review about a five-day goal specifically describes loss of useful history when day six and seven can no longer be recorded. citeturn17search1

### Cut down is a Goal-like quantity, not frequency

**Reasoned from first principles — recommendation:** move `A Daily Total / A Weekly Total / A Monthly Total` entirely out of Schedule. The screen should be **Limit**, with:

> **No more than 5 drinks**  
> **a week**
>
> **Limit counts over** A week ▾

This gives Build and Cut down the same conceptual grammar:

- Build: *how much I want to reach before the period restarts*.
- Cut down: *how much I want to stay under before the period restarts*.

The direction differs; the time-period concept does not.

Cut down gets no Schedule in this release because adding “only count alcohol on Friday and Saturday” would make the limit itself partially inactive and create another scoring clock. That can be researched separately if users request it.

Quit correctly has no frequency.

### Tasks and after completion

**Users show — recommendation:** add **After completion** to repeating tasks, not to habits in this release. Structured users explicitly request completion-relative recurrence, and Things documents a clear distinction between fixed regular recurrence and repeating from the actual completion date. TickTick similarly supports recurrence by completion. citeturn16search14turn4search4turn5search1

This is particularly natural for:

> Haircut → 6 weeks after completion  
> Replace filter → 3 months after completion  
> Service appliance → 12 months after completion

Tasks have no habit streak or historical adherence denominator, so moving the next date does not rewrite what “consistent” means. For a habit, it would.

## Accessibility, localisation and the comprehension test

Apple's current VoiceOver criteria require common tasks to be completable without sighted assistance and controls to have concise, accurate labels; form controls need both a semantic label and their current value. citeturn19search1 Standard system controls provide useful accessibility behaviour by default, but app-specific values still need meaningful descriptions. citeturn19search4turn19search7

### VoiceOver

**Reasoned from first principles — recommendation:** announce semantic information, not visual abbreviations.

Visual:

> `S M T W T F S`

VoiceOver:

> “Sunday, not selected”  
> “Monday, selected”  
> “Tuesday, not selected”

Do not expose “M button” or two indistinguishable “T” controls.

Examples of row announcements:

> “Schedule, 3 days a week, button.”  
> “Goal, 30 minutes, button.”  
> “Goal counts over, a day, pop-up button.”  
> “Every, 2 weeks, adjustable.”  
> “Shorter months, use the last day, pop-up button.”  
> “29th, selected.”  
> “First Saturday, selected.”

**Reasoned from first principles — recommendation:** the large read-back is one semantic element:

> “Schedule: every 2 weeks on Sunday.”

Do not make a screen-reader user traverse “Every”, “2”, “weeks”, “Sunday” as unrelated decorative text before reaching the actual controls.

When all seven weekdays canonicalise to Every day, announce:

> “Every day selected.”

### Dynamic Type and physical layout

**Reasoned from first principles — recommendation:**

- Use semantic system text styles throughout; never force the read-back to stay one line.
- At accessibility sizes, `Mon, Wed & Fri` can take multiple lines.
- Weekday controls may wrap; if touch targets or labels become cramped, use a vertical selectable list at accessibility sizes.
- The 1–31 month-date grid should increase cell height rather than reduce type.
- The summary sentence remains directly after the read-back; it must not be pushed beneath all parameter controls.
- Row values may wrap to a second line instead of truncating “Every 2 weeks · Mon & Thu”.
- Keep the selected state distinguishable without colour alone.

Apple specifically calls for adapting iOS interfaces to Dynamic Type rather than preserving a fixed layout, and its picker guidance says control values/order should respect language and locale. citeturn19search3turn19search0

### Localisation

**Reasoned from first principles — recommendation:** never construct recurrence sentences by concatenating translated fragments such as `"Every " + n + " weeks on " + weekdays`. Give localisation complete templates with plural and grammatical variables.

Localisable concepts include:

- singular/plural units;
- grammatical forms of weekdays;
- conjunction lists;
- ordinal numbers;
- date order;
- month names;
- “first/second/last” forms;
- week-start day;
- year-start wording if non-Gregorian calendars are eventually supported.

For en-IN:

> `12 March`  
> `Mon, Wed & Fri`  
> `Every 2 weeks`

For another locale, the date order and conjunction may change automatically.

**Reasoned from first principles — recommendation:** the user's week-start setting changes:

- weekly Goal reset;
- `N days a week` period boundary;
- phrases such as “this week” and “starts again on Monday”.

It does **not** change a fixed set of weekdays or move an established every-N-weeks anchor.

### Comprehension study to run before implementation freezes

This should be a **predict-what-happens test**, not an aesthetic preference test. Asking “Which screen do you like?” will not reveal whether the model works.

**Reasoned from first principles — recommendation:** recruit roughly **18–24 first-time participants**, deliberately including a substantial group who use English as an additional language. The number is a proposed practical qualitative sample, not a claim of statistical representativeness. Include iPhone users with a range of habit-app experience and at least several VoiceOver or large-text users in a separate accessibility pass.

Do not teach “Schedule versus Goal” first. Let the UI teach it.

The critical tasks should be:

| Task | Ask the participant to set | Then ask them to predict |
|---|---|---|
| Flexible quantity | “Read for 30 minutes on any four days a week.” | Does reading twice on Tuesday count as two days? What happens if Monday is skipped? |
| Period total | “Read 12 books this year, whenever you like.” | Does Schedule restrict dates? When does the Goal reset? |
| Fixed schedule | “Run 5 km Monday, Wednesday and Friday.” | What happens on Tuesday? |
| Flexible binary | “Go to the gym three days a week.” | Can the three days be chosen during the week? |
| Same-day count | “Do three practice sessions a week; two can happen on one day.” | Which screen owns the 3? |
| Interval | “Take medicine every three days starting next Thursday.” | Which dates will appear? |
| Week interval | “Change bedsheets every second Sunday.” | Which Sunday is first? |
| Monthly ordinal | “Deep clean on the first Saturday each month.” | Predict next two dates. |
| Period transition | Start with Mon/Wed/Fri daily Goal, then choose a weekly Goal. | What will happen to Schedule before tapping confirmation? |
| Cut down | “No more than five drinks a week.” | Is five something they are encouraged to reach? |
| Task completion-relative | “Replace a filter three months after you actually replace it.” | What happens when today's occurrence is completed late? |

For every task, ask three questions before letting the participant continue:

> “What does Schedule mean here?”  
> “What does Goal mean here?”  
> “What do you expect to see on Today tomorrow?”

**Reasoned from first principles — recommendation:** set a stringent critical threshold because this is core architecture: aim for **at least 90% of participants correctly predicting the difference between distinct days and total count without moderator help**, and no systematic misunderstanding among non-native-English participants. That number is a product acceptance criterion to use in the future test, not a reported result.

The recommendation should change if any of these occur repeatedly:

- participants put `30 min on 4 days/week` into a weekly Goal rather than Schedule + daily Goal;
- “A number of days” is not understood as distinct days;
- `Any day this week` appears to mean “do it every day”;
- users interpret a weekly Goal and fixed Schedule as simultaneously active after a transition;
- “Schedule” is consistently understood as Time of Day rather than calendar days;
- users interpret `1 logged · limit 2` as needing another one;
- non-native speakers understand `Daily/Weekly` more reliably than `Goal counts over / A day`; in that event, re-test the period wording while preserving the conceptual model.

**Reasoned from first principles — recommendation:** also test `Schedule` against the current `Repeat` label in a **comprehension** comparison, not a preference poll. The winner is the label under which more users correctly place “Mon/Wed/Fri”, “every three days” and “three different days a week” while keeping “30 min a day” and “12 books a year” in Goal.

## Sources, competitor behaviour, limitations and remaining uncertainties

Competitor implementations were used here as **behaviour checks, not design votes**. Several products actually demonstrate the very modelling trade-offs this design is trying to avoid.

Habitify, for example, documents Repeat as the schedule controlling when a habit appears and Goal as a value/unit/period; its importer has to transform a Productive configuration such as “3 times per week, 20 minutes per day” into a weekly quantity because its own model cannot directly preserve both semantics. That is useful evidence that frequency and quantity can contain independent information, but not evidence that Habitify's UI is the right one. citeturn14search2turn4search5

TickTick likewise documents habit frequency separately from quantity goals, while its task recurrence supports due-date- and completion-based custom repeats. citeturn5search0turn5search1 Loop officially advertises flexible schedules such as three times per week or every other day, but its older FAQ historically inferred specific dates from frequency rather than asking the user for them — illustrating that feature coverage alone does not guarantee a transparent mental model. citeturn15search0turn15search1

HabitKit is especially useful as a semantics check: it explicitly distinguishes a daily target from `3 / Week`, where three different successful days satisfy the weekly schedule. Its documentation also says the current week does not fail while the weekly target is still reachable. citeturn16search10turn16search8 That maps closely to the proposed “30 min on any 4 days” behaviour, although the recommended UI here is not copied from HabitKit.

### Source appendix

| Product / source | Date | Short exact excerpt | Interpretation | Limitation |
|---|---|---|---|---|
| **Internal research brief** fileciteturn0file0 | supplied 28 Sep 2026 | “Frequency and goal are different things” | Primary product requirements and internal corpus leads. | Corpus itself is unavailable to me, so counts and review IDs are not independently audited. |
| **Awesome Habits — App Store review** citeturn8search0 | 8 May, year shown on listing context | “3 times a week, not necessarilly on the same day every week” | Direct flexible-frequency request. | Ambiguous whether same-day repeats should count separately. |
| **Habitify — App Store review** citeturn9search11 | 26 Aug 2018 | “every 2nd, 3rd, 4th day” | Direct evidence for interval recurrence. | One review. |
| **Easy Habit Tracker — App Store review** citeturn9search6 | 9 Jan 2021 | “counts you as having failed … every other day” | Off-schedule days must be neutral. | Behaviour of another product. |
| **Productive — App Store review** citeturn17search0 | listing includes review dated 2018 | “water every two weeks, always on Saturday’s” | Every-N-weeks requires a visible weekday anchor. | Historical review; product may since have changed. |
| **Productive review reproduction** citeturn17search1 | accessed Sep 2026 | “lost the option to track it anymore for that week” | Do not prevent extra logging once flexible target is reached. | Third-party reproduction; lower provenance than direct App Store. |
| **Way of Life — App Store review** citeturn14search1 | 5 Jun 2019 | “looking for the option for x per week or x per month” | Users resort to Skip-based workarounds for missing flexible frequency. | Reviewer personally accepts workaround. |
| **Loop — GitHub feature discussion** citeturn15search10 | 10 Jun 2021 | “Some habits need to happen multiple times per day.” | Strong conceptual reason to separate day cadence from event count. | Small contributor discussion, not study. |
| **Loop — official repository** citeturn15search0 | current repository, accessed 2026 | “3 times per week or every other day” | Flexible cadence is a first-class documented capability. | Behaviour only. |
| **HabitKit documentation** citeturn16search10 | Aug–Sep 2026 | “Three taps on one day count as one successful day at most.” | Clear distinction between distinct-day schedule and within-day quantity. | Competitor behaviour, not user-preference evidence. |
| **Structured feedback** citeturn16search14 | over 3 years old | “based on the completion date vs. the due date” | Completion-relative task recurrence is a genuine request. | Public feedback convenience sample. |
| **Things — official support** citeturn4search4 | accessed 2026 | supports repetition “After Completion” | Confirms completion-relative recurrence behaviour is implementable and understandable. | Behaviour only. |
| **TickTick — official recurring-task documentation** citeturn5search1 | current when researched | Custom recurrence can use completion date. | Behaviour reference for tasks. | Behaviour only. |
| **Habitify Repeat help** citeturn14search2 | 10 Oct 2025 | “the schedule that tells Habitify when to show a habit” | Useful plain separation of schedule from goal. | Competitor documentation only. |
| **Streaks — official site** citeturn14search0 | accessed 2026 | “Some tasks aren’t for every day. Set the days…” | Fixed and flexible non-daily schedules are core product concepts. | Marketing documentation, not usability evidence. |
| **Apple Calendar support** citeturn18search6 | current when accessed | “choose an option from the Frequency pop-up menu” | Daily/Weekly/Monthly/Yearly are established recurrence vocabulary; supports diagnosis of Goal collision. | macOS Calendar rather than this app's iPhone UI. |
| **Google Calendar community — every-other-week** citeturn18search5 | 14 May 2024 | “It's a custom repeat that repeats weekly … every 2 weeks.” | Shows discoverability problems when interval options are hidden behind Custom. | Community support, not formal research. |
| **Google Calendar community — annual weekday** citeturn18search3 | 16 Jul 2025 | “choosing ‘repeat every 12 months’ instead of ‘once a year’” | Taxonomy can make equivalent recurrence capabilities hard to discover. | Community question. |
| **RFC 5545** citeturn10search2 | Internet calendaring standard | recurrence includes frequency, interval and BY* rule parts | Completeness checklist for recurrence shapes and invalid dates. | Not UX guidance and should never surface as UI terminology. |
| **Apple HIG — Pickers** citeturn19search0 | current when accessed | “displayed in context … in proximity to the field” | Supports inline parameters and short-list pull-downs. | General platform guidance. |
| **Apple HIG — Designing for iOS** citeturn19search3 | current when accessed | “limiting the number of onscreen controls” | Supports progressive disclosure, Dynamic Type and reachability decisions. | General guidance. |
| **Apple VoiceOver criteria** citeturn19search1 | current when accessed | “All controls should have concise, accurate labels.” | Basis for full weekday/accessibility labels. | Accessibility conformance guidance rather than recurrence research. |

### Products checked and reachability

The public research pass found useful first-party or direct-user material for Apple Calendar/Reminders, Google Calendar, Todoist, Things, TickTick, Streaks, Habitify, Loop, Way of Life, Productive, Strides, HabitKit and Structured, plus public Habitica recurrence material. Loop's open-source repository was especially accessible; Structured and HabitKit currently publish detailed help. citeturn15search0turn16search5turn16search10

Habitica's public recurrence documentation shows weekly `Repeat Every`, selected weekdays, monthly date and monthly weekday patterns, further confirming those recurrence shapes; it is community-maintained documentation rather than authoritative product research. citeturn20search8

I did **not** find equally strong, indexable first-party recurrence documentation or attributable public review text for every requested product — notably HabitNow, Everyday, Do Habits, Tiimo and Finch at the level required to make a claim about their detailed frequency picker. Tiimo's current public site speaks broadly about flexible planning rather than documenting a comparable habit-frequency model. citeturn16search3 I therefore have not filled those gaps with guesses.

The exact Google Play review IDs supplied in the brief were also not reliably discoverable through ordinary public web indexing during this research pass. I have treated them as **provided internal evidence**, not re-labelled them as independently verified public quotes. fileciteturn0file0

### Remaining uncertainties that genuinely deserve testing

**Reasoned from first principles — recommendation:** the proposed architecture is strong enough to implement as the preferred direction, but four questions remain empirical rather than solvable from competitor precedent.

First, **“Schedule” versus “Repeat”** should be comprehension-tested. I prefer Schedule because it denotes the calendar plan without colliding with Goal quantity and works for a task, but the word Repeat has very high platform familiarity. Apple itself uses Repeat for recurrence. citeturn18search6 The recommendation should change only if Schedule consistently causes people to think of Time of Day or appointments rather than calendar cadence.

Second, **“A number of days”** is the weakest static label in the proposed list. Its resulting states — `3 days a week`, `5 days a month` — are very clear; the entry label is harder. Do not replace it with “A Few Times”, because that reintroduces the event-vs-day ambiguity. Test comprehension of the entry label while keeping the resulting semantics fixed.

Third, the **one-success-clock restriction** deliberately excludes a more advanced intention such as “120 minutes a week, spread across at least four days”. Your supplied evidence suggests this combination is much rarer than either period totals or daily amounts on flexible days, but the internal denominator is not independently available. fileciteturn0file0 If future research establishes meaningful demand, it should be introduced as an explicit advanced combination, not unlocked accidentally by letting Schedule and Goal form arbitrary pairs.

Fourth, **“Not due today”** remains inconsistent with the calmer Schedule language. There is evidence that users value trackers that avoid failure-oriented feedback, including Productive's direct App Store review, but there is not enough comparative evidence here to override a decision explicitly marked as settled in the brief. citeturn17search0turn0file0 The right action is to keep it in this version and include it in the comprehension/emotional-tone study.

The core recommendation does not depend on any of those open questions:

> **Schedule owns calendar days. Goal owns quantity. Flexible Schedule always counts different days. Period Goal counts logged quantity. Only one of those is allowed to define the active success period at a time. Both rows remain visible, every transition is explicit, and one combined sentence proves the resulting meaning back to the user.**

That model makes `Every day + 8 glasses`, `Mon/Wed/Fri + 5 km`, `4 days/week + 30 min`, and `Any day this year + 12 books/year` four visibly different intentions rather than four variations of two screens saying the same thing.