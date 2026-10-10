# Where the Plus Button Goes — Accidental Taps and Pushy Placement

Written by Claude (Claude Code), 10 October 2026, for Current Work 80 point 5. The user, the same day, about the
second-device sheet ("Use your habits on this iPad?"): should "Keep both in sync" (Plus) go on top and "Move to this
iPad" below? A Plus button at the bottom is the easiest to tap by accident, and "people will blame like, oh, they are
very pushy."

**Evidence.** A fresh scan of all 1,487,223 reviews for an accident word (accidentally, by mistake, mis-tap, meant to
tap…) near a button or tap word and a paid word (78 candidates,
[`Research/Temp/plus-pricing/accidental_scan.py`](../../Temp/plus-pricing/accidental_scan.py)), **every one read by
hand** and coded in [`accidental_codes.py`](../../Temp/plus-pricing/accidental_codes.py).

## 1. The answer

**The user is right: Plus goes on top, the free move goes last, and the only filled button is the free one.** Done in
Figma (3.2, node 1024:309). The 6th-habit sheet keeps Plus as its filled button, because there buying is what the
person asked about; its free route is a plain text button under it (point 4).

## 2. What users show

**48 reviews** in 11 apps describe tapping a paid option by accident, at a mean of **1.60★**:

| What went wrong | Reviews | Mean ★ |
|---|---|---|
| The paid button sat **where the way on was expected** (skip, continue, close) | 9 | 1.33 |
| One tap charged, with no confirmation step | 14 | 1.00 |
| The upgrade or trial button was simply easy to hit | 27 | 1.96 |

(A review can be in more than one row.)

- **Position is the trap:** people tap where they expect to go on. "I accidentally clicked “continue” instead of
  “skip”" (Fabulous, 1★, `11147238095`); one app's close ✕ started a subscription (Habit-Bull, 1★, `6217825775`); "The
  button for entering a trial of the subscription is very easy to push by accident" (Finch, 1★, `11638405307`).
- **The anger is about intent, not money alone:** the same reviews call the app "scammy", "predatory" or "dark
  patterns". That is the "pushy" the user is worried about.

## 3. Reasoned from first principles

- **On an iPhone sheet the last, bottom button is the way on**: it's in the thumb's reach and where people tap
  without reading (our own rule U18 puts the main action there). Whatever sits there is read as what the app wants.
- **On this sheet people came to use their habits on the iPad.** That's the free move, so it takes the bottom and the
  one filled button. Plus comes first, as a calm card with an outlined "See Plus": it's read first, so nobody misses
  it, but it's never in the spot people tap to go on.
- **An accidental tap can never cost money here anyway:** See Plus only opens the Plus page, and buying always
  needs Apple's own sheet with Face ID or a double-click. The order is about not *feeling* pushed.

## 4. Applied

| Sheet | Order, top to bottom |
|---|---|
| 3.2 · Use your habits on this iPad? | Keep both in sync (Plus, outlined See Plus) → Move to this iPad (filled Use on This iPad) → "✕ keeps this iPad signed out" |
| 1.2 · Add a 6th habit | Plus / Plus Family → what both include → filled Get Plus → plain "Make room instead" (archive or delete). No "Not now": ✕ closes a sheet |
