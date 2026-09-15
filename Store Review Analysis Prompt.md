# Reusable Store Review Analysis Prompt

Use this prompt for **one target product folder at a time**. Replace the placeholders before starting. The goal is to turn the complete review corpus into traceable product-discovery evidence, not to produce a generic review summary.

## Inputs

- Target folder: `[TARGET_FOLDER]`
- Product / app name: `[PRODUCT_NAME]`
- Product category or problem space: `[CATEGORY]`
- Product decision being informed: `[DECISION_CONTEXT]`
- Review corpus: `[TARGET_FOLDER]/reviews.jsonl`
- Country review files, if present: `[TARGET_FOLDER]/by_country/*.jsonl`
- Metadata files, if present (for example `manifest.json`): `[TARGET_FOLDER]/*`
- Minimum country sample for an individual country analysis: `50 reviews`

The folder may contain different fields or supporting files. Inspect the schema first and document the fields actually used. Preserve the source review ID (and country, rating, date, version, title, and text whenever available) so every conclusion can be audited.

## Task

Analyze the target product's reviews for product discovery and create **one detailed Markdown report** in `[TARGET_FOLDER]`. Do not create separate country reports. Name it clearly, for example `review-analysis.md`.

Read and account for **every review** in `reviews.jsonl`, including every review that is represented in small-country files. Do not rely only on keyword search, high-rated reviews, a sample, or the records that fit in a model context window. Use an efficient, reproducible workflow for a large corpus: parse records programmatically, remove irrelevant fields only for analysis, classify or cluster in batches, aggregate results, and perform quality checks. The final report must state the total records read and reconciliation results against the source file.

Do not discard a review merely because it is short, old, low-information, or written in a different language. Deduplicate only exact technical duplicates if necessary; disclose the rule, retain a mapping to the original IDs, and use the correct denominator for every percentage.

## What to discover

Extract only insights that can inform a product, design, pricing, or roadmap decision. Identify as many supported patterns as exist, without inventing weak or arbitrary ones.

1. **Product and feature inventory**
   - Infer what the product does and which features users actually experience from reviews.
   - If useful, consult the product's official site or store listing to clarify the feature set, price model, and terminology. Keep externally sourced claims separate from review-derived evidence and cite the source and access date.
   - Identify which capabilities appear free, paid, trial-gated, subscription-gated, one-time-purchase-gated, or unclear.

2. **Customer value and friction**
   - What users praise, why it works for them, and which use cases or outcomes they describe.
   - Complaints, bugs, missing capabilities, usability friction, onboarding issues, reliability problems, support concerns, privacy concerns, and accessibility needs.
   - Requests or pain points that reveal unmet needs.
   - Distinguish a request for a new capability from a broken existing capability, a misunderstanding, and a pricing objection.

3. **Ratings and review intent**
   - Explain the main reasons behind 5-, 4-, 3-, 2-, and 1-star reviews.
   - Show how themes differ by rating; do not assume that a theme is exclusively positive or negative.
   - Identify praise that signals a differentiator and criticism that can cause churn, refusal to upgrade, or poor ratings.

4. **Monetization and paid users**
   - Treat this as a primary analysis area.
   - Identify what causes people to start a trial, subscribe, renew, make a one-time purchase, or otherwise upgrade; name the feature, outcome, or bundle involved when the review supports it.
   - Separately analyze reviewers who explicitly indicate they paid, subscribed, are on a trial, renewed, or requested a refund. Within these groups, identify value drivers, buyer segments, satisfaction drivers, cancellation/refund causes, paywall reactions, and post-purchase problems.
   - Clearly distinguish direct purchase evidence from inferred interest in paid features. Never claim conversion rates from review text alone.

5. **Geography and market segments**
   - Produce a global analysis using every review.
   - Analyze each country with at least 50 reviews individually. For countries below that threshold, include their reviews in global calculations but omit standalone conclusions unless a clearly material, well-supported insight appears; label it as limited evidence.
   - Give special attention to two explicitly labeled groups: high-spend markets and high-review-volume markets. Define membership from an available, reputable source. If spend/download data is not available, use review volume only as a disclosed proxy and do not call it downloads.
   - Compare global themes with country-specific themes, ratings, price sensitivity, monetization signals, feature expectations, and localization/support issues. Avoid cultural generalizations that the corpus does not establish.

6. **Change over time**
   - Analyze review dates across the corpus and compare meaningful time periods (for example launch/early, middle, recent; or pre/post a visible release) using a documented method.
   - Identify emerging, improving, worsening, or persistent themes. Check whether new capabilities, pricing changes, AI-related expectations, or regressions changed what people discuss. Do not label a trend if dates or sample sizes cannot support it.

## Signal thresholds

Apply these thresholds separately to the global corpus and to every individually analyzed country. For a country, use that country's total reviewed records as the denominator; for global findings, use all reviewed records. State the denominator, count, percentage, and time window beside every quantified finding.

| Share of relevant reviews | Label | Interpretation |
| --- | --- | --- |
| Under 0.1% | Ignore by default | Do not promote as a finding unless there is a clear safety, legal, security, or severe data-loss concern. |
| 0.1% to under 0.5% | Weak signal | Record it, with cautious wording. |
| 0.5% to under 1% | Emerging signal | Worth further investigation. |
| 1% to under 3% | Meaningful signal | Strong candidate for product consideration. |
| 3% to 5% | Very strong signal | Should probably influence roadmap or prioritization. |
| Above 5% | High-priority signal | Strong product problem or opportunity. |

For narrowly scoped denominators (for example, explicit paid reviewers, one-star reviews, or a single feature's users), you may present a supplemental segment rate. Always label it as a segment rate, show both the segment denominator and the global count, and do not substitute it for the threshold classification above.

## Evidence standards

- Every finding must include: theme, direction (positive/negative/mixed), count, percentage, denominator, relevant market scope, relevant time period, signal label, and representative exact review IDs.
- Use enough IDs to make the finding auditable: normally 3–10 representative IDs, more for large or ambiguous themes. Do not replace IDs with invented examples.
- Use short, faithful excerpts only when they clarify the finding; avoid long quotations. Preserve the review language and provide a clearly labeled translation when needed.
- A single review may belong to multiple themes. Explain whether theme counts are non-exclusive; they usually should be.
- Separate facts from interpretation and explicitly call out uncertainty, missing fields, possible review-selection bias, version differences, and small samples.
- Do not manufacture numerical precision. If automated classification is used, manually inspect borderline and high-impact clusters, validate a sample, and disclose the validation approach and known error risk.
- Do not treat star rating alone as a feature preference, and do not turn a correlation into a causal claim.

## Required report structure

Write in plain English: short, direct, evidence-led sentences; compact tables and bullets; no filler or long generic prose.

1. **Executive summary** — the few most consequential product decisions, opportunities, and risks.
2. **Scope and method** — files used, schema, total reviews read, date range, countries, exact coverage/reconciliation, processing method, and limitations.
3. **Product and monetization model** — review-derived feature inventory, external sources if used, and free/paid/trial/unclear classification.
4. **Global findings** — prioritized positive, negative, mixed, and unmet-need themes, with evidence.
5. **Ratings analysis** — theme breakdown and explanation for each star rating.
6. **Paid-user and upgrade analysis** — purchase triggers, buyer value, upgrade barriers, refund/churn drivers, and issues affecting paid users.
7. **Country and market analysis** — each eligible country, the defined high-spend group, the high-review-volume group, and global comparison. Include small-country caveats where relevant.
8. **Time-trend analysis** — what changed, what persisted, and the evidence for each trend.
9. **Product implications** — prioritized design, feature, reliability, support, and monetization recommendations. Tie every recommendation back to one or more report findings; distinguish immediate fixes from experiments and research questions.
10. **Evidence appendix** — taxonomy/theme definitions, all quantified findings, exact review IDs, counting rules, denominators, and any external sources.

## Completion checklist

Before finishing, verify that the report:

- Covers every record in the main review corpus and includes all reviews in global results.
- Does not make standalone country claims for sub-50-review countries without a clear limited-evidence warning.
- Applies the signal thresholds correctly at global and eligible-country levels.
- Separates paid-user evidence from general feedback and identifies both purchase drivers and monetization friction.
- Includes review IDs and numbers for every material claim.
- Uses one Markdown file only, placed inside the target folder.
- Contains actionable, evidence-backed product implications rather than a list of raw complaints.
