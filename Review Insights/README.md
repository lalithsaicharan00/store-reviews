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
| [Routinery](<Routinery/README.md>) | [User Groups — Who, Why, Paying](<Routinery/User Groups — Who, Why, Paying/README.md>) <br>[Routine Player — Helps and Dislikes](<Routinery/Routine Player — Helps and Dislikes/README.md>) | User groups 2019–2026 done; [final report](<Routinery/User Groups — Who, Why, Paying/Routinery 2019–2026 — Final Report — User Groups, Why They Use It, and What They Pay For.md>); routine player [report](<Routinery/Routine Player — Helps and Dislikes/Routinery — Routine Player — What Helps and What Users Dislike.md>) done 28 Nov 2026 |

## Rules for every study here

- **From the labels, not from memory or our app.** Every number comes from `Review Labels/<App>/<YEAR>/labels.jsonl`
  and resolves to exact reviews (an appendix in each report).
- **Every app is its own analysis** (the user, 27 November 2026: *"It is a separate app and separate analysis … It
  should be unique to its"*). Its groups, feature kinds and findings come from its own labels only; one study's
  process can be reused, never another app's groups.
- **"Not said" is never "no",** and every share carries its denominator.
- **People's own words**, quoted exactly with a translation.
- **One study's README is its prompt:** a new agent reads it and can carry on without this conversation.
- Work on `main` (the user, 26 November 2026).
