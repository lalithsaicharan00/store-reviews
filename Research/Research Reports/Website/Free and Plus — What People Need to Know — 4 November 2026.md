# Free and Plus — What People Need to Know

Written by Claude (Claude Code), 4 November 2026, at the user's request: what's the next most important section after "every kind of habit", and how should its copy read?

## The answer

**"What do I get free, and what's the catch?"** The third section says exactly what's free, what Plus adds and how paying works.

Paying is what most often makes people leave a habit app, and the hero only touches it in one line. Once someone knows the app holds their habit, the next doubt is whether they'll hit a wall.

## What people show

**Scan:** the same 372,850 unique English reviews across 181 collections of habit and routine apps as the last section, counted by machine, with samples read by hand. These are rough counts, for size and direction.

**Why people leave** (5,514 reviews of 3★ or less with a sentence about deleting, switching or giving up; the theme can be anywhere in the review):

| Theme | Share |
|---|---:|
| **Paying** | **63.0%** |
| Data, backup, accounts | 19.8% |
| Reminders | 12.3% |
| Simple, quick, clean | 10.4% |
| Bugs and crashes | 9.7% |
| Seeing progress | 6.5% |
| Keeping going | 6.4% |
| Fit: kinds of habit, schedule | 4.9% |
| Widgets | 2.9% |

**Why people choose or stay** (10,914 reviews of 4–5★ with a sentence about choosing or sticking with an app): simple 5.6%, keeping going 5.5%, **paying 5.0%**, reminders 1.9%, fit 1.9%, progress 1.8%. Fair pricing is a reason to choose as well as a reason to leave.

- **Limits.** In a hand-read sample, 22 of 40 leaving sentences named paying themselves, so 63% is the upper end. Fabulous and Me+ supply much of the anger about trials. An app with no subscription doesn't have their problem, which is the point of saying so.
- **Reviews come from people inside apps,** not from website visitors.

**Other candidates:** data and backup is the next biggest, and it deserves a section soon. Progress and streaks matter for staying, but they answer "will I keep using it?", which comes after "is it fair?" (reasoned from first principles).

## What makes people angry about paying

Users show four separate complaints, and each one tells the copy what to say.

| Complaint | Reviews | 1–2★ | What the copy does |
|---|---:|---:|---|
| Trials and charges they didn't expect | 6,937 | 84% | Says there's no trial and nothing to cancel |
| A paywall before they can try anything | 2,160 | 69% | Says what's free, with no time limit |
| A limit they weren't told about ("not said", "misleading", "should be specified") | 3,870 mention being misled or not told, across all paying complaints | | Puts the number 5 in the heading |
| Something free or promised that was taken away | 1,016 | | Says what's free stays free |

- **The cap.** People name 3 habits most often (318 mentions), then 5 (204). Reviews of a limit of 5 are mixed: "Great app, but only 5", and also praise for 5 over the usual 3. So 5 needs saying plainly, never hiding.
- **"Pay once, yours forever" can backfire.** Reviews of one app show real anger when that promise was later changed. We only say what we'll keep: [Up Next](<../../../Implementation — Up Next.md>) already rules that nothing free at launch ever moves into Plus.

## How the copy should read

**Use people's own words.** Among 68,718 reviews that touch on paying:

| Words | Reviews | Use |
|---|---:|---|
| "lifetime" | 1,496 | Search word. We don't claim a lifetime of anything we can't promise, so "yours forever" is the app's phrase instead |
| "one-time" (purchase, payment, fee) | 1,108 | **Use once in the text**: it's how people write it, so it's how they'll search |
| "no subscription" | 505 | Use: it's already the hero's headline |
| "unlimited" | 487 | Use: the plainest word for Plus |
| "forever" | 281 | Use, as in the app |
| "pay once" | 120 | Use: short and already the app's words, though people write it less |
| "free trial" | 5,647 | Use only to say there isn't one |

**Rules for this section** (from the complaints above, and reasoned from first principles):

1. **The number goes first.** "Free for 5 habits" in the heading. Nothing about the limit is left to be found later.
2. **Say what's free before what's paid.** That's the order people ask in.
3. **Name things the way the app does,** so the site and the Plus screen agree.
4. **No sales words.** No "unlock", "upgrade now", "best value", "premium" or "limited time". Those are the words of the apps people left.
5. **Short lists, one fact a line.** Each line is real text for search and AI tools.
6. **Only promises we keep.**

Most pricing-copy advice online is from vendors with something to sell, and no controlled test of free-against-paid section copy was found. Nielsen Norman Group is widely reported as finding price to be people's top information need on a site, but the search reached only secondhand summaries, so treat that as direction.

## SEO and AI tools

- **Search:** it puts "free", "one-time purchase", "no subscription" and "unlimited habits" in real text. Roundups judge habit apps on exactly this: free cap, and one payment or a subscription.
- **AI tools:** "How much is free?" is a question they answer about apps. Two plain lists give them the answer without guessing.
- **Links:** to `/plus`, which holds the full comparison.
- **Structured data:** say the app is free to download now. **Add Plus's price once it's settled.**

## What other sites do

Of the eleven usable homepages read for the last section, none had a pricing section. Roundups show the field varies: Way of Life's free plan is reported at 3 habits, HabitNow's at 5 or 7, and Streaks is paid up front with a cap of 24 (blogs that disagree with each other, so check the stores before quoting them). Leaving it off the page isn't evidence it's wrong: reviews show this is the thing people most want to know, so it's a place to stand apart.

## What the section says

From [Up Next](<../../../Implementation — Up Next.md>) (Android A73, A110) and what the code actually locks:

- **Free:** up to 5 habits (`FREE_HABIT_LIMIT`); quit and cut-down habits, tasks and timers; several reminders for each habit; streaks, milestones and each habit's progress; full history; backup to the person's own Google Drive or iCloud.
- **Plus:** unlimited habits; Today and This week widgets; Year in Pixels on each habit's page; checklist habits; Remind me again. Month and year views are free (the user, 4 Nov 2026, Android A110, which corrects A73).
- **No trial:** the Android code has none, and Plus is a one-time product.
- **Plus stays with the store that sold it** and comes back on any phone signed in to it (D16).
- **The price isn't printed.** It's still open, so the Plus card has no number. When it's settled it goes on the card: people expect it there, and reviews show they punish finding out late.

## Sources

- Scan: `Research/Temp/website-section-3/` (not in git): `scan.py`, `scan_b.py`, `words.py`
- Earlier: [After the Hero](<After the Hero — What People Want to Know Next — 4 November 2026.md>) · [Hero Copy](<Hero Copy — What People Look For First — 4 November 2026.md>) · [Feature Ledger](<../Feature Ledger.md>) (C001, C003, C007, C147, C246)
- Roundups, treated with care: [HabitDoom on free trackers](https://habitdoom.com/blog/best-free-habit-tracker-2026) · [Softpicker's ranking](https://softpicker.com/best-habit-tracker-apps/) · [Timing on habit apps](https://timingapp.com/blog/habit-tracker-apps-iphone-mac.md)
- Pricing, secondhand: [Summary of NN/g on showing prices](https://populiweb.com/blog/2013/12/nielsen-norman-group-show-your-pricing/) · [Gravity Global on pricing and usability](https://gravityglobal.com/news/blog/pricing-website-usability-opportunity)
