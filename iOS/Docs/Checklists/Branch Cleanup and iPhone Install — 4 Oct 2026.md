# Branch Cleanup and iPhone Install

Written by Codex, 4 October 2026.

- [x] Update the local repository from origin.
- [x] Verify every branch to delete is preserved in main or archive/all-2026-10-04.
- [x] Preserve uncommitted primary and secondary worktree files before cleanup.
- [x] Delete every remote branch except main, ci-results and archive/all-2026-10-04.
- [x] Retain only the three requested local branches.
- [x] Verify the local main matches the remote main after cleanup.
- [x] Build the synchronized main for the connected iPhone and install the app.
- [x] Verify installation and launch.

Recovery files: Research/Temp/branch-cleanup-2026-10-04/; the primary uncommitted changes also remain in Git stash. The secondary worktree keeps its working files.

Verified 35 remote branches before cleanup; deleted 32, leaving exactly 3. All removed branch tips are ancestors of main or archive/all-2026-10-04. Local main is 2c42b97e7e15495e9ccd9e4ffc3792cee6f62b14.

CI timing: the six running/queued jobs all target this exact main commit. Inspected actions/checkout v4: it fetches the event commit SHA into a local ref; this repository pushes results only to ci-results. The branches were therefore deleted without waiting for the suites. The post-deletion API snapshot confirms all six remain queued/in_progress and none was cancelled. Full suite results are still pending.

Device build succeeded; code signature verification passed; existing development profile includes this iPhone and expires 2 October 2027.

Often Enough (com.oftenenough.app) installed successfully on iPhone 16 and launched with ordinary launch arguments. Process ID: 7315. No uninstall or data reset was performed.
