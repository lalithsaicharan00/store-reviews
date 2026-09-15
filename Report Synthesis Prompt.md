# Reusable Report Synthesis Prompt

Use this prompt to combine **every per-app review report** in this repo into one final
feature-set document without losing anything. It is the second stage after
`Store Review Analysis Prompt.md`: that prompt turns one app's reviews into one report;
this prompt turns all reports into one set of decisions.

The goal is two things at once, from the same pass:

1. **Counts** — how many apps show the same point, so repeated things get a confidence score.
2. **Nuances** — the things that appear in one or two reports only but matter a lot (a
   tactic one app used, a feature only one app has, a pricing decision that produced a
   burst of 1★ or 5★, a market-specific blocker). These must survive with their full detail.

Counting alone loses nuances, because merging happens before counting and merging is where
detail dies. So the rule of this whole method is: **extract everything losslessly first,
merge later, on top, and never delete or rewrite what was extracted.**

Cost is not a constraint. Token use, number of sessions and number of files do not matter.
Completeness does.

---

## Inputs

- Report folder: `[REPORT_FOLDER]` (for example `App Store Reports/`)
- Report naming: `<N>. <app name> (REPORT).md`, where `<N>` is the app's rank
- Source data for review-ID checks: `[REVIEW_FOLDER]/<N>. <app name>/reviews.jsonl`
- Working files: `Tools/prd_ledger/` (committed — this is the expensive artifact)
- Output: `Research Reports/Feature Ledger.md` (the final report) and, on top of it, `PRD for App Store.md` (Stage 6)
- Existing research documents in `Research Reports/` are treated like reports: they get cards too, with `report: "<file name>"` instead of a number.

Process reports **one at a time, in folder-number order** (1, 2, 3, 4 … not 1, 10, 11). Each
report is finished, validated and saved before the next one is opened. Work is resumable at
any report boundary because everything is on disk.

---

## Run order — how a session actually proceeds

Reports are processed **one at a time**, and merging happens **continuously, after every
report** — not at the end. Merging everything at the end would mean holding thousands of
cards in context at once, which is the same problem as reading every report at once.
Report-by-report, each merge step is "this report's ~100–200 new cards against a
~100–300 entry ledger", which always fits.

### For every report `<N>`, in this exact order

```
1. Read report <N>, Parts 0–8, section by section
      └─ write cards while each section is in view → Tools/prd_ledger/<N>/cards.jsonl

2. Run Tools/prd_ledger/validate.py on <N>
      └─ headings / table rows / bold phrases / Part 8 items / review IDs / kinds
      └─ gaps → add cards → re-run until clean
      └─ writes Tools/prd_ledger/<N>/coverage.json

3. Blind second pass — ONLY if <N> is 1, 2, 3 or a multiple of 10
      └─ fresh context reads the report without the cards, lists its insights, diff
      └─ gaps → add cards AND add a rule to this prompt so the gap cannot recur

4. Merge: go through Tools/prd_ledger/<N>/cards.jsonl one card at a time
      └─ attach to an existing point in canonical.json, or create a new one,
         or leave canonical: [] (nuance register); mapping saved as <N>/merge.py
      └─ canonical.json is updated in place; <N>/cards.jsonl is never edited again

5. Consolidation pass — ONLY if <N> is a multiple of 10
      └─ over canonical.json only: merge duplicates, split over-broad points,
         record every change in merged_from

6. Render:  python3 Tools/prd_ledger/cards_to_md.py <N>   → <N>/cards.md for the owner to read

7. Commit:  ledger: report <N> carded

8. Open report <N+1>. Never open it before step 7 is done.
```

### Starting a session

1. Read this prompt in full.
2. `ls Tools/prd_ledger/` — the highest numbered folder is the last finished report.
   Check `git log --oneline -3` confirms it was committed. If a cards file exists but was
   not committed, re-run steps 2–6 for it before moving on.
3. Load `Tools/prd_ledger/canonical.json` — it is the merge context for every report.
4. Continue from the next report in folder-number order.
5. Do not re-card a report that already has a committed cards file.

### Files on disk at any moment

| path | what it is | edited when |
|---|---|---|
| `Tools/prd_ledger/<N>/` | one folder per report, holding everything generated for it | created when the report is opened |
| `Tools/prd_ledger/<N>/cards.jsonl` | the report's cards | written once, never edited after commit |
| `Tools/prd_ledger/<N>/coverage.json` | validator output + `no_new_insight` notes | written once |
| `Tools/prd_ledger/<N>/blind_pass.md` | blind second-pass list and diff (reports 1, 2, 3, every 10th) | written once |
| `Tools/prd_ledger/<N>/cards.md` | readable view of cards.jsonl, grouped by kind — regenerate with `cards_to_md.py <N>` | after any change to cards.jsonl |
| `Tools/prd_ledger/<N>/merge.py` | card → canonical mapping for that report | written once |
| `Tools/prd_ledger/<N>/cards_part_*.py` | the scripts that generated the cards, kept as audit trail | written once |
| `Tools/prd_ledger/canonical.json` | the single growing merge ledger | after every report; consolidated every 10th |
| `Tools/prd_ledger/validate.py` | coverage checker | when a blind pass adds a rule |
| `Tools/prd_ledger/build_report.py` | tallies → Feature Ledger | at the end |

### After the last report (all reports in `[REPORT_FOLDER]` plus `Research Reports/*.md`)

```
8. Final consolidation pass over canonical.json
9. build_report.py → Research Reports/Feature Ledger.md   (Stage 5), then hand-edit prose
10. Write PRD for App Store.md on top of the Feature Ledger   (Stage 6)
11. Whole-run completion checklist at the bottom of this prompt
```

### Calibration

Report 1 is the calibration run. After it, stop and let the owner check `1/cards.jsonl`
against the nuances they know are in that report. Fix the prompt before report 2 if
anything is missing. Do not proceed to report 2 without the owner's go-ahead.

---

## What to read in each report

Read **Parts 0 through 8 in full** — every heading, every table, every paragraph, in the
report's own order. Do not skip the scope/method part: it holds review-burst warnings,
solicited-review patterns and country caveats that change how the findings should be weighed.

**Skip the evidence appendix** (Part 9 / "Appendix"): the theme definitions, the complete
review-ID lists and the per-review index are lookup tables for auditing, not findings. Use
them only to resolve an ID when needed.

Read **section by section, and write cards while that section is still in view.** Never
read the whole report and then write from memory — that is exactly how minor points are lost.

---

## Stage 1 — Cards: one per distinct thing the report says

A card is the atomic unit. One card = one point the report makes, kept in the report's own
words, with the report's own numbers and review IDs. A report typically produces 80–200
cards. Every report gets its own folder `Tools/prd_ledger/<N>/`; save the cards there as `cards.jsonl`, one JSON object per line.

### Card schema

```
id                  "R<N>-<seq>" e.g. R01-041
report              1                              (or research-doc file name)
where               "§1.3 line 128"                (section and approximate line)
kind                see the list below
claim               one line, keeps the specific — never a generic label
this_app_does       what the app actually does: free | paid | absent | broken | ran-then-stopped … with detail
user_reaction       purchase-driver | praise | complaint | churn | blocked-conversion | 1★-burst | 5★-burst | mixed
magnitude           the report's own numbers, verbatim: n, %, mean ★, lift, share of paid cohort, dates
direction           what it implies for us: build-free | build-paid | undecided | research | must-have | must-never-break | do | dont | product-rule | none
report_confidence   the report's own signal label (high-priority / emerging / limited evidence / …)
generalisable       yes | app-specific | unknown   (can any app do this, or is it tied to this app's situation?)
side_effects        second-order effects the report names (e.g. "also solves payment rails in RU/TR/AR")
conditions          when the point holds or does not (cap of 3 vs 6, subscription vs lifetime, country, year)
review_ids          a few representative IDs from the report
canonical           [] at extraction time — a list of canonical IDs assigned in Stage 3, never before; a card may attach to several points; empty = nuance register
```

### Card kinds (every one of these must be looked for in every report)

| kind | what it captures |
|---|---|
| `feature` | a capability: exists / missing / free / paid, and how users react to that state |
| `monetization` | price, plan type, trial, cap, lifetime vs subscription, family plan, discount, refund, billing |
| `product-rule` | a rule the evidence says must never be broken (e.g. never move a free feature behind the paywall) |
| `must-have` | something the app must have regardless of free/paid (account system, backup, support channel) |
| `must-never-break` | reliability items that produce 1★ when they fail (sync, restore purchase, data on update, year-end report, launch crash) |
| `do` | things to do around the product: listing, screenshots, launch, support replies, localisation, programs, campaigns |
| `dont` | things to avoid: tactics that backfired, gating patterns, review prompts at the wrong moment |
| `tactic` | a specific thing the app did to grow, rank, convert or retain — and what happened (scholarship program, review-for-premium campaign, challenge, streak freeze) |
| `insight` | a *why* the report establishes (people pay because it is not a subscription; ADHD users rate highest; "simple" is table stakes not a differentiator) |
| `audience` | a user group with distinct behaviour or satisfaction (ADHD, students, medication, sobriety, parents) |
| `market` | a country or language finding (localisation-blocked conversion, payment rails, price sensitivity, review-burst in a storefront) |
| `timeline` | a dated cause → effect chain (paywall regression → rating drop; update → data loss burst) |
| `anti-pattern` | a mistake the app made, with the cost |
| `contradiction` | a place where this report disagrees with a common assumption or with another report |
| `positioning` | how the app is perceived versus competitors; what users compare it to and why they switched |
| `data-caveat` | review bursts, solicited reviews, rating-vs-text contradictions, anything that changes how the report's numbers should be weighed |

A single sentence in a report can produce more than one card (a paid data export that draws
complaints is a `feature` card *and* supports a `product-rule` card). Do not collapse them.

### What counts as "a distinct thing"

If two sentences would lead to different decisions, they are two cards. Examples of pairs
that must stay separate:

- "People buy because it is a one-time purchase" vs "people buy because the price is low"
- "Widgets drive purchases" vs "some widgets are free and that drives 5★ reviews"
- "The family plan is broken" vs "the family plan exists and there is demand for it"
- "Crashes" vs "crash-on-launch after the April update" vs "year-end report crashes every January"
- "Localisation requested" vs "users say they would pay if the app were in their language"

### Rules added from blind-pass diffs

These came from gaps found when a fresh context re-read a report. Each one is now mandatory.

- **Every table in Parts 0–8 gets one verbatim card** (kind `market`, `timeline` or
  `data-caveat`, `where` = "<section> table (verbatim)", the whole table compressed into
  `magnitude`) — even when its rows are also carded individually. Per-country and per-year
  numbers must survive into the ledger. (Report 1: the Part 0 year table.)
- **App identity facts go on the header card**: developer, bundle, aliases, sister apps,
  store rank. (Report 1.)
- **A request that appears only inside a market or audience summary still gets its own
  feature card** — e.g. "Western Europe also wants a Monday week-start setting" is a
  feature card, not just a market card. (Report 1.)
- **A quoted user sentence that describes a gating or pricing pattern gets its own card**,
  even at n=1 — e.g. "you must pay just to reach the home page". (Report 1.)
- **When a theme appears in several tables (Part 2 lifts, Part 4 counts, Part 5 requests,
  Part 7 series), its card carries all of those numbers**, not only the first table read.
  (Report 1: the no-account card.)
- **The report's own method notes** (signal bands, denominators, skipped storefronts, regex
  corrections) go on a single `data-caveat` method card, not only in coverage.json.

### Magnitude is mandatory

Every card carries the report's own numbers, exactly as the report states them. This is what
lets a one-report finding with `mean 5.00 across 91 reviews` rank next to a twenty-report
finding at the end. A card with no magnitude must say `magnitude: "report gives none"`.

---

## Stage 2 — Coverage check: mechanical, per report, before moving on

Write `Tools/prd_ledger/validate.py`. A report is not done until it passes all of these:

1. **Every heading** in Parts 0–8 is cited by at least one card's `where`, or has an
   explicit entry in `Tools/prd_ledger/<N>/coverage.json` of the form
   `{"heading": "…", "no_new_insight": "<reason, naming the card that already covers it>"}`.
2. **Every table row** in Parts 0–8 (theme master table, purchase-trigger tables, mistake
   timelines, country tables, Part 8 action lists) maps to a card.
3. **Every bold phrase** in the body is referenced by a card. Reports use bold precisely
   for the "this matters" moments; each one must be accounted for.
4. **Every numbered item in Part 8** (fixes, structural changes, experiments, research
   questions, what-not-to-change) maps to a card, including the research questions.
5. **Every review ID** on a card exists in that app's `reviews.jsonl`.
6. Zero cards with an empty `claim`, `kind`, `direction` or `magnitude`.
7. Each of the sixteen kinds was searched for; kinds with zero cards are listed in the
   coverage file with a one-line note that the report genuinely has none.

### Blind second pass

For reports 1, 2 and 3, and then every tenth report: a fresh context reads the report
**without** seeing the cards and writes its own list of insights. Diff against the cards.
Anything in the blind list that has no card is an extraction gap — add the card, and add a
rule to this prompt so the same gap cannot recur.

---

## Stage 3 — Merge: attach, never replace

`Tools/prd_ledger/canonical.json` is the ledger of canonical points. Each entry:

```
id            "C017"
title         "Free-tier habit cap produces 1★ reviews"
statement     one plain-English line
section       product-rule | free | paid | undecided | research | must-have | must-never-break | do | dont
cards         ["R01-009", "R42-003", …]      (attach only; a card is never rewritten)
reports       [1, 42, …]                     (derived from cards)
merged_from   []                             (history of consolidation)
```

Rules:

- After a report's cards pass Stage 2, go through them one by one and either **attach** the
  card to an existing canonical point or **create** a new one. The card itself is untouched.
- If nothing fits, leave `canonical: []`. That is not a failure — the set of unattached
  cards is the **nuance register**, and it is a first-class output.
- A card may attach to several canonical points (a paywall-regression event supports both
  "never re-paywall" and the specific feature it moved).
- Record the merge as `Tools/prd_ledger/<N>/merge.py` (the card → canonical mapping) so it can
  be re-run and audited.
- Never widen a canonical point's statement to make a card fit. If a card only half-fits,
  create a second, narrower canonical point.
- **Consolidation pass every 10 reports**, over `canonical.json` only: merge true duplicates
  and split points that became too broad. Record every merge in `merged_from`. Nothing is
  deleted.

---

## Stage 4 — Confidence and free/paid: computed, recomputable

### Free / paid 2×2 per feature

Every `feature` and `monetization` card has `this_app_does` and `user_reaction`. For each
canonical feature, tally the apps into:

| | user reaction positive (purchase-driver / praise) | user reaction negative (complaint / churn / blocked-conversion) |
|---|---|---|
| **app makes it free** | free-praised | free-expected-but-broken |
| **app makes it paid** | paid-converts | paid-resented |

The verdict follows the table: mostly `paid-resented` → free; mostly `paid-converts` → paid;
mixed → undecided, with the `conditions` from the cards spelled out (which apps, what price
model, what cap).

### Confidence rubric

| level | rule |
|---|---|
| Certain | ≥ 8 apps, same direction, and ≥ 2 reports label it high-priority |
| Strong | 4–7 apps, same direction |
| Moderate | 2–3 apps, **or** 1 app with exceptional magnitude (mean ≤ 1.7 or ≥ 4.8, lift ≥ ×4, or ≥ 50 reviews behind it) |
| Single-source | 1 app, ordinary magnitude — **kept**, labelled "research before deciding" |
| Contested | reports disagree on direction — listed with both sides and their conditions |

"Same direction" means the cards' `direction` values agree. Magnitude thresholds are what
let a one-report tactic (a scholarship program at mean 5.00) sit at Moderate instead of
disappearing. Apps are counted, not reviews, because corpora differ in size by 100× and two
large apps must not outvote forty small ones; review totals are shown as a secondary column.

---

## Stage 5 — The final report: `Research Reports/Feature Ledger.md`

Generate it with `Tools/prd_ledger/build_report.py` from the cards and the ledger, then
edit the prose by hand. Structure:

1. **Product rules** — canonical points with `section: product-rule`, each with count,
   confidence and the linked cards.
2. **Features — free / paid / undecided / research** — one block per feature: the 2×2, the
   verdict, the confidence, the conditions, and the nuance cards attached to it in full.
3. **Must-haves** and **Must-never-break** — with the magnitude of what happens when they
   are missing or fail, per app.
4. **Things to do** and **Things not to do** — including every `tactic` card with its
   outcome, so "what worked for whom" is visible, not just "do X".
5. **High-impact rare findings** — every card at Moderate-by-magnitude or Single-source,
   ranked by magnitude, regardless of count. Nothing from the nuance register is left out.
6. **Contradictions** — where apps' experience diverges, with the conditions on each side.
7. **Audiences and markets** — per audience and per country/language: what converts, what
   blocks, what the payment rails do.
8. **Timeline lessons** — dated cause → effect chains across apps.
9. **Data caveats** — review bursts and solicited-review patterns that weaken specific counts.
10. **Card index** — every card, by report, so any statement resolves to a report section
    and to review IDs.

Every count in the report carries: number of apps, list of report numbers (linked),
confidence level, and the card IDs. Every nuance carries its magnitude and its report.

---

## Stage 6 — The PRD: `PRD for App Store.md`

The PRD is written **on top of** the Feature Ledger. It is a clean product requirements
document: decisions only. It carries **no rules section, no method notes and no
statistics** — all of that lives here and in the ledger.

The only writing rules, and they live in this prompt, not in the PRD:

1. **Plain English.** Write like you are explaining to a friend. No theme codes, no jargon.
2. **One point per bullet, 2–3 lines.** Say the point, then the short plain reason. Nothing else.
3. **No numbers in the bullet.** A point usually comes from many reports, so one report's
   numbers would be wrong for the rest. Anyone who needs numbers opens the ledger.
4. **Every bullet ends with "Repeated in:"** followed by the linked report numbers. These
   come from the ledger's `reports` field for that canonical point, never from memory.
   A research document is linked the same way, by name.
5. Sections: 1 Product rules · 2 Features — Free · 3 Features — Paid · 4 Features — Not
   decided yet · 5 Features to research · 6 Must-haves · 7 Must never break ·
   8 Things we should do · 9 Things we should NOT do.
6. Bullet template:
   `- **Short title.** The point, then one or two lines of plain reasoning. Repeated in: [N](<link>), [M](<link>).`
7. Nuances go in too. A single-source finding with strong magnitude gets its own bullet in
   the relevant section, written the same way; its "Repeated in:" simply lists one report.


---

## Completion checklist (per report)

- [ ] Parts 0–8 read section by section; cards written in-section, not from memory
- [ ] `<N>/cards.jsonl` saved; every card has claim, kind, direction, magnitude, where
- [ ] `validate.py` passes: headings, table rows, bold phrases, Part 8 items, review IDs, kinds
- [ ] Blind second pass done if this is report 1–3 or a multiple of 10; gaps fixed and the rule added here
- [ ] Every card either attached to ≥1 canonical point or left `[]` deliberately; mapping in `<N>/merge.py`
- [ ] Consolidation pass run if this report is a multiple of 10
- [ ] `cards.md` regenerated
- [ ] Committed: `ledger: report <N> carded`

## Completion checklist (whole run)

- [ ] Every report in `[REPORT_FOLDER]` has a cards file and passes validation
- [ ] Every research document in `Research Reports/` has cards
- [ ] Final consolidation pass over `canonical.json`
- [ ] `build_report.py` run; `Feature Ledger.md` sections 1–10 present
- [ ] Every canonical point shows apps count, report links, confidence, card IDs
- [ ] Every unattached card appears in section 5 of the final report
- [ ] Spot-check: pick ten nuances from three reports at random and confirm each is findable in the final report by its own detail, not just its bucket
