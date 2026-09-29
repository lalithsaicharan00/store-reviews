# Monorepo — working conventions

- `Research/` — all store-review research. Its rules are in [`Research/CLAUDE.md`](Research/CLAUDE.md);
  follow them for any research, report or design-evidence task. Paths in that file are relative to `Research/`.
- `iOS/` — the iPhone app (SwiftUI, native components only). **Before changing any screen, read
  [`iOS/Design Rules — Don't Regress.md`](<iOS/Design Rules — Don't Regress.md>)**: decided rules that past agents broke.
  Its "Speed" section (no ticking view around a whole screen, covered screens stop drawing, measure with `sample`)
  applies to all SwiftUI code, not only screen changes.
  The app's specs and the user's checklists are in `iOS/Docs/` ([index](<iOS/Docs/README.md>)): open only the spec for
  the screen you're changing.
- Scratch files go in `Research/Temp/` (gitignored), never `/tmp`.
- Commit only when asked.
