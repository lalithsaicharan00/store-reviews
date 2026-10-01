# iPhone widgets — user requirements and delivery checklist

Written by Codex, 1 October 2026.

- [x] Separate branch from Integration: codex/iphone-widgets.
- [x] Research before implementation; consult existing full review study and recheck primary iPhone records.
- [x] Detailed report: expectations, preferred types, complaints, semantics, free/Plus boundary and acceptance cases.
- [x] Inspect parallel database/account branch; avoid interfering with it.
- [x] iPhone only: interactive Home Screen and Lock Screen widgets.
- [x] Individual, icon and agenda layouts; useful history views.
- [x] Tasks unlimited; habits/quit/cut-down share existing free cap.
- [x] Free core logging remains useful; gentle Plus discovery for extra layouts.
- [x] Same durable store; no destructive quit reset, stale-day write or duplicate callback.
- [ ] All widgets fully verified in their system hosts on an iPhone: app-hosted family coverage and real-repository checks pass; installed-host/device checks remain separate below.
- [x] macOS GitHub Actions builds, tests and screenshot artifacts; no MacBook work. Results distinguish passed app tests, the failed cold Home action assertion, and the unavailable Lock Screen host.
- [x] Distinguish actual WidgetKit/SpringBoard tests from app-hosted view tests.
- [x] Document results, workflow links, remaining device/provisioning limitations in the research report and integration/release matrix.

Report: [research, implementation and measured results](<../../../Research/Research Reports/Home Screen and Visual Design/Home Screen Cards and Widgets/iPhone Widgets — Research and Implementation.md>).

Release checks: [integration contracts and physical iPhone matrix](<../iPhone Widgets.md>).
