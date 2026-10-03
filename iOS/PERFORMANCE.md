# Speed rules — moved to the Rulebook

**The speed rules are now section S of the Rulebook, [`RULEBOOK.md`](../RULEBOOK.md)** (3 October 2026, at the user's
request: every rule in one place, read before any change). The numbers are kept: "rule N" here is **S N** there, so
older references ("PERFORMANCE.md rule 11") still point at the right rule. The Rulebook added S13–S16 (lazy grids in
list rows, grid ids, `UserDefaults` writes, work set off by every change). The measurements behind every rule are in
[`PERFORMANCE-LESSONS.md`](PERFORMANCE-LESSONS.md).

Written by Claude (Claude Code), 30 September 2026; moved 3 October 2026.

## Why the mistakes kept coming back

- The speed rules lived in the middle of a long design document that sessions read "before changing a screen", so
  changes to the store, a model or build settings never met them. They're now here, loaded first, with a script
  that fails on the ones code can show.
- Speed was judged by eye on the simulator or by reasoning about the code, not measured before and after.
- Work that grows with history (streaks, counts, calendars) was written straight into view bodies. It's fast with the
  week of data a new build has, and slow with a year of it, or on the phone.
- The phone ran an unoptimised Debug build, which made every other cost several times bigger.
