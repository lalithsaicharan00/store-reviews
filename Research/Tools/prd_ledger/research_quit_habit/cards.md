# Cards — research document: Quit Habit Decision

Source: `Research Reports/Quit Habit Decision.md`  
16 cards. Generated from `cards.jsonl` by `cards_to_md.py` — edit the JSONL, not this file.

## Contents

- [Must never break](#must-never-break) — 2
- [Features](#features) — 3
- [Insights (the why)](#insights-the-why) — 1
- [Audiences](#audiences) — 1
- [Markets and languages](#markets-and-languages) — 3
- [Positioning](#positioning) — 1
- [Anti-patterns](#anti-patterns) — 1
- [Things not to do](#things-not-to-do) — 1
- [Things to do](#things-to-do) — 2
- [Data caveats and method](#data-caveats-and-method) — 1

## Must never break

### RQH-010 — A relapse must not wipe history — 'the most-repeated complaint in the Days Since corpus' (10,621 reviews). The specified behaviour is to log the slip, keep the record, and show best-ever alongside current. This is the single most-repeated item in the leading quit tracker's corpus, so it is the defining failure mode of the category.

- **Where:** What to do, item 2
- **This app does:** leading quit tracker: relapse destroys the record
- **User reaction:** complaint
- **Magnitude:** the most-repeated complaint across 10,621 Days Since reviews
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Canonical:** C019 Quit-habit / bad-habit mode — a counter that counts up from the last relapse, with its own vocabulary, relapse record and non-punitive reset; C216 A forgiving long-run measure — cumulative or decaying credit that a missed day does not zero — alongside streaks; C308 Logging a lapse must not be the same action as destroying the count — a quit-tracker needs a way to record a slip, and non-judgemental wording around it

### RQH-013 — Quit mode must be readable in dark mode — 'a literal, fixable complaint about the #1 app', whose quit habits set to 0 per day render as 'nothing is readable because of the all dark colors'. A contrast defect specific to the zero-target state of a quit habit.

- **Where:** What to do, item 5
- **This app does:** leader: quit habits at 0/day are unreadable in dark colours
- **User reaction:** complaint
- **Magnitude:** quoted defect in the #1 app's corpus; document gives no count
- **Direction for us:** must-never-break · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Conditions:** the defect appears specifically when the target is zero
- **Canonical:** C019 Quit-habit / bad-habit mode — a counter that counts up from the last relapse, with its own vocabulary, relapse record and non-punitive reset; C080 Colour themes / dark mode; C171 Accessibility stack: VoiceOver, motion, sound and light sensitivity, text size

## Features

### RQH-009 — A quit habit needs a days-since counter, not a streak: 'Quitting is days clean, not did it today.' The two mechanics are different data models and the document names the counter as the first-class requirement for the habit type.

- **Where:** What to do, item 1
- **This app does:** specified as a build requirement
- **User reaction:** request
- **Magnitude:** document gives no count for this item
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Conditions:** applies to the quit habit type only; good-habit tracking keeps the streak
- **Canonical:** C019 Quit-habit / bad-habit mode — a counter that counts up from the last relapse, with its own vocabulary, relapse record and non-punitive reset

### RQH-011 — Quit goals need allowances, not only zero: "'2 drinks a week' is a real goal; the leader caps at one month and users complain loudly about it." The #1 app's ceiling of a one-month maximum period with a two-drink minimum is quoted in §4 as a blocking limitation for alcohol tracking.

- **Where:** What to do, item 3
- **This app does:** leader: max period 1 month, 2-drink minimum, no open-ended allowance
- **User reaction:** complaint
- **Magnitude:** document gives no count; the leader's limit is quoted verbatim from its reviews
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Conditions:** moderation goals are a distinct mode from abstinence goals
- **Canonical:** C019 Quit-habit / bad-habit mode — a counter that counts up from the last relapse, with its own vocabulary, relapse record and non-punitive reset; C048 Flexible units / partial progress; C108 Goals / targets

### RQH-012 — Milestones carry the emotional payload of a quit tracker: 1/7/30/90 days plus money saved, and "Days Since's happiest reviews (4.77 average) are milestone screenshots" — the highest-rated behaviour in the leading quit corpus is a user photographing a milestone, which makes the milestone screen both the retention moment and the sharing surface.

- **Where:** What to do, item 4
- **This app does:** leading quit tracker: milestones present and they are its best-rated moment
- **User reaction:** praise
- **Magnitude:** milestone-screenshot reviews average 4.77★ in the 10,621-review Days Since corpus
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Side effects:** the milestone screen doubles as the organic-sharing surface
- **Canonical:** C019 Quit-habit / bad-habit mode — a counter that counts up from the last relapse, with its own vocabulary, relapse record and non-punitive reset; C100 Money-saved counter; C101 Milestones, achievements, celebration

## Insights (the why)

### RQH-005 — Silence in the review corpus is not absence of demand when the leader already ships the feature: of 56,653 reviews of the #1 app only 164 (0.29%) mention quitting, but reading them they are 'overwhelmingly complaints about the existing quit feature, not requests for one'. The document treats the low count as evidence of a satisfied-then-disappointed surface rather than a dead one — a general rule for reading any request count against a feature that already exists.

- **Where:** §4
- **This app does:** n/a
- **User reaction:** complaint
- **Magnitude:** 164 of 56,653 reviews (0.29%) mention quitting; the majority of those are complaints about the shipped feature
- **Direction for us:** product-rule · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Conditions:** holds when the incumbent ships the feature; a 0.29% count for a feature nobody ships means something different
- **Canonical:** C142 Surface existing features where users look; C310 A low request count for a feature the market leader already ships measures satisfaction with that implementation, not demand for the feature

## Audiences

### RQH-007 — The quit audience and the build-good-habits audience barely overlap: only 2.4% of Days Since reviewers ask for good-habit building, and 'Quit users mostly want one thing: a clean day counter that does not reset.' The document says this cuts both ways — a combined app will not cannibalise a quit app, but a separate quit app gains almost no cross-sell: 'Two apps, two ASO efforts, two support queues, for two groups that don't migrate.'

- **Where:** §5
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 2.4% of Days Since reviewers ask for good-habit building
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Side effects:** low overlap removes the cannibalisation risk and the cross-sell case at the same time
- **Conditions:** measured on the Days Since corpus (10,621 reviews)
- **Canonical:** C060 Cross-sell an app family on brand trust; C309 Quit tracking belongs inside the habit app as a habit type — never as a second, generic 'quit anything' app

## Markets and languages

### RQH-002 — The generic 'quit anything' market has one incumbent and a graveyard behind it. US ratings (verbatim): App | US ratings ; Days Since: Quit Habit Tracker | 19,073 ; Quitzilla: Quit Tracker | 1,473 ; Quit Bad Habits & Addiction | 1,061 ; Days Without: Break Bad Habits | 6 ; ZeroBadHabits | 0 — 'One app has traction. The rest are near zero. That is not a market with room in it.' The ceiling on the category leader is ~19k US ratings.

- **Where:** §1; §1 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** Days Since 19,073; Quitzilla 1,473; Quit Bad Habits 1,061; Days Without 6; ZeroBadHabits 0
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Conditions:** applies to a generic quit tracker, not to a vertical one
- **Canonical:** C019 Quit-habit / bad-habit mode — a counter that counts up from the last relapse, with its own vocabulary, relapse record and non-punitive reset; C309 Quit tracking belongs inside the habit app as a habit type — never as a second, generic 'quit anything' app

### RQH-003 — The money in quitting is in verticals, not in 'quit anything'. US ratings (verbatim): App | US ratings ; I Am Sober | 186,328 ; Smoke Free | 57,263 ; Reframe: Drink Less | 44,339 ; Sober Time | 41,632 ; Nomo — Sobriety Clocks | 16,398 ; QuitNow! | 13,572 — 'These beat every generic quit app by 3-10x.' The stated reason is search intent plus content: someone quitting smoking searches 'quit smoking', not 'quit tracker', and wants lung-recovery milestones, craving support and a community, 'none of which a generic counter provides'. The conclusion is that a generic quit app loses on both sides — too vague for the vertical searcher and redundant for the habit-tracker user.

- **Where:** §2; §2 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** I Am Sober 186,328; Smoke Free 57,263; Reframe 44,339; Sober Time 41,632; Nomo 16,398; QuitNow! 13,572 — 3-10x the generic apps
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Side effects:** vertical apps own the high-intent keywords and the recovery content
- **Conditions:** the vertical advantage rests on milestone content and community, not on the counter
- **Canonical:** C019 Quit-habit / bad-habit mode — a counter that counts up from the last relapse, with its own vocabulary, relapse record and non-punitive reset; C309 Quit tracking belongs inside the habit app as a habit type — never as a second, generic 'quit anything' app

### RQH-008 — What people actually quit, from 10,621 Days Since reviews (verbatim): Category | Share of reviews ; Alcohol | 5.0% ; Smoking / vaping | 3.7% ; Social media / phone | 2.0% ; Sugar / junk food | 1.0% ; Weed / drugs | 0.7% ; Nail biting, caffeine, gambling | 0.6% ; Porn | 0.2%. The two largest categories are locked up by the verticals; social media and phone use are not — 'no large dedicated app owns it, and it's the third-biggest quit reason. That's the one quit niche with genuine room.'

- **Where:** §6; §6 table (verbatim)
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** alcohol 5.0%, smoking/vaping 3.7%, social media/phone 2.0%, sugar 1.0%, weed/drugs 0.7%, nail biting/caffeine/gambling 0.6%, porn 0.2% of 10,621 reviews
- **Direction for us:** research · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Side effects:** phone/social-media quitting is the unclaimed vertical
- **Conditions:** shares are of all reviews, not of quit-intent reviews only
- **Canonical:** C019 Quit-habit / bad-habit mode — a counter that counts up from the last relapse, with its own vocabulary, relapse record and non-punitive reset; C309 Quit tracking belongs inside the habit app as a habit type — never as a second, generic 'quit anything' app

## Positioning

### RQH-004 — Quit tracking is becoming table stakes inside habit trackers rather than a differentiator: 8 of the top 40 habit trackers explicitly market breaking bad habits — including Habit Tracker (#1), HabitKit, Streaks and Simple Streak — and 'the #1 app already ships a Quit tab'. The document states both halves plainly: 'Shipping it doesn't differentiate you. Not shipping it is starting to look like a gap.'

- **Where:** §3
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 8 of the top 40 habit trackers market quitting; the #1 app ships a Quit tab
- **Direction for us:** must-have · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Conditions:** quit as a habit type is defensive parity; the differentiation has to come from doing it well, not from having it
- **Canonical:** C019 Quit-habit / bad-habit mode — a counter that counts up from the last relapse, with its own vocabulary, relapse record and non-punitive reset

## Anti-patterns

### RQH-006 — The #1 app's quit implementation fails in five named ways, quoted from its reviews: 'the streak counter is sometimes wrong for Quit habits'; 'It is not possible to track if you want to quit drinking alcohol. You can only choose a max period of 1 month with a 2 drink minimum?'; "When habits are set to 'Quit' with 0 per day — nothing is readable because of the all dark colors"; 'I click the QUIT habit tab, I get the form error'; 'Bad for quitting habits'. The document names this as the opportunity: 'The leader ships quit-habits badly. Doing it properly is a differentiator inside your existing app — and costs you nothing in downloads, because the traffic is already coming for habit tracking.'

- **Where:** §4 quotes (verbatim)
- **This app does:** leader: wrong streak count on quit habits, 1-month/2-drink allowance ceiling, unreadable dark mode, form error on the Quit tab
- **User reaction:** complaint
- **Magnitude:** five distinct defects quoted from the #1 app's 56,653-review corpus
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Side effects:** no incremental download cost — the traffic already arrives for habit tracking
- **Conditions:** a differentiator only if the implementation is correct; shipping the same defects gains nothing
- **Canonical:** C019 Quit-habit / bad-habit mode — a counter that counts up from the last relapse, with its own vocabulary, relapse record and non-punitive reset; C308 Logging a lapse must not be the same action as destroying the count — a quit-tracker needs a way to record a slip, and non-judgemental wording around it; C310 A low request count for a feature the market leader already ships measures satisfaction with that implementation, not demand for the feature

## Things not to do

### RQH-014 — Do not build a generic quit app as a second listing: 'It would compete with your own app for the same keywords, cap out around 19k ratings, and read as a repackage.' Three separate costs are named — keyword cannibalisation against your own listing, a hard ceiling at the incumbent's ~19k US ratings, and the reputational reading of a reskin.

- **Where:** What to do, closing; 'Do not' paragraph
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** ceiling ~19k US ratings (Days Since); same-keyword competition with your own listing
- **Direction for us:** dont · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Canonical:** C278 Do not name the app after an established competitor — a name collision makes the product 'the fake one' before it is tried, and the cost cannot be measured from reviews; C309 Quit tracking belongs inside the habit app as a habit type — never as a second, generic 'quit anything' app

## Things to do

### RQH-015 — If a second app is ever built it must be vertical and genuinely different — the document names a phone/social-media quit app, 'given that niche is unclaimed', and sets the bar explicitly: 'That is a different product with different content, not a reskin, so it wouldn't look like spam.' Different content, not a re-theme, is the test that separates a legitimate second listing from a spam signal.

- **Where:** 'If you later want a second app' paragraph
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** phone/social media is 2.0% of Days Since reviews and unclaimed by a large dedicated app
- **Direction for us:** research · **Report confidence:** emerging · **Generalisable:** generalisable
- **Side effects:** avoids the App Store spam-reskin reading that a generic second quit app would attract
- **Conditions:** conditional on the second product having its own content, not a shared codebase with a new skin
- **Canonical:** C060 Cross-sell an app family on brand trust; C309 Quit tracking belongs inside the habit app as a habit type — never as a second, generic 'quit anything' app

### RQH-016 — Quit terms are a keyword surface a habit app can annex without a second listing: Days Since ranks #3 overall in the category on ranking strength and #1 in 10 rich markets 'purely on quit terms'. Adding a proper quit mode lets one listing compete for 'quit habit', 'break bad habits' and 'sobriety tracker' alongside the habit keywords, 'without splitting your ASO across two listings.'

- **Where:** The bonus: keyword surface
- **This app does:** Days Since: #3 overall ranking strength, #1 in 10 rich markets, on quit terms alone
- **User reaction:** mixed
- **Magnitude:** #3 overall on ranking strength; #1 in 10 rich markets
- **Direction for us:** do · **Report confidence:** high-priority · **Generalisable:** generalisable
- **Side effects:** one listing carries both keyword sets; no second ASO or support queue
- **Canonical:** C140 Market the generic-tracker use case; C309 Quit tracking belongs inside the habit app as a habit type — never as a second, generic 'quit anything' app

## Data caveats and method

### RQH-001 — Research document, not a review corpus: a decision memo answering 'should quit-habits be a feature or a separate app?'. Its evidence base is 56,653 reviews of the category's #1 app (Habit Tracker), 10,621 reviews of the leading quit tracker (Days Since), and App Store search and ratings-count results across the standalone quit and vertical-sobriety markets. Public US ratings counts are the unit throughout, not downloads or revenue; no review IDs are cited, so every number resolves to a ratings count or a share-of-corpus figure rather than to an individual review. Headline recommendation stated up front: 'build it as a feature. Do not ship a generic quit tracker app.'

- **Where:** header; intro lines 1-8
- **This app does:** n/a
- **User reaction:** mixed
- **Magnitude:** 56,653 + 10,621 reviews behind it; App Store ratings counts as the market unit; no review IDs
- **Direction for us:** none · **Report confidence:** method · **Generalisable:** generalisable
- **Conditions:** market-structure evidence, so it ranks category positions rather than user sentiment
- **Canonical:** — (nuance register)
