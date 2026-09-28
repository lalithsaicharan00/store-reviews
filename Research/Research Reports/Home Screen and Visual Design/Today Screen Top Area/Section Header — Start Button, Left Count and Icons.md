Written by Claude (Claude Code), 28 September 2026.

# Section Header — Start Button, Left Count and Icons

Checklist of the user's points: [iOS/Section Header — Start and Left Checklist.md](<../../../../iOS/Section Header — Start and Left Checklist.md>).

**The problem.**
- Today treats each time of day as a routine: Morning is the morning routine, started with ▶ into a full-screen focused player, as in Routinery.
- The first build showed **Start** (▶ and the word) only in the Now section, when it was open.
- A later change (27 Sep, `iOS/Today Improvements.md`) put a ▶ on **every** unfinished section, open or folded, and **replaced "N left" with it**.
- That removed the number people open the app to see. It also crowded out the folded icons.

## What users show

Scan: `Research/Temp/section-header/start_scan.py`, over all 1,238,784 reviews. Hits: 158 start/play-button mentions (55 in Routinery, 21 in RoutineFlow), 31 on how many are left, 18 on accidental starts, and 6 on starting a routine early or late. All the "left", accidental and early/late hits were read, plus the Routinery, RoutineFlow, Fabulous and Me+ start hits.

**1. "How many are left" is the number people want. In routine apps, it's per routine.**

| Review | App | What they say |
|---|---|---|
| `90e18a21-40d2-4ccc-84d5-986f2cb2d5b2` (5★) | RoutineFlow | "really like how the app allows me to clearly see how many steps are left" |
| `1edc41b3-6e36-4adc-b0df-9aa187be89e7` (5★) | RoutineFlow | "Step 5 of 7, 2 steps left … helped us a lot to stay on track" |
| `28be91f5-81a4-4091-9043-9398d2b36632` (5★) | RoutineFlow | wants to see what else is remaining in the current routine |
| `ef440828-ac0e-4e8a-927e-97f6f02c7e64` (4★) | HabitNow | "I'd like to be able to estimate quickly how many habits left" |
| `1360875860` (5★) | Productive | "I love that the number of habits left for the day shows up on the icon" |
| `6207955228` (4★) | Habit | wants a count of how many habits are left |

**Against:** `12350739113` (Finch, 4★) was put off "by how high the number was" and asked to hide it. A big total is discouraging. A small per-section number ("2 left") is the gentle version of that.

**2. Pressing Start is *the* action of a routine app.**
- `14371526010` (Routinery, 5★): "I just need to decide to start the routine, the rest is decided".
- `12279005430`: "I just press play and I get through them".
- `11968776517` (Fabulous): "I press play, and its like a Pavlovian response".
- `8571f430-2baa-4fd6-aa18-88597c6db5b3` (RoutineFlow): opening the app shows "a big 'start routine' button".

**3. People start routines off-schedule,** so Start can't be locked to the Now window.
- `8305241443` (Routinery, 5★): "I love that I can start my routine later on in the morning if I wake up later".
- `79474dd3-ce8d-4ebd-a263-5e32b8415ae3` (RoutineFlow): starts early.

**4. A start button on routines that aren't current confuses people.**
- `96055e2a-9752-4499-bb02-1e6220658d7a` (RoutineFlow, 2★): "the quick start button appears randomly on routines that aren't coming up next".

There were no complaints about accidentally starting a routine from a list. The accidental-start hits are about subscriptions, journeys and timers, not routine buttons.

## Decisions

**R4: "N left" is always shown, open or folded** (the user's decision; reviews point 1). This replaces Question 38's rule of a count on folded sections only.

**R5 and R10: done is a single ✓.** A folded done section already shows its habits' icons. A ✓ says they're finished in about 20 pt, where "✓ All done" took about 78 pt; the difference is two more icons. VoiceOver still says "All done".

| Status | Width (15 pt text) |
|---|---|
| "3 left" | 36 pt |
| "12 left" | 42 pt |
| "✓ All done" (round 1) | ≈ 78 pt |
| **✓** (new) | ≈ 20 pt |
| "3/3 ✓" (considered) | ≈ 44 pt; it makes people subtract, and Question 38 chose "left" over done/total |

**R6–R9: where Start goes.**
- The user decided three cases: open sections get "▶ Start"; a folded section gets ▶ alone; the Now section's button is primary.
- The open question was whether a **folded section that isn't Now** gets ▶. **Decision: no.** It shows its icons and "N left" only.
  - **Users show it:** a start button on routines that aren't "coming up next" confused a RoutineFlow reviewer (point 4). The one button people look for is the current routine's (point 2).
  - **Reasoned from first principles:** one primary action per screen keeps the choice obvious. Several ▶ buttons in a column read as several equal "play now" choices.
  - **Space** (the user's point R11): dropping ▶ there frees 44 pt, so one or two more icons fit.
  - **Starting early or late still works** (point 3). Open the section and its Start is there. Two taps, for the less common case.
  - **Earlier sections with habits left open by default** (Question 43, catch-up), so their Start shows without a tap.

| Section | Open | Folded |
|---|---|---|
| **Now**, habits left | "3 left" · **[▶ Start]** primary (filled) · › | icons … "3 left" · **[▶]** primary · › |
| **Other** (Anytime, earlier, later), habits left, today | "3 left" · [▶ Start] secondary (grey) · › | icons … "3 left" · › |
| Any section, all done | ✓ · › | icons … ✓ · › |
| A past or future day | "3 left" or ✓ · › (no Start: routines run today only) | same |
| Quitting | › | › |

**Style:**
- **Primary:** a filled capsule in the app's ink colour (charcoal in light mode, white in dark), the same "primary" as the rest of the app. The user asked for white, and in dark mode it is white.
- **Secondary:** grey (tertiary fill) with ink text.
- **Folded:** a 34 pt circle with ▶, inside a 44 pt tap target. **Open:** a capsule, "▶ Start", 34 pt high.
- **Order on the right:** "3 left", then Start, then the chevron. The number sits first, next to what it counts, and the button is never squeezed.

**R11: icons.** The gap between the icons and the controls drops from 24 pt to 12 pt. With the smaller done mark and no ▶ on later folded sections, a folded header on a 402 pt iPhone shows about 2–3 more icons before "+N". "+N" is still used when they don't fit.

**Kept rules (R12):**
- The name gives way first: folded names show 8 letters and "…".
- Status and Start never shrink.
- Disclosure and Start are separate 44 pt targets.
- No ▶ on Quitting.
- Start only for today.

## Limits

- Point 4 is a single review. The no-▶-on-later-folded-sections rule leans mostly on first principles and the user's space goal.
- The per-section "left" count is backed by routine-app reviews that talk about steps left in *a* routine. Nobody compares sections.

## Built and checked (28 Sep)

- `PartHeader` and the new `StartButton` in `iOS/Habits/Today/TodayRows.swift`.
- **Checked** with `HabitsUITests/SectionHeaderUITests`, screenshots only, on the iPhone 17 Pro simulator. Screenshots are in `Today Screen Evidence/section_header_*.png`:
  - **Afternoon, Now, open:** "2 left" · **▶ Start** (filled) · chevron.
  - **Afternoon, Now, folded:** icon, "+2", "2 left", **▶** (filled).
  - **Anytime and Evening, open:** "N left" · ▶ Start (grey).
  - **Evening, folded:** all five icons, then "5 left", with no ▶.
  - **Morning, all done:** its four icons and a ✓.
- **Supersedes:** "show play on both open and collapsed unfinished sections" in `iOS/Today Improvements.md`, and Question 38's "count only when collapsed".
