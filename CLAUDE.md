# Monorepo — working conventions

## FIRST: the Rulebook (every session, before any change)

Every rule for this repository is in one place, [`RULEBOOK.md`](RULEBOOK.md): speed (S), data safety (D), design and
behaviour (U), testing (T) and how we work (W). The user calls it **the Rulebook**. It's loaded below; follow it, quote
its rule numbers, and add to it the same day you learn something.

@RULEBOOK.md

## Everything else

- `Research/` — all store-review research. Its rules are in [`Research/CLAUDE.md`](Research/CLAUDE.md);
  follow them for any research, report or design-evidence task. Paths in that file are relative to `Research/`.
- `iOS/` — the iPhone app (SwiftUI, native components only). **Before changing any screen, read
  [`iOS/Design Rules — Don't Regress.md`](<iOS/Design Rules — Don't Regress.md>)**: decided rules that past agents broke.
  The app's specs and the user's checklists are in `iOS/Docs/` ([index](<iOS/Docs/README.md>)): open only the spec for
  the screen you're changing.
- Builds, tests, speed runs and CI: Rulebook T1–T6. Scratch, commits and branches: W1–W5. IDs: U8.
