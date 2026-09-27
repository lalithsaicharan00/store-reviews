# Shared core: Kotlin Multiplatform

**Status: Accepted by the user, 26 September 2026.** Resolves Backlog #15. Architecture decision finalized; implementation and integration checks are not yet complete.

## Decision

Use **Kotlin Multiplatform (KMP) for one shared domain implementation**, with **native platform UIs**, **written behavior specifications**, and **shared test fixtures**. Establish the KMP boundary from the start of production development, including the iPhone app.

KMP is selected because native UI plus shared business logic has official architecture guidance, working examples, production adoption, and dedicated integration support. AI-assisted implementation will follow those established references and compatible tool versions. General language popularity is not the rationale. See [research and sources](<Shared Core Research.md>).

## Scope and platform delivery

The core owns habit-day/week rules, effective-dated schedules and targets, streaks and progress, domain validation, ID-based deduplication, merge/deletion/restore decisions, and semantic snapshot calculations. Time, IDs, settings, and records are explicit inputs; platform effects happen through adapters.

| Platform | Shared code delivery | UI and integration |
|---|---|---|
| iPhone / iPad | Kotlin/Native compiled framework | Swift/SwiftUI calls a small core API |
| Mac | Kotlin/Native macOS framework from the same source | Native SwiftUI |
| Android | Standard Kotlin Android compilation and Android Runtime execution | Native Android UI and services |
| Web | Kotlin/JS module | Web UI calls exported functions |
| Windows initially | Same Kotlin/JS module in the installable web app | Existing PWA-first plan; native Windows remains a separate backlog decision |
| Apple Watch | Kotlin/Native watchOS build | Native Watch UI; verify device targets and resource budgets |
| Wear OS | Kotlin Android library | Native watch UI and system integrations |
| Cloudflare | Kotlin/JS build of the pure merge/validation subset | Worker/Durable Object adapters own auth, storage, and network operations; verify runtime compatibility |

On iPhone, Kotlin is compiled to native machine code and packaged with the app; it does not require a JVM. On Android, the shared library follows the normal Kotlin Android execution path. We share source and behavior, with separate platform builds. [Kotlin/Native](https://kotlinlang.org/docs/native-overview.html), [Android Runtime](https://developer.android.com/guide/platform)

UI, database drivers, transaction execution, HTTP transport, background scheduling, notifications, billing SDKs, Health APIs, credentials, and file access remain platform/server responsibilities. The adapter commits local changes and the outbox atomically. KMP adoption does not select SQLDelight or replace the existing GRDB/Room storage plan. *Superseded for storage on 27 Sep 2026: one SQLite database through Room 3 in the shared core ([Local Database Decision](<Local Database Decision.md>)).* The core executes locally for offline and guest use; the sync protocol transfers records between devices.

Use established framework interoperability for Swift and a narrow exported API for JavaScript. Direct Swift export, SKIE, and additional libraries are not automatically selected by this decision. Add a dependency only when needed and after checking supported targets and tool versions.

## Documentation and correctness

Keep the implementation and its contract in this monorepo. The planned `Core/` module will contain:

- `spec/`: authoritative domain rules, stable rule IDs, examples, and edge-case decisions.
- `fixtures/`: language-neutral inputs and independently reviewed expected outputs.
- `src/commonMain/`: the shared Kotlin domain implementation.
- `src/commonTest/`: domain tests and merge/convergence properties.
- Target configuration and small platform export facades.

These are planned implementation paths, not files created by this decision. Existing architecture documents describe the wider system and will link to the relevant rules. Change the specification, implementation, fixtures, and compatibility notes together whenever behavior changes.

Run conformance fixtures through real Swift, Android, browser, and server callers, as well as common tests; add Mac and Watch coverage for shipped targets. Test replay/deduplication, merge convergence, time-zone boundaries, effective dates, unknown-field preservation, and mixed client versions. Pin core releases and distinguish library versions from protocol and behavior compatibility. Same source does not eliminate integration bugs or temporarily different offline data.

## Implementation follow-through

Start with the [official native-UI logic-sharing example](https://github.com/Kotlin/kmp-logic-sharing-simple-example/) and [recommended module structure](https://kotlinlang.org/docs/multiplatform/multiplatform-project-recommended-structure.html). Use the research note's reference catalog and support routes when integration issues arise.

The first implementation milestone is a small working slice: day assignment, one schedule/streak calculation, and one merge operation exercised across platform callers. Verify builds, packaging, runtime compatibility, debugging, memory, and realistic history performance before shipping. Specify remaining product edge cases before coding their behavior.

These are implementation and release checks, **not an unresolved choice between KMP, Rust, and separate native cores**. Rust and duplicated native implementations were considered and not selected. Any future material change to the architecture should be recorded as a new decision that supersedes this one.
