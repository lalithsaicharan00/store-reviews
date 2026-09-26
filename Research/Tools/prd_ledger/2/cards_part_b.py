import json, re
R = 2
rep = open("App Store Reports/2. Daily Habits - Habit Tracker - Habit List and Routine Tracker (REPORT).md").read().split("\n")
def table(start, end):
    rows = [l for l in rep[start-1:end] if l.startswith("|") and not re.match(r"^\|[\s\-:|]+\|$", l)]
    return " ; ".join(re.sub(r"\s*\|\s*", " | ", l.strip("|")).replace("**","").strip() for l in rows)
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))

# ---- PART 2 ----
c(36, "Part 2 5★ table (verbatim)", "insight", "What produces 5★ (n=314): unlimited habits 29 ('the single biggest 5★ engine'), simple/clean 103, reminders that work 22, 'compared and chose this' 21, one-time cheap price 16",
  "n/a", "5★-burst", table(170, 176), "none", "high-priority", "yes", [])
c(37, "Part 2 5★ row 1", "monetization", "Unlimited habits / a generous free tier is the single biggest 5★ engine",
  "unlimited habits free", "5★-burst", "29 of 314 5★ reviews", "build-free", "high-priority", "yes", [])
c(38, "Part 2 5★ row 4", "positioning", "'I compared it against others and chose this' appears in 21 5★ reviews — genuine preference, not default",
  "wins head-to-head comparisons", "praise", "21 of 314 5★; 6.00% of corpus (Part 3)", "do", "high-priority", "yes", [])
c(39, "Part 2 1–2★ table (verbatim)", "must-never-break", "What produces 1★ (n=47) and 2★ (n=31): crashes 14/4 (29.8% of 1★), data loss 11/6 (23.4%), confirmed payer 10/2, refund language 8/0, reminders don't fire 6/3, Watch broken 5/3, calendar damage 1/4",
  "n/a", "1★-burst", table(180, 188), "must-never-break", "high-priority", "yes", [])
c(40, "Part 2 1★ row 1", "must-never-break", "Crashes / freezes / unusable are the dominant cause of 1★ — 29.8% of all one-star reviews",
  "crashes; iOS 14 crash regression", "1★-burst", "14 of 47 1★, 4 of 31 2★; 28 total (5.42%, mean 2.11, Part 4)", "must-never-break", "high-priority", "yes", [])
c(41, "Part 2 1★ row 2", "must-never-break", "Data loss / progress reset is the #2 cause of 1★ — 23.4% of one-star reviews",
  "data lost on relaunch, on iOS upgrade, at random", "1★-burst", "11 of 47 1★, 6 of 31 2★; 22 total (4.26%, mean 1.95, Part 4)", "must-never-break", "high-priority", "yes", [])
c(42, "Part 2 1★ row 6", "must-never-break", "Apple Watch broken draws concentrated, disproportionate anger — 5 of 47 1★ and 3 of 31 2★",
  "Watch app shows 'No actions', wrong day, won't sync back", "1★-burst", "5 1★ + 3 2★; 12 negative of 15 mentions (2.32%, mean 2.33)", "must-never-break", "meaningful", "yes", [])
c(43, "Part 2 3–4★ table (verbatim)", "feature", "The 'almost' band (3★ n=36, 4★ n=89): stats too thin 2/7, reminder sound too quiet 1/7, not in my language 5/5, can't schedule '3× a week' 2/5, date off by one 5/3, sync unreliable 3/4, can't reorder 3/0",
  "n/a", "complaint", table(194, 203), "none", "high-priority", "yes", [],
  side="fixing the sound, the stats, flexible scheduling and reordering would move a large share of 125 near-miss reviews upward — none require new product surface")
c(44, "Part 2 3–4★ row 2", "feature", "Reminder sound too quiet and not customisable is a 4★ blocker — the cheapest win in the list, asked by happy users",
  "one fixed quiet sound", "complaint", "1 3★ + 7 4★; 10 requests (1.93%, mean 4.10, Part 5)", "build-free", "meaningful", "yes", [])

# ---- PART 3 ----
c(45, "Part 3 table (verbatim)", "insight", "Praise themes: simple/clean 140 (27.08%, 4.56); unlimited habits free 30 (5.80%, 4.97); reminders that work 30 (5.80%, 4.77); chose over competitors 31 (6.00%, 4.29); one-time price 19 (3.68%, 4.84); customisation incl. own photos 34 (6.58%, 4.35); widget/3D Touch 17 (3.29%, 4.00); calendar integration when it works 5 (0.97%, 4.00)",
  "n/a", "praise", table(210, 219), "none", "high-priority", "yes", [])
c(46, "Part 3 row 1", "insight", "Simple / clean / easy is the dominant praise — 27.08% of all reviews at mean 4.56",
  "minimal design", "praise", "140 (27.08%), mean 4.56", "must-have", "high-priority", "yes", [])
c(47, "Part 3 row 2 + bold paragraph", "monetization", "The unlimited free tier is the most positively-charged theme in the corpus (mean 4.97; 29 of 30 mentions 5★) and it is what people tell their friends about",
  "no habit limit in free", "5★-burst", "30 (5.80%), mean 4.97, 29/30 5★", "build-free", "high-priority", "yes",
  ["8188213087","5875158296","9216520052","10643933062","9636902294","3609568795","1520986091","6950869104","7740420763","4840822821","2911210521","3655435197","13629753462","12571415671","4317482186","3651405499","3338942850"],
  side="'Other apps only let you enter 3 habits for free and with this one you have no limits'; 'I'm just going to get the premium version to support the developers' — generosity converts to goodwill purchases",
  cond="unlimited reminders are praised in the same breath")
c(48, "Part 3 row 3", "feature", "Reminders that work are a high-priority praise theme (5.80%, mean 4.77)",
  "per-habit reminders, free", "praise", "30 (5.80%), mean 4.77", "build-free", "high-priority", "yes", [])
c(49, "Part 3 row 6", "feature", "Customisation — icons and personal photos — is the second-largest praise theme (6.58%)",
  "custom icons + own photos, free", "praise", "34 (6.58%), mean 4.35", "build-free", "high-priority", "yes", [])
c(50, "Part 3 'personal photos' paragraph", "feature", "Personal photos on habits is a small but distinctive delight that no competitor mentioned in this corpus offers",
  "own photo as a habit icon, free", "praise", "6 IDs; 'the visual really keeps me motivated'", "undecided", "small, distinctive", "yes",
  ["5559605362","1508808010","11920843498","4502143627","3511211105","1485913018"])
c(51, "Part 3 row 7", "feature", "Today Widget / 3D Touch is praised at 'very strong' band but with the lowest mean of the praise items (4.00)",
  "Today widget + 3D Touch, free; no iOS 14+ widget", "praise", "17 (3.29%), mean 4.00", "build-free", "very strong", "yes", [],
  cond="modern iOS 14+ widget requested (Part 5) — the old widget aged with the app")
c(52, "Part 3 row 8", "feature", "Calendar integration is praised when it works (0.97%) — and damages calendars when it doesn't",
  "calendar sync, paid", "mixed", "5 (0.97%), mean 4.00 praise vs 9 (1.74%), mean 2.11 damage", "research", "emerging", "yes", [])
c(53, "Part 3 'shop before choosing' paragraph", "positioning", "6.00% of reviewers actively shopped before choosing this app — tried 10, a dozen, '20 hours testing' — so the product wins on merit when compared, beating Productive and Way of Life",
  "wins comparisons on free tier + simplicity", "praise", "31 (6.00%), mean 4.29", "do", "high-priority", "yes",
  ["3562883708","9489418687","1663634672","7562844763","1509521731","1641223556","1673348075","1683318031","1485799388","1492916849","1835187375","2069816938"])

# ---- PART 4 ----
c(54, "Part 4 table (verbatim)", "must-never-break", "Complaint themes: crashes 28 (5.42%, 2.11); data loss 22 (4.26%, 1.95); broken Pro 35 (6.77%, 2.83); date off by one 14 (2.71%); Watch broken 12 (2.32%, 2.33); sync broken 12 (2.32%); reminders don't fire 10 (1.93%, 1.50); calendar damage 9 (1.74%, 2.11); abandonware 9 (1.74%); onboarding confusion 10 (1.93%, 3.30); slow/laggy 7 (1.35%); dated design 6 (1.16%, 3.67); ads 6 (1.16%, 3.67); rating-prompt & cross-promo spam 4 (0.77%)",
  "n/a", "complaint", table(237, 252), "none", "high-priority", "yes", [])
c(55, "Part 4 combined line", "must-never-break", "56 reviews (10.83%, mean 2.05) report a stability failure — data loss, crash, freeze or crippling lag; one review in nine",
  "unstable", "1★-burst", "56 (10.83%), mean 2.05", "must-never-break", "high-priority", "yes", [])
c(56, "Part 4 'Data loss is the app-killer'", "must-never-break", "Data loss reads the same in every language and never got fixed across 2016–2023: entries gone on next launch, a month reset to incomplete, six months wiped, all habits gone after iOS 14.5 — one user about to buy Pro didn't",
  "local data lost on relaunch / iOS upgrade / at random; no developer response", "1★-burst", "22 (4.26%), mean 1.95", "must-never-break", "high-priority", "yes",
  ["1511065444","1538217704","1543097703","5423974093","5726080829","5891978522","6379792275","7271771390","9488272822","5403701988","1777981808","1816542296","8106352419","1560960588","5548521598","1580919614","1542809054","1519202196","4089300870","3518102228","3313222571","1481301722"],
  side="data loss blocks conversion as well as causing churn: 'There's no point keeping a log'")
c(57, "Part 4 'off-by-one date bug'", "must-never-break", "The off-by-one date bug (app/widget/Watch shows tomorrow as today) was reported in the first two weeks after launch, fixed once in Nov 2016 — two users raised their ratings to 5★ for the fast turnaround — then came back and stayed for years",
  "timezone/date bug, regressed", "complaint", "14 (2.71%), mean 2.71; reported 2016–2019", "must-never-break", "meaningful", "yes",
  ["1479044283","1480026316","1483978534","1484186051","1775022964","1581035694","3496905165","4115836897","1490259621","1490152355"],
  side="a fast fix earns upgraded ratings; a regression of the same bug earns years of complaints")
c(58, "Part 4 'Apple Watch'", "feature", "The Apple Watch app is broken for most who mention it (12 negative of 15) — 'No actions' while the phone is full, wrong day, no sync back — yet it is a purchase driver when it works ('far superior to other habit trackers')",
  "Watch app exists, free, unreliable", "mixed", "12 negative of 15 mentions (2.32%), mean 2.33", "build-paid", "meaningful", "yes",
  ["1856430373","3313222571","3032470486","4115836897","1816542296","3385244633","11151750805","3297361804","3496905165","4402829597","7515450312","1777981808","1482775394"],
  side="'I'd advise Apple Watch users not to buy'")
c(59, "Part 4 'Calendar sync damages the calendar'", "must-never-break", "Calendar sync is the most severe individual complaint class: blank undeletable events, ~20 copies of each item, infinite duplicates, a phantom 2001 event, every habit written as a one-hour block — one user spent hours with Apple support restoring their phone",
  "paid calendar sync writes bad events into the system calendar", "1★-burst", "9 (1.74%), mean 2.11", "must-never-break", "meaningful", "yes",
  ["1650678342","1508808010","1639153995","4494723296","1484435569","2493571137","1816432913","9974150902","5683048621"],
  side="a feature that damages data outside the app produces 'I've never left a bad app review before' reviews",
  cond="writing to shared system stores (calendar, health) needs the highest reliability bar")
c(60, "Part 4 table row 'Reminders don't fire'", "must-never-break", "Reminders not firing is the lowest-mean complaint theme (1.50) — it breaks the only job that matters",
  "reminders sometimes fail", "1★-burst", "10 (1.93%), mean 1.50", "must-never-break", "meaningful", "yes", [])
c(61, "Part 4 table row 'Onboarding confusion'", "feature", "Onboarding confusion draws 10 reviews (1.93%) at mean 3.30",
  "confusing first run", "complaint", "10 (1.93%), mean 3.30", "must-have", "meaningful", "yes", [])
c(62, "Part 4 table row 'Slow / laggy'", "must-never-break", "Slow / laggy (5+ seconds per tap in one paid case) draws 7 reviews at mean 2.57",
  "performance lag", "complaint", "7 (1.35%), mean 2.57", "must-never-break", "meaningful", "yes", [])
c(63, "Part 4 table row 'Dated design'", "positioning", "Dated or unattractive design draws 6 reviews (1.16%, mean 3.67) — 'doesn't look as nice as the Atomic Habits app'",
  "design frozen since 2021; 'only green'", "complaint", "6 (1.16%), mean 3.67", "do", "meaningful", "yes", ["12488497405"])
c(64, "Part 4 table row 'Ads'", "monetization", "Ads in the free version draw 6 complaints (1.16%, mean 3.67) and are a stated reason for 3 purchases",
  "ads in free tier", "complaint", "6 (1.16%), mean 3.67", "research", "meaningful", "yes", [],
  cond="report 1's 'no ads' was the best-rated topic — ads are a mild negative here, not a 1★ driver")
c(65, "Part 4 table row 'Rating-prompt & cross-promo spam'", "anti-pattern", "Rating-prompt and cross-promo spam (promoting the developer's other apps) draws 4 complaints",
  "in-app prompts for ratings and sibling apps", "complaint", "4 (0.77%), mean 3.00", "dont", "emerging", "yes", [])

# ---- PART 5 ----
c(66, "Part 5 table (verbatim)", "feature", "Feature requests: deeper statistics 13 (2.51%, 3.31); 'X times per week' 12 (2.32%, 3.42); louder/custom reminder sounds 10 (1.93%, 4.10); localisation 14 (2.71%, 3.50); reorder habits 9 (1.74%, 4.33); journal/notes 8 (1.55%, 3.62); colour themes/dark mode 5 (0.97%, 3.60); cross-app integration 10 (1.93%, 3.10); modern iOS 14+ widget 5 (0.97%, 3.00)",
  "n/a", "complaint", table(289, 299), "none", "high-priority", "yes", [])
c(67, "Part 5 row 1", "feature", "Better / deeper statistics is the #1 request: weekly-monthly-yearly review, per-habit charts, month/year calendar",
  "stats thin; extended stats paid and deficient", "complaint", "13 (2.51%), mean 3.31", "build-paid", "meaningful", "yes", [],
  cond="the paid stats are what users find thin — a paid reports feature must be substantial")
c(68, "Part 5 row 2 + paragraph", "feature", "'X times per week' scheduling is the highest-value missing capability — fixed weekdays only is 'the #1 model complaint'; '3 times a week on random days and keep the streak… this is the clue of keeping the habit'",
  "specific weekdays only", "complaint", "12 (2.32%), mean 3.42; also 2-weekly / 2-monthly asks", "must-have", "meaningful", "yes",
  ["8509313946","3826839521","1644836488","3654077349","1543097703","1663634672","12040349741","7580228017","4502143627","5960513517","3604096686","1534636069"])
c(69, "Part 5 row 3", "feature", "Louder / customisable reminder sounds — asked by happy users (mean 4.10); the cheapest win in the list",
  "one quiet fixed sound", "complaint", "10 (1.93%), mean 4.10", "build-free", "meaningful", "yes", [])
c(70, "Part 5 row 5 + paragraph", "feature", "Manual reordering of habits is the best effort-to-goodwill ratio in the corpus — mean 4.33, requested across six countries over eight years, never shipped; last-added jumps to the top",
  "no manual reorder", "complaint", "9 (1.74%), mean 4.33", "build-free", "meaningful", "yes",
  ["1534483238","1488986466","1700631660","4874970421","11247319482","7897418954","4025884406","4204815325","3537709874"])
c(71, "Part 5 row 6", "feature", "Journal / notes improvements: comments vanish, note field too small, no search",
  "notes exist but lossy and small", "complaint", "8 (1.55%), mean 3.62", "undecided", "meaningful", "yes", [])
c(72, "Part 5 row 7", "feature", "Colour themes / dark mode — 'is only green, more colors needed'",
  "single green theme", "complaint", "5 (0.97%), mean 3.60", "build-free", "emerging", "yes", [])
c(73, "Part 5 row 8", "feature", "Cross-app integration with the developer's Be Focused / Focus Matrix is requested by 10 (1.93%) and assumed to exist — its absence caused 1★ reviews",
  "none", "complaint", "10 (1.93%), mean 3.10", "research", "meaningful", "app-specific", [])
c(74, "Part 5 row 9", "feature", "A modern iOS 14+ widget is requested — ties directly to abandonment",
  "legacy Today widget only", "complaint", "5 (0.97%), mean 3.00", "build-free", "emerging", "yes", [])

with open("Tools/prd_ledger/2/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
