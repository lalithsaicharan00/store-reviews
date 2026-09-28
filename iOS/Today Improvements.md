# Today Improvements — Implementation and Verification

Requested by the user, 27 September 2026. This task uses simulators only; the physical iPhone is being tested independently.

## Requested behavior

- Let every day section launch its routine independently of the Now label, including Anytime and custom sections.
- Research whether unfinished collapsed sections should expose play too. Use a circular play icon, with stronger white emphasis for Now and a quiet neutral fill elsewhere.
- Never offer routine play on Quitting. Hide it when nothing remains. Keep ordinary habit logging available without running a routine.
- Replace the bottom-bar calendar picker with daily completion rings. Dates with no eligible habits are plain; the selected date uses a light adaptive fill, never a dark block.
- Validate on simulators, including existing habit creation, persistence and small-screen layouts.

## Evidence reviewed and implementation rationale

This is a focused review of existing research and selected original reviews, not a new full-corpus analysis. No prevalence or conversion claim is made.

Routinery originals were verified in `Research/App Store Reviews/5. Routine Planner, Habit Tracker - Daily Time Management for ADHD/reviews.jsonl` (the existing corpus folder):

- `14371526010`, US, 5 stars, 31 July 2026: the user describes a single decision to start as removing subsequent decision fatigue, and values flexible skipping.
- `10507135013`, Germany, 3 stars, 23 October 2023: the user objects to compulsory timers/whole-block execution and wants direct checklist use.
- `12069182383`, UK, 2 stars, 16 December 2024: accidental completion without recovery is frustrating.

Also reviewed the existing Day Sections, Categories and Routines research and the Routinery App Store report.

External checks, accessed 27 September 2026:

- [Apple disclosure controls](https://developer.apple.com/design/human-interface-guidelines/disclosure-controls): frequent actions should remain visible near the top of the disclosure hierarchy.
- [Routinery's own description](https://www.routinery.app/blog/best-app-daily-rituals): sequential execution with separate morning/evening rituals. Product documentation corroborates the interaction concept; marketing claims are not treated as user evidence.

**Reasoned from first principles:** show play on both open and collapsed unfinished sections today. Folding means hiding details; it should not disable the section's principal action or add a prerequisite tap. Now indicates a preferred time, not permission to act. This is an inference, not an experimentally established preference for collapsed-card buttons. Separate 44-point disclosure and play targets reduce accidental actions; full section names remain in accessibility labels.

## Implementation

- Independent disclosure/play controls, with no parent tap gesture that also fires on play.
- A small focused routine sheet replaces the old first-timer-only stub. It uses existing habit entries and controls, includes only unfinished habits, supports checklists/amounts/timers/section-specific ticks, and allows skip without false completion. Closing pauses the current timer; reopening derives remaining habits from saved progress.
- Routine execution is today-only. Past days retain existing manual logging; future days are previews and cannot log completion.
- Calendar and bottom bar use `HabitStore.daySummary`, so both count the same eligible non-archived, non-quit habits and deduplicate habits present in several sections. A ring represents completed habits divided by due habits, not fractional amount progress. Before creation or on a day with no scheduled habits, there is no ring. Future scheduled days have a faint empty ring. Complete past/current days have a small check badge.
- Month navigation respects the configured week start and calendar arithmetic. Day selection opens that day immediately; Today returns to the current logical day. The sheet scrolls at small screen sizes or large text sizes.
- Existing progress/schedule rules remain in the iOS model, matching the current architecture; the shared Kotlin storage/schema is unchanged.

## Verification

Pending simulator test results. See `Research/Temp/routine-calendar/` for logs, result bundles and screenshots.
