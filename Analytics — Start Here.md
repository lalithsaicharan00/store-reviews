# Analytics — Start Here

Written by Codex, 1 October 2026. Branch: `analytics`.

## Branch origin

This branch was created directly from **`integration`**, at commit
`4cfa11118531c43bca6d56432e8d8fc120dd20b8`, rather than from the older `main`.
It inherits that integration snapshot. Other feature branches were reviewed for the analytics plan but were not merged into this branch.

## Analytics work completed

Reviewed 31 branch references at 21 distinct tips, relevant app/architecture documents, and official PostHog documentation. Created the proposed event, privacy, free-plan budget, dashboard and testing plan:

[Often Enough — Product Analytics and Reliability Plan](<Research/Research Reports/Product Analytics and Reliability/Often Enough — Product Analytics and Reliability Plan.md>).

The report is also listed in the [research index](<Research/Research Reports/README.md#product-analytics-and-reliability>).
Only documentation has been added: analytics tracking is not implemented and PostHog settings have not been changed. The PostHog plugin is enabled, but project-query tools were unavailable, so actual project settings and usage remain unverified.

## Next agent

Continue analytics implementation on **this `analytics` branch**. First update it from the consolidated app after the integration, server/sync, onboarding and widget work is merged by their owners. Recheck the report's pinned branch snapshot against current source; branches have advanced since the research audit, including the backup/account client implementation.

Use the report as a proposed contract, verify the actual PostHog project and consent configuration, then implement and validate the content-free tracking described there.
