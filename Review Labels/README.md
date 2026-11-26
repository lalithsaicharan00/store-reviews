# Review Labels

Written by Claude (Claude Code), 22 November 2026, at the user's request.

Store reviews, read one at a time by an AI and labelled with **who the person is, why they chose the app, which
features, whether they paid and why, and what problems they have**. Labelled once, so any later research can search
the labels instead of reading the reviews again.

What the labels add up to (user groups, reasons, paying) is written up in [`Review Insights/`](<../Review Insights/README.md>).

This folder is new and stands on its own. The older review folders under `Research/` stay as they are (read-only) and
are only the source the year files are built from.

## Layout

```
Review Labels/
  README.md          ← this file: the layout and every field
  Prompt.md          ← the starter and the instructions: an Opus chat orchestrates, two Sonnet agents
                       label, an Opus agent checks, the chat commits and pushes (pass 1)
  Tools/
    build_app.py     ← builds an app's year folders from the raw store files
    label.py         ← shows the next review, checks a label, saves it; check pages for the checker
  Routinery/
    App.md           ← the app's names, IDs, collection dates, counts
    sources.json     ← which raw files it's built from
    2019/
      reviews.jsonl  ← that year's reviews, both stores, oldest first
      labels.jsonl   ← one label per review, written by label.py
      progress.json  ← how far the reading has got (written by label.py)
      checked.jsonl  ← labels the checker has read (written by label.py; labels made before
                       23 Nov 2026 were made by Opus and marked checked at once)
      claims.json    ← blocks of reviews reserved for labellers working side by side (written by
                       label.py; gone once every claim is labelled)
      page.json      ← only while a check page is open (written by label.py; not committed)
    2020/ … 2026/
```

- **One folder per app**, with no split by store. Each record says which store it came from.
- **One folder per year**, from the review's own date. When newer reviews are collected, they go on the end of the
  latest year and into new years (`build_app.py` keeps what's there and adds the rest), so it's always clear what has
  been collected and labelled.
- Files are JSONL: one JSON object per line.

## reviews.jsonl: one review per line

Built by `build_app.py`, never edited by hand.

| Field | App Store | Google Play |
|---|---|---|
| `review_id` | ✓ | ✓ |
| `store` | `appstore` | `play` |
| `date` | ✓ (UTC) | ✓ (UTC) |
| `rating` | 1–5 | 1–5 |
| `title` | ✓ | always null (Play has no titles) |
| `text` | ✓ | ✓ |
| `author` | ✓ | ✓ |
| `country`, `country_name` | ✓ (the storefront) | null (Play doesn't give it) |
| `store_language`, `store_language_name` | null | ✓ (the language Google filed it under; the text can be another) |
| `app_version` | null | ✓ when Play gives it |
| `helpful_votes` | ✓ (`vote_sum`) | ✓ (thumbs up) |
| `votes_total` | ✓ (`vote_count`) | null |
| `developer_reply` | null | ✓ text, or null |
| `is_edited` | ✓ | null |
| `duplicate_of` | the earlier review's ID when the same author posted the same words; otherwise null | same |

## labels.jsonl: one label per review

Written only by `label.py save`. The reader writes the fields marked *reader*; the tool copies the rest from the
review, so they can't be mistyped.

```json
{
  "schema": 1, "prompt": 1, "app": "Routinery",
  "review_id": "…", "store": "play", "date": "2021-03-19T05:52:27Z", "year": 2021, "rating": 5,
  "country": null, "store_language": "en", "app_version": "3.5.1", "helpful_votes": 12,
  "developer_replied": true, "duplicate_of": null,

  "language": "en",
  "nothing_useful": false,
  "who":        [{"label": "nurse working night shifts", "quote": "as a nurse working nights"}],
  "why_chose":  [{"reason": "couldn't get going in the mornings", "quote": "…"}],
  "chose_for":  [{"feature": "timer for each step of a routine", "quote": "…"}],
  "liked":      [{"feature": "voice that reads the next step", "quote": "…"}],
  "came_from":  [{"app": "Fabulous", "quote": "…"}],
  "paid":       {"status": "paid", "why": "worth it for unlimited routines", "quote": "…"},
  "problems":   [{"problem": "reminders stopped after an update", "kind": "broken", "quote": "…"}],
  "how_long_used": {"value": "about two years", "quote": "…"},
  "still_using":   {"status": "using", "quote": "…"},
  "note": null,
  "labelled_at": "2026-11-22T07:04:39Z"
}
```

| Field | Who writes it | What it holds |
|---|---|---|
| `schema` | tool | Version of this record shape (1) |
| `prompt` | tool | Version of the prompt that made the label (1). When the prompt changes, older labels can be told apart |
| `app` … `duplicate_of` | tool | Copied from the review. `developer_replied` is true or false |
| `language` | reader | The language the review is actually written in (`en`, `es`, `pt-BR`, `zh-TW`; `und` for emoji only) |
| `nothing_useful` | reader | True only when every field below is empty ("great app", "👍") |
| `who` | reader | What the person says about themselves: life stage, job, condition, family, situation, and whom they use the app for |
| `why_chose` | reader | Why they came to the app or use it: the need, goal, struggle or recommendation |
| `chose_for` | reader | Features they say made them pick the app or switch to it |
| `liked` | reader | Features they praise while using it |
| `came_from` | reader | Apps or tools they moved from (another app, paper, a planner) |
| `paid.status` | reader | `paid`, `trial`, `charged_unexpectedly`, `refused`, `free` or `not_said` |
| `paid.why` | reader | The reason they give for that status, or null |
| `problems` | reader | One entry per problem; `kind` is `broken` (doesn't work), `missing` (wanted but not there) or `dislike` (works, but they don't like it, price included) |
| `how_long_used` | reader | How long they've used it, in their terms, or null |
| `still_using.status` | reader | `using`, `came_back`, `about_to_quit`, `quit` or `not_said` |
| `note` | reader | Anything a later reader must know (sarcasm, about another app, couldn't read it), or null |
| `labelled_at` | tool | When it was saved |

Every label, reason, feature, app, problem and paid reason carries a **quote**: words copied exactly from the review's
title or text, in its own language. `label.py` refuses any quote that isn't in the review. Labels themselves are in
English, in plain words.

"Not said" is never the same as "no": an empty list or `not_said` means the review doesn't say.

## Pass 2 (later)

Pass 1 writes each answer in the reviewer's terms. Once a whole app is read, pass 2 groups those answers into fixed
lists (who: student, parent, shift worker …; problems: reminders, sync, price …) written down in a `Groups.md` here,
and adds a `group` next to each item. The lists come from what people actually said, never guessed beforehand.

## Using it

- The reading is strictly in order: `label.py save` accepts only the review `next` shows (oldest year, oldest review
  first), so nothing is skipped or read out of turn.
- Read the next review: `python3 "Review Labels/Tools/label.py" next Routinery`
- How far it's got: `python3 "Review Labels/Tools/label.py" status Routinery`
- One review and its label: `python3 "Review Labels/Tools/label.py" show Routinery <review_id>`
- Query everything with SQL, without a database: DuckDB reads the files as they are, for example
  `SELECT * FROM read_json_auto('Review Labels/*/*/labels.jsonl') WHERE paid.status = 'paid'`.

## Adding an app

1. Make `Review Labels/<App>/` with a `sources.json` like Routinery's (each store's raw `reviews.jsonl`) and an `App.md`.
2. `python3 "Review Labels/Tools/build_app.py" <App>`.
3. Give a reader [Prompt.md](Prompt.md) with the app's name.
