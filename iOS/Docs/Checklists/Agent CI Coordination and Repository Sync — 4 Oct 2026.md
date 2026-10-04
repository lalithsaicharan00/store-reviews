# Agent CI Coordination and Repository Sync

Written by Codex, 4 October 2026, from the user's request.

- [x] Put the policy in the shared Rulebook and the root agent entry points, applicable to all providers.
- [x] Keep ordinary pushes free of test trigger tags; attach tags only for intended validation.
- [x] Before starting tests, check repository-wide live run/job status and wait for other agents' tests to finish.
- [x] Recheck before dispatch; do not depend on the user to remind agents or cancel others' work.
- [x] Avoid the widget cancellation tag without explicit user authorization.
- [x] Fetch remote updates and fast-forward local main before editing.
- [x] Inspect the other agent's committed documentation and preserve its new requirements without merging app code.
- [x] Preserve checklist item IDs: source branch items 22/23 map to main's 33/34.
- [x] Verify documentation and prepare the shared instructions and imported requirements for the authorized commit/push to main.

Fetched main was already at `87513a8`. The other agent's `e657641` was available on
`claude/weekly-overview-stats-ly55gk`; its routine-player requirements are imported as documentation only.
Uncommitted work in another checkout/session cannot be fetched through Git; it becomes visible after that agent
commits and pushes it. Completion claims and implementation status are kept pending verification.

Validation: all 34 current-checklist item numbers are unique, linked local documents exist, the speed-rule check passes, and the diff contains Markdown only. Confirm remote/local main equality after pushing; no test run is requested by this documentation commit.
