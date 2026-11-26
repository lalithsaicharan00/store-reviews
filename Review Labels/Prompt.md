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
  (23 Nov 2026, Routinery 2024, missed in two checks) A fact said in passing counts too ("before I go to school",
  "after my shift"): student, shift worker. Check every "I"/"my" line before leaving who empty.
  (23 Nov 2026, Routinery 2024) How they use the app goes in why_chose, never in who ("relying on it to build routines").
  (25 Nov 2026, MyRoutine 2022, in two checks) A who item holds the fact alone ("studies", "uses a Galaxy phone"),
  never with how they found or use the app tacked on ("looked for a study planner", "as a widget").
  (25 Nov 2026, MyRoutine 2022, three in one check) A "for example, if you want to…" line about a feature is no who
  fact; an age said in passing ("lived 2n years without this app") is one: in their twenties.
  (24 Nov 2026, Routinery 2025) A sleep or daily pattern said in passing ("sometimes I fall asleep at 8,9,10,11") is a who item.
  (24 Nov 2026, Routinery 2026, three in one check) Each fact once, from their own first-person words: never a second
  item that infers it again, never one from a bare title word ("ADHD") or one note calls unclear; a gender they state
  ("I was the girl") counts.
  (24 Nov 2026, Routinery 2025) So is work shown only as one of their own routine steps ("check in with team - 30
  minutes" → works with a team).
  (24 Nov 2026, Routinery 2025, again) And a job or school named only as what a routine or feature is for ("routines
  for studying" → studies; "timer for work tasks" → works).
  (24 Nov 2026, Routinery 2026, missed in two checks) Work, school or family named as a time or place ("before I go
  out to work", "when the kids are asleep") is a who item too: works outside the home, parent.
  (24 Nov 2026, Routinery 2026, missed again) A line about "a person" or "people" isn't first-person: never in
  who or why_chose; at most note, as unclear.
  (24 Nov 2026, Routinery 2026, missed again) "On my day off", "my commute" and the like are who items too.
  (24 Nov 2026, Routinery 2026) Never a gender (he, she, mum) they don't say; "parent", "person" when unsure.
  (24 Nov 2026, Routinery 2025, in two checks) A personality type ("my MBTI"), a supplement, medication or health
  remark about themselves is a who item; a job or school word in a line about people in general never is.
  (24 Nov 2026, Routinery 2025, again) So is any personal practice in their own routine ("my morning routine includes
  praying"). A who item holds only what its first-person quote shows; a "you" or "if you" line adds nothing.
  (24 Nov 2026, Routinery 2025, again) A title with I/me/my that names their condition ("Protects me from time
  blindness") is a who item; only a bare title word with no I/me/my isn't.
  (24 Nov 2026, Routinery 2025, three in one check) A fix or test they tried ("checked on two other phones") is never
  a who item; seasonal and weekly patterns count like daily ones; a who quote reaches the I/my words, not a "you" phrase.
  (24 Nov 2026, Routinery 2025) A gender shown by their own grammar ("me stessa", "cansada") counts as stated.
  (24 Nov 2026, Routinery 2025, in two checks) A device or a family member is a who item only when they say it's
  theirs (I/my): never from a device named in a complaint ("no Split View on iPad"), and never with a gender unsaid.
  (24 Nov 2026, Routinery 2025, missed again) That includes a device or OS version in a bug report ("Android version 16").
  (25 Nov 2026, MyRoutine 2023, in two checks) Even "아이폰 13이에요" said with a bug goes in that bug's item and quote,
  never who; app-hopping history ("유목민 출신") goes in why_chose and came_from, never who.
- paid:
  - "Worth it" or "a good price" with no purchase stated → not_said, and say so in note.
  - "Would pay if it improves" → not_said, with the condition in note; it isn't refused. With a plain "but not now"
    or "I won't until then" it is refused, the condition as why.
  - A price complaint from someone who says they won't pay, or whom the price or paywall put off ("got pay walled
    way too quick", "I will move on without a lifetime option") → refused, and a dislike in problems.
  - (23 Nov 2026) "I would love to upgrade, but [the price, glitches]" → refused, what holds them back as why.
  - (24 Nov 2026, Routinery 2026) Put off by how paying works (a trial that renews by itself, a card asked for
    up front) → refused, that as why.
    (24 Nov 2026, Routinery 2026, missed again) Yearly billing hidden in a trial counts: refused, never not_said.
    (24 Nov 2026, Routinery 2026) "I thought I had to pay, but it's free for me" → free, never only in note.
  - A price complaint that doesn't say whether they pay → not_said, and a dislike in problems.
  - "I like that two routines are free" alone isn't free: free needs them to say they use the free version.
    (23 Nov 2026, Routinery 2024, missed again) Praise of what's free ("great free usability", "all the essential
    features are free") → not_said.
  - (23 Nov 2026) Saying the free version works or is enough for them ("functional for me", "enough for me") → free.
    (23 Nov 2026, missed in two checks) This includes "the free limit hasn't affected me much": free, that line as
    why, never only in note. "Worth the subscription" with no purchase stated stays not_said.
    (23 Nov 2026, Routinery 2024, missed twice in one check) "The free limit is fine for me" → free, even when
    the rest of the review is about features or bugs.
    (23 Nov 2026, Routinery 2024) "Glad I didn't pay" → free, never only in note. A request for a refund → paid
    (nothing_useful false), the request as quote.
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
  (23 Nov 2026, still missed in two checks) A complaint about what the app does now counts even after "it used to
  work" or "there are errors" → using. quit needs them to say they stopped; "I do better without it" alone isn't.
  (24 Nov 2026, Routinery 2026, three non-English in one check) In any language, "I like…" or "it has stopped
  loading" ("Me gusta que…", "перестало прогружаться") → using; "I can't use it" ("못 쓰겠습니다") → about_to_quit.
  (23 Nov 2026, Routinery 2024, three in one check) A line saying they're leaving, won't carry on, or the app is "not
  for me" beats a present-tense complaint or recommendation → about_to_quit, with that line as the quote ("Not going
  to waste another hour remaking it"). A using quote is about their own use, not their phone or advice to others.
  (23 Nov 2026, Routinery 2024) A return after a long gap ("when I opened it after a long time") → came_back, never not_said.
  (23 Nov 2026, Routinery 2024, missed in every check) A one-line review that only says they use or love it ("I really
  like using this app") → using with that line as the quote, so nothing_useful is false.
  (23 Nov 2026, Routinery 2024) Present perfect about their own use ("It has helped me improve my daily routines") → using.
  (24 Nov 2026, Routinery 2025) A promise to come back and change the review ("I'll come back and give it 5 stars")
  isn't about_to_quit: judge still_using from their present-tense lines about their own use.
  (23 Nov 2026, Routinery 2024) So is a love line in another language's past tense ("amei") and a present line about how
  their life is now ("I'm eating correctly again") → using.
  (24 Nov 2026, Routinery 2026, two in one check) In every language a one-line love or thanks review ("gostei",
  "人生が変わった") → using with that line as the quote, so nothing_useful is false.
  But the line must be about their own use ("I love it", "gostei"): "best app ever" or "great app" alone isn't,
  and stays nothing_useful.
  (24 Nov 2026, Routinery 2026, two in one check) Japanese and Korean plain or polite present forms (〜ない, 〜ます,
  〜ている, 안 돼요) about what the app does for them now are present tense → using.
  (24 Nov 2026, Routinery 2026) The using quote is the present-tense line itself, never a past-tense one.
  (24 Nov 2026, Routinery 2026) Trying or asking how to cancel → about_to_quit, never using.
  (24 Nov 2026, Routinery 2026) So is "it makes me not want to use it" or "I'm losing interest" → about_to_quit.
  (23 Nov 2026, six missed in one check) Also using: a present line about their own plight with the app ("I
  understand nothing", "where is my routine?", "I have to translate"), a recurring complaint ("whenever an update
  comes out it won't open"), and "has started crashing" even if support then fixed it. Recommending isn't a quote
  for using.
  (23 Nov 2026, Routinery 2024, missed in two checks) A present-tense line of enjoyment or help ("I love the timer",
  "it helps me a lot with my mornings") or "the free version works for me" is also using, besides liked or free.
  (23 Nov 2026, Routinery 2024, missed again) So is a present-tense line about their own routines in the app ("my
  routines are …"). Before saving not_said, name to yourself every present-tense line; any about their own use wins.
  But "I'll look for something better" or "I'm looking for another app" beats a present complaint → about_to_quit.
  And "I used it years ago and came back" beats using → came_back.
  (24 Nov 2026, Routinery 2026, missed in two checks) "It doesn't work for me" beats a present-tense line →
  about_to_quit. With no such line, any present-tense line about their own use → using, never not_said.
  (24 Nov 2026, Routinery 2025, in two checks) The using quote is never about someone they set it up for ("my son
  uses it") or general praise ("real good features for free"); "I love how…" → using; "stopped … to delete the
  app" → quit.
  (24 Nov 2026, Routinery 2025, again) A one-line feeling about their own find or use ("so blessed to meet this
  amazing app") → using; the using quote is never a "would" or "if" line.
  (24 Nov 2026, Routinery 2025, again) In every language, if the only present-tense line is general praise with no
  I/me/my ("otherwise super"), still_using is not_said.
  (24 Nov 2026, Routinery 2025, three non-English in one check) A present-tense complaint about what they meet in the
  app ("そこだけ気になる", "mes yeux saignent") → using, never not_said.
  (24 Nov 2026, Routinery 2025, four in one check) A using quote is never a "you" line ("you have to switch it off");
  "it ruined the app for me" → about_to_quit.
  (24 Nov 2026, Routinery 2025, again) "Thank you for creating this" and a past-form love line ("achei maravilhoso")
  → using, never not_said; "you're ruining your app" → about_to_quit.
  (24 Nov 2026, Routinery 2025, in two checks) The using quote is about this app now (a present complaint counts),
  never a general habit ("I tend to use timers") or a wish or "if" line ("I wish it supported…").
  (24 Nov 2026, Routinery 2025, four in one check) Pick the still_using quote first and let it set the status: a
  present complaint ("it's stuck all the time") is using; "unusable" or "won't pay until it's fixed" is about_to_quit;
  a past-tense line ("helped me stay focused") with no present one is not_said.
  (24 Nov 2026, Routinery 2025, again) "Useless" or "useless now" about the app reads as "unusable": about_to_quit.
  (24 Nov 2026, Routinery 2025, again) A past-tense result ("made me…", "saved my life") is never the using quote:
  with no present-tense or love line about their own use, still_using is not_said.
  (24 Nov 2026, Routinery 2025, four in one check) A thank-you line, even alone ("thanks to the developers who made
  it"), and an "I love" in the title → using, so nothing_useful is false.
  (24 Nov 2026, MyRoutine 2021, in two checks) "I keep using another app instead" (다른 어플을 계속 사용하게 되네요)
  or asking for a refund of the unused months → about_to_quit, never using. Korean ~더라구요 ("it turned out…") is
  past tense: never the using quote.
  (24 Nov 2026, MyRoutine 2020, in two checks) Korean list endings about the app (-음, -됨, -긺: "삭제가 안 됨") are
  present tense, so using; pick a present complaint over general praise ("참 좋죠") as the quote.
  (25 Nov 2026, MyRoutine 2022, in two checks) A closing thank-you is using even when the rest is past tense, and so
  is a mild present-tense complaint ("좀 그렇네요").
- why_chose (24 Nov 2026, Routinery 2026, missed in two checks): how they found the app ("downloaded it after
  reading the reviews", "saw it on TikTok") is an item. Each item says only what its quote shows, never a hope.
  Advice to others ("everyone should try it") is never their own reason.
  (24 Nov 2026, Routinery 2026, two in one check) A struggle from before the app, said in passing ("I always
  forgot my meds"), is an item too. The title counts as much as the text, for every field.
  (24 Nov 2026, Routinery 2026, two in one check again) Before saving, look for any line about their life before
  the app ("I used to…", "I was always…"): each is a why_chose item.
  (24 Nov 2026, Routinery 2025) What a recommender said stays in the recommendation item's quote, never a reason of
  their own (ChatGPT "told me … you should prefer this").
  (24 Nov 2026, Routinery 2025, in two checks) A general "you/your" phrase inside their own first-person sentence
  ("As an individual with ADHD, starting your work is hard") is still their struggle; a line about people, in any
  language ("Leute"), never is.
  (24 Nov 2026, Routinery 2025, three in one check) A struggle the app ended ("stopped me arriving late", "no more
  rushing") or one they admit to ("I'm bad at time management") is a why_chose item, never a who item.
  (24 Nov 2026, Routinery 2025, again) A struggle the app ended is a why_chose item even when it's also a liked item:
  put it in both.
  (24 Nov 2026, MyRoutine 2021, in two checks) Why they gave up an old app ("다른 앱은 귀찮아서 몇일만에 지웠는데") is a
  why_chose item as well as a came_from item: put it in both.
  (25 Nov 2026, MyRoutine 2022, in two checks) "The app I'd been looking for" is a why_chose item as well as liked; a
  goal they expect the app to help with ("I think I can build good habits this year") is one too, written as the goal.
  (25 Nov 2026, MyRoutine 2023, in two checks) Every detail a why_chose item names (whose video, "the app's CEO") is
  inside its quote: start the quote where that detail is said.
- came_from (24 Nov 2026, Routinery 2026): a comparison with their old way ("better than my paper list") is an item.
- how_long_used (24 Nov 2026, Routinery 2025, in two checks): just started, or about to start the first routine
  ("my routine starts tomorrow"), is how_long_used, never null.
  (24 Nov 2026, Routinery 2025, again) A length of use said in passing inside a complaint ("routines I had built over
  months") counts too: never null.
  (24 Nov 2026, Routinery 2025, again) So does "in the last few months the app has…" or "tried it over several days".
  (24 Nov 2026, MyRoutine 2020, three in one check) Just downloaded or installed, in any language ("다운받고",
  "깔고", "インストールした"), is how_long_used ("just installed"), never null.
  (25 Nov 2026, MyRoutine 2022, in two checks) So is contacting the developer or using a feature a while ago
  ("emailed you months ago" → at least a few months); its quote reaches every detail the value gives ("before buying").
- language (23 Nov 2026, missed in two checks): und only for text with no words at all (emoji, symbols). One word,
  a stretched word ("coooool"), gibberish beside real words or a place name → the language of the words it has.
- liked: one item per thing they praise or per way life got better ("room is tidy", "eats breakfast before work").
  (23 Nov 2026, missed in two checks) Never praise with nothing named ("it has really helped me"), what they wanted
  when choosing (chose_for) or how long they used it (how_long_used); two praises are two items, each its own quote.
  (23 Nov 2026, Routinery 2024, missed in two checks) Before saving, go through the review once more for every
  way their life got better ("got moving", "sleep earlier"): each one is its own liked item. A named quality
  counts too ("no technical issues so far", "no ads").
  (23 Nov 2026, Routinery 2024, three in one check) Thanks to the developer or support for help or a fix is a liked
  item ("helpful support", "developer fixed a bug"; "Thank you so much for helping").
  (24 Nov 2026, Routinery 2025) Praise of the price is a liked item, with paid still not_said unless they bought
  ("the paid version is very affordable at under five dollars a month").
  (23 Nov 2026, Routinery 2024, missed again) Last step for liked: drop any item that is a length of use ("a
  week in") or names nothing ("makes all the difference"). A first day or first routine goes in how_long_used.
  (24 Nov 2026, Routinery 2026, liked in two checks) Each liked quote shows the very thing its item names ("cute
  design" needs the words about the design); "free of charge" said as praise is a liked item, with paid not_said.
  (24 Nov 2026, Routinery 2026, missed again) Praise of what the free version gives them ("I love that two
  routines are free") is a liked item, and in the present tense it is the using quote too.
  (24 Nov 2026, Routinery 2026, missed again) One word of praise ("helpful", "useful", "great") names nothing:
  never a liked item.
  (24 Nov 2026, Routinery 2026, three in one check) Last pass for liked, in this order: every named quality, every
  way life got better, then drop any item whose own quote doesn't name it ("design" needs words about design).
  (24 Nov 2026, Routinery 2025, in two checks) Praise of premium features is its own liked item (paid stays
  not_said), and every example or result an item names is inside its quote.
  (24 Nov 2026, Routinery 2025, again) "Better off", "my life is better" and "helped my life" name nothing: never a
  liked item.
  (24 Nov 2026, Routinery 2025, four in one check) Never pick the shortest quote first: before saving each liked
  item, check every word of it (the thing, "helped", the result, any "not") is in its quote; if not, lengthen it.
  (24 Nov 2026, Routinery 2025) A better life said in the past tense or with typos ("this app mae my habit so good")
  is still a liked item; for still_using, read the tense through typos and quote a present line.
  (24 Nov 2026, Routinery 2025, four in one check) A hedged quality ("seems clean enough") and praise of what free
  gives ("good features even without premium") are liked items too.
  (24 Nov 2026, Routinery 2025, again) A better life in the title ("Increases my Productivity") or told as a before
  ("I was a mess until I got this") is a liked item too.
  (24 Nov 2026, Routinery 2025, in two checks) Split each praise sentence at every clause (and, while, つつ): each
  half that names something gets its own item, hedged praise ("seems very good") included; "helped me with X" (ADHD,
  my mornings) is a liked item, and only a bare "helped me" names nothing.
  (24 Nov 2026, Routinery 2025, again) "The most helpful of everything I tried" and "I couldn't get through X
  without it" are liked items too.
  (24 Nov 2026, Routinery 2025, two in one check) A liked quote that says only "it" or "that" is too short: lengthen
  it to reach the word for the feature its item names ("the timer").
  (24 Nov 2026, Routinery 2025, again) Also when it ends on "that" or "now": reach the words for the struggle ended
  or the thing that got better.
  (24 Nov 2026, MyRoutine 2020, three in one check) An overall or comparative judgment is a liked item, the title's
  too ("best of the habit apps I've used", "good for beginners", 최고, 입문자에게 좋은); a quote runs to the end of its
  clause ("since starting"). In Korean, a line about 분들/사람들 is about others, never why_chose; what they use the
  app for ("…변화시키는데 도움") is a why_chose item.
  (24 Nov 2026, MyRoutine 2021, three in one check) Conditional praise that compares ("could be the best routine app
  with a little more polish") is a liked item too, and an item is never stronger than its quote ("I like" is not "best").
  (24 Nov 2026, MyRoutine 2021, five in one check) An overall verdict is a liked item even when it opens a complaint
  ("앱 자체는 좋은데…") or is also a why_chose item ("the app I'd been looking for", "worth recommending").
  (24 Nov 2026, MyRoutine 2021, three in one check) So is one inside a thank-you or a plan to stay ("다 좋아요",
  "좋은 앱", "settling on this one after trying others"); only a bare adjective that describes nothing isn't.
  (24 Nov 2026, MyRoutine 2021, three in one check) Praise of the developer's care or sincerity ("진심인 사람이구나") is
  a liked item, like thanks for help or a fix.
  (24 Nov 2026, MyRoutine 2020, again) So is who it's for, in the title or about 분들 ("an app for X", "best for
  people who…", "좋은 의도"): a liked item, never why_chose.
  (25 Nov 2026, MyRoutine 2022, five in one check) So are "worth trying for X people" and hedged title praise
  ("looks good"); an item never adds a noun its quote lacks ("clean", not "clean design").
  (25 Nov 2026, MyRoutine 2022, six in one check) So is a plain closing recommendation naming no group ("no regrets,
  download it") and a change in their life ("my life feels different since I started").
  (25 Nov 2026, MyRoutine 2022, four in one check) The title's verdict is a liked item too ("괜찮은데", "너무 좋아요!").
  (25 Nov 2026, MyRoutine 2022, six in one check) An item never reads two ways: 기획자 is the person who planned the
  app, never a "planner" feature.
  (25 Nov 2026, MyRoutine 2023, three in one check) So is settling on this app after searching ("여기 정착했습니다")
  and a plain "정말 추천드려요"; an item names only what its quote names (no "red light" unless the quote says it).
  (25 Nov 2026, MyRoutine 2023, in two checks) But "잘 쓰고 있어요" names nothing: it's the still_using quote, never a
  liked item; an item never says whom it means (developers, users) unless its quote does.
  (26 Nov 2026, MyRoutine 2023, in two checks) A satisfaction word inside a using line ("만족스럽게 이용중인",
  "만족하며 잘 쓰고") is a liked item, unlike a bare "잘 쓰고 있어요"; so is "기능도 맘에들고".
- note: only what the review says or how it reads. Never a claim from outside the review (what a version number
  means, what other apps do), and never names or phone numbers.
  (23 Nov 2026) Never put a finding in note or repeat one: what they use the app for goes in why_chose, problems
  only in problems. A phrase that can be read two ways is called unclear in note, never settled as one reading.
  (23 Nov 2026, still missed in two checks) Last step before saving: reread note and drop anything a field already
  holds or should hold (an app they came from, a comparison, a fix they tried: that goes in its problem's item). If
  note calls a phrase unclear, the problem item keeps the reviewer's own words and doesn't pick a reading.
  (24 Nov 2026, Routinery 2026) That includes paid and how_long_used: never say again in note what they hold.
  (24 Nov 2026, Routinery 2026, two in one check) But note must say what a paid rule asks for ("a good price" with
  no purchase), and never says a problem was fixed unless the edit says so in words.
  (24 Nov 2026, Routinery 2026) When an edit does say a problem changed (fixed, back, worse), note says so in a line.
  (24 Nov 2026, Routinery 2026) "Same words as another review" only when the tool's NOTE says so, never for a rewrite.
  (23 Nov 2026, Routinery 2024, missed in two checks) In an edited review, note never restates a problem or says
  what changed when; if the edit doesn't plainly say a problem was fixed, leave note null.
  (23 Nov 2026, Routinery 2024, missed again) When note calls a word unclear, the problem item puts that word in
  quotes as the reviewer wrote it ("app 'traba' on open"), never a translation or guess of it.
  (23 Nov 2026, Routinery 2024, missed twice in one check) An edit that says the problem was fixed, or was their own
  doing ("EDIT: Hey, so i found out that its because of my DND"), is said in note; never leave that note null.
  (24 Nov 2026, Routinery 2025, in two checks) If note calls a word unclear, it says only that, never "read as";
  a fix they tried goes in its problem's item, never in note.
  (25 Nov 2026, MyRoutine 2022) In every field, not only problems, an unclear or misspelled word stays in quotes in
  the reviewer's spelling, and note says only that it's unclear.
- Quotes: avoid parts containing HTML entities (`&#39;`, `&amp;`); pick another part of the same sentence.
  (24 Nov 2026, Routinery 2026) But never drop a "doesn't" or "not" to avoid one: if only the part with the
  entity holds the meaning, quote it, entity and all.
  (23 Nov 2026) Each item says only what its own quote proves, and the quote is about this app and their own use.
  Fixes they tried for one problem belong in that problem's item, not a new one.
  (23 Nov 2026) A quote starts and ends on whole words; never cut into a word.
  (23 Nov 2026, Routinery 2024, three in one check) If an item says more than its quote shows (stuck, then "kept
  going after restarting"), quote the longer unbroken part that shows it all, or cut the item to what the quote shows.
  (24 Nov 2026, Routinery 2026, in problems, why_chose and liked across four checks) Last step before saving: read
  each item against its quote alone. If it says more ("cannot be recovered" for "not sure how to get them back",
  "sent feedback" with no such words), cut it to the reviewer's own words or lengthen the quote.
  (24 Nov 2026, Routinery 2026, five in one check: the most common correction) Do this for every item in every
  field, one by one, before saving; a complaint its quote doesn't show is split into its own item with its own quote.
  (24 Nov 2026, Routinery 2026, five in one check again) "Shortest" never means cutting what the item depends on:
  keep a "doesn't" or "not", a condition ("when it isn't open"), a cause ("since changing phones"), a comparison
  ("better than") and the word that names the thing praised or "helped" inside the quote.
  (24 Nov 2026, Routinery 2026, six in one check: checking afterwards isn't enough) Work the other way round: pick
  the quote first, then write the item using only what that quote says. One complaint in one sentence is one item.
- problems: (23 Nov 2026, Routinery 2024, five in one check) Before saving, check every clause for a separate
  complaint or plea, including side remarks and a closing request ("please be free the app"): each is its own item.
  (24 Nov 2026, Routinery 2025) When paid is charged_unexpectedly, the charge is its own problem item too ("It said I
  would have 7 days trial, I bough an year plan").
  (24 Nov 2026, Routinery 2026, two in one check) A complaint in the title or in a later edit is its own item too.
  (24 Nov 2026, Routinery 2026, three in one check) Write a problem only from its own quote: a cause ("after a recent
  update") or a result from another clause needs its own quote, or leave it out.
  (24 Nov 2026, Routinery 2025, in two checks) Every detail an item names (the trial, how often) is inside its
  quote; two complaints in one sentence are two items; a workaround ("restart usually helps") goes in its bug's item.
  (24 Nov 2026, Routinery 2025, three in one check) But one complaint said twice, as a lack and a dislike ("can't set
  it daily, only every 2 days"), is one item. The title's complaint gets its own item quoted from the title; never
  merged into a text item or left in note.
  (24 Nov 2026, Routinery 2025, missed again) Even a title that restates the text's complaint gets its own item;
  "said twice is one item" applies only within the text. Pick the quote first, then write the item from it alone.
  (24 Nov 2026, Routinery 2025, three in one check) A plea is its own item even inside a line about people in
  general; a title naming two complaints gives two items; an item never adds a reading in brackets.
  (24 Nov 2026, Routinery 2025, eleven in one check) A fix they tried (reinstalling, restarting, updating, clearing
  data) is never its own problem item, even in a sentence of its own: it goes in the item of the bug it was tried on.
  (24 Nov 2026, Routinery 2025, in three checks) A problem quote holds the word for the feature its item names
  ("skipping", "Dynamic Island", a section's name); a wish and a dislike about one thing are one item.
  (24 Nov 2026, Routinery 2025, four in one check) Last step for problems: every detail in the item (when, a
  place, a time of day, "others report") must be in its quote; if it isn't, lengthen the quote or drop the detail.
  (24 Nov 2026, Routinery 2025, six in one check) A quote keeps the cause ("after an update"), the feature's own word
  ("smallest widget") and any quality ("unstable") its item names. In a long review, a second wish in brackets or
  the next clause and a warning about a coming charge are each their own item.
  (24 Nov 2026, Routinery 2025, again) The quote holds the complaint itself, not only its opening words ("they make
  impossible" needs "stop my subscription"), and the item keeps both halves of a contrast.
  (24 Nov 2026, MyRoutine 2021, six in one check) A detail from the title or the next sentence ("since the update",
  "iPhone", "often forgets to save") goes in an item only if its quote reaches it, else it gets its own item quoted
  from where it's said; a "does X not work?" question about their own use is a problem item, never note.
  (24 Nov 2026, MyRoutine 2021, eight in one check) In Korean and Japanese the condition or subject comes first
  ("화면이 작은 경우", "저의 폰에서만"): start the quote at the start of the sentence, not at its last clause.
  (24 Nov 2026, MyRoutine 2021, three in one check) A paywall or free limit that blocks an action (can't save the
  15th routine without Pro) is dislike, never broken.
  (24 Nov 2026, MyRoutine 2020, five in one check) A plea or question ("어떻게 없애나요") is its own item, apart from
  the dislike beside it.
  (25 Nov 2026, MyRoutine 2022, in two checks) So is a closing "please fix/improve it", a question beside a
  complaint, and a detail said only in the title (a device, a place): never merged into the bug beside it or dropped.
  (25 Nov 2026, MyRoutine 2022, five in one check) But a wish and a dislike about one thing stay one item even across
  two sentences, and a "so that I can…" clause belongs to the wish it explains, never a second item. A closing plea
  or "I'll wait for an update" is still its own item, even about the same thing as the complaint before it. A
  question and the plea after it are two items ("is it a bug or on purpose?", "if it's a bug, fix it fast").
  (25 Nov 2026, MyRoutine 2022, four in one check) A remark right after a complaint (often in brackets) is about that
  feature, so a workaround ("I only use it as a list") goes in its problem item, never why_chose; a proposal that
  starts "so…"/"그래서…" and spells out the wish before it is part of that wish.
  (25 Nov 2026, MyRoutine 2022, twelve in one check) A warning or cynical remark at the developer ("you'll regret this
  update") is its own dislike item, never dropped as tone; a device named only in a bug goes in that bug's item and quote.
  (25 Nov 2026, MyRoutine 2023, four in one check) An opening plea ("확인부탁드립니다") is its own item like a closing
  one; a quote starts at its sentence's start and holds the feature's word ('언제할래요?') and every detail the item
  gives ("as an option"); an unclear word ('공복') is quoted as written, never read as something else.
  (25 Nov 2026, MyRoutine 2023, in two checks) A cynical aside ("조만간 수정해주긴하겠지") is its own dislike item; a
  dislike-and-wish item's quote reaches the dislike sentence as well as the wish; '中午' stays quoted as written.

## Stopping and starting again

Everything is saved after each review, so you can stop at any time. A claim keeps its reviews for you: if you stop
early, the next labeller carries on with the same claim. Never work on a claim or year that another labeller is on.

## When it says "All done"

Reply as in "When you stop" above, adding anything in the prompt or the fields that didn't fit what people wrote.
````
