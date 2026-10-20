# Section 02 Round 02 — Habits and Rhythms Explained

Written by Codex, 12 October 2026. Current Work 93. User-led expansion of the researched second section; Figma proposal only.

## Round 05 — responsive and checklist refinement, current direction

The user asks for kitchen utensils with a visible Dishes/Sink/Floor checklist and a more readable narrow section. Current design keeps nine examples, uses the fork-and-knife emoji plus three outlined marks, and replaces both phone grids with compact wide rows. Tablet/desktop retain the staggered visual examples. The hero is separately simplified on smaller widths; See features is removed and the offer uses a re-verified review's “one time payment” terminology. [Current handoff and exact wording provenance](<../../../website/Design Handoff.md>) / [nine final renders and audits](<../../../website/Design Previews/Responsive Round 05/manifest.json>). This is direct user refinement of the same visitor question, not a new corpus or conversion study. Implementation remains pending.

## Round 04 — historical visual-card refinement

The user now requests white after the gray hero and compact, orderly floating habit examples instead of method explanations. Nine static, editable cards show call family, water, books, daily/weekly time, checklist steps and repetition, quitting's elapsed time and both maximum quantity/time limits. Fixed staggered columns are a reasoned visual treatment of the same visitor question, “Will this tracker fit my habits?” No new research audit or conversion claim. Hero and tasks preserved. All eight responsive Home/review copies audited, four final section renders inspected, no card/text overflow. Source family, exact examples, measurements and previews are in the [Round 04 handoff](<../../../website/Design Handoff.md>) and [manifest](<../../../website/Design Previews/Section 02 Round 04/manifest.json>); implementation remains pending.

## Round 03 — historical scanability correction

The user rejects the expanded guide's density: visitors scan, and this should feel light like the hero. Preserve the verified six methods and frequency meanings, but remove the explanatory paragraphs, six repeated “Examples” labels, eyebrow and separate frequency preamble. Use **Your habits. Your way.**, one short subline (**From daily habits to monthly goals.**) and compact emoji-led entries with short goal examples. Checklist retains steps and weekly/monthly repetition; quitting retains elapsed-time meaning; cut-down retains both maximum units and daily/weekly/monthly scope. These remain information, not app controls.

Reuse the existing verified research and source assets; no fresh corpus study or claim about conversion. Keep actual hero and tasks content unchanged. Replace the long continuous white guide with six light entries on the hero's pale canvas, using existing SF Pro/neutral foundations. Three columns on desktop, two on tablet, one compact stack on phones. Measure word count and layout height as design evidence, inspect four final renders and preserve the accepted surrounding content. No motion or runtime change (U5/W6/U9/S19).

**Round 03 delivered for review:** 75 whitespace-delimited text tokens versus 181 before (about 59% less); measured consistently over the habit section's visible text. All six methods and required meanings remain. Main section heights are now 641/792/1083/1158px, versus 919/1166/1888/2011px. The initial horizontal-card change left its text column fixed and caused clipping; fixed width/hug height axes and child FILL sizing were corrected. All four final renders inspected; no card text overflow, SF Pro/shared styles and six emoji fills verified. Hero and tasks text/dimensions/internal geometry unchanged. Same source/review IDs; Round 02 PNGs retain history. [Current preview manifest](<../../../website/Design Previews/Section 02 Round 03/manifest.json>). User design approval and implementation remain pending.

## Corrected scope

The visitor question remains **“Will this tracker fit the habits I actually have?”** The user clarifies that this section must answer it through both tracking methods and frequencies, covering all habit methods rather than three selected examples. Weekly and monthly goals, checklist repetition, quitting time, and cut-down amount/time limits must be explicit. Tasks belong in a separate section. The following draft Ways to track section will become the tasks companion so the page does not repeat the same habit inventory.

The [Round 01 research](<Section 02 — Goals That Fit Your Life.md>) and its complete nine-original review index remain the evidence for personal fit, clear amount-plus-period wording and simple presentation. No additional corpus audit or new prevalence/visitor ranking is claimed here (W2/W6). This revision follows direct user feedback, current code verification and reasoned information design.

## Accuracy check and copy inventory

Current sources: [NewHabitView.swift](<../../../iOS/Habits/AddHabit/NewHabitView.swift>) ItemType, summaries, examples and form save paths; [HowOften.swift](<../../../iOS/Habits/Model/HowOften.swift>) HowOften and HabitPlan; [HowOftenEditor.swift](<../../../iOS/Habits/AddHabit/HowOftenEditor.swift>) limit/count/amount choices; [Habit.swift](<../../../iOS/Habits/Model/Habit.swift>) kind and frequency meanings; [Design Rules](<../../../iOS/Design Rules — Don't Regress.md>) New Habit and limit behavior.

| Method | Explanation | Illustrative examples |
|---|---|---|
| Check it off | Mark a habit done, once or several times. | Make bed — every day; Call family — 3 times a week. |
| Track an amount | Record quantities with your own unit and goal. | Water — 8 glasses a day; Books — 2 a month. |
| Time it | Use a timer or log time manually. | Read — 20 minutes a day; Study — 3 hours a week. |
| Follow a checklist | Break a habit into steps and tick each one. | Kitchen reset — dishes, sink, floor; repeat every week or month. |
| Quit | See time since you stopped or your last slip. | Quit smoking; Log a slip when it happens. |
| Cut down | Set a maximum amount or time for a day, week or month. | Coffee — max. 2 cups a day; Social media — max. 30 minutes a day. |

Weekly/monthly amounts are totals for their period. A count of times is distinct from a count of different days. A checklist finishes when all its steps are ticked; weekly/monthly repetition is of the checklist, not an arbitrary pool of steps accumulating across the month. Quit is elapsed time, not a deadline/countdown. A cut-down time limit is supported through minutes as the unit and a duration kind; no claim of automatic screen-time monitoring or app blocking. Example quantities are customizable examples, not health recommendations. Yearly/interval/specific-date options exist but the section is a concise overview, not an exhaustive configuration manual.

Headline: **Different habits. Different ways to track.** Support: **Choose how to track each habit, then set the goal or schedule that fits.** Frequency summary: **Daily, weekly, monthly — or on specific days.** This summary describes build/maintain schedules; the quit/cut-down explanations state their own meanings.

Tasks companion: **For the things you do once.** **Add a date and optional time. Keep one-time to-dos alongside your habits.** Examples: Buy groceries, Send a parcel, Pay a bill. Tasks can also repeat in the app; this section introduces one-time use without claiming it is their only capability.

## Presentation boundary

All six entries are informational editorial blocks: meaningful Noto emoji, named method, one short explanation and explicit example sentences. Remove progress bars, numeric slots, completion/check controls, weekday selectors and simulated clocks. There is no visual promise that this is how a screen looks in the app. Do not add a technical disclaimer to the visitor flow; the educational form and “Examples” labels communicate the role directly. Actual native app proof remains in the hero (U2/U9).

Reuse SF Pro, neutral variables, small licensed store-family emoji and auto-layout. Three columns on desktop, two on tablet, one on mobile/320px; every method stays visible, without a carousel. Tasks are a separate small neutral section. Static text and small emoji assets only; no motion, 3D runtime, blur or live timer (S19). Inspect all four final renders, verify coverage, source asset fills, wrapping and hero preservation. Implementation and real-phone speed remain pending user approval.

## Delivered for review

The four habit section IDs remain `1284:146` / `1284:501` / `1284:810` / `1291:1241`. The formerly duplicate tracking sections now introduce tasks at `1284:163` / `1284:518` / `1284:827` / `1291:1258`. Stable review IDs `1385:2974` / `1385:3097` / `1385:3220` / `1385:3343` now contain the combined habit/tasks composition; Round 01 PNGs retain the previous three-example proposal.

Six reusable informational components live in `1395:3263`; tasks source is `1395:3265`. All eight habit/review copies contain six methods, weekly/monthly goals, checklist steps/repetition, elapsed quit wording and both limits. SF Pro and resolved licensed emoji fills verified, no text outside section bounds, and the hero's text/dimensions/child geometry unchanged. All four final renders inspected. The pale background's fallback paint, narrow-phone headings, tablet headline and obsolete review height were repaired after visual inspection. Source tokens were preserved. Four PNGs decode and match final Figma dimensions/checksums. No fresh review audit or performance measurement is claimed. Current files: [Design Handoff](<../../../website/Design Handoff.md>).
