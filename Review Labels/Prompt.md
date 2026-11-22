# Prompt: Label Every Review (Pass 1)

Written by Claude (Claude Code), 22 November 2026, at the user's request. Prompt version **1** (the `prompt` field in
every label it makes). If you change the prompt, raise the version here and `PROMPT_VERSION` in `Tools/label.py`.

Copy everything inside the box. Change the two lines at the top: the app, and the year (or `all`). To run several
sessions at once, give each a different year; never two sessions on the same year.

````text
APP: Routinery
YEAR: all

You are labelling store reviews for the app named in APP above, in the repository at
/Users/lalith/Desktop/store reviews. The folder is "Review Labels/". Read "Review Labels/README.md" first: it has the
layout and every field. This prompt tells you how to do the reading.

## Why

We want to know WHO uses this app and WHY they chose it, which features drew them, whether they paid and why, and
what problems they have. You are labelling the data once, so that later research can search your labels instead of
reading the reviews again. Labels that are wrong, guessed or skipped spoil that research, so accuracy matters more
than speed.

## The one rule: one review at a time, completely

- Read every review, one by one, in the order the tool gives them (oldest year first, oldest review first; the tool
  refuses a label for any review except the next one in order). Read the whole review (title and text) before
  writing anything. Write its label, save it, and only then move to the next review.
- Never read ahead, never label several reviews at once, never skim, never skip a review because it is long, short,
  in another language or looks like the one before.
- Never write a script, regex or keyword search that labels reviews, and never label from the rating alone. A person's
  reading of each review is the whole point.
- Never edit labels.jsonl, progress.json or reviews.jsonl yourself. Only the tool writes them.
- Don't hand the reading to a subagent. You read every review yourself.

## The loop

1. Get the next review:

       cd "/Users/lalith/Desktop/store reviews"
       python3 "Review Labels/Tools/label.py" next "<APP>"            # YEAR: all
       python3 "Review Labels/Tools/label.py" next "<APP>" --year 2021  # one year

2. Read it fully. Answer the questions below for this review only.

3. Save its label by sending JSON on standard input (keep the quoted 'EOF' so apostrophes are safe):

       python3 "Review Labels/Tools/label.py" save "<APP>" <<'EOF'
       { …the label… }
       EOF

   Add --year 2021 to save if you were given one year, so you stay inside it.

4. If it says NOT SAVED, fix exactly what it lists and save again. Never weaken a label just to get it saved (for
   example by dropping a true finding because its quote was hard to copy): copy the quote properly instead.

5. A saved label prints the next review. Go back to step 2. Carry on until the tool says "All done".

To correct a label you already saved, send the whole corrected label with --replace. To look at one again:
python3 "Review Labels/Tools/label.py" show "<APP>" <review_id>. To see progress: status "<APP>".

## The label

Send exactly these fields. The tool adds the facts it copies from the review (store, date, rating, country, store
language, app version, helpful votes, developer reply): don't send those.

{
  "review_id": "the id printed above the review",
  "language": "en",
  "nothing_useful": false,
  "who": [],
  "why_chose": [],
  "chose_for": [],
  "liked": [],
  "came_from": [],
  "paid": {"status": "not_said", "why": null, "quote": null},
  "problems": [],
  "how_long_used": null,
  "still_using": {"status": "not_said", "quote": null},
  "note": null
}

### Field by field

language — the language the review is actually written in: en, es, de, fr, pt-BR, ko, ja, zh-TW, zh-CN … Use the
text itself, not the store language printed above it (Google files some reviews under the wrong language). und only
when there are no words (emoji only).

who — anything the person says about THEMSELVES or about the person they use the app FOR. One item per fact.
  - Counts: life stage (student, retired, new mum), job (nurse, teacher, freelancer), working pattern (night shifts,
    works from home), health or condition (ADHD, autism, depression, chronic illness, burnout), family (parent of
    three, carer), age if they say it, situation (just moved, recovering from surgery, training for a marathon), and
    whom it's for ("for my son", "my partner and I", "my students").
  - Write it in plain words, with "uses it for …" when it's for someone else: "parent; sets routines for her son".
  - Only what the review states. Never guess from the author's name, writing style, rating or language. "I" alone
    tells you nothing. If they don't say, leave it empty.
  - Record every group the review states, ADHD included. Don't leave anyone out because of what we expect.

why_chose — why they came to this app or use it: the need, goal, struggle, situation or recommendation behind it.
  "couldn't get out of bed on time", "wanted a calmer evening", "therapist recommended it", "saw it on TikTok",
  "needed structure after losing my job". One item per reason. This is the need, not a feature.

chose_for — features they say made them PICK this app or switch to it ("downloaded it because it times each step",
  "the only app that reads the steps out loud"). A feature they simply like goes in liked instead.

liked — features or qualities they praise while using it ("love the timer", "the design is calm", "the widget").
  Name the feature plainly. "Good app" or "love it" alone is not a feature: leave liked empty for that.

came_from — another app, tool or method they moved from or compare against as their old way: an app's name, "paper
  planner", "phone alarms", "Notion". Leave out apps they only mention in passing.

paid — whether they paid, and why.
  - status:
      paid                  they bought, subscribed or say they pay
      trial                 they're on a free trial now
      charged_unexpectedly  charged without meaning to (a trial that turned into a charge, a charge they didn't
                            agree to, charged after cancelling)
      refused               they say they won't pay, or the price put them off
      free                  they say they use the free version
      not_said              the review says nothing about paying (most reviews)
  - why: the reason they give for that status, in plain words ("worth it for unlimited routines", "too expensive for
    a timer app"), or null when they give none.
  - quote: required unless not_said; null when not_said.
  - Complaints that it costs too much go here as refused, if they didn't pay, AND in problems as a dislike.

problems — every separate problem, one item each, with kind:
      broken   something doesn't work (crashes, reminders don't come, lost data, sync fails)
      missing  something they want that isn't there ("no way to repeat every other day", "wish it had a widget")
      dislike  it works, but they don't like it (too many steps, too expensive, ads, the paywall, the design)
  Write each problem plainly and specifically: "reminders stop after an update", not "bugs".

how_long_used — only if they say: {"value": "about two years", "quote": "…"}. "first day", "a week", "since 2020".
  Otherwise null.

still_using — using (they use it now), came_back (left and returned), about_to_quit, quit (deleted it, stopped,
  cancelled), not_said. Quote required unless not_said.

nothing_useful — true only when the review says nothing for any field ("great app", "👍", "ok"). Then every list is
  empty, paid and still_using are not_said and how_long_used is null. If anything is recorded, it's false.

note — one short sentence a later reader must know, or null: "sarcastic", "about a different app", "review is a
  question to the developer", "partly unreadable", "same words as another review". Don't use it for findings: those go
  in the fields.

### Quotes

- Every item carries a quote: the shortest part of the review that proves it, copied exactly, word for word, from the
  title or the text, in the review's own language. Don't translate it, fix its spelling, or join two separate parts.
- Several items may use the same quote when one sentence proves them all.
- The tool checks every quote against the review and refuses one that isn't there.

### Plain words

- Labels, reasons, features, problems and paid reasons are in English, even for a review in another language, in at
  most 15 words, in the reviewer's meaning: what they said, not what you think it means for us.
- Don't invent, add or stretch. If you're unsure whether something is said, leave it out (or say so in note).
- Don't judge the person or the app. "Not said" is not "no": an empty field means the review doesn't say.
- Don't group or rename things into categories now. That's pass 2. Keep each answer in the reviewer's terms.

### Hard cases

- A review in a language you read less well: read it carefully and label what you can be sure of. Use note for
  anything uncertain.
- Mixed reviews: record both what they like and what's wrong. The rating doesn't decide anything.
- A review that's really about another app, or spam: label what it says about this app (often nothing), and say so in
  note.
- A duplicate (the tool prints a NOTE): label it anyway, on its own.
- A long review: read all of it. Long reviews hold the most about who and why.

## Stopping and starting again

Everything is saved after each review, so you can stop at any time. A new session runs the same prompt: next always
gives the first review without a label. Never start a year that another session is reading.

## When it says "All done"

Run status "<APP>" and report, in plain words: how many reviews were labelled, any you found hard and why, and anything
in the prompt or the fields that didn't fit what people wrote. Don't commit; the user decides.
````
