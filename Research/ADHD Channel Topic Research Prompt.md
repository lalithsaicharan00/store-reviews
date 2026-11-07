# ADHD Channel Topic Research Prompt

Written by Claude (Claude Code), 7 November 2026, at the user's request. To run it, tell an agent: "Pull the latest `main`, then follow `Research/ADHD Channel Topic Research Prompt.md`."

---

## 1. Your job

We are building one ADHD channel on YouTube, and later on TikTok and Instagram. It should slowly become one of the biggest ADHD channels. We are working in reverse: we find the videos first, and the app is shaped by what we find.

**Find 50 evergreen YouTube video topics for that channel.** Each one must be proven by 10 to 15 real videos, and strong enough that a well-made video on it has a high chance of success whenever it is posted. The user makes the videos. Your job is to make sure every topic is solid.

**The app does not exist yet.** It has no design and no feature list. So judge topics by the **problem** they are about, never by app features. Promotion must feel like help: a viewer should think "this person gets me, and this could help me", never "they're selling me another app".

This is a very large job. It runs in phases, across many hours and probably several sessions. Sections 4 and 5 tell you how to run it without losing or forgetting anything. Follow them exactly.

**In scope:** YouTube only, English first. TikTok and Instagram get their own passes later, with their own thresholds.

## 2. Before anything else

### Sync the repository

Your local copy may be behind GitHub, because the research this prompt depends on was pushed recently. **Do this first, before reading anything else:**

1. Run `git fetch origin`, then `git status`.
2. Make sure you are on `main`, then run `git pull --ff-only origin main`.
3. Confirm the 2 reports listed below and both of their evidence folders are there.

Never discard, stash or overwrite local changes to make this work. If the pull can't go through cleanly, stop and tell the user what's in the way. Don't start on an out-of-date copy.

### Use the computer, in the Chrome tab that's already open

This runs on the user's own computer, not in a cloud session. Computer use is turned on. **All work on YouTube happens through the computer, in the one Chrome tab the user has already opened.** That tab is in the right Chrome profile with the right account.

- **Work only in that tab.** Find it, and do everything there: search, open videos, open channels, read comments and transcripts, and go back.
- **Never open a new tab, a new window, another Chrome profile or another browser.** Other profiles have a different Gmail and don't have the accounts. Open every link in the same tab.
- **Don't switch or change the account.** Never sign in, sign out or change a setting.
- **Read only.** Never like, subscribe, comment, save to a playlist or report anything. Those would also change what the account is shown.
- **The account is signed in, so results can be personal.** Search with exact terms, and judge videos by the rules in this prompt, not by how high YouTube ranks them.
- **If the tab is missing, signed out or in the wrong profile,** stop and tell the user. Don't try to fix it by opening another one.
- **If your computer tool can only look at Chrome and can't click or type there,** use a Chrome control tool on that same tab. If neither works, stop and tell the user. Never move to another browser to get around it.
- **The tab can only do one thing at a time,** so only you use it. Subagents never touch it.

## 3. Read these next

1. `RULEBOOK.md`: the "Starting again" section and rules W2 to W5, D11, and the W2 lessons on checking what a word match actually hit.
2. `Research/CLAUDE.md`.
3. `Research/Research Reports/Market Discovery/What ADHD Users Pay For — Features and Reasons — 7 November 2026.md`: what ADHD users already pay for.
4. `Research/Research Reports/Market Discovery/Who Pays for Habit Apps and Why — Audience Groups — 7 November 2026.md`: who pays.

**The paid problems from those reports** are your starting map. Treat them as evidence about payers. They are not a limit on topics:

- Not forgetting: 26.0% of 861 payers read in full
- Routines and time: 24.3%
- Calm and simple: 20.0%
- Staying motivated: 17.8%
- Getting started: 8.0%
- Understanding ADHD: 6.4%
- Focus: 4.8%

## 4. How to run this: never rely on memory

Your context will fill up and be summarised. **Every fact and decision lives in a file, never only in your head.**

**Working folder:** `Research/Temp/adhd-channel/`. Nothing goes in `/tmp`.

| File | Holds |
|---|---|
| `STATE.md` | Current phase, what's done, what's next, every count, open problems. **Read it first, every time.** |
| `search_terms.csv` | Every search term, where it came from, whether it's done, new qualifying videos it added |
| `channels.csv` | Every channel: subscribers, recent median views, band, brand or person |
| `videos_raw.jsonl` | Every video screened, as collected |
| `videos.csv` | Every video after grading, with its grade and tags |
| `shorts.csv` | Shorts found on the way, kept for the later TikTok pass |
| `topics.csv` | Every candidate topic, its gates, evergreen verdict and score |
| `rejected_topics.csv` | Every rejected topic and the exact rule that failed |
| `deep/<topic-slug>/` | Transcript, comments and notes for each video read deeply |
| `app_mentions.csv` | Every app mention or sponsorship found, and how the audience reacted |
| `problems.csv` | Problem to feature ranking |
| `decisions.md` | Every judgement call, dated, with the reason |

**Resuming:** at the start of every session, and after any summary of your context, read `STATE.md` and carry on from there. Never redo a finished phase. Never trust a number that isn't in a file.

**Saving:** update `STATE.md` at the end of every batch, and at least every 30 minutes. Write collected data to disk as you get it, in small batches, so a crash loses very little.

**Gates:** every phase ends in an exit check, run by a script where it can be. Don't start the next phase until the check passes. If it can't pass, write down why in `STATE.md` and tell the user plainly.

**Task list:** keep one task per phase on the user's task list, and give a short plain update as each phase ends.

**Subagents:** you may use subagents for Phase 6 only, and only to analyse transcripts and comments you've already saved to `deep/`, about 5 topics each. They never use Chrome. Give each one sections 6 and 7 of this prompt and have it write to `deep/`. Check one in every five of their topics yourself against the source.

**Work on your own.** Don't stop to ask questions. Stop only for the blocks listed in section 10.

## 5. The phases

| Phase | What happens | Exit check |
|---|---|---|
| 0 | Setup and a small test | 5 test videos have every field correct |
| 1 | Build the search list | At least 150 terms and 40 channels |
| 2 | Collect videos | At least 5,000 unique long-form videos screened, and new finds have dried up |
| 3 | Grade videos and channels | Every video has a grade; every video kept has channel numbers |
| 4 | Group videos into topics | 80 to 120 candidate topics; every kept video has one main topic |
| 5 | Gates and evergreen test | Every candidate has a recorded result for every gate and test |
| 6 | Deep read | Every surviving topic has its 3 to 5 videos read |
| 7 | Score, group and choose the 50 | 50 topics chosen, or a stated shortfall; balance checks done |
| 8 | Problem to feature ranking | Every chosen topic maps to a problem |
| 9 | Verify everything | Every check in section 9 passes |
| 10 | Write the report | Files saved, index updated |

### Phase 0: Setup

- Confirm section 2 is done: the repository is synced and you're in the right Chrome tab.
- Create the folder and `STATE.md`.
- **Reading pages efficiently:** one search results page or a channel's Videos tab sorted by Popular shows many videos with their views and age, so screen from those lists. Open a video's own page only for videos that look like they qualify, to get the exact upload date, views and comment count.
- **Scripts are for saved data:** use them to store, grade and check what you read in the tab. Save each page's findings to a file as you go.
- **If reading exact numbers through the tab proves too slow,** a helper such as `yt-dlp` or the YouTube API (if `YOUTUBE_API_KEY` is set) may fill in the numbers for videos you've already found. Searching and reading still happen in the tab, and you check a sample against the page. **Never write a key to any file (D11).**
- Go gently, at a person's pace. If YouTube slows or blocks you, wait and slow down. Never try to get around a block or a CAPTCHA.
- Test on 5 videos: read each page, save the fields, and read them back against the page. Fix your method before going on.

### Phase 1: Build the search list

Build **at least 150 search terms**, using all of these sources:

- **Paid problems:** every problem in section 3, in the words people use ("why do I forget everything", "can't start tasks", "time blindness").
- **ADHD life:** paralysis, executive dysfunction, procrastination, motivation, dopamine, hyperfocus, boredom, overwhelm, burnout, masking, rejection sensitivity, emotions, sleep, mornings, waking up, phones, doom scrolling, cleaning, messy rooms, laundry, food, forgetting to eat, money, impulse spending, work, studying, relationships, friendships, late diagnosis, women, men, students, adults.
- **YouTube autocomplete:** type "ADHD" plus each letter a to z, and "why do I", "how to", "ADHD and", "living with ADHD".
- **Formats:** "day in the life", "things I wish I knew", "signs", "tips that actually work", "what it's really like".
- **Tools:** "best apps for ADHD", "ADHD planner", "ADHD routine", and named apps such as Tiimo, Structured, Finch, Goblin Tools, Alarmy and Forest.

Find **at least 40 ADHD channels** from what those searches show, across small, medium and large. Never list a channel from memory without confirming it exists. Include terms **outside** the paid problems, because new ideas must be able to surface.

### Phase 2: Collect videos

In the Chrome tab, for each search term, take the top results by relevance and by view count, using YouTube's own sort filter. For each channel, open its Videos tab and take its most popular videos and its recent uploads.

Save for each video: URL, video ID, title, channel, channel ID, upload date, views, likes if shown, comment count, length, whether it's a Short, the date you read it, and the search term that found it.

**Keep going until both are true:** at least 5,000 unique long-form videos are screened, and the last 20 search terms added under 5% new qualifying videos. Reaching 50 topics needs about 600 qualifying videos.

### Phase 3: Grade videos and channels

Apply section 6 by script. Get each channel's subscribers and recent uploads from its page in the Chrome tab. Then look through a sample of 100 kept and 100 dropped videos by hand, to catch off-topic videos and word-match mistakes. Fix the rule and rerun if needed, and note it in `decisions.md`.

### Phase 4: Group into topics

**A topic is one problem and one promise to the viewer.** "Why you can't start tasks" is a topic. "ADHD tips" is not. Two ideas are the same topic if one video could fully serve both.

Read the titles yourself. A script may suggest groups, but you make the decisions. Build 80 to 120 candidates. Each kept video gets one main topic. If a topic has more than 15 qualifying videos, keep the total as a measure of demand and pick the strongest 15 as its examples, keeping a spread of channels and years.

### Phase 5: Gates and evergreen test

Apply section 7 to every candidate. Record every result, including the failures. A topic that fails goes to `rejected_topics.csv` with the exact rule it failed. **Don't lower a bar to reach 50.**

### Phase 6: Deep read

For every topic still standing, choose the best 3 to 5 videos: the strongest by grade and channel-size proof, from different channels. For each, in the Chrome tab, open the video, open its transcript from the description ("Show transcript"), and sort comments by Top, then by Newest. Save what you read to `deep/` straight away. If a video has no transcript, note it and choose another.

- **Transcript:** note the first 30 seconds, the promise, the structure, where people would likely stay or leave, and any app or sponsor mention.
- **Comments:** read the **top 100 by likes** and the **30 newest**. Record likes as a measure of agreement. Count these kinds:
  - "This is me": they recognise themselves
  - Details of the problem in their own words
  - What they've tried, and why it failed
  - Asking for a tool, an app or a next step
  - Mentions of paying for something
  - Doubts and objections, such as "another app I'll forget about"
  - Requests for a follow-up video

Read comments yourself, in the language they're written in. A word search only finds candidates.

**Log every app mention** in `app_mentions.csv`: the app, paid or not, whether it was disclosed, where in the video, how long, and how the comments reacted. Also run a separate search for videos promoting ADHD apps, even if they fall below the view limit, because how audiences react to promotion is what we most need to learn.

### Phase 7: Score, group and choose

Apply section 8. Choose the 50. Run the balance checks. Put up to 15 good runners-up in a reserve list.

### Phase 8: Problem to feature ranking

This is how the videos shape the app. For each problem behind the chosen topics, record:

- How many topics and qualifying videos it has, and their median views
- Whether people pay to solve it (from section 3), with the number
- What the comments ask for and what they say has failed
- What an app would need to do to help, in plain words
- A ranking: **build first** (big audience and proven payers), **test** (big audience, no proof of paying), or **leave out** (an app can't really help)

Report anything that isn't in the store research as a new idea. Those are the findings we want most.

### Phase 9: Verify

Run every check in section 9.

### Phase 10: Write the report

See section 11.

## 6. How to judge a video

**A video can count only if all of these are true:**

- At least **100,000 views**.
- **ADHD is its main subject**, or its audience is clearly people with ADHD.
- **Long-form.** Shorts go to `shorts.csv` and never count here.
- In English.
- Not a livestream, a compilation, or an ad uploaded as a video.

**Speed.** Age in months = days since upload ÷ 30.44. Views per month = views ÷ age in months.

| Grade | Rule | Counts as proof? |
|---|---|---|
| **Good** | 25,000 or more views a month (100K in 4 months) | Yes |
| **Okay** | 8,000 to 24,999 a month (100K in a year) | Yes |
| **Long-runner** | At least 36 months old with at least 500,000 views, at any speed | Yes, and it's strong evergreen proof |
| **Too new** | Under 3 months old | Not yet. Keep it as a sign of current demand |
| **Drop** | Anything else | No |

Long-runner is also a tag: a video can be Good or Okay and a Long-runner too, so mark both.

Today's views are all we can see, not when a video reached 100K. An average since upload understates older videos, which is why Long-runner exists. Say so in the report.

**Channel size.** Good views on a huge channel prove the channel, not the topic. So for each video record:

- **Subscribers**, and a band: Small under 50,000, Medium 50,000 to 500,000, Large over 500,000.
- **Views ÷ subscribers.** Above 1 means it reached beyond the channel's own audience.
- **Outlier score:** the video's views ÷ the median views of that channel's last 30 long-form uploads, leaving this video out.

| Outlier score | Reading |
|---|---|
| 3 or more | **Strong:** the topic beat the channel's normal audience |
| 1.5 to 2.99 | **Good** |
| 0.75 to 1.49 | **Normal:** it's about what this channel always gets |
| Under 0.75 | **Weak:** the channel's audience, not the topic |

If a channel has under 10 other long-form videos, mark the outlier score "not enough history" and use views ÷ subscribers.

**Tags that lower a video's value as proof:**

- **Possible bought views:** a brand's video with very few comments for its views, such as under 0.3 comments per 1,000 views. Companies often pay for views. It can't count as proof until you've looked at it by hand.
- **Borrowed audience:** a famous guest, TED, a TV or news brand. Allowed, but at most 3 per topic, and it can't be used for the channel-size gate.
- **Brand channel:** run by an app or company. Record it, because it may be promotion we can learn from.

## 7. How to judge a topic

**A topic must pass every gate.**

| Gate | Rule |
|---|---|
| **G1 Examples** | 10 to 15 qualifying videos |
| **G2 Channels** | At least 4 different channels, and no channel provides more than a third of the examples |
| **G3 Beyond one channel** | At least 3 examples with a Good or Strong outlier score, or views above subscribers, from at least 2 channels, and at least 2 examples from Small or Medium channels |
| **G4 Speed** | At least 3 examples graded Good |
| **G5 Evergreen** | Passes the test below |
| **G6 Different** | Not the same problem and promise as a topic already chosen |
| **G7 Safe** | Can be done well with no medical advice: no medication guidance, no diagnosis, no claim of treating ADHD |

**The evergreen test.** The topic must work whenever the video is posted. Check it thoroughly, and try to **disprove** it. Record the evidence for every line.

| Test | Rule |
|---|---|
| **E1 Spread** | Examples were uploaded in at least 3 different calendar years |
| **E2 Alive now** | At least 2 examples uploaded in the last 24 months |
| **E3 It lasted** | At least 2 examples older than 36 months, or at least 1 Long-runner |
| **E4 Still found** | On at least 3 examples older than 24 months, people left new comments in the last 6 months |
| **E5 Not one moment** | No more than 60% of examples come from any single 12 months |
| **E6 No date attached** | Nothing depends on a year, season, holiday, news story, new study, drug shortage, celebrity, trend, meme, or a version of an app or platform. New Year, back to school and exam season fail |
| **E7 Search interest** | Google Trends over 5 years, where it has data: steady or rising, with no once-a-year spike. "Not enough data" doesn't fail, but say so |
| **E8 Five-year title** | Write the title. It would need no change in 5 years |
| **E9 Lasting problem** | Comments show it's an ongoing part of living with ADHD, not a passing interest |

**Verdict:** Pass means every test passes. Borderline means one test is unclear, and the topic may go to the reserve list only. Fail means any clear failure. **Only Pass topics can be in the 50.**

## 8. Choosing the 50

### Three questions for every topic

1. **Do people watch it?** Sections 6 and 7 answer this.
2. **Do people already pay to solve it?** Use the reports in section 3.
3. **Could a phone app really help?**

| Group | Means |
|---|---|
| **Proven** | Watched, and people already pay to solve it |
| **New idea** | Watched and an app could help, but no proof yet that people pay |
| **Pure help** | Watched, but an app doesn't fit |

### The natural-fit test

We want good topics for promoting the app, so check this carefully. A topic can carry promotion only if it passes all of these:

- **N1 Real help:** an app can truly reduce this problem.
- **N2 The moment:** the video reaches a natural point where a viewer asks "okay, so what do I do?"
- **N3 Honest story:** the mention can be said in a true sentence or two, such as "I kept doing this, so I built something for it". It's always open that the app is ours. We never pose as a neutral reviewer.
- **N4 Useful without it:** **the video gives its full value even if the app is cut out.** This one matters most.
- **N5 People want a tool:** the comments ask for tools, or describe what they've tried.
- **N6 No backlash:** app mentions in similar videos didn't draw anger. If they did, record why and how to avoid it.

### The promotion mix

| Type | Target | Meaning |
|---|---:|---|
| **Built around the problem** | About 20 | The whole video is about a problem the app solves, and the app is one of the main fixes. Passes N1 to N6 strongly |
| **Natural mention** | About 20 | A helpful video with a 30 to 60 second mention at the right moment. Passes N1 to N6 |
| **Pure help** | About 10 | No app. Builds reach and trust |

**Fit sets the limit.** Prefer strong topics that can carry promotion, because reaching people through the app is the aim, and look hard for them. But never force it. If only 32 topics pass honestly, report 32 and say what would raise it. Never relabel a topic to hit the target.

### Score each topic out of 100

| Part | Points | Measures |
|---|---:|---|
| Demand | 20 | Total qualifying videos and their median views |
| Speed | 10 | Share graded Good |
| Beyond one channel | 15 | Outlier scores, Small and Medium channel proof |
| Evergreen strength | 10 | Spread of years, Long-runners, recent comments |
| Resonance | 15 | "This is me" comments and how many likes they got |
| Buyer signal | 10 | People asking for tools, or saying they've tried or paid |
| App fit | 20 | Results of N1 to N6 |

Score each part by a written scale, saved in `decisions.md`, and apply it the same way to every topic.

### Balance checks

The final 50 must also pass these. Record them.

- **Wide reach:** one channel has to reach as much of the ADHD audience as possible, so cover adults, late diagnosis, women, men, students and work. Parents of children with ADHD are a different buyer: keep those for the reserve list.
- **No over-crowding:** no single problem takes more than 8 of the 50.
- **First videos:** mark 10 Pure help topics to post first, because the app won't exist yet.
- **Long-term run:** order the 50 so that promotion builds gradually.
- **Presenter:** it isn't decided yet whether the presenter has ADHD. Tag each topic **needs lived experience**, **works either way**, or **expert style**.

## 9. Verification

The work isn't finished until all of these pass:

- A script confirms every example video meets section 6, and every topic meets every gate.
- Reopen a random 30 example videos in the Chrome tab and confirm the title, date and views. Note any change.
- Every URL is real and came from a page or data you read. **Never write a URL, title or number from memory.**
- No video is the main example for two topics.
- Every quote is checked word for word against its source by script.
- Every topic has every field in its card.
- The rejected list explains every candidate not chosen.
- Every number in the report carries its count, its base and the date.

## 10. Rules

- **Plain English** in everything written for the user.
- **Label the evidence:** keep machine counts and hand-read findings apart. Say "users show…" for evidence and "reasoned from first principles" for judgement. Follow W2.
- **Never copy competitors blindly.** A popular video proves demand, not that its advice or method is right.
- **Copyright:** learn from scripts and never copy them. Transcripts and full comment sets stay in `Research/Temp/`, which git ignores. Reports use short quotes only, under 15 words. Titles we suggest must be our own.
- **Privacy:** don't store or publish commenters' names.
- **Medical care:** never suggest a video that gives medical advice.
- **Honesty:** if you fall short of 50, say how many passed and why. A true 41 is worth more than a padded 50.
- **Git:** follow W3 and W4. Commit only if the user asks, and when they ask for a commit to `main`, push it too and confirm it reached GitHub. Secrets never go in git (D11).
- **Learned something?** Add it to `RULEBOOK.md` the same day (W5).
- **When to stop and tell the user:** the repository won't sync, the Chrome tab is missing, signed out or in the wrong profile, you can't control the tab, or YouTube blocks you and waiting doesn't help. Save your state first.

## 11. What to deliver

Save in `Research/Research Reports/Market Discovery/`:

**The report:** `ADHD Channel — 50 Evergreen Video Topics — <date>.md`. It opens "Written by …, <date>" and is added to `Research/Research Reports/README.md`. It contains:

1. **The short answer:** the best topics, what was found, and what surprised you.
2. **What was searched:** the funnel with every count.
3. **The 50 topics,** ranked, one line each, with type, group and score.
4. **A card for each topic** (below).
5. **The promotion mix:** how many of each type, and any shortfall.
6. **How promotion works on ADHD audiences:** what the app mentions showed, what earned trust, what drew anger, and doubts to expect.
7. **Problem to feature ranking:** build first, test, leave out, and new ideas.
8. **Posting order,** including the first 10 videos.
9. **Reserve list.**
10. **Limits.**

**Each topic card contains:**

- Topic, the problem, and the promise to the viewer
- Type (Built around, Natural mention, Pure help), group (Proven, New idea, Pure help) and score out of 100
- Presenter tag
- **Proof:** total qualifying videos, channels, median views, median views a month
- **The 10 to 15 examples:** link, channel, subscribers, upload date, views, views a month, grade, outlier score
- **Evergreen:** result and evidence for E1 to E9
- **The audience's words:** short quotes of the most-liked comments
- **What people have tried,** and why it failed
- **The gap:** what commenters still want that these videos didn't give them
- **Our angle:** how our video could be better, not just the same
- **What works:** hooks and structures from the videos that did best
- **Three title ideas** in the audience's language, written by you
- **The app moment** (unless Pure help): where in the video, why it's natural, a two-sentence example, the doubt to expect, and the app feature it would need
- **Paid evidence:** whether people pay to solve it, with the number

**The evidence folder:** `ADHD Channel Topics — Evidence/` beside the report, with `Videos.csv`, `Channels.csv`, `Topics.csv`, `Rejected Topics.csv`, `App Mentions.csv`, `Problems.csv`, your scripts, and a README. No transcripts and no commenter names.

## 12. Final checklist

Before saying it's done, confirm each line in `STATE.md`:

- [ ] Repository synced before starting, and all YouTube work done in the one Chrome tab, with no other tab, window or profile opened
- [ ] At least 150 search terms, 40 channels and 5,000 long-form videos screened, and new finds dried up
- [ ] Every video graded, with channel numbers for every kept video
- [ ] Hand checks of kept and dropped videos done
- [ ] Every candidate tested against G1 to G7 and E1 to E9, with results recorded
- [ ] Only Pass topics in the 50
- [ ] Deep read done for every surviving topic: transcript, top 100 comments, 30 newest
- [ ] App mentions logged, including a separate search for promoting videos
- [ ] N1 to N6 recorded for every topic carrying promotion, and N4 true for all of them
- [ ] Promotion mix reported honestly
- [ ] Balance checks done, first 10 and posting order set
- [ ] Problem to feature ranking done, with new ideas called out
- [ ] Every check in section 9 passed
- [ ] Report, evidence folder and research index done
- [ ] Rulebook updated with anything learned
- [ ] Nothing committed unless the user asked
