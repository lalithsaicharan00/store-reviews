# Final Small typography and recovery states

Written by Codex, 6 October 2026. Latest user correction; supersedes older 13 pt Semibold and 11 pt Regular supporting captions.

**Supporting text is SF Pro 12 pt Medium, line height 16 within the existing 18 pt capsule.** This applies to Best 45 days, Daily/Weekly/Monthly limit, Limit reached, Over the limit, 12 min today, 2 checks today, Skipped today, Tracking paused, Private, Not planned and Choose a habit. Names and primary values retain their hierarchy. The old catalogue's empty/privacy/recovery supporting instructions also use this style. The capsule remains a display.

Shared style: `Daily widget / Supporting context`, `S:48ab282aa77e651b1c49cc3c8f47c838052df7c0,`. Main 29 scenarios and timed-limit/paused-quit source families retain their IDs. The recovery family is `636:7241`; [review group](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=637-7418) is inside the current [Small list](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=537-2981). Sources remain outside review; review cards are instances.

## State and action matrix

| Card | Main state/value | 12 pt Medium caption | Arrow/body route and data behavior |
|---|---|---|---|
| Choose a habit | Choose a habit / Not selected | Edit Widget | Open app setup guidance; instruct touch and hold → Edit Widget → select stable UUID. No widget logging; no arbitrary default substitution |
| No habits yet | No habits yet / Start in the app | Create a habit | Open existing habit creation; after save, configure selection in system Edit Widget |
| Selection unavailable | Choose habit / Habit unavailable | Edit Widget | Open setup guidance; user selects another UUID in system editor. Keep original configuration until explicitly changed |
| Content hidden | Content hidden / Private | Open app | Authenticate/unlock in app. No real habit name, color, symbol, count, notes or actionable mutation leaks |
| Open to update | Open to update / Data unavailable | Open app | Refresh the disposable shared snapshot through the app. Do not present guessed progress or logging success |
| Save recovery | Couldn’t save / Check in the app | Open app | Show the storage error, reload committed data, inspect/retry from app. Never automatically replay a potentially committed event |

The existing private, not-planned, paused, skipped and removed/stale cases remain in the original scenario list with the same supporting style. Not planned preserves real saved logs and follows the app's allowed manual-log route; it must not fabricate planned completion. Paused/skipped quick logging stays unavailable until the user makes the explicit corresponding change in Day details. A timer already running uses shared session accounting rather than silently dropping elapsed time.

Setup/recovery source and board notes name the intended destination, **not an ability to open the system editor from an AppIntent**. Logging controls become navigation-only for these states; do not expose a dormant logging intent behind the arrow or lock. Privacy should win over every other state. Then honor data availability and stable selection before showing normal progress. A save error must remain distinguishable from a new unselected widget.

## Final evidence

[Typography Audit.json](<Typography Audit.json>) records all 42 individual card instances and each actual supporting label's font/size/style/bounds. [Recovery State.json](<Recovery State.json>) records exact source/review IDs and routes. [Recovery Audit.json](<Recovery Audit.json>) checks the final dark instances and action/layout geometry. [Export Manifest.json](<Export Manifest.json>) covers 48 final PNGs: 42 individual cards and six boards/layout/dark exports. [Images](<Images/README.md>) contains every render.

The latest main baseline was refreshed before publication; native widget implementation is unchanged. Verify instantiated text/geometry, not merely a setter's success (U9). These are Figma/artifact checks; system picker presentation, actual recovery dispatch, privacy update latency, persisted failure handling and accessibility still require the native/device checks in the [accepted contract](<../Accepted Widget Contract.md>).
