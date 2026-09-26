# Cards — research document: Feature Gating vs Quantity

Source: `Research Reports/Feature Gating vs Quantity.md`  
17 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Product rules](#product-rules) — 2
- [Features](#features) — 1
- [Monetization](#monetization) — 4
- [Insights (the why)](#insights-the-why) — 6
- [Dated events and trends](#dated-events-and-trends) — 1
- [Positioning](#positioning) — 1
- [Anti-patterns](#anti-patterns) — 1
- [Data caveats and method](#data-caveats-and-method) — 1

## Product rules

### RFG-005 — In consumer habit and task apps, capping the core count reads as a hidden trial: 'capping basic habits/tasks in the free tier often feels like a hidden trial.' EasyHabits is cited advising that a good free tracker should allow 'at least 5-10 habits on the free plan, ideally with no limit', and freemium design guides are cited for protecting core free value — users should never feel 'cheated if we moved it behind the paywall'. The summary rule: a fully functioning app preserves retention even when volume-capped, whereas hard quantity limits annoy users early.

- **Where:** §intro para 3
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** cited threshold: at least 5-10 free habits, ideally unlimited
- **Direction for us:** build-free · **Report confidence:** industry claim · **Generalisable:** generalisable
- **Conditions:** a consumer-app rule; the document contrasts it with team tools throughout
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C133 Gate on capability, not on quantity; C236 A free-tier limit must announce itself before the user invests — at install, at setup and at the wall — never silently stop a visible progress signal

### RFG-017 — The document's conclusion, stated as a rule: 'don't cripple the core habit/task loop in free tiers.' Free users should create and track unlimited or many habits/tasks; monetisation comes from capability gates — advanced analytics, custom themes, widgets, device sync/backup and similar enhancements. The named mechanism is trust: preserving unlimited core use builds the retention and trust that make an engaged user willing to pay later, whereas strict quantity limits make the free plan 'feel like a trick' — "'free' feels misleading if you can only log 3 tasks." Leading freemium designers are cited for protecting a free-user 'bill of rights' — unlimited logging, streaks, reminders — and gating only non-essential add-ons. The document answers its own question directly: 'Yes, the claim is supported by evidence', and names the model 'capabilities not quotas'.

- **Where:** §Recommendation: Prioritize Capability Gates
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** synthesis of the above; the one hard number behind it is the 0.8% -> 2.6% case study
- **Direction for us:** build-free · **Report confidence:** industry claim · **Generalisable:** generalisable
- **Side effects:** higher retention is claimed to produce more paid upgrades in absolute terms despite an unchanged conversion rate
- **Conditions:** consumer habit/task apps; the document explicitly excepts team tools where gated features carry clear ROI
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C133 Gate on capability, not on quantity; C147 Let people use the product before they pay

## Features

### RFG-010 — A named user reaction to a habit cap, quoted from an iOS review: the reviewer begged the maker to 'extend the habit limit for free users from 3 to 4...(or better make it unlimited) - my OCD is making me seriously consider switching apps because of this'. The document's reading is that gating the count 'directly drove a paying-interested user to look elsewhere' — a user who was willing to pay, lost to the cap rather than converted by it.

- **Where:** §User Sentiment and Surveys para 1
- **This app does:** 3-habit free cap
- **User reaction:** blocked-conversion
- **Magnitude:** n=1 quoted review; a 2026 app-rating guide is cited for Habitify's cap making the free experience 'feel like a paywall trial'
- **Direction for us:** dont · **Report confidence:** industry claim · **Generalisable:** generalisable
- **Conditions:** a single quoted review, carried for its mechanism rather than its weight
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes; C293 Raising a free habit cap by a couple of slots does not buy back sentiment — the objection re-forms at the new number; change what the cap gates or when it is hit, and instrument it

## Monetization

### RFG-003 — A cap has a calibration window with failure on both sides: 'if the cap is set too low, new users hit it before forming a habit and churn; if too high, they never hit it and never pay.' The stated target is to have typical engaged users meet the cap after roughly 30 days of use.

- **Where:** §intro para 1
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** target: cap encountered after ~30 days of use by a typical engaged user
- **Direction for us:** research · **Report confidence:** industry claim · **Generalisable:** generalisable
- **Conditions:** assumes a cap is used at all; the document's own conclusion is that habit apps should not cap the core loop
- **Canonical:** C133 Gate on capability, not on quantity; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

### RFG-004 — The two models stated verbatim: 'Usage-cap (taster) model: Free users can do everything core to the app but only a fixed amount (e.g. up to N tasks). This helps users build habits on full functionality and upgrade once they max out usage.' and 'Feature-gate (split) model: Free users get all usage they need but some valuable features (analytics, multi-device sync, admin controls) require payment. This is effective in team apps where paid features have clear ROI.' Many leading SaaS products run a hybrid: generous or unlimited core usage plus limited basic services, with advanced or business-oriented features premium-only.

- **Where:** §intro para 2; the two blockquotes (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** document gives none
- **Direction for us:** undecided · **Report confidence:** industry claim · **Generalisable:** generalisable
- **Conditions:** the feature-gate model's ROI argument is explicitly a team/B2B condition
- **Canonical:** C133 Gate on capability, not on quantity

### RFG-008 — Task managers cap quietly, and the pattern varies by unit: TickTick gives free users unlimited tasks and boards but limits the habit module, counting it as a small extra; Trello allows unlimited cards but only 10 boards free; Todoist advertises 'unlimited tasks' while limiting each project to 300 tasks — 'a restriction discovered only in user reports.' The point is that quantity gating is widespread in productivity apps and often undisclosed.

- **Where:** §Habit/Task Apps: Case Studies para 2
- **This app does:** TickTick: unlimited tasks, habit module limited; Trello: unlimited cards, 10 boards; Todoist: 300 tasks per project, undisclosed
- **User reaction:** mixed
- **Magnitude:** Trello 10 boards; Todoist 300 tasks per project
- **Direction for us:** dont · **Report confidence:** industry claim · **Generalisable:** generalisable
- **Side effects:** an undisclosed cap is discovered as a surprise, which is the harm
- **Conditions:** these are task managers, not habit trackers; the habit module is the capped unit in TickTick
- **Canonical:** C133 Gate on capability, not on quantity; C218 Store listing and paywall copy stay true — disclose limits, and never advertise a feature you removed, lack, or don't integrate; C236 A free-tier limit must announce itself before the user invests — at install, at setup and at the wall — never silently stop a visible progress signal

### RFG-013 — The capabilities habit apps commonly gate, as named: Apple Watch support, widget access, detailed analytics, and backup/sync. A Zapier review of free project managers is cited for the complementary pattern — unlimited tasks and collaborative features on a free plan create strong adoption, while premium plans monetise cloud sync and reporting.

- **Where:** §User Sentiment and Surveys para 2
- **This app does:** industry norm: Watch, widgets, detailed analytics, backup/sync are the gated set
- **User reaction:** mixed
- **Magnitude:** document gives no counts
- **Direction for us:** build-paid · **Report confidence:** industry claim · **Generalisable:** generalisable
- **Conditions:** a description of what the market gates, not a finding that each gate converts
- **Canonical:** C011 Weekly / monthly / yearly reports; C013 Cloud sync / multi-device as the paid differentiator; C022 Apple Watch app (done properly: timer, two-way sync); C107 Widget variants and customisation as the paid layer; C133 Gate on capability, not on quantity

## Insights (the why)

### RFG-002 — Volume caps and capability gates behave differently by market: in consumer (B2C) products a usage-cap model — full core functionality, capped volume — 'often works best', whereas feature gates that lock premium capability are 'more common in B2B tools'. The canonical example given is Dropbox's 2 GB free storage, which let users fully experience the product before hitting a limit.

- **Where:** §intro para 1
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** document gives no numbers for the B2C/B2B split
- **Direction for us:** undecided · **Report confidence:** industry claim · **Generalisable:** generalisable
- **Conditions:** stated as a general B2C/B2B pattern, and the document goes on to argue the opposite for habit apps specifically
- **Canonical:** C133 Gate on capability, not on quantity

### RFG-011 — Users interpret low quantity limits as a hostile paywall on core value and respond by abandoning or avoiding the app rather than upgrading — the document states the reaction is to leave, not to pay. This is the causal claim underneath the whole document: a cap on the core unit does not create purchase pressure, it creates exit.

- **Where:** §User Sentiment and Surveys para 1
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** document gives no count for this synthesis
- **Direction for us:** product-rule · **Report confidence:** industry claim · **Generalisable:** generalisable
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C133 Gate on capability, not on quantity

### RFG-012 — Capability gates draw less immediate backlash than quantity gates because 'users expect to purchase non-essential extras (custom themes, widgets, advanced stats) once they've already invested time.' The sequencing matters as much as the object: the expectation forms after the time investment, not at install.

- **Where:** §User Sentiment and Surveys para 2
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** document gives no count
- **Direction for us:** build-paid · **Report confidence:** industry claim · **Generalisable:** generalisable
- **Conditions:** requires that the gated item be genuinely non-essential and that the user has already invested time
- **Canonical:** C133 Gate on capability, not on quantity; C137 Show the paywall at the moment of need, not on app open

### RFG-014 — Freemium conversion in B2C apps is typically 1-4% of free users, so retention is the lever rather than the paywall: users who remain active past the first week are 'five to eight times more likely to convert'. Pushing a paywall before habit formation therefore destroys the conversion base it is trying to harvest.

- **Where:** §Retention and Conversion Insights para 1
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** B2C freemium conversion 1-4%; past-first-week actives 5-8x more likely to convert
- **Direction for us:** product-rule · **Report confidence:** industry claim · **Generalisable:** generalisable
- **Conditions:** industry-wide figures, not category-specific
- **Canonical:** C147 Let people use the product before they pay; C182 A pre-use hard paywall makes every purchase non-evidence-based and non-durable

### RFG-015 — Habit-formation timing is the reason a habit app's paywall cannot be early: habit-formation research puts the average at about 66 days for a new habit to become automatic, so 'if a habit app slams a limit or trial around day 7-14, users quit before they've truly engaged.' A truly free core — unlimited habits/tasks, reliable reminders, no lockouts — lets the routine form first; only afterwards do users become sensitive to missing extras, which is when they will pay to enhance an app that is already valuable.

- **Where:** §Retention and Conversion Insights para 1
- **This app does:** n/a
- **User reaction:** churn
- **Magnitude:** ~66 days to habit automaticity; a limit or trial at day 7-14 lands before it
- **Direction for us:** product-rule · **Report confidence:** industry claim · **Generalisable:** generalisable
- **Side effects:** the free-tier bill of rights named here is unlimited logging, streaks and reminders
- **Conditions:** the 66-day figure is an average with wide individual variance in the underlying research
- **Canonical:** C133 Gate on capability, not on quantity; C147 Let people use the product before they pay; C182 A pre-use hard paywall makes every purchase non-evidence-based and non-durable

### RFG-016 — An internal study paraphrased in the document found that free users who complained about task/habit caps were less likely to ever pay — 'They were likely turning off the app instead of upgrading.' It also notes the other side: apps like Todoist and Trello that give ample free usage have large user bases though their conversion sits in the normal low-single-digit freemium range, while apps that aggressively gate basic usage retain fewer free users.

- **Where:** §Retention and Conversion Insights para 2
- **This app does:** n/a
- **User reaction:** blocked-conversion
- **Magnitude:** no numbers given for the internal study; Todoist/Trello conversion described as 'a few percent'
- **Direction for us:** dont · **Report confidence:** industry claim · **Generalisable:** generalisable
- **Conditions:** the study is paraphrased and unnamed; treat the direction as the finding, not the magnitude
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C133 Gate on capability, not on quantity

## Dated events and trends

### RFG-009 — The document's one quantified case: a consumer project-management app limited free users to 3 projects and locked collaboration features, and its consumer conversion 'crashed to 0.8%'. After removing the 3-project cap and instead gating advanced features — storage and templates — conversion rose to 2.6%, a more than threefold increase. The stated reading is that freeing the core usage unit vastly improves uptake even when new limits are placed on non-essential extras.

- **Where:** §Habit/Task Apps: Case Studies para 2
- **This app does:** before: 3-project cap + locked collaboration; after: no cap, storage and templates gated
- **User reaction:** blocked-conversion
- **Magnitude:** conversion 0.8% -> 2.6% (>3x) after removing the core-unit cap
- **Direction for us:** build-free · **Report confidence:** case study · **Generalisable:** generalisable
- **Side effects:** gating collaboration did not help consumer conversion; gating optional advanced capability did
- **Conditions:** a project-management app in a consumer market, single case, source unnamed
- **Canonical:** C133 Gate on capability, not on quantity; C147 Let people use the product before they pay

## Positioning

### RFG-006 — Habitica keeps all core features free and unlimited and sells only cosmetic 'Pro' perks, and its users understand the trade — they 'buy the paid tier only for cosmetics'. It is the document's worked example that a fully free core loop is compatible with a paid tier, provided the paid tier is decoration rather than capability.

- **Where:** §Habit/Task Apps: Case Studies para 1
- **This app does:** Habitica: core free and unlimited; cosmetics paid
- **User reaction:** praise
- **Magnitude:** document gives no count
- **Direction for us:** build-free · **Report confidence:** industry claim · **Generalisable:** app-specific
- **Conditions:** works because the paid tier is cosmetic; it is not evidence that any paid tier converts
- **Canonical:** C133 Gate on capability, not on quantity; C167 Cosmetic and colour variety as the paid layer

## Anti-patterns

### RFG-007 — Low habit caps convert the free tier into a short trial: Habitify caps at 3 habits 'then locks you out' and Productive caps at 5. The cited HabitBox analysis says Habitify's 3-habit limit 'feels engineered to push you to Pro within a week', and that capping free users at 3-5 habits means someone 'hits a wall' as soon as they try to build a routine.

- **Where:** §Habit/Task Apps: Case Studies para 1
- **This app does:** Habitify: 3-habit cap with lockout; Productive: 5-habit cap
- **User reaction:** blocked-conversion
- **Magnitude:** Habitify cap 3; Productive cap 5; 'push you to Pro within a week'
- **Direction for us:** dont · **Report confidence:** industry claim · **Generalisable:** generalisable
- **Conditions:** the complaint is about 3-5; the document's own floor is 5-10 free habits
- **Canonical:** C007 Generous fixed habit cap (or unlimited) — never change it; C133 Gate on capability, not on quantity; C222 A hard habit cap is a defensible design position only with an opt-in pressure valve — the default never changes

## Data caveats and method

### RFG-001 — Research document, not a review corpus: an industry-literature answer to whether a freemium habit/task app should gate usage volume ('quantity') or capability. Its sources are named only in aggregate — 'Freemium strategy guides and case studies; habit-tracker app analyses and user reviews; habit-formation research' — with secondary citations to EasyHabits, a HabitBox analysis, a Zapier review of free project managers and one unnamed consumer project-management app. No review IDs, no corpus, no denominators for most claims; the conversion figures come from third-party analyses, not from this repo's review data. Every card from this document must be weighed as external industry evidence that the 70 App Store corpora can confirm or contradict, never as a measurement of our own category.

- **Where:** header; closing 'Sources' line
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** no corpus; secondary sources cited by name only; one quantified case study
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** generalisable
- **Conditions:** external industry literature — corroborating, not primary, evidence
- **Canonical:** — (nuance register)
