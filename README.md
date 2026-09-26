# Habit tracker — monorepo

| Folder | Contents |
|---|---|
| [`Research/`](Research/) | Store-review research: review corpora, per-app reports, the Feature Ledger, research reports, analysis tools. See [`Research/README.md`](Research/README.md). |
| [`Architecture/`](Architecture/) | System design: data safety, accounts, sync. |
| [`iOS/`](iOS/) | The iPhone app (SwiftUI). |

Android and web will get their own top-level folders when they start.

**Shared core:** Kotlin Multiplatform with native platform UIs, documented domain rules and shared tests. See the [accepted decision](<Architecture/Shared Core Decision.md>). The planned `Core/` module has not been implemented yet.
