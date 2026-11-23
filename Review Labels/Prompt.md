# Prompt: Label Every Review (Pass 1)

Written by Claude (Claude Code), 22 November 2026, at the user's request. Prompt version **2** since 23 November 2026,
when "Calls settled while labelling" was added (the `prompt` field in
every label it makes). If you change the prompt, raise the version here and `PROMPT_VERSION` in `Tools/label.py`.

## How it runs (from 23 November 2026)

One cycle labels and checks 50 reviews, then saves them to GitHub:

1. **Two Sonnet agents label, side by side.** The main chat reserves two blocks of 25 reviews (`claim`) and starts two
   Claude Sonnet 5.5 agents (high effort) at the same time, one per block. Each labels its 25 reviews one at a time,
   in order, with the tool, exactly as the labeller's instructions say. Every label is saved in the year's files the
   moment it's made, so nothing has to be handed over.
2. **One Opus agent checks.** Once both have finished, a fresh Claude Opus 5.5 agent (high effort) reads the standard
   (README and the labeller's instructions), checks the 50 new labels on two check pages (`page`: 25 reviews in full,
   each with its label on one line), corrects wrong labels with `save --replace`, marks each page checked (`checked`),
   and replies in one line.
3. **The main chat commits and pushes** the checked labels to `main`, then starts the next cycle.

**The main chat (Claude Opus 5.5, high effort) only orchestrates.** It reads only the agents' one-line replies and the
tool's `status`. It never reads reviews, labels or check pages, so it grows by about 1,000 tokens per cycle and one
chat can run a whole year. **Never more than two agents run at once**, and the checker never runs while a labeller
does.

Why these numbers:

- **25 per Sonnet agent:** its chat grows about 2,000 tokens per review, so a fresh agent every 25 keeps each call
  small.
- **25 per page, 50 per checker:** a page of 25 is about 10,000–15,000 tokens, small enough to read every review and
  label properly; a page with long reviews stops early (20,000 characters of review text) and the rest come on the
  next page, so nothing is skimmed. Each checker re-reads the standard (about 15,000 tokens), so giving it two pages
  halves that cost while keeping it small.
- **One main chat per year:** it only holds short replies. Start a fresh one for the next year.

Nothing is lost if a chat or agent stops: `status` shows, for every year, how many reviews are labelled and checked
and any open claim with reviews still to label; the next chat finishes those first.

## How to start a chat

Start a fresh chat with Claude Opus 5.5 at high effort and paste this starter, changing the values in square
brackets. The chat reads this file, so a rule added here reaches every later chat without changing the starter. Run
one chat per year; never two chats on the same year.

````text
Orchestrate store review labelling. Read "Review Labels/Prompt.md" and follow everything inside its box "The
orchestrator's instructions" exactly. Don't read the other boxes: the agents read those.

APP: [Routinery]
YEAR: [2023]

Repository: C:\Users\lalit\Desktop\store-reviews (Windows; Git Bash).
````

## The orchestrator's instructions (the main Opus chat)

````text
APP and YEAR are given in the starter message. Repository: C:\Users\lalit\Desktop\store-reviews. Run the tool from the
repository root in Git Bash as: PYTHONUTF8=1 python "Review Labels/Tools/label.py" <command> "<APP>" …

Your job is only to run agents and save their work. You never read reviews, labels, check pages or the other boxes in
this file, and you never label or correct a label yourself. Keep this chat small: no summaries beyond the lines below.

Never more than two agents at once. The two labellers run together; the checker runs only after both have finished,
on its own; the commit comes only after the checker has finished. Wait for each step before the next.

Repeat this cycle until the year is done:

1. Run  status "<APP>". Read YEAR's line ("N of T labelled · C checked") and any "open claim" lines under it.
   - Open claims with reviews left (a chat or agent stopped early): give those claims to the labellers in step 2
     instead of making new ones.
   - If C is less than N and there is no open claim: labels are waiting to be checked; go to step 3.
   - If N equals T, C equals N and there is no open claim: the year is done; go to step 6.

2. Labellers. Make two claims, one after the other:  claim "<APP>" --year <YEAR> --count 25  (each prints
   "Claimed 25 reviews in <YEAR>: <CLAIM>"). If the year has fewer than 26 reviews left, make one claim and start one
   labeller. Then start one labeller per claim in the same message, so they run side by side: the Agent tool,
   subagent_type general-purpose, model sonnet, effort high, foreground. Give each exactly this brief, with APP, YEAR
   and its own CLAIM filled in:

     Label store reviews. Read "Review Labels/Prompt.md" and follow everything inside its box "The labeller's
     instructions" exactly. APP: <APP>. YEAR: <YEAR>. CLAIM: <CLAIM>. Repository: C:\Users\lalit\Desktop\store-reviews
     (Windows; Git Bash). Label every review in your claim, one at a time, saving each with the tool, until it says
     the claim is done; then reply in one line: how many you saved, and the ids of any you found hard.

   Wait for both. If one stops before its claim is done, start one labeller again for that claim.

3. Checker. Start one checker on its own: the Agent tool, subagent_type general-purpose, model opus, effort high,
   foreground. Give it exactly this brief, with APP and YEAR filled in:

     Check store review labels. Read "Review Labels/Prompt.md" and follow everything inside its box "The checker's
     instructions" exactly. APP: <APP>. YEAR: <YEAR>. Repository: C:\Users\lalit\Desktop\store-reviews (Windows; Git
     Bash). Reply in one line, as that box says.

4. Commit and push, once the checker has replied. Run  status "<APP>"  for the counts, then from the repository root:

     git add "Review Labels/<APP>" "Review Labels/Prompt.md"
     git commit -m "Review Labels: <APP> <YEAR> <N> of <T> labelled and checked [skip ci]" -m "Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>"
     git pull --rebase origin main
     git push origin main

   Commit only those paths; never another session's files. If the pull or the push fails (a conflict, a rejection),
   stop and tell the user in one line; never force a push.

5. Write one line:  2023: 628 of 1,763 done, 4,723 left. Checked 50, corrected 4 (paid 2, still_using 2). Pushed.
   Take the counts from status and the kinds from the checker's reply.

   If the same kind of correction appears in two checkers' replies (or three times in one), add a rule for it before
   the next cycle: read only the section "Calls settled while labelling" in this file, add one short line with the
   date that would have prevented it, and say so in one line. The next commit carries it.

6. Go back to step 1. When the year is done: write the final progress line, the total checked and corrected in this
   chat and the main kinds of correction, and stop.
````

## The checker's instructions (the Opus agent)

````text
APP and YEAR are given in the message that started you. Repository: C:\Users\lalit\Desktop\store-reviews. Run the tool
from the repository root in Git Bash as: PYTHONUTF8=1 python "Review Labels/Tools/label.py" <command> "<APP>" …

You don't label reviews. Sonnet agents label them, one review at a time; you read every label they saved and correct
the wrong ones. Accuracy is the point: a wrong paid status, an invented who or a missed problem spoils later research.

First, read "Review Labels/README.md" and the box "The labeller's instructions" in this file, all of it, including
"Calls settled while labelling". They are the standard you check against.

Then, page by page:

1. Run  page "<APP>" --year <YEAR>. It shows up to 25 saved labels not yet checked, each review in full with its label
   on one line. If it says there is nothing to check, go to step 4.

2. Read every review in full and its label against the standard. A label is wrong when it breaks a rule or misreads
   the review: a wrong paid or still_using status, a who that isn't first-person or is guessed, a problem or liked
   item that is missing, merged or invented, a claim from outside the review in note, nothing_useful set wrongly, the
   wrong language. A call where two readings both fit the rules is not wrong: leave it. For each wrong label, send
   the whole corrected label (all thirteen fields, as in the labeller's instructions) with
   save "<APP>" --year <YEAR> --replace. Change only what is wrong; don't reword labels that are right.

3. Run  checked "<APP>"  to mark the page checked. Go back to step 1.

4. Reply in exactly one line:  Checked 50, corrected 4: paid 2, still_using 2 (ids: 9861014690, 05bae83b-…).
   Name each kind of correction by its field. Don't commit, and never label a review that has no label yet.
````

## The labeller's instructions (the Sonnet agent)

````text
APP, YEAR and CLAIM are given in the message that started you. CLAIM is your own block of reviews: another labeller
may be working on the next block at the same time, so add  --claim <CLAIM>  to every next and save (in place of
--year), and stop when the tool says the claim is done. (Labelling in a chat of your own, with no CLAIM: use --year,
and stop after the number of reviews the user gave.)

You are labelling store reviews for the app named in APP, in the repository at C:\Users\lalit\Desktop\store-reviews
(on the Mac: /Users/lalith/Desktop/store reviews). The folder is "Review Labels/". Read "Review Labels/README.md"
first: it has the layout and every field. This prompt tells you how to do the reading.

On Windows run the tool from the repository root in Git Bash as `PYTHONUTF8=1 python "Review Labels/Tools/label.py" …`
(PYTHONUTF8=1 keeps Korean, Japanese and other scripts intact); on the Mac use `python3 "Review Labels/Tools/label.py" …`.

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

1. Get the next review (from the repository root, /c/Users/lalit/Desktop/store-reviews):

       PYTHONUTF8=1 python "Review Labels/Tools/label.py" next "<APP>" --claim <CLAIM>   # an agent with a claim
       PYTHONUTF8=1 python "Review Labels/Tools/label.py" next "<APP>" --year 2023       # a chat of your own

2. Read it fully. Answer the questions below for this review only.

3. Save its label by sending JSON on standard input (keep the quoted 'EOF' so apostrophes are safe):

       PYTHONUTF8=1 python "Review Labels/Tools/label.py" save "<APP>" --claim <CLAIM> <<'EOF'
       { …the label… }
       EOF

   With no claim, use --year in its place (leave it out when YEAR is all).

4. If it says NOT SAVED, fix exactly what it lists and save again. Never weaken a label just to get it saved (for
   example by dropping a true finding because its quote was hard to copy): copy the quote properly instead.

5. A saved label prints the next review. Go back to step 2. Carry on until the tool says the claim is done (or, in a
   chat of your own, until you have saved the number the user gave, or the tool says "All done").

When you stop: reply in one line, how many you saved and the ids of any you found hard (in a chat of your own, the
progress line `2023: 603 of 1,763 done, 4,748 left.` from the tool's numbers, about every six reviews and at the
end). Don't commit.

To correct a label you already saved, send the whole corrected label with --replace (after the app name:
`save "<APP>" --year 2023 --replace`). To look at one again: `show "<APP>" <review_id>`. To see progress:
`status "<APP>"`.

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
- An edited review (EDIT, UPDATE, "updating my review"): label every part, the newest update as carefully as the
  original. Say in note which problems are from the older part if the update says they were fixed.

### Calls settled while labelling (prompt 2, 23 November 2026)

Learned on Routinery, from a side-by-side check of 50 hard reviews. Follow them so every label is made the same way.

- who: first-person facts only. "Great for people with ADHD" is a general claim: note, not who. Devices they say
  they use (a watch, an iPad) count as facts about themselves.
- paid:
  - "Worth it" or "a good price" with no purchase stated → not_said, and say so in note.
  - "Would pay if it improves" → not_said, with the condition in note; it isn't refused. With a plain "but not now"
    or "I won't until then" it is refused, the condition as why.
  - A price complaint from someone who says they won't pay, or whom the price or paywall put off ("got pay walled
    way too quick", "I will move on without a lifetime option") → refused, and a dislike in problems.
  - (23 Nov 2026) "I would love to upgrade, but [the price, glitches]" → refused, what holds them back as why.
  - A price complaint that doesn't say whether they pay → not_said, and a dislike in problems.
  - "I like that two routines are free" alone isn't free: free needs them to say they use the free version.
  - (23 Nov 2026) Saying the free version works or is enough for them ("functional for me", "enough for me") → free.
- still_using: a present-tense line about their own use ("it helps me so much", "I use it every morning") → using,
  with that line as the quote. quit only when they say they stopped, deleted, cancelled or uninstalled; a general
  put-down ("pen and paper will do") isn't quit. A line like "I won't keep paying" or "I'm looking for something new"
  is about_to_quit.
  (23 Nov 2026) This holds without the words "I use it": a present-tense line about what the app does for them now
  ("I feel so much more organized with this app", "elle m'aide vraiment à suivre mes routines") → using, even when
  the rest of the review is about price or the free version. It holds inside a bug report too ("now it just loads
  and loads when I open it", "notifications come while I'm doing a routine") → using.
  (23 Nov 2026) A present-tense complaint about what the app does or fails to do for them now, in any language
  ("no me notifica", "the alarm still rings") → using; not_said only when every line is past tense or general.
  (23 Nov 2026) Still missed on non-English reviews: before choosing not_said, check every line for present tense.
- liked: one item per thing they praise or per way life got better ("room is tidy", "eats breakfast before work").
- note: only what the review says or how it reads. Never a claim from outside the review (what a version number
  means, what other apps do), and never names or phone numbers.
  (23 Nov 2026) Never put a finding in note or repeat one: what they use the app for goes in why_chose, problems
  only in problems. A phrase that can be read two ways is called unclear in note, never settled as one reading.
- Quotes: avoid parts containing HTML entities (`&#39;`, `&amp;`); pick another part of the same sentence.
  (23 Nov 2026) Each item says only what its own quote proves, and the quote is about this app and their own use.
  Fixes they tried for one problem belong in that problem's item, not a new one.
  (23 Nov 2026) A quote starts and ends on whole words; never cut into a word.

## Stopping and starting again

Everything is saved after each review, so you can stop at any time. A claim keeps its reviews for you: if you stop
early, the next labeller carries on with the same claim. Never work on a claim or year that another labeller is on.

## When it says "All done"

Reply as in "When you stop" above, adding anything in the prompt or the fields that didn't fit what people wrote.
````
