# Monorepo — working conventions

- `Research/` — all store-review research. Its rules are in [`Research/CLAUDE.md`](Research/CLAUDE.md);
  follow them for any research, report or design-evidence task. Paths in that file are relative to `Research/`.
- `iOS/` — the iPhone app (SwiftUI, native components only). **Before changing any screen, read
  [`iOS/Design Rules — Don't Regress.md`](<iOS/Design Rules — Don't Regress.md>)**: decided rules that past agents broke.
  Its "Speed" section (no ticking view around a whole screen, covered screens stop drawing, measure with `sample`)
  applies to all SwiftUI code, not only screen changes.
  The app's specs and the user's checklists are in `iOS/Docs/` ([index](<iOS/Docs/README.md>)): open only the spec for
  the screen you're changing.
- **Builds and tests run on GitHub Actions, not the user's MacBook** (battery). Cloud sessions run Linux: no Xcode, no
  Simulator, so never try to build iOS there. Push with `[ios-ci]` in the commit message to build and run
  TodayUITests + TimerUITests, `[ios-perf]` for the speed tests (both can go in one message); other pushes run nothing.
  About 200 free Mac minutes a month, so don't run the whole suite by default. A few minutes after the run, read the
  result: `git fetch origin ci-results && git show origin/ci-results:latest.md` (build errors, failed tests, speed
  table). Details at the top of [`.github/workflows/ios-tests.yml`](.github/workflows/ios-tests.yml).
- Scratch files go in `Research/Temp/` (gitignored), never `/tmp`.
- Commit only when asked.
