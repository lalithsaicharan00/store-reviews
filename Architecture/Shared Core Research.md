# Sharing the habit core across platforms

Researched and accepted by the user on 26 September 2026. Backlog #15 is resolved by [Shared Core Decision](<Shared Core Decision.md>), the authoritative decision record. This document retains the evidence and alternatives considered. No prototype or performance measurements were made in this research.

**Accepted: Kotlin Multiplatform (KMP) for one shared domain core, native platform UIs, a written behavior contract, and shared conformance tests. Platform services remain adapters. Integration checks are required implementation work before shipping, not a pending technology choice.**

Both the shared-core architecture and KMP implementation choice are finalized. Documentation alone shares intent. A library shares the actual calculations. Tests check that the library, its bindings, and its callers preserve the intended behavior.

## Follow-up: production examples and support for this exact problem

**User clarification, 26 September:** AI will do the implementation. Prioritize established production patterns, reference implementations, and a community solving native-UI/shared-core integration. The user explicitly confirmed that native UI must remain; only the core should be shared.

**Basis for the accepted decision:** use KMP with native UI because this exact combination has an official project structure, reference code, specialist interoperability tools, and dedicated help channels. Kotlin's general popularity is not the deciding evidence. AI reduces the importance of the team's initial language familiarity, but repeatable builds, supported integrations, and reproducible fixes still matter.

There is no verified market-share ranking here for “one core plus native UI on all five platforms.” The evidence supports calling KMP an established, supported route, especially on Android/iOS. It does not establish that KMP is the most-used solution across every target combination.

| Evidence | What it demonstrates | Boundary of the evidence |
|---|---|---|
| [Official recommended project structure](https://kotlinlang.org/docs/multiplatform/multiplatform-project-recommended-structure.html) | Separate app entry points and shared business logic; native Swift apps can depend on logic without Compose UI | Architecture guidance, not our app's completed implementation |
| [Official native-UI logic-sharing example](https://github.com/Kotlin/kmp-logic-sharing-simple-example/) | Shared business logic connected to Android, iOS, and web UIs | A simple reference, not a complete production sync engine |
| [JetBrains sample catalog](https://kotlinlang.org/docs/multiplatform/multiplatform-samples.html) | RSS Reader demonstrates native UI plus shared data/state; People In Space includes SwiftUI on iOS/macOS; other samples cover desktop/web | Samples use different UI stacks; no claim that all implement our exact architecture |
| [Cash App engineering account](https://code.cash.app/kotlin-multiplatform-summer) | First-party account of Kotlin/Native work on iOS and adoption of Kotlin/JS for shared client presentation logic, with published tools | Its architecture is not a drop-in template for our product |
| [Touchlab KaMPKit](https://github.com/touchlab/KaMPKit) | Native mobile reference architecture, integration guides, testing/build setup, and an explicit support path | Mainly mobile; some README sections are historical, so do not copy old tool versions blindly |
| [SKIE](https://skie.touchlab.co/intro) | A maintained-purpose tool for the specific Kotlin-to-Swift interoperability problem | Optional third-party build dependency; check version compatibility before adoption |

**Where to go when stuck:** official KMP docs direct developers to the Kotlin Slack `#multiplatform` channel and the KMP tooling issue tracker. KaMPKit directs users to `#touchlab-tools` and offers a direct route to discuss specialist support. These are support channels for cross-platform integration, not merely general language forums; community replies are not guaranteed. [Official help routes](https://kotlinlang.org/docs/multiplatform/quickstart.html), [KaMPKit support instructions](https://github.com/touchlab/KaMPKit)

The implementation workflow should start from the current official native-UI template and the linked logic-sharing example. Keep a clean reference build, pin compatible tool versions, and reproduce integration problems in that small project before changing the product architecture. Use KaMPKit as an architecture reference; introduce SKIE only if the API actually needs its Swift interoperability features. AI should follow these references instead of inventing a new bridging framework or combining incompatible snippets from different tool generations.

Flutter and React Native/Expo were considered during this follow-up. Flutter has official multi-platform architecture guidance and broad deployment support; React Native has separately maintained web/desktop platforms. Their usual app-level sharing approaches change the UI strategy, so they are not selected for the confirmed native-UI/core-only requirement. Rust remains a proven alternative, but this research did not establish that its complete binding/packaging workflow offers an easier support path for our exact combination. [Flutter architecture](https://docs.flutter.dev/app-architecture/guide), [Flutter targets](https://docs.flutter.dev/reference/supported-platforms), [React Native platform structure](https://reactnative.dev/docs/out-of-tree-platforms)

The strongest evidence is for native mobile sharing. Web has an exact official example; Mac has native-UI examples. Watch, a future WinUI/C# client, and our Cloudflare integration still need target-specific verification. The existing Windows PWA plan remains the straightforward reuse path. The integration spike below verifies our chosen dependencies and targets; it is not an experiment to discover whether shared-core architecture exists.

## Why this fits our project

I read Backlog #15, Other Surfaces §§8–9, the Sync Engine model and rules, the server merge path, release safety, and the iOS README. They describe:

- An offline-first habit tracker, including use without an account.
- Native SwiftUI on iPhone and Mac; Android later.
- Web later, with an installable web app covering Windows initially.
- Independent Watch behavior and small snapshots for widgets.
- Local records plus an outbox, and a Cloudflare server that also merges records.
- No production iPhone app started yet, according to the iOS README.

This makes local reusable calculations valuable: a check-in must work without calling a server, and every surface needs consistent day, schedule, progress, and merge rules. It also means we can establish a clean module boundary before logic spreads through screens.

The accepted decision retains the repository's Windows-PWA-first plan; no immediate native WinUI requirement has been established. A future native Windows requirement should trigger a target-specific review. Following the AI-development clarification above, existing language familiarity is a secondary consideration. The repository also has inconsistent iOS minimum-version proposals; settle those before selecting build targets.

## Established approaches and evidence

The architectural pattern is commonly called **ports and adapters**: the domain runs independently, while adapters connect UI, databases, networks, and operating-system services. This does not require an elaborate framework. A small module with explicit inputs and outputs is enough for our starting point. [Original description by Alistair Cockburn](https://alistair.cockburn.us/hexagonal-architecture)

There are production precedents for both main language choices:

- **KMP:** Google officially supports sharing Android/iOS business logic this way and lists Cash App, Google Docs, and other adopters. This establishes real adoption, not a promise that their whole application or every platform uses one core. [Android Developers](https://developer.android.com/kotlin/multiplatform)
- **Rust:** Bitwarden documents a shared Rust SDK with UniFFI bindings for mobile and wasm-bindgen for web. Element X describes a Rust SDK connected to Swift and Kotlin. [Bitwarden architecture](https://contributing.bitwarden.com/architecture/sdk/crate-structure/), [Element X](https://element.io/blog/element-x-ignition/)
- **A counterexample:** Dropbox reported abandoning its shared mobile C++ approach in 2019 because tooling, integration, and staffing costs outweighed savings. This is historical evidence about that implementation, not proof that current KMP or Rust is a mistake. Our lesson is to share a narrow domain and measure integration costs. [Dropbox engineering](https://dropbox.tech/mobile/the-not-so-hidden-cost-of-sharing-code-between-ios-and-android)

| Approach considered | Benefit | Cost or mismatch for us | Outcome |
|---|---|---|---|
| Document rules; implement Swift, Kotlin, and TypeScript separately | Simple native tooling | Every fix has to be ported; prose leaves edge cases ambiguous | Not selected; domain rules will use KMP from the start |
| KMP domain library | Reuses Kotlin across mobile, Apple desktop, and web; Kotlin also serves Android | Gradle/Xcode integration, boundary types, and target-specific dependencies need care | Selected |
| Rust domain library | Strong option for native libraries and WebAssembly | Additional language, bindings, binary packaging, and debugging ownership | Not selected; a future material requirement change would need a new decision |
| Put all rules on the server | Central deployment | Offline and guest behavior still require local rules | Cannot be the sole core for this product |
| Adopt a shared UI stack as well | Potentially shares more application code | Expands the decision beyond core reuse and changes our UI approach | Reassess only if UI strategy changes |

These are project judgments, not measured cost rankings. There is no universally cheapest language across teams.

## What the shared core owns

| Shared behavior | Platform adapter responsibility |
|---|---|
| Assign a habit day from explicit date/time context and day-start setting | Read current time and device time zone |
| Group weeks; resolve effective-dated schedules and targets | Read persisted records |
| Calculate due, done, streaks, totals, and progress | Display and localize the results |
| Validate domain commands and produce record changes | Commit records and outbox together in a local transaction |
| Compare merge metadata, deduplicate IDs, apply deletion/restore semantics | Fetch/send operations and persist merge results |
| Produce semantic snapshot values | Write snapshot files, reload widgets, communicate with Watch |
| Decide desired reminder occurrences/cancellations | Register/cancel OS notifications and obey background limits |

Keep SwiftUI, Android UI, StoreKit, Play Billing, HealthKit, Health Connect, credentials, OS scheduling, SQLite handles, and network calls outside the initial core. The server remains responsible for authorization and purchase verification; sharing a client library does not make client claims trustworthy.

For example: the app reads local records, calls `evaluateHabit(records, rules, asOfDay)`, and renders its result. A command path reads state and invokes the core inside the adapter's serialized transaction boundary, then commits returned record changes and the outbox atomically. A background worker sends the outbox later. The transaction boundary prevents another write from invalidating the state used by the calculation.

Avoid turning the shared core into a full cross-platform app framework. Storage drivers and HTTP clients can be reconsidered later if duplication becomes costly.

## How one Kotlin implementation reaches our devices

| Surface | Selected delivery path (implementation pending) |
|---|---|
| iPhone / iPad | Kotlin/Native framework called through a small Swift wrapper; SwiftUI stays native |
| Mac | macOS framework using the same core source, called from SwiftUI |
| Android | Kotlin library called directly by the Android application |
| Web | Kotlin/JS module consumed by the web UI; export a deliberately small API |
| Windows initially | The installable web app uses that same JS module |
| Cloudflare server | Reuse the pure merge/validation subset as a Kotlin/JS module inside the existing Worker/DO adapter; verify bundling and runtime compatibility during implementation |
| Apple Watch | watchOS build of the narrow core, subject to device, size, and runtime validation |

**Research finding, now reflected in Other Surfaces §9:** KMP does not require Kotlin/Wasm or a second handwritten implementation for web. Kotlin/JS explicitly supports sharing logic between Android, iOS, and web while retaining native UIs. [Kotlin/JS overview](https://kotlinlang.org/docs/js-overview.html)

Kotlin/JS can generate TypeScript declarations for exported APIs. That helps integration; it does not remove export-type restrictions or guarantee every dependency works in a browser or Worker. Keep browser, Node, JVM, and Android-only APIs out of the common domain. [Kotlin/JS project setup](https://kotlinlang.org/docs/js-project-setup.html)

Current platform documentation lists mobile, desktop JVM, and Kotlin/JS as stable, while Kotlin/Wasm and watchOS are beta. Native macOS ARM64 has strong compiler support; native Windows `mingwX64` is a lower-tier target, and the current table deprecates Intel macOS. JVM desktop support is not equivalent to seamless WinUI/C# integration. Validate the intended Mac CPU support explicitly. [Platform stability](https://kotlinlang.org/docs/multiplatform/supported-platforms.html), [Native target support](https://kotlinlang.org/docs/native-target-support.html)

For Swift, start with the established framework/Objective-C interoperability route and a thin Swift-facing wrapper. Direct Swift export is currently Alpha, so it should not be a prerequisite for this decision. Prefer plain records and synchronous calculations at the boundary rather than exposing a coroutine-heavy application model. [Swift/Objective-C interoperability](https://kotlinlang.org/docs/native-objc-interop.html), [Swift export status](https://kotlinlang.org/docs/native-swift-export.html)

A future native Windows app requires a separate UI-host and packaging decision; the selected initial path remains the Windows PWA. Such a future review does not reopen the current KMP decision. Rust is a credible alternative, but UniFFI's built-in Swift/Kotlin support does not mean all languages or packaging are automatic. Its guide explicitly separates binding generation from shipping a library. [UniFFI guide](https://mozilla.github.io/uniffi-rs/latest/)

## Where documentation belongs

Keep the contract with the code in this monorepo. Planned structure; the core directories are not implemented by this note:

```text
Architecture/Shared Core Decision.md  accepted choice, scope and tradeoffs
Core/spec/                   authoritative domain behavior, with stable rule IDs
Core/fixtures/               language-neutral inputs and reviewed expected outputs
Core/src/commonMain/         shared implementation
Core/src/commonTest/         domain and property tests
Core/                       Gradle target configuration and export facades
iOS/                        Swift wrapper, storage, UI, system integrations
Android/                    Android adapters and UI
Web/                        JS/TS integration and browser storage
server/                     server adapters consuming the shared merge subset
```

Existing architecture documents explain the wider system and should link to the contract rather than duplicate every rule. A rule change should update the relevant spec, implementation, fixtures, and compatibility note in the same change. Schemas or generated types can share data shape; they cannot generate the meaning of a streak from prose. AI-generated ports still need the same conformance checks.

Example fixture: with day start `03:00`, local time `2026-09-26 02:30` maps to habit day `2026-09-25`; at `03:00` it maps to `2026-09-26`. An explicitly backfilled date remains the selected date. Expected answers must be independently reviewed, not merely copied from current output.

## What shared source does not guarantee

**Same input and compatible rules should yield the same answer.** Two disconnected devices can temporarily have different records, different current time zones, or different core versions. Code sharing does not make synchronization instantaneous or fix a bad merge algorithm.

Before implementing, make these existing proposals precise:

- Streak behavior for missed, skipped, paused, non-due, and still-open days, and weekly target habits.
- Concurrent schedule changes with the same effective date.
- A total tie-break order for identical merge clocks; behavior under extreme clock skew.
- How an explicit restore defeats a tombstone without allowing an old edit to resurrect data.
- Unknown fields and unsupported habit types across old and new clients.

Time-zone conversion also needs a policy: platform databases can differ. Persist the assigned habit day, use explicit inputs for calculations, and test each time-zone adapter. If identical future instant conversion across platforms is required, evaluate a common versioned time-zone database. Specify DST gaps and repeated times; do not hide them behind the phrase “shared code.”

Run the same fixtures through the Swift, Android, browser, and server entry points, not only in the common test runner. Add merge properties: replay is idempotent; permutations and duplicate deliveries converge to the same semantic records. Test the actual database/outbox transaction and supported old/new version combinations. A shared bug can otherwise reach every app together.

Pin each app to a known core release. Track library, wire-protocol, and behavior compatibility separately. Updating the shared source still requires building and releasing the affected apps; users retain older binaries. New incompatible behavior needs capability/version handling, not an assumption that every device updates at once.

## Implementation validation

Build a small KMP integration slice **before substantial production domain code**. KMP is already selected; this milestone verifies the chosen dependencies and target integrations:

1. Implement day assignment, one effective-dated schedule calculation, one streak calculation, and one field-merge operation with reviewed fixtures.
2. Call those from a minimal SwiftUI app, Android harness, browser page, and Cloudflare test runtime. Add a macOS harness and Watch target if Watch is in the first release.
3. Measure clean/incremental builds, release size, startup/memory, and debugging effort. Exercise a realistic large history. Record observations rather than inventing performance expectations.
4. Demonstrate a clean CI build and one shared-rule change reaching every harness. Verify errors, Unicode, nulls, numeric serialization, and preserved unknown fields at boundaries.

Resolve integration issues against the official reference projects and dedicated support routes. Separate Swift/Kotlin/TypeScript domain implementations and a Rust core are not the selected plan. Any material change requires a new recorded decision superseding the accepted KMP decision.

The user has accepted the architecture and KMP choice. This research does not establish completed implementation, build feasibility for the selected dependency set, or measured savings; those remain implementation validation tasks.
