# Review Insights

Written by Claude (Claude Code), 26 November 2026, at the user's request.

**What this is.** Research findings drawn from the labelled store reviews in [`Review Labels/`](<../Review Labels/README.md>),
one folder per app. Where `Review Labels/` holds one label per review (what each person said), this folder holds what
the labels add up to: **who the users are, why they use an app, what they like, and what they pay for**.

**Why.** To understand users purely from data, as research for a new product or a full rebuild. Nothing here is
shaped by our own app (Often Enough): not its features, its code or its plans. A finding stands on the reviews alone.

## Layout

```
Review Insights/
  README.md                         ← this file
  <App>/
    README.md                       ← the app, its studies, and a summary of every year done
    <Study>/
      README.md                     ← the prompt: goal, rules, method and steps, so any agent can continue
      <App> <YEAR> — ….md           ← one report per year
      Tools/                        ← the scripts and hand-made maps behind the reports
```

## Apps

| App | Studies | Status |
|---|---|---|
| [Routinery](<Routinery/README.md>) | [User Groups — Who, Why, Paying](<Routinery/User Groups — Who, Why, Paying/README.md>) | 2019–2025 done; 2026 ready |

## Rules for every study here

- **From the labels, not from memory or our app.** Every number comes from `Review Labels/<App>/<YEAR>/labels.jsonl`
  and resolves to exact reviews (an appendix in each report).
- **"Not said" is never "no",** and every share carries its denominator.
- **People's own words**, quoted exactly with a translation.
- **One study's README is its prompt:** a new agent reads it and can carry on without this conversation.
- Work on `main` (the user, 26 November 2026).
