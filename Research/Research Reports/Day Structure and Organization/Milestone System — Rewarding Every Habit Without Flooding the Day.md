> **Who wrote this:** a deep-research tool, run by the user on 17 October 2026 from the prompt Claude (Claude Code) wrote
> for Current Work 127. Claude added it to the repository unchanged below the line, with the user's decision on top.
> Claude did not write the report.

## The user's decision (17 October 2026)

**Adopted as the milestone system for every habit and the whole app,** in the user's words: "this is good … from this
report, the only thing that we are changing is the row will have this animation".

**The one change: the row animation.**

- **When a milestone is shown in the row only** (no bar, no pop-up), it plays the **row milestone animation**, drawn in
  Figma as **R.1** (the row alone) and **R.2** (in a full Today, with the layout below moving):
  - the ✓ presses and fills, with the confirm vibration;
  - a small ring and burst go round the ✓;
  - the old line slips up, and the medal pops in with the words (*60 days in a row*);
  - the count rolls 59 → 60;
  - then Undo · Note open as after any log.

  The timings are in the Android designs handoff.
- **When a bar or a pop-up is shown for the milestone, the row animation doesn't play.** The tap gets the ordinary ✓
  fill and vibration, the medal and words still appear in the row, and the bar or pop-up carries the moment.

**What this replaces from the earlier milestone designs:**

- **Several milestones in one visit:** taps get only the row. At the next pause, the single best milestone gets one
  pop-up (if it's a landmark and the budget allows) or one bar, with *and N more today*. This replaces version 3's
  "one bar per milestone, each replacing the last" (Figma V3.2) and version 2's grouped pop-up (V2.5).
- **Pop-ups are for landmarks within the budget:** at most 1 a day and 2 in any 7 days. This replaces "a pop-up
  whenever a milestone comes alone" (V2.2).
- **What stays:**
  - the surfaces themselves: the pop-up sheet; the habit-coloured bar (V3.1, 72 dp, with sparkles, a sheen and its
    motion in V3.7); the medal and words in the row; the "While you were away" card;
  - "never a pop-up when the app opens".
- **The open decisions at the end of the report take the report's recommendations**, since the user changed only the
  row:
  - a shared day-3 first milestone;
  - older habit first on ties;
  - 66 in total for daily build habits only;
  - unit totals for build habits only;
  - a monthly look-back card;
  - opt-in notifications for quit landmarks (7, 30, 90, 365);
  - a "Pop-ups for big milestones" switch;
  - a synced presentation log.
- **Before shipping,** the report's unverified points need checking: the Duolingo +1.7%, the Material and WCAG
  specifics, and the alcohol and caffeine timelines (no health facts for those templates until then). Its "after"
  frequencies are estimates: re-run them with `Milestones on Today Evidence/simulate_pileups.py`.

---

# Often Enough: A Milestone System That Rewards Every Habit Without Flooding the Day

Keep milestones per habit, but decide what to celebrate once for the whole app: every milestone is still recorded and shown in its row, while pop-ups and bars are rationed by a fixed, on-device ranking with a budget of at most 2 noticeable moments a day, at most 1 pop-up a day and 2 in any 7 days, plus a floor that guarantees long-term users something meaningful every month.

## TL;DR

- **One budget for the whole app, many records per habit.** Every milestone is computed and dated on the habit page, and every one gets the row medal and the confirm vibration. Only the highest-ranked new milestones reach the bar (at most 2 a day) or the pop-up (at most 1 a day, 2 in any 7 days, usually 3+ days apart). Repeats of lengths already reached stay in the row. One milestone per habit per day. Habits that reach the same length on the same day share one moment.
- **Fewer rungs early, new tracks late.** Drop the rungs that cause pile-ups (10 and 75 in a row; 10, 45 and 120 for quit; several week rungs). Add tracks that keep growing for veterans: totals in the habit's own unit (hours, km, pages), yearly anniversaries, regular total rungs every 500, "again" comebacks, and a monthly look-back card. Science supports the timescale (a median of 66 days in one study of daily behaviours, with a range of 18 to 254). It doesn't justify any specific round number, and the report says which numbers are chosen for feel.
- **The five-candidate case is fixed by ranking, not by order.** When two or more milestones are possible in one visit, each tap gets only the row medal and vibration. At the next pause, the single best one gets the pop-up (if it qualifies and the budget allows) or one bar, with "and 3 more today". The last tap never wins just for being last.

## Scope and honesty notes

- **I couldn't read the repository, the review corpus, earlier reports or `simulate_pileups.py`.** None of them were attached. All review counts and "before" simulation figures below come from your brief. I invented no repository contents or review statistics.
- **What I verified:** the habit-formation papers (Lally 2010; Singh 2024; Buyalskaya 2023 and its correction; Gardner 2012), Maltz's 21-day origin, Silverman & Barasch 2023, Deci, Koestner & Ryan 1999, Kivetz 2006, Dai 2014, Bryan 2011 and its failed replication, Adams & Leary 2007, the lapse study by Kirchner, Shiffman & Wileyto, Rutledge 2014, and the NHS and American Cancer Society smoking timelines.
- **What I didn't verify:**
  - Material Design and WCAG specifics, Iqbal & Bailey, alcohol and caffeine timelines, and app-store reviews of Strava, Hevy, Finch and the quit apps.
  - The Duolingo +1.7% figure. I found it only in secondary write-ups, not on Duolingo's blog.
  
  These are marked where used.
- **The "after" frequency figures are my estimates, not simulation output.** They come from the formulas below. The included script is a specification to re-run against your simulator; it was not executed for this report.

## Key Findings

1. **"66 days" is narrower than its reputation.**
   - Lally, van Jaarsveld, Potts & Wardle (2010) gave 96 volunteers one eating, drinking or activity behaviour to do daily in the same context for 12 weeks.\[1\]
   - 82 gave enough data. The curve fitted 62 people, but only 39 had a good fit.\[1\]
   - Among those 39, the median time to reach 95% of their own automaticity plateau was 66 days (range 18–254; quartiles 39–102).\[1\]
   - Exercise behaviours took a median of 91 days, against 65 for eating and 59 for drinking. That difference was not significant (p = 0.328), and the study wasn't powered for sub-groups.\[1\]
   - It is honest to say "a median of 66 days in one study", and only about **daily** behaviours.
2. **Missing a day is fine; this is the most useful fact for the product.**
   - In Lally's data there were 140 missed opportunities across 55 participants.\[1\]
   - Automaticity dropped by an average of only 0.29 points on a 0–42 subscale.\[1\]
   - The authors concluded that missing one opportunity "did not materially affect the habit formation process".\[2\]
   - They also suggest that missing a week's worth of opportunities does hinder habit formation.\[3\]
3. **Newer work confirms "months, not weeks", and says it depends on the behaviour.**
   - Singh, Murphy, Maher & Smith (2024, *Healthcare*) reviewed 20 studies with 2,601 participants.\[4\]
     - Medians were 59–66 days, means 106–154 days, and individual times 4–335 days.\[4\]
     - Most studies (11) had a high risk of bias.\[4\]
     - The authors conclude that health habits typically need 2–5 months.\[4\]
   - Buyalskaya et al. (2023, *PNAS*) used machine learning on 30,110 gym members and 3,124 hospital workers (over 40 million hand-washing observations).\[5\]
     - Hand-washing became predictable after about 9–10 shifts.\[5\]
     - The original gym estimate of "4 to 7 months" was **formally corrected** to 68–78 days (about 2–3 months).\[6\]
     - Anyone still quoting "4–7 months" is using a superseded figure.
4. **"21 days" is a misquote.** Maxwell Maltz, a plastic surgeon, wrote in *Psycho-Cybernetics* (1960) that "it requires a minimum of about 21 days for an old mental image to dissolve and a new one to jell". He was writing about patients adjusting to a new face or a lost limb, not habit formation.\[7\]\[8\]
5. **Broken streaks reduce engagement, and repair softens it.**
   - Silverman & Barasch (2023, *JCR*, 7 studies) define a streak as a behaviour done three or more times in a row.\[9\]
   - People did more of a behaviour when their log showed an intact streak than a broken one; the abstract says this effect "is independent of actual past behavior and depends solely on how that behavior is represented within the log".
   - The effect was stronger when people blamed themselves for the break and weaker when the streak could be "repaired".\[9\]
   - The lesson for us: never show a broken run as a broken thing. Give credit that a break can't erase (totals, "again", anniversaries).
6. **Feedback that informs helps; expected tangible rewards undermine.**
   - Deci, Koestner & Ryan (1999) meta-analysed 128 studies.\[10\]
   - Expected tangible rewards undermined free-choice intrinsic motivation:\[11\]
     - engagement-contingent: d = −0.40
     - completion-contingent: d = −0.36
     - performance-contingent: d = −0.28
   - Verbal rewards (positive feedback) enhanced it in college students (behavioural d = 0.33), but less so, or not at all, in children.\[12\]
   - This supports milestones as information, not prizes.
7. **Surprise matters more than totals.**
   - Rutledge et al. (2014, *PNAS*) found that momentary happiness in a reward task was explained by recent expectations and reward prediction errors, not by total earnings.\[13\] A reward prediction error is the gap between what you expected and what you got.
   - Predictable, identical celebrations lose their effect.
   - This supports rationing, variety of wording and insight, and a design where rarer means bigger. It does **not** justify random rewards.

## The recommended system in one page

- **Every milestone exists and is recorded.** It's computed from records, dated on the habit page, and shown as a medal in the row for the rest of the day. Undo removes it.
- **Four tiers of surface:**
  - **Pop-up:** landmarks only.
  - **Bar:** first-time lengths and comebacks.
  - **Row:** everything else that happened live.
  - **Record:** the habit page only, for collisions, backfills and imports.
- **Budget across the whole app:**
  - at most 2 noticeable moments a day (pop-up or bar);
  - at most 1 pop-up a day and 2 in any rolling 7 days;
  - pop-ups normally at least 3 days apart.
- **One lead milestone per habit per day.** In a row beats in total when both land on the same tap; the other is recorded silently.
- **Habits reaching the same value on the same day become one moment.** It is shown on the top-ranked habit's surface with "and N more today".
- **Repeats are quiet.** A length already reached before gets only the row. The exception is reaching your previous best again (14 or more), which gets a bar with "again", at most once per habit per 30 days.
- **Long-term tracks:** totals in the habit's own unit, yearly anniversaries, total rungs every 500, "longest yet", and a monthly look-back card (never a pop-up; never shown by itself when the app opens).
- **Floor:**
  - If 30 days pass with no noticeable moment, the best eligible candidate is promoted to a bar.
  - If 45 days pass with no pop-up, the best first-time candidate is promoted to a pop-up.
- **Insights** appear in the pop-up only, only for the habit kinds they apply to, and no single insight is shown more than once every 90 days.
- **Away milestones** go to the existing "While you were away" card. These are quit clocks, cut-down days judged at day's end, and widget, watch, Siri or notification logs. **See** opens the pop-up because the person asked for it.

## The system spec

### 1. Tiers

| Tier | Surface | Gets it by default | Counts against budget |
|---|---|---|---|
| **Pop-up** | Existing bottom sheet, opens by itself only at a pause | Landmarks: the person's first milestone in the app; first time reaching 30, 100, 365, 500, 730, 1,000 days or times in a row, and each later year; 26 and 52 weeks; 6 and 12 months; 66 times in total (daily habits); 500 and 1,000 in total; unit totals at powers of ten; anniversaries | Yes (1/day, 2 per 7 days) |
| **Bar** | Existing habit-coloured 328 × 72 dp bar, 5 s | First time reaching any other rung; comeback "again" (previous best of 14 or more regained); 50, 100, 250, 750 in total; other unit rungs; floor promotions | Yes (with pop-ups, max 2/day) |
| **Row** | Medal and words in the row's subtitle for the rest of the day, plus the confirm vibration | Every live milestone, including those above | No |
| **Record** | Habit page only (medal shelf, "All milestones") | Same-tap collisions, backfills, imports, restores, syncs of old data, milestones undone and redone | No |

The tier says what a milestone *may* get. The budget decides what it *does* get. A milestone that is refused a higher tier falls one tier at a time: pop-up, then bar, then row. It never vanishes, because it's always on the habit page.

### 2. Budget (evidence vs reasoning)

| Rule | Value | Basis |
|---|---|---|
| Noticeable moments a day | ≤ 2 | Your target; corpus complaints about celebration on every item (17) and unremovable celebration (40, 2.95★). **Reasoned.** |
| Pop-ups | ≤ 1/day, ≤ 2 per rolling 7 days, ≥ 3 days apart unless a "major" (365+ in a row, 1,000+ total, anniversary) | Habituation and prediction error (Rutledge 2014): rarer stays bigger. The specific numbers are **reasoned**. |
| Bars | ≤ 2/day, one at a time | Material Design's one-snackbar-at-a-time guidance (from your brief; not re-verified). |
| Monthly floor | Bar after 30 quiet days; pop-up after 45 days without one | Your "at least monthly" target; progress principle. **Reasoned.** |
| Comeback cap | 1 per habit per 30 days | Avoids "congratulations on your FIRST milestone… 10 times" (1 review). **Reasoned.** |

### 3. Ranking and allocation algorithm (on device, deterministic)

The milestone set is a pure function of the records. Presentation depends only on that set, a small presentation log ("shown" IDs, synced with the habit data but never treated as the truth), and the visit's clock. Two devices with the same records and the same log make the same decisions.

```text
# ---------- 1. Compute (pure; same records -> same output on every device) ----------
Event = {habitId, track, value, reachedAt (day key in the person's day-start hour),
         runId (in-a-row only), cause (TAP | DAY_CLOSE | CLOCK | AWAY_LOG | BACKFILL | IMPORT),
         firstTime: bool,          # this habit never reached this value on this track before
         regainedBest: bool,       # equals the habit's previous best (>=14) after a break
         ladderIndex: int}

eventId(e) = hash(habitId, track, value, runId or "-")   # stable across devices

def events_for(habit, records):
    for track in tracks(habit.kind, habit.frequency, habit.direction):   # table in section 5
        for crossing in track.crossings(records, goalHistory, skips, pauses):
            yield Event(...)

# ---------- 2. Classify ----------
MAJOR = {inARow: 365+ ; total: 1000+ ; anniversary: any}
def tier(e):
    if not e.firstTime and not e.regainedBest:      return ROW
    if e.regainedBest:                              return BAR
    if e.isPersonsFirstMilestoneInApp:              return POPUP
    if (e.track, e.value) in LANDMARKS:             return POPUP
    return BAR

def significance(e):     # bigger = better
    return (tierRank[tier(e)],                # POPUP 3, BAR 2, ROW 1
            1 if e.value in MAJOR[e.track] else 0,
            trackRank[e.track],               # inARow 4 > anniversary 3 > unitTotal 2 > total 1
            e.ladderIndex,                    # deeper rung = rarer
            -habit.createdAt,                 # older habit first? no: newer first is kinder;
                                              # choose ONE and keep it; here: older first
            habit.id)                         # final stable tie-break (lexicographic)

# ---------- 3. Reduce ----------
def reduce_day(events_today):
    # one lead per habit per day
    leads = {h: max(evts, key=significance) for h, evts in group_by(events_today, habitId)}
    for e in events_today - leads: e.surface = RECORD_PLUS_ROW_TEXT_OF_LEAD
    # cohort grouping: same track+value on the same day
    groups = group_by(leads, (track, value))
    moments = [max(g, key=significance).withExtra(len(g)-1) for g in groups]
    return sorted(moments, key=significance, reverse=True)

# ---------- 4. Allocate (live visit) ----------
state: shownLog, popupsLast7d, lastPopupDay, noticeableToday, lastNoticeableDay

at visit start:
    planned = candidates_one_log_away(today)          # app already knows these
    multi = count(c for c in planned if tier(c) in {POPUP, BAR}) >= 2
             or any cohort in planned has size >= 2

on tap that creates event e (cause == TAP):
    show ROW medal + confirm haptic                   # always, immediate (Fogg)
    if not multi and tier(e) == BAR and budget_allows(BAR): show BAR(e)
    else: pending.add(e)

on breakpoint (last item on today's list done, or ~2.5 s with no touch):
    if pending empty: return
    m = reduce_day(pending)[0]                        # best, not last
    others = len(pending) - 1
    if tier(m) == POPUP and budget_allows(POPUP):  show POPUP(m, line="and {others} more today")
    elif budget_allows(BAR):                       show BAR(m, suffix=others)
    # else: rows only; everything is on habit pages
    pending.clear(); mark shownLog

def budget_allows(kind):
    if noticeableToday >= 2: return False
    if kind == POPUP:
        if popupToday or popupsLast7d >= 2: return False
        if days_since(lastPopupDay) < 3 and not isMajor(m): return False
    return True

# ---------- 5. Floor (checked at each breakpoint) ----------
if days_since(lastNoticeableDay) >= 30 and best pending/away candidate exists: promote to BAR
if days_since(lastPopupDay) >= 45 and a firstTime candidate exists:           promote to POPUP

# ---------- 6. Away and day-close ----------
for e with cause in {CLOCK, DAY_CLOSE, AWAY_LOG} since last visit and not in shownLog:
    add to "While you were away" card (max 3, then "and N more"), ordered by significance;
    POPUP-tier items show their large medal on the card; See -> pop-up (person-initiated,
    not counted against the automatic pop-up budget, but logged as shown)

# ---------- 7. Never celebrate old data ----------
celebrate(e) only if e.cause in {TAP, CLOCK, DAY_CLOSE, AWAY_LOG}
  and e.reachedAt >= lastVisitDay - 1 day
  and e.reachedAt > habit.importedOrRestoredAt
  and eventId(e) not in shownLog
BACKFILL / IMPORT events -> RECORD only (the medal appears on the page, dated correctly)
```

**Reasoning for the ranking order (reasoned from first principles):**
- First-time lengths come before repeats, because personal records are where surprise lives. Hevy's personal-record medal was liked (2 reviews), and Rutledge 2014 explains why.
- Deeper rungs come before shallow ones, because they are rarer.
- In a row comes before totals on the same day, because the person thinks in runs and the total is redundant on that day.
- The tie-break is fixed so the result is deterministic. Pick "older habit first" or "newer first" once and never change it.

### 4. The five-candidate edge case, resolved

- At the start of the visit the app sees five candidates, so `multi` is true.
- Taps 1–5 each get the ✓ fill, the confirm vibration and the row medal. There are no bars during the burst, because the person is mid-task. Iqbal & Bailey's breakpoint finding is cited from your brief; I did not re-verify it.
- At the pause, the single best one is chosen by rank:
  - It gets the pop-up if it is a landmark and the budget allows, with "and 4 more today".
  - Otherwise it gets one bar.
  - "All milestones" and each habit page list the rest.
- The fifth habit gets the pop-up only if it ranks highest, never because nothing was left waiting.
- If only one candidate exists, the original design stands: a bar at the tap for bar-tier milestones, or a pop-up at the pause for landmarks, with no bar before it.

### 5. Per-kind definitions

Ladder legend:

- **D (in a row, days or times):** 3, 7, 14, 30, 50, 100, 150, 200, 250, 365, 500, 730, 1,000, then every 365. This removes 10 and 75.
- **T (in total):** 10, 25, 50, **66 (daily habits only)**, 100, 250, 500, 750, 1,000, then every 500. Month goals add 3 and 6; year goals add 2 and 5.
- **U (unit total):** a 1–2.5–5 series (×10ⁿ) in the habit's unit, starting at the first value ≥ 10× the daily goal, for example 10, 25, 50, 100, 250… hours or km.
- **A (anniversary):** each year since the first log, shown only if the habit had a goal met in the last 30 days.

| Kind × frequency × direction | Tracks | Ladder | Trigger | Words (examples) | Default tier |
|---|---|---|---|---|---|
| Check, every day | In a row (days), in total, anniversary, "longest yet" | D, T, A | Tap that meets the day | "30 days in a row" · "66 times in total" · "One year of Stretch" · "Longest run yet: 41 days" | 3 (first ever in app) Pop-up; 7, 14, 50 Bar; 30, 100, 365+ Pop-up; repeats Row; T10/25 Row, 50/100/250/750 Bar, 66/500/1,000 Pop-up |
| Check, several times a day | Same as above. Counts **days the goal is met**, never single taps | D, T, A | Tap that completes the day's goal | "30 days in a row" | Same |
| Check or other kinds, specific weekdays / every N days / every N weeks / month dates / calendar rules | In a row (times), in total, anniversary | D (as times), T **without 66**, A | Tap that meets an occurrence | "14 times in a row" | As daily, but no 66 insight |
| Flexible N days per week/month/year; N times per period | In a row (weeks/months/years with the goal met), **in total counts each day done**, anniversary | Weeks: 2, 4, 8, 12, 26, 52, 78, 104, then every 52. Months: 2, 3, 6, 9, 12, 18, 24, 36, then every 12. Years: each. T on days done | Tap that meets the period's goal (early is fine); T on any done day | "12 weeks of goals met" · "100 runs in total" | 4, 8, 12 weeks Bar; 26, 52 weeks Pop-up; 3 months Bar; 6, 12 months Pop-up; years Pop-up |
| Amount, build | In a row, in total, **unit total** | D/T + U | Tap that reaches the goal; U on any log crossing a rung | "1,000 glasses in total" · "500 km in total" | U Bar; U powers of ten Pop-up |
| Amount in total over a week/month/year ("2 chapters a week") | Periods in a row, U | Week/month ladders, U | Log that reaches the period total | "8 weeks of goals met" · "100 chapters in total" | As flexible |
| Duration | In a row, in total, U in **hours** | D/T + U (hours) | Tap or timer stop that reaches the goal | "100 hours of Read in total" | U 100/1,000 h Pop-up |
| Checklist | In a row, in total | D, T | Last step ticked | "30 days in a row" | As daily |
| Cut down (atMost) | Days or periods within the limit in a row; in total | D (or period ladders), T without 66 | **Day close** (or period close); never at a tap | "30 days within the limit" | Delivered on the away card next visit; See opens pop-up |
| Quit | Days since a slip (live clock); total clean days; anniversary of the quit | 1, 3, 7, 14, 30, 60, 90, 180, 270, 365, 500, 730, then yearly (removes 10, 45, 120). Total clean days: 100, 250, 500, 1,000, then every 500 | **Clock** | "30 days since a slip" · "250 clean days in total" | Card; 7, 30, 90, 365+ show the large medal on the card; regained best gives "again" |
| Task, "How was today?" | None | None | None | None | Out of scope |

**Why these ladders (honest split):**
- **Evidence-anchored:**
  - 66 as a total for daily habits only (Lally's median, in repetitions of a daily behaviour).
  - "Months" as the scale of formation (Singh; Buyalskaya).
  - Total clean days and "again", because broken runs demotivate and credit that survives a break avoids that (Silverman & Barasch).
- **Chosen for feel (reasoned):** every round number (3, 7, 14, 30, 100, 365, 1,000, the 1–2.5–5 unit series).
  - 3 is kept because the early congratulation lands with new users (4 reviews).
  - 10 and 75 are dropped because they add density without meaning.
- **Not evidence:** the week and month rungs. No study shows weekly or monthly behaviours become automatic on a known timetable. Lally and Singh studied daily or near-daily behaviours. Buyalskaya's gym-goers are the nearest data on non-daily behaviour, and there the time-since-last-visit cue mattered.\[14\] Monthly milestones are honest as records of consistency, not as claims of automaticity.

### 6. Duplicates and collisions

- **In a row and in total on the same tap:** in a row is the lead; the total is recorded only. This removes the "two milestones for one tap" problem.
- **Several habits, same length, same day:** one moment on the top-ranked habit, with "and N more today"; every row shows its own medal.
- **A backfill that jumps several thresholds:** record only. Each medal is dated to the day it was actually reached. No celebration, because nothing just happened.
- **Habits started together staying in sync for months:**
  - Grouping makes this one moment per rung instead of N.
  - Unit totals and differing goals naturally de-sync them over time.
  - The 3-day pop-up gap stops the same cohort producing back-to-back pop-ups.

### 7. Edge cases

| Case | Rule |
|---|---|
| Backfilling past days | Recompute. New medals are Record only, correctly dated. If a backfill completes *today's* goal, that counts as a tap. |
| Goal or schedule change | Each day is judged by the goal in effect that day (goal history). Runs continue across a change if every scheduled occurrence under each rule was met. Changing the goal never creates a celebration on its own. |
| Pauses and skips | Neutral. They neither extend nor break a run. A run's "days in a row" counts only met days. Anniversaries still count calendar years. |
| Archive / unarchive | Archived habits make no candidates. On unarchive, records return. Nothing is celebrated for the gap. |
| Undo, or deleting a log | Recompute. The medal disappears from the row and page. The shown log keeps the ID, so redoing the same tap shows the row medal but no second bar or pop-up. |
| Restore, import, sync, second device | Stamp `importedOrRestoredAt`; events at or before it are Record only. Synced logs from another device are Away (card), and the shown log is synced so a moment seen on iPhone isn't repeated on iPad. |
| Widget, watch, Siri, notification logs | Cause AWAY_LOG, delivered on the card at the next visit, never as a pop-up on opening. |
| Day-start hour, time zones, daylight saving | Day keys use the person's day-start hour in the device's current zone at log time, stored with the log. A 23- or 25-hour day is still one day. Travel never creates or removes a day already recorded. |
| Quit slip | The run ends silently. Total clean days stay. No message about the slip. Early rungs of the new run are Row/card-quiet until the previous best is regained ("30 days since a slip, again"). |
| Several times a day | Only the tap that meets the day's goal can trigger. Extra taps never do. |
| Week/month goals met early | Build habits count the period when the goal is reached, even on Tuesday. Cut-down periods are judged at period close. |
| Cut-down day judged after midnight | DAY_CLOSE event, shown on the card at the next visit as "Yesterday: 30 days within the limit". It is never a pop-up on opening, and See opens it. |

## Frequency check

**Method.** I couldn't run your simulator. The "before" rows for the two personas you simulated are your figures. Everything else is my estimate from the formulas below and should be re-run.

**Key formulas:**
- **Probability a run reaches length L** when each day is done with probability p: P(L) = p^(L−1) once a run starts.
- **Run starts per habit-day:** about p·(1−p).
- **Day on which the total reaches T:** about T/p after the habit starts.
- **Example:** at p = 0.8, P(14) ≈ 0.055 per run start. With about 14 run starts in 90 days, about half of habits reach 14 in a row at least once (1 − 0.945¹⁴ ≈ 0.55), while 30 in a row is rare (0.8²⁹ ≈ 0.0015 per start).

```python
# Re-runnable spec (not executed for this report). Plug into simulate_pileups.py.
import random
D=[3,7,14,30,50,100,150,200,250,365,500,730,1000]
T=[10,25,50,66,100,250,500,750,1000]
POP_D={30,100,365,500,730,1000}; POP_T={66,500,1000}
def sim(n_habits, days, p_fn, seed):
    rng=random.Random(seed); run=[0]*n_habits; best=[0]*n_habits; tot=[0]*n_habits
    shown_first=False; last_pop=-99; pops7=[]; out=[]
    for d in range(days):
        ev=[]
        for h in range(n_habits):
            if rng.random()<p_fn(d):
                run[h]+=1; tot[h]+=1
                cand=[]
                if run[h] in D: cand.append(('row',run[h],run[h]>best[h]))
                if tot[h] in T: cand.append(('tot',tot[h],True))
                best[h]=max(best[h],run[h])
                if cand: ev.append((h,max(cand,key=lambda c:(c[2],c[0]=='row',c[1]))))
            else: run[h]=0
        # tier
        def tier(c):
            kind,v,first=c
            if not first: return 1
            if kind=='row' and (v in POP_D): return 3
            if kind=='tot' and v in POP_T: return 3
            return 2
        groups={}
        for h,c in ev: groups.setdefault((c[0],c[1]),[]).append(tier(c))
        moments=sorted((max(t) for t in groups.values()),reverse=True)
        nonlocal_first = not shown_first and moments and moments[0]>=2
        pops7=[x for x in pops7 if d-x<7]; noticeable=0; popup=0
        for m in moments:
            if noticeable>=2: break
            if (m==3 or nonlocal_first) and not popup and len(pops7)<2 and d-last_pop>=3:
                popup=1; noticeable+=1; pops7.append(d); last_pop=d; shown_first=True
            elif m>=2: noticeable+=1
        out.append((len(ev),noticeable,popup))
    return out
# Report: days with any event, days with >=1 noticeable, pop-ups, max noticeable/day, per week.
```

**Before vs after per persona (estimates except where marked):**

| Persona | Before | After: noticeable moments (bar or pop-up) | After: pop-ups | Long-term floor met? |
|---|---|---|---|---|
| New: 5 daily habits same day, 90%/80%, 90 days | **Your sim:** 58 of 90 days with a milestone; 24 days with 2+, 7 with 3+ (each could be a bar) | ~10–15 days of 90 (about 1 a week, more in week 1); never more than 2/day | ~3–4 (day 3 shared first milestone; first 30 or 66-total moments, spaced ≥3 days) | n/a |
| Established: 8–12 mixed, 85%, 1 year | **Your sim (8 habits):** 225 days with a milestone; 134 with 2+, 56 with 3+ | ~50–70 days a year (about 1–1.5 a week) | ~15–22 a year (about every 2.5–3.5 weeks) | Yes, plus 12 monthly cards |
| Very consistent: 8 daily, 98%, year 3 | Sparse: in-a-row rungs at 1,000 then yearly; totals 1,000 then 2,500 | ~25–35 a year (unit totals ~10–15, anniversaries 8, totals every 500 ~6, yearly runs) | ~12–18 a year | Yes |
| Restarter: 5 daily, ~50%, many breaks | Frequent repeated "3 days" and "7 days" (the "FIRST milestone 10 times" complaint) | Repeats go to Row; ~1 noticeable every 2–3 weeks from totals, rare new bests, capped "again" | ~monthly or less (66, 100 totals) | Yes, through totals plus the floor |
| Quit-only: 1–2 quit habits, no slip | Year 1: 13 rungs, all on the away card | Year 1: 10 rungs on the card (7, 30, 90, 365 large); year 2+: 500, 730, totals, anniversary | Via See only | Year 2+ only through the monthly card; an honest gap |
| Weekly and monthly goals (3 flexible weekly, 2 monthly) | ~12 week-rungs per weekly habit in year 1 | ~30 a year (about 0.6 a week) | ~8–10 a year | Yes, with the monthly card |

The targets are met on paper: at most 2 noticeable moments a day by construction, pop-ups about every 2–4 weeks, and at least one meaningful moment a month for every persona except the slip-free quit-only user in year 2+. That user relies on the monthly card. An opt-in notification for quit landmarks is offered as an open decision.

## Insight library (pop-up only)

**Rules for all insights:**
- Plain words and a named source.
- "In one study" wording.
- No insight more than once per 90 days.
- At most one insight per pop-up.
- Never on a bar, a row or a card.

| Words | Source | Conditions | Habit kinds | Trigger | Confidence | Variety |
|---|---|---|---|---|---|---|
| "In a study at University College London, a new daily habit took a median of 66 days to feel automatic, with a wide range. You've now done this 66 times." | Lally, van Jaarsveld, Potts & Wardle 2010, *Eur J Soc Psychol* 40(6):998–1009, doi:10.1002/ejsp.674 | Daily behaviour in a fixed context; 96 enrolled, 39 with good model fit; self-reported automaticity (SRHI subset); median, range 18–254\[1\] | Daily check, amount, duration, checklist (build). **Never** weekly, monthly, flexible, specific weekdays, cut-down or quit | 66 **in total** (not only in a row) | Medium (small, self-report, modelled) | Once per habit, ever |
| "In that study, the time varied from 18 to 254 days between people. Slower doesn't mean it isn't working." | Same | Same | Same | 30 in a row or 100 in total, whichever pops first | Medium | Once per habit |
| "In a study at University College London, missing one day didn't materially set back how automatic a habit became." | Lally 2010 (140 missed opportunities across 55 people; −0.29 on a 0–42 scale)\[1\] | Daily behaviours; one missed day, not a week | All build kinds | Comeback "again" | High for the narrow claim | Once per 90 days |
| "A 2024 review of 20 studies (2,601 people) found health habits usually took about two to five months to form." | Singh, Murphy, Maher & Smith 2024, *Healthcare* 12(23):2488, doi:10.3390/healthcare12232488 | Medians 59–66 days, means 106–154, range 4–335; most studies at high risk of bias\[4\] | Daily and near-daily build habits | 100 days in a row or 3-month anniversary | Medium | Once per habit |
| "How long a habit takes depends on the habit. In one large study, going to the gym took about two to three months to become predictable; hospital hand-washing took a couple of weeks." | Buyalskaya et al. 2023, *PNAS* 120(17), doi:10.1073/pnas.2216115120; correction doi:10.1073/pnas.2312763120 | 30,110 gym members; 3,124 hospital workers; predictability, not self-report\[5\] | Any build kind, including weekly or flexible exercise | 12 weeks of goals met, or 50 in total | Medium-high | Once per 90 days |
| "Habits grow by repeating the same action in the same situation."\[15\] | Gardner, Lally & Wardle 2012, *Br J Gen Pract* 62(605):664–666, doi:10.3399/bjgp12X659466\[16\] | Narrative review | All build kinds | 25 in total (if no other insight shown in 30 days) | High (general principle) | Once per habit |
| "In a study of people quitting smoking, a drop in confidence after a slip, more than the slip itself, predicted the next one." | Kirchner, Shiffman & Wileyto, PubMed 21787035 (203 smokers, 1,001 lapses; self-efficacy drop HR 1.09)\[17\] | Smokers; real-time diaries | Quit, cut-down | "Again" after a slip | Medium | Once per 90 days |
| "Research on slips suggests that being kind to yourself afterwards helps more than being hard on yourself." | Adams & Leary 2007, *J Soc Clin Psychol* 26(10):1120–1144, doi:10.1521/jscp.2007.26.10.1120; Marlatt's abstinence violation effect (Larimer, Palmer & Marlatt 1999, PMC6760427) | Lab study of restrictive eaters; clinical model | Quit, cut-down | Second "again" | Medium-low (generalised) | Once per 180 days |

**Substance-specific insights, for the recognised "Stop smoking" template only.** The person chose the template; the free-text name is never matched. Show with "The NHS says…" and no personal claim. Never call it medical advice, and offer a setting to turn health facts off.

| Milestone | Words | Source |
|---|---|---|
| 1 day | "The NHS says that after 8 hours, the carbon monoxide in your blood halves; after 48 hours it's at a non-smoker's level."\[18\] | NHS Better Health, Quit smoking (nhs.uk/better-health/quit-smoking) |
| 3 days | "The NHS says that after 72 hours breathing often feels easier as the bronchial tubes relax."\[18\] | NHS |
| 28 days (template-only rung) | "The NHS says that if you reach 28 days smoke-free, you're 5 times more likely to quit for good."\[18\] | NHS Stoptober page; NHS-linked materials trace it to West & Stapleton 2008 (*European Respiratory Review* 17(110)), found only through a secondary citation, so confidence is medium |
| 90 days | "The NHS says that between 2 and 12 weeks circulation improves."\[18\] | NHS |
| 270 days | "The NHS says that over 3 to 9 months lung function can increase by up to 10%."\[18\] | NHS |
| 365 days | "The NHS says that after a year the risk of heart attack is about half a smoker's."\[18\] | NHS |
| 10 years | "The NHS and the American Cancer Society say the risk of dying from lung cancer is about half a smoker's after 10 years."\[18\]\[19\] | NHS; American Cancer Society |
| 15 years | "The American Cancer Society says coronary heart disease risk is close to a non-smoker's after 15 years."\[19\] | cancer.org, Benefits of quitting smoking over time |

Alcohol and caffeine templates: **don't ship health facts yet.** I didn't verify timelines from a government body in this pass.

## Motivation evidence turned into rules

| Principle | What the source found | Limits | Rule for Often Enough | Type |
|---|---|---|---|---|
| Broken streaks (Silverman & Barasch 2023, *JCR* 49(6):1095–1117, doi:10.1093/jcr/ucac029) | 7 studies: intact logged streaks increase later engagement versus broken; stronger with self-blame, weaker with repair\[9\] | Lab and online tasks; one secondary write-up reports about 66% vs 58% choosing to continue\[20\] | Never display a broken run; credit that survives breaks; "again" | Evidence |
| Overjustification (Deci, Koestner & Ryan 1999) | 128 studies; expected tangible rewards undermine (d −0.28 to −0.40); verbal feedback enhances (d 0.33, college students)\[11\]\[12\] | Lab tasks; contested by Cameron & Pierce | No points or prizes; milestones as informative words | Evidence |
| Prediction error and habituation (Rutledge et al. 2014, *PNAS* 111(33):12252–12257) | Happiness tracks recent expectations and surprises, not totals\[13\] | Gambling task | Ration surfaces; rarer means bigger; vary insights | Evidence (transfer reasoned) |
| Variable rewards | Unpredictable rewards are highly engaging | Ethically fraught | **Rejected.** Rewards are fixed and predictable from the records; variety comes only from honest content | Reasoned |
| Goal gradient (Kivetz, Urminsky & Zheng 2006, *JMR* 43(1):39–58) | Café customers bought more often near the free coffee; 12-stamp card with 2 pre-stamped finished faster\[21\] | Tangible rewards; illusory progress | Keep the "next milestone" ring; never give fake head starts | Evidence |
| Fresh start (Dai, Milkman & Riis 2014, *Mgmt Sci* 60(10):2563–2582) | Gym visits, "diet" searches and goal commitments rise after temporal landmarks\[22\]\[23\] | Observational in part | Monthly look-back card at month start; "again" framing | Evidence |
| What-the-hell effect and abstinence violation | Lapses can cascade when seen as total failure (Marlatt)\[24\] | In Kirchner, Shiffman & Wileyto (*J Abnorm Psychol* 2012), no AVE response after the first lapse predicted relapse; after later lapses, drops in self-efficacy sped progression (HR 1.09) while self-blame protected (HR 0.98) | Slips are silent; totals persist | Evidence plus reasoned |
| Self-compassion (Adams & Leary 2007) | Self-compassion induction reduced eating after breaking a diet among highly restrictive eaters\[25\] | Small lab study, women undergraduates | Kind, neutral copy after breaks | Evidence (limited) |
| Identity framing (Bryan et al. 2011, *PNAS* 108(31):12653–12656) | "Be a voter" raised turnout (e.g. 89.9% vs 79.0%)\[26\] | A 2016 *PNAS* field experiment by Gerber, Huber, Biggers & Hendry (over 4,400 subjects) did not replicate it, nor did a preregistered 2020 replication (Gerber, Huber & Fang, *Behavioural Public Policy*); identity can raise the stakes of failure | **Avoid "you're someone who…"**; describe what they did | Evidence (mixed) |
| Progress principle and savouring | Seeing progress motivates (from your brief) | Workplace diaries | Habit-page records; monthly look-back | Evidence from your brief, not re-verified |
| Peak–end | Moments and endings are remembered | General | One strong moment at the end of a burst, not five weak ones | Reasoned from evidence |

**Landscape (checked lightly, not copied):**
- **Duolingo:**
  - Its own blog post, "How Streaks keep Duolingo learners committed to their language goals", reports that a Streak Wager test gave "statistically significant increases in Day-1, Day-7 and Day-14 user retention, with Day-7 retention showing the greatest improvement at +14%".
  - The +1.7% milestone-animation figure appears only in secondary sources in my search.\[27\]\[28\]
  - Both are tied to loss-framed streaks we reject.
  - Take-away: special animation only at milestone days, not every day.\[28\]
- **Apple Fitness:** in Apple Community and press threads, users complain about **missing or wrongly dated awards**.\[29\]\[30\]\[31\] That supports principle 5: records must be reliable and re-computable.
- **Not verified in this pass:** user-review evidence for Strava, Hevy (beyond your corpus counts), Fitbit/Garmin, Headspace/Calm, Finch, Streaks, Habitica, Fabulous, Loop, Habitify, I Am Sober, Nomo, Smoke Free and QuitNow. Use your corpus.

## What to avoid

- **Popping a pop-up because a milestone is last or alone in time.** It rewards order, not meaning.
- **Celebrating repeats of lengths already reached.** This was the "FIRST milestone… 10 times" complaint, and it wears out the surfaces.
- **Two moments for one tap** (in a row plus in total).
- **Showing "66 days" for weekly, monthly, cut-down or quit habits, or saying "it takes 66 days".** It's a median in one small study of daily behaviours.
- **"21 days" anywhere, including in onboarding.**
- **Identity claims** ("You're a runner now"). Replication failed, and they raise the stakes of a break.
- **Variable or surprise rewards, points, unlocks or levels.**
- **Health facts based on free-text names** ("Smoking less" typed by hand), or any health fact for cut-down habits.
- **Celebrating backfills, imports, restores or synced history,** and pop-ups on opening.
- **Quoting Buyalskaya's "4–7 months" for the gym.** It was corrected to about 2–3 months.\[6\]

## Open decisions (with my recommendation)

1. **The day-3 first milestone as a pop-up.** Recommend **yes, once per person, as a shared moment**: "3 days in a row" on the top habit with "and 4 more today". It's supported by your 4 reviews; keep it to one.
2. **Tie-break: older or newer habit first.** Recommend **older first**. It's stable and rewards the longest effort. The choice matters only for determinism.
3. **Adding 66 to the totals ladder.** Recommend **yes for daily build habits only**, paired with the insight.
4. **Unit totals for every amount habit, including money ($) and cut-down amounts.** Recommend **build habits only**. "1,000 coffees" for a cut-down habit reads as a count of failures.
5. **Monthly look-back card.** Recommend **yes**: at the top of Today on the first visit of a month, dismissible, never a pop-up. It shows each habit's month in plain counts and any "most consistent month yet". This is where the fresh start effect fits.
6. **Opt-in notifications for quit landmarks.** Recommend **opt-in, landmarks only (7, 30, 90, 365)**. Four corpus reviews ask for it.
7. **A setting to make celebrations quieter.** Recommend **yes**: "Pop-ups for big milestones" on or off. Your corpus has 40 reviews about celebrations that couldn't be turned off.
8. **Syncing the presentation log.** Recommend **yes**, through the same iCloud or Drive store, marked as non-authoritative, so a moment is never shown twice across devices.

## Sources

1. <https://www.flexyourbrain.com/wp-content/uploads/2015/10/UL-STUDY-66-Days-IJSP_998-1009.pdf>
2. [How are habits formed: Modelling habit formation in the real world - Lally - 2010 - European Journal of Social Psychology - Wiley Online Library](https://onlinelibrary.wiley.com/doi/10.1002/ejsp.674)
3. [Modelling habit formation in the real world](https://emotionalfirstaidacademy.com/wp-content/uploads/2023/10/How-habits-are-formed.pdf)
4. [Time to Form a Habit: A Systematic Review and Meta-Analysis of Health Behaviour Habit Formation and Its Determinants](https://mdpi.com/2227-9032/12/23/2488)
5. [What can machine learning teach us about habit formation? Evidence from exercise and hygiene](https://www.pnas.org/doi/10.1073/pnas.2216115120)
6. [pmc.ncbi.nlm.nih.gov](https://pmc.ncbi.nlm.nih.gov/articles/PMC10450439)
7. [How Long Does it Actually Take to Form a New Habit? (Backed by Science)](https://jamesclear.com/new-habit)
8. [blogs.ucl.ac.uk](https://blogs.ucl.ac.uk/bsh/2012/06/29)
9. [or track how broken streaks affect consumer decisions](https://www.colorado.edu/business/faculty-research/2023/04/19/or-track-how-broken-streaks-affect-consumer-decisions)
10. [(PDF) A Meta-Analytic Review of Experiments Examining the Effects of Extrinsic Rewards on Intrinsic Motivation](https://www.researchgate.net/publication/12712628_A_Meta-Analytic_Review_of_Experiments_Examining_the_Effects_of_Extrinsic_Rewards_on_Intrinsic_Motivation)
11. [(PDF) Effects of reward on intrinsic motivation - Negative, neutral, and positive: Comment on Deci, Koestner, and Ryan (1999)](https://www.researchgate.net/publication/12712630_Effects_of_reward_on_intrinsic_motivation_-_Negative_neutral_and_positive_Comment_on_Deci_Koestner_and_Ryan_1999)
12. [http://rer.aera.net Review of Educational Research](<https://elaborer.org/psy1045/cours/Deci(2001).pdf>)
13. [A computational and neural model of momentary subjective well-being](https://www.pnas.org/doi/10.1073/pnas.1407535111)
14. [No magic number for time it takes to form habits](https://www.sciencedaily.com/releases/2023/04/230417155750.htm)
15. [(PDF) Making health habitual: The psychology of 'habit-formation' and general practice](https://www.researchgate.net/publication/233848140_Making_health_habitual_The_psychology_of_'habit-formation'_and_general_practice)
16. [Making health habitual: the psychology of ‘habit-formation’ and general practice](https://www.scienceopen.com/document?vid=a9c51931-d658-41d4-a44f-fbe1fc796d08)
17. [Relapse dynamics during smoking cessation: recurrent abstinence violation effects and lapse-relapse progression - PubMed](https://pubmed.ncbi.nlm.nih.gov/21787035/)
18. [Quit smoking - Better Health](https://www.nhs.uk/better-health/quit-smoking/)
19. [Health Benefits of Quitting Smoking Over Time](https://www.cancer.org/cancer/risk-prevention/tobacco/guide-quitting-smoking/benefits-of-quitting-smoking-over-time.html)
20. [How Broken Streaks Sap Motivation](https://www.psychologytoday.com/us/blog/ulterior-motives/202306/how-broken-streaks-sap-motivation)
21. [IDEAS home Printed from https://ideas.repec.org/p/feb/natura/00658.html](https://ideas.repec.org/p/feb/natura/00658.html)
22. [MANAGEMENT SCIENCE Articles in Advance, pp. 1–20](https://static1.squarespace.com/static/5353b838e4b0e68461b517cf/t/53b17c1be4b09fe9f6e12f32/1404140571261/the-fresh-start-effect.pdf)
23. [Fresh Start Effect: An S-Tier Behavioral Designer's Guide](https://yukaichou.com/behavioral-analysis/fresh-start-effect-dai-milkman-riis-temporal-landmarks/)
24. [Abstinence Violation - an overview](https://www.sciencedirect.com/topics/psychology/abstinence-violation)
25. [Promoting Self–Compassionate Attitudes Toward Eating Among Restrictive and Guilty Eaters](https://guilfordjournals.com/doi/10.1521/jscp.2007.26.10.1120)
26. [Motivating voter turnout by invoking the self](https://cdn.prod.website-files.com/59faaf5b01b9500001e95457/5bc55edda8a9d806acce2dbd_Bryan,%20C.%20J.,%20Walton,%20G.%20M.,%20Rogers,%20T.,%20&%20Dweck,%20C.%20S.%202011.pdf)
27. [Streaks: extension animation, day-7 milestone and up to two equipped protections · Issue #193 · lukaskourilcz/react-express-app · GitHub](https://github.com/lukaskourilcz/react-express-app/issues/193)
28. [Duolingo Streaks: How the Mechanic Drives 2x Daily Retention](https://duolingo.deconstructoroffun.com/mechanics/streaks)
29. [This Apple Watch Quirk Will Annoy Anyone Who Loves Collecting Badges - BGR](https://www.bgr.com/tech/this-apple-watch-quirk-will-annoy-anyone-who-loves-collecting-badges/)
30. [Awards gone on iPhone and not updating on… - Apple Community](https://discussions.apple.com/thread/254696914)
31. [NOT getting notified about “Special” Apple Watch Challenges](https://forums.macrumors.com/threads/not-getting-notified-about-special-apple-watch-challenges.2240172/)
