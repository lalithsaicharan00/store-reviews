# Section 02 — Goals That Fit Your Life

Written by Codex, 12 October 2026. Current Work 93. Research-led Figma proposal; website implementation and user acceptance remain separate.

**Round 01 historical proposal:** the user expanded this section to all habit methods and frequencies and requested clearly informational presentation. [Round 02](<Section 02 Round 02 — Habits and Rhythms Explained.md>) supersedes the three-example layout below; its review IDs now show the expanded composition. The nine-original research index remains evidence, not a new audit.

## What belongs after the hero

**“Will this tracker fit the habits I actually have?”** The hero establishes the app, today's tracking, progress and download. The next section should make personal fit concrete: different habits have different amounts and schedules. Show familiar examples people can map to their own life before asking them to learn the full feature list.

This ordering is reasoned from review evidence and the download objective (W2/W6), not a measured ranking of website visitor needs. We have no oftenenough.com survey, analytics or conversion experiment. Progress, easy logging, cost and trust also matter; the hero already introduces progress, native logging and the free/Plus offer. Dedicated sections can explain those afterward. Availability remains in Download. No universal “second most important feature” claim.

## Evidence and scope

Read Claude's earlier [How People Describe a Habit](<../Habit Creation/How People Describe a Habit — 4,407 Descriptions From Reviews.md>) and [Goals — Periods, Entry and What + Adds](<../Habit Creation/Goals — Periods, Entry and What + Adds.md>). The first study's description corpus and counts are attributed earlier research, not a fresh audit here. Its key useful distinction is that amount and rhythm belong in the same plain-language sentence. Current code supersedes old implementation details: GoalInput.swift now uses each habit's saved quick increment, not the older threshold rule for what + adds.

I read nine full original App Store reviews individually: four retrieved from citations in the description study and five reused from the verified Hero Round 03 originals. This is bounded source verification across six apps, not a sample estimating popularity or a new full-app corpus analysis. Dates span January 2016–June 2024. Competitor criticism is historical, not a claim about today's competitor behavior. No country-level, clinical or outcome claims. An additional weekday citation in the earlier mixed-platform report was absent from the App Store corpus search; it is excluded from this audit, rather than treated as verified.

| App | Original ID | Reading and design implication |
|---|---|---|
| Streaks | 11421595582 | Gives daily walking and reading a few days weekly as familiar examples. Personal transformation claims are not transferred to ours. |
| Productive | 1324482823 | Wants multiple checks on one day toward a weekly count. Distinguish number of times from distinct days; do not imply they are interchangeable. |
| Way of Life | 1557285030 | Requests weekly/monthly frequency and names meditation/exercise examples. Makes flexibility explicit rather than leaving it in setup jargon. |
| Way of Life | 1705374517 | Names water amounts and several-times-weekly habits; daily-only workarounds disappoint. Also values skipping/reminders, which are separate concerns. |
| HabitKit | 10260406195 | Values simplicity and longer progress history. Keep this section concise; progress remains a later proof opportunity. |
| Habit — Daily Tracker | 3901732031 | Wants statistics to match a weekly goal. A weekly example must show a weekly total, not a daily failure grid. |
| Habit — Daily Tracker | 4685770593 | A three-times-weekly gym goal looks worse than daily habits in its statistics. Neutral untracked spaces must not imply failure. |
| Do Habits | 8101391015 | Values simple setup/logging over distracting extras. Show three comprehensible examples, not every setting; no ADHD efficacy promise. |
| Do Habits | 7462593752 | Wants the total of a weekly amount. Goal period and amount should be shown together. |

Exact paths, dates, ratings and the complete reading map are preserved in `Research/Temp/website-section2/`. All nine original IDs and interpretations must match; no omitted record. Source body is the authority. Earlier numerical coding is not independently recounted.

[NN/g homepage principles](https://www.nngroup.com/articles/homepage-design-principles/) recommends clear purpose, useful imagery, simple presentation and representative content examples. Applied here: three recognisable habit goals make flexibility understandable without a long feature inventory. [NN/g product-page guidance](https://www.nngroup.com/articles/ecommerce-product-pages/) supports answering purchase questions with clear product information; applying that to an app download is our inference. Neither article establishes this exact page order or a conversion uplift.

## Copy and actual behavior

Headline: **“Goals that fit the way you live.”** Supporting copy: **“Some habits are daily. Others fit a few times a week. Choose a goal and a schedule for each one.”**

| Example | Message | Code/spec support |
|---|---|---|
| 💧 Water — 8 glasses a day | Track an amount, not just done/not done. | GoalDraft amount/unit/day; Habit.quickIncrement; existing native Today Water 3/8. Eight is an example, not health advice or a universal recommendation. |
| ☎️ Call family — 3 times a week | A weekly count can happen on whichever days work. | GoalPeriod.week / Frequency.perWeek. Three marks show the goal count, not three compulsory weekdays. |
| 📚 Read — 20 minutes, Mon/Wed/Fri | Time and chosen weekdays can coexist. | GoalDraft.duration and ScheduleDraft.specific → weekdays. Selected day labels indicate the schedule, not completed sessions. |

Verified current sources: [GoalInput.swift](<../../../iOS/Habits/Model/GoalInput.swift>), [Schedule.swift](<../../../iOS/Habits/Model/Schedule.swift>) and [New Habit Goal and Time of Day](<../../../iOS/Docs/Specs/New Habit Goal and Time of Day.md>). GoalPeriod supports day/week/month/year; ScheduleDraft distinguishes selected weekdays, flexible distinct days and recurrence. This section does not promise automatic Health tracking, an amount on N arbitrary days as a times count, readings/mood support, or changes to a habit's tracking type after creation.

## Visual plan and feasibility

Retain the hero. Replace the thin three-card wireframe with a deliberate, warm neutral section: oversized black/gray headline, short explanation and three generous white goal illustrations on a pale gray field. Give each example a meaningful Noto emoji, a large goal value, its period and a compact neutral visual explaining only that goal. These are editorial goal examples, not simulated iPhone screenshots or interactive controls. Use the store screenshot emoji family and existing SF Pro/neutral foundations (U2/U9). All cards remain visible; no carousel.

Desktop shows three cards across, tablet uses a compact three-card row, mobile and 320px stack the examples with full-width readable text. Native UI/hardware in the hero stays untouched. Static text/vector/emoji artwork; no 3D engine, blur, autoplay or animation. Later implementation should avoid shipping Figma frame rasters; use semantic HTML/CSS and small emoji assets. Runtime speed and physical-phone acceptance remain unmeasured until implementation (S19/U9).

## Delivery and visual checks

Four full-Home sections updated in place; `1284:146` is retained. Four focused review frames: `1385:2974`, `1385:3097`, `1385:3220`, `1385:3343`. Six reusable goal variants live in `1385:2912`. Hero text and child geometry are unchanged. All website text uses shared SF Pro styles; example marks are editable vectors, with three discrete emoji image fills per composition.

The available color-emoji font returned plausible metrics but blank pixels. Replaced it with the same Noto v2.047 asset family used by the store screenshots, using the provider's unchanged 128px PNGs and preserving Apache-2.0 licensing. The three assets total 11,425 bytes. Tablet illustration sizing was corrected after resize reset it to FIXED. Gray headline and weekday text use the secondary token for legibility on their actual fields; no added shadows or motion.

Desktop, tablet, mobile and 320px final renders inspected. Nine original IDs/body/rating/date/country records and the complete hand-written interpretation map verified; no duplicates or omissions. Four PNGs decoded/checksummed; no text outside section width, all illustrations fit card inner widths, and no free-standing text without a shared style. Current preview files and details: [Design Handoff](<../../../website/Design Handoff.md>). This completes the research/Figma proposal, not user approval, implementation or real-phone performance validation.
