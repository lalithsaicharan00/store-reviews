# Habit Tracker — Business Model, Free Baseline and Moat

23 September 2026 · Built from a read of every card in the Feature Ledger (7,590 cards across 70 App Store reports, the two research documents and the native reports) · **Recommendations, not decisions.** Decisions stay in Notion.

---

## 0. The answer on one page

**Where we stand.** The category earns money by charging for the act of tracking habits: a 1–5 habit cap, a trial that locks you out, or a subscription on a static checklist. That is the main source of 1★ reviews across the ledger. Every app that stopped doing it improved, and every app that started doing it lost ratings. Our opening is to be the tracker that never charges for tracking, and to earn money on things people actually volunteer to pay for.

**Free, forever, and said out loud.** This is a complete tracker. It beats Apple Reminders, Google Tasks and Microsoft To Do at the one job they fail:

- Unlimited habits, with every schedule shape: daily, chosen weekdays, N times a week, every N days, monthly, counts and durations. It also handles habits you are quitting or limiting.
- Your full history is always readable, with a year grid and basic stats.
- A forgiving momentum score sits beside an optional streak.
- Reminders: multiple per habit, with your own words, completable from the notification, and a "nag until done" option.
- Interactive home-screen and lock-screen widgets, and check-in on Apple Watch and Wear OS.
- Sync across your own devices, with automatic backup, import and export.
- Undo, backfill, skip, pause and archive.
- Dark mode, a passcode or Face ID lock, and no account required.
- No ads, ever.

**Paid, part 1: "Plus", a one-time purchase.** Price it at about US$14.99, adjusted by region. It sells three things:

- **Personalisation:** themes, extended palettes, photo covers, app icons, widget designs, sounds.
- **Depth:** compare habits and periods, long-range timelines, goal pacing, a detailed Year in Review.
- **Patronage:** Supporter status, and the option to gift Plus to a student who can't pay.

It is offered at moments of success, never at a wall. This is the main business.

**Paid, part 2: one subscription, only because the value keeps arriving.** "Companion" costs about US$2.99 a month or US$19.99 a year. It is an opt-in AI reflection partner that reads your check-ins and notes and replies, plus a growing library of guided programmes. It is justified because it costs us money every time it is used and it produces something new every week. The ledger's static subscriptions failed for the opposite reason. If Companion fails its test, we drop it and the business still stands on Plus.

**The moat.** An AI can clone a checklist in ten minutes. One reviewer did exactly that with Claude (R89-015). The defences have to be things a prompt cannot reproduce:

- A public pricing pledge, then years of keeping it.
- Signature mechanics and craft: a momentum score, the year grid, a satisfying completion.
- Being the default recommendation, from LLM assistants to therapists to the widget people see 50 times a day.
- Users' own multi-year history, which we let them take away freely and let them bring in from any rival.
- Breadth of localisation.
- A founder-led public roadmap.

**Revenue.** US$1k/month net is about 80 Plus sales a month on its own. US$3k–5k needs roughly 200–300 Plus sales a month plus a few hundred to a thousand Companion subscribers (section 6). At the conversion rates the research gives for freemium, that means roughly 3,000–10,000 new installs a month. Becoming the category's default is therefore the revenue plan, not a separate goal.

**Where this disagrees with the Notion decisions as I understand them:**

- **6 free habits.** I recommend unlimited.
- **No subscription.** I recommend one, for Companion only.
- **No tips.** I agree: patronage is folded into Plus, so no tip jar is needed.

Section 10 has the detail.

---

## 1. What was read, and how

- **All 7,590 ledger cards, in order.**
  - Reports 01–67 and report 68 up to card R68-043 were read in full.
  - From card R68-044 through report 90 and the two research documents, I read a condensed view of the same cards: verbatim tables cut to their first eight rows, and per-country cards reduced to their summary line. Every claim, product rule, monetisation, contradiction, anti-pattern and tactic card was still read in full. The script is `Temp/fb-condense.py` and the running notes are `Temp/fb-notes.md`.
- **The two native reports:**
  - Reminders: 25,951 reviews.
  - Google Tasks: 7,069 reviews.
- **A keyword scan of Microsoft To Do**, 23,647 reviews. There is no full report for it, so treat its counts as indicative.
- **The earlier assessment**, `Habit Tracker — Free Baseline and Monetization Evidence Assessment.md`. Section 9 compares against it.

Crashes and generic reliability are left out of the pricing argument, as asked. Two reliability items stay in because they are part of what is sold: data that never disappears, and purchases that always unlock.

Citations are ledger card IDs (R`<report>`-`<card>`) or canonical codes (C`nnn`). Every R-ID below was checked against `Tools/prd_ledger/*/cards.jsonl`.

---

## 2. What we are actually compared against

There are three different comparisons, and mixing them up is how most apps in the ledger priced themselves wrong.

### 2.1 The free tier is compared with what is already on the phone, and now with AI

The native apps have a real habit gap, and it is the same gap everywhere:

- **Apple Reminders.** 1,163 of 25,951 reviews (4.48%) want habit behaviour, flat for five years. The cause is structural: completing a repeating reminder wipes the record of having done it. Willingness to pay for Reminders is effectively zero: 11 reviews, and the one articulate pricing statement rejects about $100/year and entertains a one-time price. The gap is loudest in China (9.0%), India, Korea and Japan, and below average in the US.
- **Google Tasks.** 320 of 7,069 reviews (4.53%). In 84 of the 94 reviews where a habit fails, the cause is that the recurring task hides until it is due. People pay third-party apps built on the free Google data for the one missing capability.
- **Microsoft To Do** (keyword scan only). 112 of 23,647 reviews mention habits or streaks. The typical story: after a death in the family, the reviewer had to "lie by marking them done" because the app has no skip.
- **Notes, Calendar, paper and spreadsheets.** These are named whenever a paywall blocks someone:
  - Habit Hub: "0 reviewers leave for a named paid competitor". The people who left went to free defaults (R43-059/094).
  - Mindway lost users to Reminders because it sold task slots, which is the exact thing Reminders gives away (R60-010).
  - Grit's gated users compared it with Reminders and a paper notebook, not with Streaks (R25).
- **AI assistants, a new substitute.**
  - "Uninstalled this and created my own in 10 mins with Claude" (R89-015).
  - "I would get a better personalised routine using ChatGPT for free" (R09).
  - 36 reviewers say Life Reset's plan could be generated free (R49-056).

**Implication.** The free tier has to be clearly better than Reminders plus a spreadsheet plus a chatbot at the habit job. Anything we charge for that looks like a list, a slot, an alarm or a checkbox will be priced against zero (C214, C277, C257).

### 2.2 The paid tier is compared with one-time rivals

Users who are willing to pay compare us with:

- Streaks, a one-time purchase. Its price rose from $3.99 to $9.99 over 11 years with no rise in price objections (R23).
- HabitKit, at about €35 lifetime (R07).
- Awesome Habits, at $22.99 lifetime (R41).
- Habit Hub, at $2.99–4.99 one-time (R43).

People churn away from subscription apps to these: 26 left Habit — Daily Tracker for Streaks after it switched to a subscription (R20), and Atoms users left for "HabitKit $16 lifetime" (R16).

### 2.3 The brand is compared with the category's reputation

Reviewers arrive primed by the category's worst trust practices:

- Trials that charge early.
- Off-store web billing.
- Countdown "50% off lifetime" offers that double-charge (R88-005).
- Lifetime purchases revoked (R13, R20, R31, R53, R76).
- Data locked behind a paywall (R74-005).

"When did we normalise that a habit tracker doesn't allow us to track habits?" (R58-008). That resentment is our marketing.

---

## 3. The free baseline

### 3.1 The table

| Capability | Free boundary | Why it has to be free (evidence) |
|---|---|---|
| Habits | **Unlimited**, and never changed later | The cap is the single largest source of 1★ reviews in the ledger. Natural experiments show the effect of the cap size: <br>• Habit Hub removed its cap: cap complaints went from 14.1% to 0% and all monetisation friction went from 23.1% to 0% (R43). <br>• Habit Hearts cut its cap from 3 to 1 for six weeks: mean fell from 4.85 to 4.29, then recovered to 4.73 when the cap went back to 3 (R72-004). <br>• Today: 1-habit complaints average 1.97★, 3-habit complaints 3.60★ (R86-009). <br>• HelloHabit: 5 free habits was defended (3.78★), 3 was hated (2.20★) (R50-006). <br>For free-and-unlimited apps, "free" is the acquisition story: free praise rose from 5% to 47% of TheFor's reviews while rivals capped (R69-004), and it is stable at 44–47% in every era of HabitGrid regardless of language mix (R84-037). C007, C296, C297. |
| Schedules | Daily, chosen weekdays, N× a week on any days, every N days, monthly; counts, durations and partial progress; non-scheduled days are neutral in stats | This is the one structural request that runs through the whole ledger: Way of Life saw it in 15 of 16 years (R76-005). It separates us from Reminders, and "3 times a week" must not fail on the other days. C043, C048, C143. |
| Quit and limit habits | Days-since counter, limits ("2 drinks a week"), and a relapse that is logged but does **not** wipe history | "Relapse destroys the record" is the most-repeated complaint in the leading quit tracker. The #1 habit app ships quit tracking badly. Quit keywords can be won from inside our own listing (RQH-006/010/011/016, R90-004). C019, C308, C309. |
| History and stats | Full dated history, year grid, week/month/year views, totals and completion %. **Plus adds depth, never access.** | Gating the progress view removes the motivation loop (C234). Grit's evidence predicts that free stats *increase* conversion (R25). "Don't Break The Chain only makes sense if you can see your chain" (R34). |
| Scoring | A forgiving momentum score (a missed day lowers it, doesn't zero it), with the streak optional alongside | Momentumly's concept drew 26.8% praise and zero detractors in 20 months (R77-004). Habit — Daily Tracker's "habit strength %" was "the only feature no competitor has" (R20). Awesome Habits' % ring won perfectionists (R41-077). C216, C157. |
| Reminders | Multiple per habit, your own wording, actionable from the notification, nag until done, and never silenced after a miss | A paid reminder moves the comparison to a free alarm: "Your alarm… can do everything this app does. Wasted $20!" (R42-025). Nag-until-done is "something no other app has offered" (R43-011). C257, C258, C252, C288. |
| Widgets | Interactive home-screen and lock-screen check-off, showing all habits | This is the retention surface. <br>• The widget is the most-requested feature in every year of Quit Bad Habits (14%) (R90-006). <br>• Ripples' widget had 27 praise mentions at 5.00★ with none negative, then was gated and drew "Useless if you don't pay" (R79-007/025). <br>• Days Since gated its widget: 1–2★ went from 1.75% to 8.64% (R03). <br>C023, C040. |
| Watch / Wear | Glance and check-in | Watch was requested every year since 2015 in Habitica (R85-011). Watch apps are a named purchase reason (R23), but only for richer workflows; basic check-in is expected. C022. |
| Sync | Across your own devices, automatic backup on by default, restore that can't destroy data | Sync is what users say they would pay for (R76-109). But it is free elsewhere, it is the paid feature most often broken (R55-085, R36-150), and "iCloud means no server cost" is thrown back at subscriptions (R41-084). Charging for it creates the category's worst 1★ class. C030, C034, C153, C230. |
| Import and export | Free CSV and backup; import from the major rivals | "Never gate data exit" (R34). Import lowers the cost of switching *to* us (R31: "import your Done data, keep your one-time price"). C020. |
| Recovery | Undo, backfill, skip, pause, archive, graduate a habit | Charging for backfill is "charging to undo the app's own penalty" (R47-008). Archive was the most-upvoted request in Today and HabitMinder (R86-027, R53-029). C262, C016, C227, C223. |
| Notes | A short note on any check-in | Notes are credited as a differentiator (R50-011) and requested (R86-029). C172. |
| Look and privacy | Dark mode, a good default palette and icons, passcode or Face ID lock, no account required, offline | Dark mode behind a paywall got "immediate deletion" (R46) and 3★ (R76-024). A paid lock that leaked through the widget was the worst of both (R86-013). C080, C009, C017, C209, C188. |
| Ads | **None, anywhere** | Ads on the completion or creation path are the most destructive monetisation in the ledger (R28, R47-006, R57-008, R65-014). Gambling ads were served inside an addiction app (R90-009). C246, C240. |

### 3.2 What this gives away that competitors charge for

| Competitors charge for | Examples in the ledger | We charge |
|---|---|---|
| More than 1–5 habits | HabitKit 4, Habitify 3→2, Atoms 1, Grit 3, everyday 3, Streaks 6→24 | $0 |
| Widgets | HabitKit (all Pro), Days Since, Ripples, Momentumly | $0 |
| Stats and history | Grit, Habify (yearly stats), Habit Check Calendar (records locked after trial) | $0 for the full record; Plus adds depth |
| Sync and backup | Today and Way of Life (paid backup), DayStamp ("practically blackmail") | $0 |
| Reminders and exact times | Productive, Daily Habit & Routine Tracker | $0 |
| Dark mode and passcode | Way of Life, Check Calendar, Today | $0 |

---

## 4. Paid, part 1: Plus, a one-time purchase

### 4.1 Why a one-time purchase is the main engine

- **The one-time model is itself the top reason people buy.**
  - 22.4% of Habify's paid cohort name "not a subscription" as their top reason (R01).
  - Awesome Habits' lifetime option is its most-cited commercial feature, and a "no-brainer" (R41-013).
  - Streaks' "no subscription" praise *grew* from 3.6% to 8.0% as the category moved to subscriptions (R23).
  - Tappsk sold to 1,090 lifetime payers; its one-time praise outnumbers subscription objections 93 to 23 (R59-012).
- **It produces almost no billing conflict.** Habit Hub had 2 refund requests in 638 reviews at $2.99–4.99 (R43-091). Habit Check Calendar had zero refunds or cancellations (R74-025).
- **Switching to a subscription destroyed good apps:**
  - Productive fell from 4.75 to 2.37 (R13).
  - Habit — Daily Tracker fell from 4.56 to 1.62 in one release (R20).
  - Strides averaged 2.21★ for nine months until it reversed the switch and recovered to 4.62 (R48-006).
  - Done's price objections went from 4.1% to 13.0% (R31).
  - Way of Life lifetime buyers were told they no longer had premium (R76-009).
  - Ripples lost its year-one differentiator (R79-005).

### 4.2 What goes inside Plus: only things people ask to pay for

| Area | Contents | Evidence that it sells when the core is free |
|---|---|---|
| **Personalisation** | Theme packs; extended palettes with a hex picker; photo covers per habit; alternate app icons; widget designs; completion sounds and haptic styles | <br>• Cosmetic gating is the most tolerated gate: skins 2.77★ vs habit cap 2.30★ (R36-050). <br>• In ShineDay, themes and icons lift payers ×3.65 and ×2.83 (R52-054). <br>• In everyday, a palette is the only purchase asked for unprompted ("I will pay for this!!") (R46-012). <br>• In Today, photo covers are a named trigger (R86-037). <br>• In Days Since, widget customisation is the #1 trigger once the base widget is free (R03). <br>C167, C107, C261, C079. |
| **Depth** | Compare habits and periods; multi-year timeline; goal pacing ("where you should be today"); a detailed Year in Review (a basic one stays free); descriptive patterns | <br>• Reports are Habify's #1 paid driver (R01). <br>• A long-range comparison is ShineDay's most-upvoted request (R52-094). <br>• Pacing is what Strides users value (R48). <br>• "Free basic year summary, paid detailed report" (R52-198). <br>Caution: "nobody reports buying for statistics" when the stats were basic (R86-037), so depth has to be real. |
| **Power** | Advanced Shortcuts and automations, NFC check-in, extra Watch complications, Health-driven auto-complete rules | Power users are the paying segment (R07). Health auto-complete "removes the friction that killed every other habit app" (R23). C046, C021. |
| **Patronage** | Supporter status, and "gift Plus to a student" | <br>• Supporting the developer is the purchase trigger with the largest lift: 15× in 継続する技術 (R70-015) and 37× in Habitica (R85-028). <br>• A scholarship scheme was Habify's cleanest source of 5★ reviews (R01). <br>• Habit Hearts' hardship grants gave 11 grants and 11 5★ reviews (R72-008). <br>• Finch's sponsored memberships have 708 mentions at 4.76★ (R10). <br>C025, C061. |

Family Sharing is on. One purchase covers every platform we ship (C271).

### 4.3 Price

- **Evidence band.** The one-time willingness-to-pay clusters at $10–30 (R16), $5–15 (R20), $10–20 (R48) and $5–10 (R55).
  - $22.99 drew zero objections in 2026 (R41).
  - Objections rise at about €35 "for a utility" (R07), and $99.99 is too high, with an anchor of $30–70 (R46-010).
  - Today's $299.99 "lifetime" beside a $9.99/year plan reads as "a mistake or contempt" (R86-061).
- **Recommendation.**
  - US$14.99 with purchasing-power pricing by region (C092).
  - One stable price: no countdowns, no "wait, don't go" offers (C113, C180).
  - An honest New Year sale is fine. Tappsk's lifetime purchases mostly happened on discount (R59).
  - Always say "one-time, not a subscription" (C305).
- **When to show it.**
  - Never on app open, never on the check-in path (C240).
  - Show it in Settings and at a success moment: after a 30- or 100-day run, or at the Year in Review.
  - In 継続する技術, 40.7% of buyers bought as a reward after completing 30 days (R70-014). Awesome Habits recommends surfacing the unlock at a 14-day streak, not at a count limit (R43-135).
  - The purchase screen says plainly that everything the user has today stays free (R90-043, C110).

### 4.4 The honest risk

Fully free apps have almost no paying evidence:

- HabitGrid has none (R84-028).
- Dots had one unprompted donation request (R56-021).
- Blossom's willingness to pay is "patronage-shaped, not access-shaped" (R58-011).

So Plus cannot be a tip jar with a new name. It needs design investment in beautiful themes, widgets and a Year in Review. The evidence that it can work is Habit Hub, which still sells its one-time unlock after going unlimited (R43), and HelloHabit's payers, who were "happy with one clean gate" (R50-008).

---

## 5. Paid, part 2: is a subscription justified?

### 5.1 Static subscriptions fail, and reviewers say why

- "It's not like a yoga or meditation app, constantly adding new content, so why a yearly fee?" (R55-029)
- "Subscriptions make sense if there is running cost… this isn't the case." Atoms users call it renting a checklist (R16).
- Productive's objection is "not Netflix" (R13). Habit — Daily Tracker drew "ZERO updates… nothing that justifies a yearly fee" (R20).
- "A tracker is not a service" (R33).
- An annual fee reads as a promise of ongoing development, and reviewers then judge the app by its update log (R55-029, R17, C196).

### 5.2 Where recurring value does exist in the ledger

- **An AI reply to the user's own check-in.**
  - DotHabit's AI coach was the first premium feature praised unprompted, at 12.3% of its latest era (R47-012).
  - Roubit's AI letter is its most singled-out feature (21.7% of an era). Payers "subscribed… the money isn't wasted at all" (R83-004/029).
  - At Critique AI, insiders called a working coach "a steal" against a human trainer (R64-039).
- **A continuing content stream.** Finch's monthly events and pet (R10). Fabulous's coaching content, whose positive reviews are about the product and whose negative reviews are about billing (R24).
- **Hosted services with running costs:** accountability partners, and a coach seeing a client's progress (R48-046).

### 5.3 The proposal: Companion

**What it is (opt-in, its own tab, never in the core loop):**

1. **An AI reflection partner.**
   - It reads your check-ins, notes and misses, replies, and writes a weekly review letter.
   - It suggests adjustments you can accept or reject.
   - It must consume its input: no confident feedback on empty input (R64-012, C279).
   - It is labelled as AI (R83-044), off by default, and never decorates the core with AI art or copy (R49-011, C267, C056).
   - It follows a crisis protocol for self-harm and addiction disclosures (R83-006/044, R90-008, C162, C103).
2. **A programmes library that grows every month.**
   - 30-day programmes with sources ("the why").
   - The library with sources was what worked for Ultiself (R68-010). The guided setup that shrinks goals to five minutes was 継続する技術's strongest mechanic (R70-004).
   - It is a saved library, not a stream (C233).

**Price and terms:**

- US$2.99/month or US$19.99/year. The reservation band is $2–5/month and $15–60/year (R16). Roubit's ₩55,000/year drew "Animal Crossing is ₩50,000 for life" (R83-008).
- The monthly option is always visible (C163). No weekly tier (C190).
- In-app cancel (C112), a reminder before renewal (C152), and no retention offer at cancel (C287).

**Free allowance instead of a card-gated trial:**

- A few AI reflections a week, free forever, stated before the user writes.
- Roubit's free letters were loved; letters that "just stop" without warning were resented (R83-047).
- A card-free trial converts worse per start and far better per review (R49-090).

**Guardrails and demand caveat:**

- Plus owners never see pop-up upsells for Companion (C248). It lives in its own tab.
- Explicit demand for AI in minimal trackers is close to zero: 6 of 56,653 reviews in Habify (R01), 0 of 498 in Rabit (R65-050), and restraint-product users punish AI additions (R05, R11, R79-069). So Companion is a bet for a segment, not the brand. Build the free product and Plus first, then test Companion with real users. If people don't return to it weekly, drop it.

**If the Notion "no subscription" decision stands,** do not sell AI in a lifetime tier. Its cost never ends. Leave AI out entirely, and the business rests on Plus.

---

## 6. Revenue and margins

**Assumptions** (not from the ledger; replace with real figures):

- Store fee 15% under Apple's and Google's small-business rates.
- Plus averages about US$10 net after regional pricing and tax.
- Companion averages about US$1.70 net contribution per subscriber-month, after an assumed AI cost of $0.10–0.30.
- Plus conversion over a user's first 90 days is 2–4%. The research document puts B2C freemium at 1–4% and says users still active after week one are 5–8× more likely to convert (RFG-014).

| Net target per month | Plus sales/month | Companion subscribers | New installs/month needed (at 3% Plus conversion) |
|---|---|---|---|
| **$1,000** | ~80 (≈ $800) | ~120 (≈ $200) | ~2,700 |
| **$3,000** | ~200 (≈ $2,000) | ~600 (≈ $1,000) | ~6,700 |
| **$5,000** | ~300 (≈ $3,000) | ~1,200 (≈ $2,000) | ~10,000 |

**Reading the table:**

- **Margin is high.** Local-first data with CloudKit or Google Drive sync costs almost nothing per user. The only real variable cost is Companion's AI, and it is paid for by the subscription that uses it.
- **Lifetime revenue depends on a steady flow of new users; the subscription is a stock that builds.** That is why growth and revenue are the same plan here. Being the category default is how the install numbers are met.
- **One case in the research shows what removing the cap does to conversion.** A consumer app went from a 3-item cap to no cap with extras gated, and conversion rose from 0.8% to 2.6% (RFG-009). Caps make people leave rather than pay (RFG-011/016).

---

## 7. The moat in the AI era

What can be copied in a weekend, and what cannot:

| An AI can copy in a weekend | What it cannot copy, and the evidence |
|---|---|
| A checklist with streaks and reminders (R89-015; R49-056: "the checklist is" reproducible) | **A track record of never breaking the pricing promise.** Trust compounds because everyone else keeps breaking it (R20: "Trust is the moat, not features"; R23's no-subscription praise grew as rivals subscription-ised). Publish a pledge (§7.1) and keep it for years. |
| A nice-looking screen | **Feel and signature mechanics:** press-and-hold completion with haptics and sound, "hardest thing to copy" (R36-082, C229); the momentum score (R77); the year grid (R34, R79, R84); native feel, "feels like Apple built it" (R79-023). |
| Features | **Being the default recommendation.** <br>• LLMs already route users: "GPT suggested this app… I immediately closed Xcode" (R84-006); "asked GPT to recommend an app" (R57-062); ChatGPT led to Habitica (R85-052). They recommend the free, well-reviewed, well-documented option. <br>• Therapists and coaches (R23, R55-030, R76-041). <br>• Press and podcasts (R76-062). <br>• A shareable Year in Review: a Reddit screenshot led to an install (R50-060). <br>• The widget as a daily impression (R79-066). |
| — | **Users' own history.** "A habit tracker's only durable asset is the user's history" (R31). Keep it ethical: free export, and import from rivals, so people stay because years of record live here, not because they are trapped (C176). |
| — | **Breadth of localisation, including content.** HabitGrid's review rate rose 2.7× after localising (R84-047); Me+ eliminated its localisation complaint within a year (R04). C027. |
| — | **A founder-led community:** public roadmap and voting (R48-038, R79-028, C298); the developer's own voice as the product (R70-018); founder support by name (R41, R48). |
| — | **Opt-in accountability.** Parties and guilds were Habitica's "soul", and closing them produced its worst era (R85-008). Keep it small and private, not a feed: "please never add social features" drew 48 votes (R52-036, C131, C202). |

### 7.1 The public pledge (brand copy)

1. Tracking habits is free. There is no limit on habits, check-ins, history, reminders, widgets, Watch or sync, now or later.
2. No ads. No data sold.
3. Anything you buy is yours. "Lifetime" means lifetime, on every platform, and if we ever change the model it is honoured.
4. You can leave with all your data, any time.
5. There are no trials that lock you out, no quizzes before the price, and no countdown timers.

Every retraction in the ledger (R36, R47, R48, R52, R53, R55, R57, R65, R79, R86, R89) is the story this pledge is written against.

### 7.2 Positioning and go-to-market

- **The line:** *"The habit tracker that's actually free."* The price argument is framed against the phone's free tools and against subscription rivals together.
- **Who to target first:**
  - Habit-tracker refugees who have tried 2–10 apps and want less, not more: 23.75% in TheFor (R69-012), 19.6% in Awesome Habits (R41-008), 32.6% in HabitGrid (R84-021).
  - People who hit the habit gap in native apps (§2.1).
  - Quit-habit searchers (RQH-016).
  - ADHD and neurodivergent users. Earn that audience through simplicity and forgiving design rather than claiming it (R56-049, C042), with no clinical claims.
- **Timing:**
  - A rival re-paywalling is an acquisition event (R08, R65-010, R36-176).
  - January is peak season (R48-015, C032).
  - Launch on Reddit or TikTok with the founder present (R34, R55, R58).

---

## 8. The "never" list

- Never move anything free behind payment, and never shrink capacity someone already has (C001, C191).
- Never put an ad, upsell or rating prompt on the check-in or create path (C240, C275). Never ask for a rating before the app has been used (C150).
- Never gate recovery or exit: undo, backfill, restore and export stay free (C262, C020).
- Never sell lifetime AI, and never sell a feature before it works (C078). Restore must be instant; cache entitlements for offline use (C033, C139).
- Never bill off-store or tie a subscription to another checkout (C210, C299). Never stack an offer on a purchase (C304).
- Never add pets, feeds, AI decoration or tabs to the core. Every addition is opt-in (C006, C207).

---

## 9. How this differs from the earlier assessment

**Where it agrees.** The earlier report's free-baseline table is broadly right: unlimited habits, reminders, widgets, sync, history, recovery and data ownership free. This report keeps all of that.

**Where it falls short, and what this report changes:**

1. **It never answers the question.** It hedges on every boundary, gives no prices and no revenue path, and ends with "no numerical estimate is possible". Sections 4–6 here commit to a model, prices and a sensitivity table.
2. **It puts the subscription on the weakest candidate.** Its primary subscription test is "Pro analysis/automation". The ledger says charts sell only when they are real depth (R86-037, R54-012), and "one more chart" is exactly the static subscription reviewers reject (R55-029, R16). The recurring value reviewers praised unprompted was an AI reply to their own check-in (R47-012, R83-029), so that is where this report puts the subscription.
3. **It undersells cosmetics.** It treats them as optional one-off packs. The ledger shows cosmetics as the most tolerated gate with the highest payer lifts (R36-050, R52-054, R46-012, R03), and they are how you "charge for delight, never for function".
4. **It has no moat and no AI-era defence,** which was the central question. Section 7 answers it.
5. **It has no acquisition or brand plan,** even though the revenue depends on installs. Section 7.2 covers it.
6. **It is written in mixed Telugu and English,** which is harder to share with a team.

---

## 10. Conflicts with the Notion decisions

I'm working from our earlier discussion of these decisions. Please correct me if the Notion page says something different.

| Notion decision | This report | Why |
|---|---|---|
| 6 free habits | **Unlimited** | A cap of 6 is survivable: 5 was defended in HelloHabit (R50-006), and one Habit Hearts reviewer said 6 would retain far more users (R72-005). But it gives up the positioning that makes a new entrant the category default (§3.1), and a cap does little converting when the paid tier has real value (R72-025, R59-069). If a cap is kept, prefer one that grows with use: ShineDay's quota growing with check-ins cut cap complaints from 8.2% to 0.6% (R52-021, C270). |
| One lifetime price | **Agree:** Plus | Section 4. |
| No subscription | **One optional subscription, for Companion only** | It is justified only by continuing delivery and cost. Without it, leave AI out entirely. |
| No tips | **Agree in effect** | Patronage lives inside Plus and "gift a student". No separate tip jar. |
| No ads | **Agree** | C246. |

---

## 11. First steps

1. **Ship the free baseline in §3,** starting with the four things that beat native apps: the year grid, flexible schedules, widget check-off and forgiving scoring.
2. **Publish the pledge** in the listing and on the website (§7.1).
3. **Build Plus** with three strong theme packs, the widget designer and the Year in Review. Offer it at milestones.
4. **Prototype Companion with 50–100 real users** on the free allowance. Adopt it only if they come back to it weekly.
5. **Measure:**
   - Day-7 and day-30 retention, and widget adopters' retention.
   - Plus conversion within 90 days, by trigger.
   - Companion's weekly active use and renewal.
   - 1★ reviews whose text is about money. The target is near zero; the ledger's apps with one-time, generous tiers run at about 0–5%.
