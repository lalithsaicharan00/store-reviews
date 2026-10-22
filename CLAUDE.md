# Monorepo — working conventions

## FIRST: the Rulebook (every session, before any change)

Every rule for this repository is in one place, [`RULEBOOK.md`](RULEBOOK.md): speed (S), data safety (D), design and
behaviour (U), testing (T) and how we work (W). The user calls it **the Rulebook**. It's loaded below; follow it, quote
its rule numbers, and add to it the same day you learn something.

@RULEBOOK.md

**21 Oct 2026: starting again.** The app is being designed again from scratch, Android first. For new design work,
the existing design rules, specs and earlier designs are reference only; the user's new decisions win. Read the
Rulebook's "Starting again" section first: it says what still holds.

## Everything else

- `Brand/` — the current Often Enough logo guide, decision history and exported assets. Follow
  [`Brand/Logo Guide.md`](<Brand/Logo Guide.md>) for reproduction (U29); the research archive preserves rejected directions.
- `Research/` — all store-review research. Its rules are in [`Research/CLAUDE.md`](Research/CLAUDE.md);
  follow them for any research, report or design-evidence task. Paths in that file are relative to `Research/`.
- `iOS/` — the iPhone app (SwiftUI, native components only). **Before changing any screen, read
  [`iOS/Design Rules — Don't Regress.md`](<iOS/Design Rules — Don't Regress.md>)**: decided rules that past agents broke.
  **Widgets are LOCKED (Rulebook U28):** before touching anything a widget does (taps, saving, updating, routing),
  read [`iOS/Docs/Widgets — Taps and Updates (Locked).md`](<iOS/Docs/Widgets — Taps and Updates (Locked).md>).
  Speed work and bug fixes that keep the instant switch and never lose or delay-sync a tap are allowed (its §8).
  The app's specs and the user's checklists are in `iOS/Docs/` ([index](<iOS/Docs/README.md>)): open only the spec for
  the screen you're changing.
- `Android/` — the Android app. **Start at [`Android/Docs/README.md`](<Android/Docs/README.md>)**: the decisions (with the
  user's words), the research, the Google Drive sync design. Whatever is designed for one platform works the same on the
  other (the user, 11 Oct 2026).
- Builds, tests, speed runs and CI: Rulebook T1–T10. **Before every push/test dispatch, follow T10:** ordinary
  pushes have no trigger tags; start your own tests when ready, never waiting for other agents' runs, and never
  cancel or replace theirs (use temporary branches of your own for parallel runs; the user, 9 Oct 2026); do not use the widget cancellation tag without explicit authorization. Check live status without relying on a
  user reminder. This applies to all agents. Scratch, commits and branches: W1–W5. IDs: U8.
