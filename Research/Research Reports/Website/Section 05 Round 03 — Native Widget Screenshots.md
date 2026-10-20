Written by Codex, 12 October 2026. Current Work 93. Design preparation; native captures pending.

# Section 05 Round 03 — Native Widget Screenshots

The user replaces the widget catalogue with two or three genuine iPhone Home/Lock Screen screenshots. Remove Free/Plus labels, individual family blocks and the separate Lock catalogue. Keep the important benefit—interactive widgets—easy to scan. Accepted earlier sections and Morning routine remain unchanged.

## Capture plan

Use an erased GitHub simulator and the current app's real WidgetKit extension, installed through SpringBoard. The simulator-only fixture is on temporary branch `codex/website-widgets-capture`, based on `ac462364b33bc90ebaaa7a222893d153cdae87ac`. No production tap, intent, snapshot or persistence behavior changes (U28/D8). The fixture is idempotent and marks the ordinary debug sample set installed before adding anything (T14).

- Small Water: 3 of 8 glasses; an amount with a saved increment.
- Small Smoke-free: live elapsed quit run, about 12 days. Its entry opens the app as the locked behavior requires; do not imply direct quit logging.
- Weekly Medium Coffee: daily maximum of 3 cups, with real seeded history. This covers cut-down limits using a common habit.
- Today Large, configured with the app's native Morning filter: Stretch check, Meditate duration, Walk amount, Kitchen checklist (Dishes/Sink/Floor), and Read monthly book goal. None duplicates the other Home widgets. “Today” is the widget family; the selected section's native heading is “Morning.” Preserve that truthful label.
- Lock: native remaining-items summary plus two configured circular widgets. Verify installation and actual final Lock/Notification Center capture; gallery previews or an editor screenshot cannot pass as the installed Lock Screen.

Two Small plus Weekly Medium plus Today Large may exceed the native phone grid. Verify on the simulator; if necessary use Home A (Small pair + Large), Home B (Weekly), and one combined Lock capture. Do not manufacture a Home Screen that cannot exist.

## Presentation prepared for the captures

**Interim cleanup applied 13 October:** removed 24 Free/Plus badge instances from the responsive gallery sources and the separate Lock catalogue from all eight Home/combined section copies. The existing specimens remain temporarily while native capture is pending. This is not yet the final screenshot replacement. Accepted desktop hero/habits/progress/Morning dimensions were preserved.

Headline: **Interactive widgets.** One short supporting sentence explains direct checks, counts and timers on the Home Screen. Present the actual captures in the accepted sourced iPhone bezel, preserving native pixel ratio and complete screen. Quiet labels distinguish Home Screen, This week and Lock Screen; no plan badges, family catalogue, decorative panels or extra explanatory cards.

Desktop can show the actual captures together in one balanced row. On smaller widths, show one readable phone with a compact, accessible screenshot selector; keep every capture available without a long vertical wall of phones. Implement later with static optimized images and ordinary HTML/CSS controls, with 44px targets, keyboard selection, descriptive text and no automatic cycling (S19). Native UI stays inside unedited images; site copy and controls remain editable in Figma.

## Evidence and remaining work

**13 October continuation:** Run 38281051206 passed the core checks and native build but both capture methods failed before widget setup. The app hierarchy proves the fixture loaded; Morning was folded and exposed `Open Morning`, so the test's Kitchen lookup could not succeed. The corrected setup opens Morning first. Native configuration selectors also use the actual Show parameter and combined Small-widget recovery label. [Run 38342664113](https://github.com/lalithsaicharan00/store-reviews/actions/runs/38342664113), commit `e1772a04caefb0c9c1920af679b27d0cc877dd40`, retries the capture setup. The unchanged core's passing evidence is reused; the native app still builds normally. Light appearance and the simulator's native 9:41 Home status-bar override are applied before capture, without retouching images.

Capture harness and fixture prepared through the GitHub connector. The user explicitly authorized starting on our separate branch alongside other CI. The initial [capture run 38281051206](https://github.com/lalithsaicharan00/store-reviews/actions/runs/38281051206), commit `9db1f8970d678b6597787d9bb6db7d60bf1fd3b0`, failed as diagnosed above. Verifying installed Home/Lock images, importing them into Figma, responsive renders and final handoff are still pending. No other agent's run is cancelled or replaced. No screenshot claim is made from preparatory code or gallery previews.

**Runner diagnosis, 13 October, 04:26 UTC:** The user reiterated proceeding on our own branch. Run 38342664113 is already submitted there, with a branch-specific concurrency group and no assigned runner. Five other actual Mac jobs have assigned runners. [GitHub's limits](https://docs.github.com/en/actions/reference/limits) specify five concurrent Mac jobs for Free/Pro/Team, shared by standard and larger runners. This observation matches an account capacity queue; the account plan itself has not been independently retrieved. Creating another branch or changing the standard Mac label does not add account capacity. Continue the submitted run instead of creating duplicates. [GitHub's status API](https://www.githubstatus.com/api/v2/summary.json) reported Actions operational at this check.

Apple references: [adding and configuring widgets](https://support.apple.com/en-ie/118610), [widget design guidance](https://developer.apple.com/design/human-interface-guidelines/widgets), [native widget families](https://developer.apple.com/documentation/widgetkit/widgetfamily/). Layout and copy choices are inferences from these native constraints and the user's feedback, not a new review sample or conversion experiment. Existing review evidence remains in [Round 01](<Section 05 — Interactive Widgets.md>).
