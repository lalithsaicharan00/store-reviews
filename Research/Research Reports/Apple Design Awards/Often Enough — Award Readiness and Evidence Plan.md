# Often Enough — Award Readiness and Evidence Plan

Written by Codex, 15 October 2026. Proposed follow-on work from [Apple Design Awards — Why Apps Win and Our 2027 Strategy](<Apple Design Awards — Why Apps Win and Our 2027 Strategy.md>). This document does not approve implementation, alter product decisions or claim a likelihood of selection.

## Purpose

Prepare a credible **2027** candidate by improving the experience and recording evidence. The 2026 ceremony is complete. The present strategic preference is Interaction, with Inclusivity as a possible second strength; recheck official categories and conditions for 2027. These are our planning choices, not application categories that Apple has agreed to assess us under.

The working product thesis is **a clear next step, even when your week changes**. Validate that with real people before making it public positioning. The existing native SwiftUI design remains the foundation (U1). Every proposed change still needs user evidence or explicit first-principles reasoning (W2/W6), and a widget change must respect U28.

## 1. Establish one honest baseline

Before scheduling a feature project, produce a matrix for the exact candidate build. Record commit, version, build, OS, device, Free/Plus state, locale and accessibility settings. Distinguish current working-copy code, merged implementation, simulator checks, real-device checks and public release status.

Use these statuses per capability:

| Status | Required meaning |
|---|---|
| Missing | No supporting implementation or evidence established. |
| Implemented, unverified | Code exists; behavior has not passed the relevant check. |
| Verified in a limited setting | A named build/device/task passed; broader scope remains open. |
| Verified across the release matrix | Every declared scenario for the supported release passed, with evidence. |

This avoids calling the app fully accessible, fully localized or award-ready from a screenshot or a broad checklist heading. A future observation can change any status. Store records of failures as well as passes.

## 2. Proposed work order

**P0 means release foundation**, not “Apple requires this.” P1 makes the candidate story stronger. P2 is conditional exploration. Existing numbered Current Work items retain ownership of their implementation; the rows below are research work packages, not replacement item numbers.

| Package | Priority | Work to scope | Deliverable / acceptance evidence |
|---|---|---|---|
| A. Candidate story | P0 | Select three concrete people/tasks; explain what our approach improves. | One page with the problem, contribution, examples and unsupported claims removed. |
| B. Core comprehension | P0 | Observe first habit creation, Today scanning, weekly progress and next-action choice. | Task-by-task errors, assistance and explanations, followed by a tested refinement. |
| C. Recovery and history | P0 | Exercise Undo, editing a past record, interrupted routines and changed schedules. | Correct saved state and comprehensible recovery for the declared scenarios. |
| D. Accessibility task path | P0 | Complete the same useful jobs with assistive technology and relevant settings. | A matrix of independent task completion, open barriers and participant feedback. |
| E. System integrity | P0 | Verify widget, Watch and app actions through suspension, disconnection and reconnection. | Device records showing no lost/doubled action and truthful presentation. |
| F. Performance | P0 | Measure actual tasks with realistic histories under S rules. | Named measurements for the candidate build; no decorative treatment that regresses them. |
| G. First use and purchase | P0 | Fresh install, useful first action, plan limits, unavailable products and restore. | Real build/configuration evidence; clear language and no surprise loss of work. |
| H. Localization | P1 | Audit text/formatting, choose supported languages, review all relevant surfaces in context. | Human-reviewed app/store/help assets and language-specific task results. |
| I. Product character | P1 | Refine wording, progress explanation and optional completion feedback within native controls. | Compared prototypes and user observations that justify the choice. |
| J. Platform adaptation | P1 | Polish the supported iPad/Watch/system surfaces around the activity. | Real hardware results; each surface has a clear role and appropriate layout/input. |
| K. Real-world usefulness | P1 | Gather consented accounts of how the app fits variable weeks. | Specific attributed examples and limits; no unsupported causal or clinical claim. |
| L. Editorial package | P1 | Prepare a factual substantial-release nomination and demo for appropriate featuring opportunities. | Ready-to-review draft with original assets and verifiable claims. No submission in this task. |
| M. New technology | P2 | Consider an additional API only after establishing a concrete unmet user need. | Prototype proving an advantage, failure behavior, privacy and performance; otherwise omit. |

Existing implementation concerns remain in [Current Work Checklist](<../../../iOS/Docs/Checklists/Current Work Checklist.md>). For example, do not relabel all iPad work as missing because an old roadmap row remains unchecked; inspect its detailed evidence. Conversely, a checked implementation does not clear an outstanding real-device check.

## 3. Core workflow test cards

Run these with an unfamiliar participant first, without explaining the interface. Record what they expected, where they hesitated and what they believe was saved. The examples below are proposed tests, not measured findings.

### A person with a variable week

“You want to read on three days this week. Set that up, record today’s reading, then tell us how the week is going.”

Check that the participant understands planned versus unplanned days, the relevant period and whether the task is complete. Introduce a changed week and ask what they would do. Avoid teaching our terminology before observing their interpretation.

### A person accumulating a weekly quantity

“Your goal is 90 minutes of practice this week. You did 20 minutes today. Record that and explain what remains.”

The expected meaning is period progress, without inventing a 90-minute daily target. Check numeric entry, units, saved time/date, the chart and any widget/Watch summary. A textual explanation must carry meaning without relying on color.

### A person reducing or quitting something

Use a neutral, nonclinical example agreed with the participant. Ask them to record an event, inspect the result and correct an error. Check that the interface names the event accurately, avoids accidentally inviting the opposite behavior, and preserves the record without shame-based wording. Do not infer health outcomes from completion.

### A person completing a routine while interrupted

Start a short routine, suspend the app or lower the Watch, then return. Ask what is running, what is saved and what happens next. Moving to a step must not be mistaken for completing it. Check timers against stored start times and the correct logical day. Continue only with test data and test isolation (D8).

### A person using VoiceOver

Ask them to create a weekly habit, find today’s action, log, understand progress and undo the action. Record navigation order, wording, values, focus behavior and whether they can complete each job independently. Include form errors and confirmation states. This is domain semantics, not just presence of `.accessibilityLabel`.

## 4. Accessibility and language matrix

| Scope | What to verify |
|---|---|
| VoiceOver | Action versus navigation, habit identity, amount/unit, goal period, current state, named Undo, focus after updates. |
| Largest Dynamic Type | Essential controls and text remain reachable; no truncation of the meaning; forms work with the keyboard. |
| Contrast and color | State remains legible in light/dark and Increase Contrast; Differentiate Without Color has a meaningful result. |
| Motion and sensory feedback | Reduce Motion is respected; sound/haptics are optional and never the only information channel. |
| Alternative input | Relevant controls can be targeted and operated through Voice Control, Switch Control or keyboard where supported. |
| Progress content | A useful spoken/textual summary, with underlying values and an understandable period, not only an image label. |
| System surfaces | Widget and Watch controls communicate accurately within actual system constraints. |
| Language | Plural rules, units, dates, numbers, grammatical agreement, long strings and right-to-left layout where supported. |
| Input | Names and notes handle composition for supported scripts without corrupting text. |
| Whole experience | Onboarding, help, errors, privacy, purchases, relevant Siri phrases and store assets match the supported language. |

Recruit people who actually use the relevant settings. Simulation and automated checks are useful but do not establish independent task completion. A small formative study finds barriers; it does not prove universal accessibility. Use [Apple’s Accessibility Nutrition Label evaluation guidance](https://developer.apple.com/help/app-store-connect/manage-app-accessibility/overview-of-accessibility-nutrition-labels/) when preparing store claims, and retain unmet criteria explicitly.

## 5. Release and reliability matrix

The award demo must be backed by release evidence, including failure states. Use existing T rules for test execution and coordination; this report itself dispatches no tests.

| Situation | Proof to retain |
|---|---|
| Fresh install | Honest empty state, clear first action, no developer-only demo assumptions. |
| Upgrade / restore | History survives; imports and exports round-trip; failure and undo behavior are understood. |
| Repeated actions | Each intended addition is saved once; reversible actions reverse the right record. |
| No connectivity | Useful local behavior and truthful sync status. |
| Reconnection | Correct merge and no lost/doubled history. |
| App suspension / restart | Acknowledged actions persist, timers and routine state remain coherent. |
| Day boundaries | Correct local logical day, configured day start, travel and daylight-saving scenarios. |
| Privacy settings | Hidden names remain hidden on relevant system surfaces; disclosure is accurate. |
| Purchase states | Free/Plus behavior, pending/unavailable purchases, restore and ended entitlements do not hide or erase existing data. |
| Small/large devices | Core jobs work with the keyboard, largest text and supported window sizes. |
| Long history | Existing S targets still hold during the jobs we demonstrate. |

Do not introduce a server holding habits to obtain marketing evidence (D16). Do not add an award-related reason to relax the data-safety rules. Keep measurements scoped to the exact tested build/device and do not call a simulator check a physical-device check.

## 6. Evidence package template

For every important improvement, save a short record with:

1. **Observed problem:** who encountered it, in which task/build/settings, and what failed.
2. **Design hypothesis:** what we expect to become easier and why.
3. **Alternatives considered:** a concise explanation of the meaningful options.
4. **Chosen implementation:** linked source/build, without claiming that code existence proves behavior.
5. **Verification:** actual task results, device evidence and limits; report failures too.
6. **Remaining uncertainty:** participant/sample gaps, unsupported languages or unverified states.
7. **Public claim allowed:** the exact statement the evidence supports.

For interviews, record consent and permitted attribution. Keep identifying details and private habit content out of the public repository. Store only appropriate summaries or anonymized aggregate research artifacts. No participant recruitment or external contact is authorized by this document alone.

## 7. Nomination and demo preparation

For **editorial featuring**, prepare a draft in the account’s Featuring Nominations workflow when a meaningful release is ready. The current Apple help page recommends at least three weeks of lead time; the overview allows longer for wider consideration. This is not an ADA entry deadline or a promise of award consideration.

Prepare a short introduction, the precise release improvements, supported platforms/locales, a working demo, a separate accessibility clip if useful, and specific evidence. Include original screenshots and a clear support/privacy presence. Identify test data and simulator material accurately. Use an authorized account role when submitting; no account change or submission was made here.

The principal walkthrough should remain understandable without explaining internal technologies. A separate technical note can show how App Intents, native UI, synchronization and accessibility APIs make the experience possible. Keep future plans out of claims about the currently downloadable build.

## 8. Proceed / hold decisions for a future implementation task

**Proceed toward public communication** when the central contribution is clear, the public build supports it, critical workflows pass, claims match evidence, and the package describes a useful release.

**Hold the claim or release component** when a demonstration relies on hidden setup, loses records, misrepresents state, fails independent access, or advertises a device/language that has not been verified. Fix the specific issue; do not use a broad “award-ready” label to conceal it.

**Reconsider the category story** when real user research points to a stronger contribution than our original thesis. We can improve the same product even if it is never selected. This plan measures the work we control; it does not estimate the award outcome.

## Source links

The [main research report](<Apple Design Awards — Why Apps Win and Our 2027 Strategy.md>) contains the dated winner evidence and case studies. Primary operational guidance: [getting featured](https://developer.apple.com/app-store/getting-featured/), [Featuring Nominations](https://developer.apple.com/help/app-store-connect/manage-featuring-nominations/nominate-your-app-for-featuring/), [inclusive app design](https://developer.apple.com/videos/play/wwdc2025/316/), [accessibility evaluation](https://developer.apple.com/help/app-store-connect/manage-app-accessibility/overview-of-accessibility-nutrition-labels/). None publishes a formula that guarantees an Apple Design Award.
