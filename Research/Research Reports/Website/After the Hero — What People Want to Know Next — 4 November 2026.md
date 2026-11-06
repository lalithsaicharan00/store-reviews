# After the Hero — What People Want to Know Next

Written by Claude (Claude Code), 4 November 2026, at the user's request: once the hero has done its job, what is the next most important thing to show, for people and for search?

## The answer

**"Will it track my kind of habit?"** The second section shows every kind of habit the app tracks, then how often each one can repeat.

The hero has already answered what it is, whether it's simple, what the catch is and how to get it. The next doubt is whether this app can hold the habit the visitor actually has in mind.

| Order | Section | The question it answers |
|---|---|---|
| 1 | Hero (approved) | What is it? What's the catch? |
| **2** | **Every kind of habit** | **Will it track mine?** |
| 3, likely | Free and Plus | What exactly do I get free? |
| Later | Progress, widgets, tasks, privacy and backup, questions | Will I keep using it? Are my habits safe? |

Only section 2 is decided here. The rest is a likely order, to be checked when we reach each one.

## What people show

**Scan:** 372,850 unique English reviews across 181 App Store and Play Store collections of habit and routine apps, counted by machine, with a sample read by hand. A review counts when one sentence both asks for something ("I wish", "can't", "please add", "only") and names the theme. These are rough counts and the themes overlap, so read them as size and direction only.

| What the review asks about | Reviews | Share | 1–2★ | 4–5★ |
|---|---:|---:|---:|---:|
| Paying: subscription, paywall, free limit | 12,270 | 3.29% | 52% | 36% |
| Reminders | 5,478 | 1.47% | 24% | 64% |
| Widgets | 2,573 | 0.69% | 15% | 71% |
| Backup and a new phone | 2,069 | 0.55% | 29% | 57% |
| Progress: stats, charts, calendar | 1,357 | 0.36% | 13% | 74% |
| **How often:** weekly, monthly, set days | 1,348 | 0.36% | 13% | 73% |
| **Quit or limit:** bad habits, cut down | 1,174 | 0.31% | 14% | 78% |
| Skip, pause, past days | 1,108 | 0.30% | 26% | 60% |
| **Amounts:** numbers, units | 1,106 | 0.30% | 16% | 72% |
| **Time:** timer, duration | 748 | 0.20% | 15% | 72% |
| **Steps:** sub-habits, checklists | 412 | 0.11% | 23% | 62% |

- **Paying is the biggest theme, and the hero's headline already answers it.** The details (what's free, what's Plus) are the likely third section.
- **The five "will it fit?" themes add up to 4,788 reviews before overlap,** which makes them the largest group the hero leaves open.
- **These are people who nearly stayed.** Roughly three in four of these reviews give 4 or 5 stars, against 36% for paying. Users show an app they like, and one kind of habit it can't hold. They ask for days of the week, 3 times a week, once a month, every other day, units, and a way to track a bad habit.
- **Reminders are bigger, but they don't separate one app from another.** Every serious tracker has them, so they belong in a later feature section (reasoned from first principles).

**Limits of the count:**

- **Hand-read samples are noisy.** About two in three "How often" samples were real requests and about half of "Quit or limit" (some matches were "reduce the price" or praise for a quit app).
- **The "Tasks" count is dropped.** Its pattern caught the ordinary words "to do", so its 6,984 reviews mean nothing. The hero report's 10.1% for tasks is also inflated: most statements in a sample came from to-do apps. Tasks need their own check before they get a section.
- **Reviews come from people who already installed an app,** not from website visitors. No review talks about websites, so the order above is reasoned from what people ask for inside apps.

## What search and AI tools need

Reasoned from first principles, with vendor keyword tools as rough direction only.

- **The hero carries the head term; this section carries the long tail.** It's the first place the page can say, in plain text, what people type: track water, meditation timer, quit smoking, cut down coffee, screen time, weekly goals, checklist.
- **Each kind is a real heading with a line of text,** which gives AI tools short, quotable answers to "can it track X?".
- **It links onward.** Quit and Cut down point to the planned search page for them, and the section to Features.

## What other sites do

Fourteen homepages read, eleven usable. HabitKit, Streaks, Habitify, Way of Life and Productive all follow the hero with what the app does or how it works. None has a pricing section on the homepage, and only two have an FAQ. This is a check on the order, not a reason for it.

## Why not the others

| Option | Why not second |
|---|---|
| **Free and Plus** | Price is weighed once someone knows it fits. The hero's headline already removes the fear, and the price of Plus isn't settled, so the section couldn't give the full answer yet |
| **Reviews or social proof** | The app isn't live. We have none, and we won't invent any |
| **Progress or widgets** | They answer "will I keep using it?", which comes after "can it hold my habit?" |
| **How it works, in steps** | The hero says one tap, and the phone shows it. Steps would repeat that |

## What the section says

From the current Android code (`ItemType`, the How often page), never from memory:

- **Six kinds:** Check it off, Track an amount, Time it, Checklist, Cut down, Quit. Tasks wait for their own section.
- **Checklist carries a Plus tag,** because a new checklist is Plus (Android A73). Showing it as free would be untrue.
- **How often, in the app's words:** Every day, 3 times a week, Every Monday, Wednesday and Friday, Every 3 days, Every other week on Friday, On the 23rd of every month, Every year on October 23.
- **The band says "Flexible schedules" in plain words** above "Often enough doesn't mean every day.", because the brand line alone doesn't tell a person or an AI tool what the feature is (the user, 4 Nov 2026).
- **Example amounts are examples,** never health advice. No claim that the app watches screen time or blocks apps.

## Sources

- Scan: `Research/Temp/website-section-2/` (not in git): `scan.py`, `scan2.py`, `scan3.py`
- Earlier: [Hero Copy](<Hero Copy — What People Look For First — 4 November 2026.md>) · [Website Reset](<Website Reset — Pages, SEO and AI Search — 4 November 2026.md>) · [Feature Ledger](<../Feature Ledger.md>) (C043 flexible frequency, C019 quit mode)
- Android: `ui/newhabit/Choices.kt`, `ui/newhabit/FormPages.kt`
