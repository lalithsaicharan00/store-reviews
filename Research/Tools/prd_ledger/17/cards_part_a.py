import json, re
R = 17
rep = open("App Store Reports/17. Daily Routine - Organise your time into blocks (REPORT).md").read().split("\n")
def table(after, k=0):
    i = next(n for n, l in enumerate(rep) if after in l)
    blocks, cur = [], []
    for l in rep[i+1:]:
        if l.startswith("|"): cur.append(l)
        elif cur:
            blocks.append(cur); cur = []
            if len(blocks) > k: break
    if cur: blocks.append(cur)
    rows = [l for l in blocks[k] if not re.match(r"^\|[\s\-:|]+\|$", l)]
    return " ; ".join(re.sub(r"\s*\|\s*", " | ", l.strip("|")).replace("**","").strip() for l in rows)
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))

c(1, "header lines 1-10; §1.6 External source table (verbatim)", "positioning",
  "Daily Routine (App Store ID 1580007457) — 'Organise your time into blocks' — is a timeline / time-blocking day scheduler relaunched in Sep 2021 on a subscription after its beloved one-time-purchase predecessor 'Daily Routine Classic' was abandoned and pulled; the decision it informs is how to relaunch a beloved, abandoned paid app on a subscription",
  "developer Daily Routine Pty Ltd; bundle com.dailyroutine.bundle-id.daily-routine-apple-universal; Free label with Monthly $1.99 / Annual $19.99 / One-Time $64.99; v1.1.4 released 9 Jan 2023; English only; iPhone only; store rank 17", "mixed",
  "38 written reviews, 12 storefronts, 5 Sep 2021 → 3 Aug 2026; written mean 3.132; store 3.4★ from 41 ratings; " + table("## 1.6 External source"), "none", "corpus-level fact", "app-specific", [])
c(2, "How to read this; ⚠️ Three warnings; §1.1 Files used; §1.2 Schema; §1.3 Coverage and reconciliation; §1.4 Processing method; §1.5 Limitations and judgement calls; §9.1 counting rules", "data-caveat",
  "Method: n=38 so one review = 2.63% and 'high-priority' is 3 reviews — counts are the honest unit; but reviews are unusually substantial (median body 236 chars, ~4× other small corpora) so the corpus supports mechanism findings better than rates; no country reaches 50 (US 18), global only; 18 of 30 crawled storefronts (incl. GB, AU, FR, IT, JP, KR) returned zero reviews; selection bias runs to both poles — nostalgic returners and blocked non-buyers — the quiet paying middle is under-represented; 12 pure-praise (all 5★) vs 26 with criticism (mean 2.27), almost no middle; judgement calls: a 1★ containing its own pasted prior 5★ counted once; the sabotage allegation coded as grievance not defect; a 5★ reading 'support ipad icloud' coded as a request; store 3.4★ vs written 3.13 are close because written reviews are nearly the whole rating population",
  "n/a", "none", "38/38 read; 0 duplicates; 12 storefronts reconcile; 5★14 / 4★6 / 3★1 / 2★5 / 1★12; vote_count non-zero on 12; is_edited false on all (understated); 3 non-English (2 ES, 1 DE)", "none", "method", "yes",
  ["9244113250","9289248731","9957602682","13120304447"])

# ---- PART 0 ----
c(3, "Part 0 §1 This is not a habit-tracker corpus. It is a relaunch-migration corpus; population table (verbatim)", "timeline",
  "A relaunch-migration corpus: more than half of reviews reference the predecessor 'Daily Routine Classic' — a paid app that built a devoted following, went years without maintenance, became unusable, was pulled, and was relaunched Sep 2021 on a subscription; the legacy base splits into returning users delighted by the relaunch (mean 4.46) and legacy buyers who feel betrayed (mean 1.17) — a 3.29-star gap inside the same user base over the same event, separated not by the product but by whether they had paid for the original",
  "abandoned one-time app relaunched as subscription with no migration", "mixed", "classic references 20 of 38 (52.63%); " + table("## 1. This is not a habit-tracker corpus"), "product-rule", "high-priority (counts)", "yes", [])
c(4, "Part 0 §2 The relaunch bought roughly one quarter of goodwill, then spent it; era table (verbatim)", "timeline",
  "The relaunch bought a quarter of goodwill then spent it: relaunch euphoria (mean 4.30, 9 of 10 reference the classic) → first full year 2.62 as new users with no nostalgia hit a paywall on first launch — a 1.68-star drop; the opening ratings were a loan against the classic app's reputation, not a measure of the new product",
  "relaunch on legacy goodwill", "mixed", table("## 2. The relaunch bought"), "product-rule", "counts", "yes", [])
c(5, "Part 0 §3 The single largest negative theme: you cannot try the app at all", "product-rule",
  "The largest negative theme: you cannot try the app at all — 'Was excited to use this just to find out that I can't because it's not free??'; 'I couldn't get out of the payment subscription page'; 'the free trial is entirely unusable without going through payment confirmation. Can't even look at the settings or examine how the app will handle cancelation' — none of the seven describes the product; they rated an app they never saw; the 'Free · In-App Purchases' label sets the expectation; a user who cannot inspect the cancellation flow before committing must trust blind a developer who already abandoned once",
  "hard paywall on first launch; trial gated behind payment confirmation", "1★-burst", "7 (18.42%) mean 1.14, 6 of 7 1★ — lowest-rated theme", "product-rule", "high-priority (counts)", "yes",
  ["8863711662","10621025077","10024637302","12167506108","9992175230","9471017050","9289248731"])
c(6, "Part 0 §4 The pricing is the second trust problem, and the numbers are now public; price table (verbatim)", "monetization",
  "Pricing is the second trust problem: Monthly $1.99, Annual $19.99, One-Time $64.99 — the lifetime is 3.25 years of the annual, asking users to bet on the longevity of a developer who already broke that bet once ('A one-time purchase is available for three times the price of a premium word processor… all future versions are free. Until the next pricing model'; 'Is there a chance that I buy the new version and they aren't going to drop it in couple years again?' — answered by events)",
  "$64.99 lifetime vs $19.99/yr", "complaint", "price objection 5 (13.16%) mean 1.60; " + table("## 4. The pricing is the second trust problem"), "product-rule", "high-priority (counts)", "yes",
  ["9289248731","7849996761"])
c(7, "Part 0 §4 5 reviewers object to the shift from one-time purchase to subscription; sabotage allegation (reported perception, not fact)", "product-rule",
  "Five reviewers object to the shift from one-time purchase to subscription — 'you broke functionality and ditched support for the old classic version I bought; to make this version that costs considerably more up-front, forcing people to subscribe… That is disgusting' — and one alleges the classic app was deliberately broken ('a special dialog: Crashing in 5 seconds'); treated as reported perception, not established fact, but a paying customer publicly concluded the developer sabotaged a product they had bought",
  "one-time → subscription; classic left broken", "1★-burst", "sub-model objection 5 (13.16%) mean 1.40; sabotage allegation n=1", "product-rule", "high-priority (counts)", "yes",
  ["8874399635","9289248731"])
c(8, "Part 0 §5 The app was abandoned once, relaunched on a subscription, and has now been abandoned again — while still charging", "must-never-break",
  "The most consequential finding: abandoned once, relaunched on a subscription, abandoned again while still charging — current version 1.1.4 released 9 Jan 2023, more than three and a half years without an update; 'I'm getting tired of the paywall with zero app updates. If we can get iPad and watch apps along with more regular debugging, I will keep paying. Otherwise, I am switching to Blocos when they develop a calendar integration' (the single most actionable review: continued payment contingent on continued development, competitor and trigger feature named); the corpus closes on 'Obsolete. Where's the updates? I want my Daily Routine Classic back'",
  "subscription charged on an app unupdated for 3.5+ years", "churn", "abandonment 4 (10.53%); last release 9 Jan 2023", "must-never-break", "high-priority (counts)", "yes",
  ["13193213543","13441826130","13120304447","14384355988","7849996761"])
c(9, "Part 0 §6 What people actually love: the timeline, and one feature no competitor has — no alternative exists; timeline model praised", "positioning",
  "Nearly a quarter of the corpus says they searched for a replacement and failed ('I was searching for routine/habits app that would fill the void, but honestly none of apps could'; 'I've been using it for 10 years, even when it degraded to a buggy app… still the best and the only one perfect for my needs'); the timeline / time-blocking model itself is praised ('The only app in the store that queues up duties as the time approaches… Epic, a major health care app… has a Brains timeline. This is what Daily Routine has achieved')",
  "timeline-first time-blocking scheduler", "praise", "no alternative 9 (23.68%) mean 4.22; timeline praised 8 (21.05%) mean 4.50", "must-have", "high-priority (counts)", "yes",
  ["7988825337","8013032927","7775035126","9504102829"])
c(10, "Part 0 §6 The one capability named as unique: global schedule shifting — the product's moat, stated once, absent from the listing", "feature",
  "The one capability named as unique to this app is global schedule shifting — 'there is no other app that allows you to easily globally shift a schedule, rather than moving all tasks individually. Invaluable for my erratic work and sleep schedule… jet lag or sleep problems'; the one competitor that came close (Sorted) failed because it collected unchecked tasks and froze — this is the product's moat, stated once, and it appears nowhere in the store listing",
  "global schedule shift (shift the whole day at once)", "praise", "n=1 (2.63%), high-value", "must-have", "n=1", "yes",
  ["7886496270"])
c(11, "Part 0 §6 Time blindness / ADHD; Support that converts", "audience",
  "Two more value signals: 'I experience time blindness and this app helps manage that immensely' — a specific clinical use case for a timeline-first scheduler; and support that converts — 'I asked for a feature and the dev emailed me personally when they implemented it. This is above and beyond' — the only support interaction, a 5★",
  "timeline scheduler; personal dev email", "praise", "n=1 each (2.63%)", "do", "n=1", "yes",
  ["8557538403","8244932708"])
c(12, "Part 0 §7 The product is hard to learn, and the corpus says exactly which words confuse people; a day of experimenting vs a hard paywall", "must-have",
  "The product is hard to learn and the corpus names the words that confuse people — 'what is a sequence? What is a block? What is an activity? What's the difference between them?'; 'I deleted it after trying to make it work for a good 30 minutes'; satisfied users confirm the curve is real but surmountable ('takes a day of experimenting'; 'very different UI than all the other apps… once you get it you'll love it') so the problem is onboarding, not design — a day of experimenting is what the product asks, and a hard paywall demands payment before that day",
  "unique block/sequence/activity model; no tutorial; paywall before learning", "complaint", "learning curve 7 (18.42%) mean 3.43 (2★–5★); no tutorial 3 (7.89%)", "must-have", "high-priority (counts)", "yes",
  ["8827339965","8644242601","8013032927","7866331165","7988825337","8557538403"])

# ---- PART 1 ----
c(13, "§1.3 Note on the empty storefronts — GB, AU, FR, IT, JP, KR returned zero written reviews", "market",
  "Major markets including GB, AU, FR, IT, JP and KR returned zero written reviews; with an English-only listing this suggests effectively no reach outside a handful of markets — an observation, not a finding",
  "English only; no reach", "none", "18 of 30 crawled storefronts empty", "research", "observation", "app-specific", [])
c(14, "§1.7 Corpus composition ratings table (verbatim); bimodal; storefronts; language; volume by year", "data-caveat",
  "A strongly bimodal distribution — 68.42% of reviews are 5★ or 1★, only one 3★; the product does not produce moderate opinions",
  "n/a", "mixed", table("## 1.7 Corpus composition") + " ; storefronts us 18 · in 4 · ca 3 · de 3 · mx 2 · ru 2 · ch 1 · cn 1 · cy 1 · pl 1 · ro 1 · se 1; EN 35, ES 2, DE 1; by year 2021 10 · 2022 13 · 2023 6 · 2024 3 · 2025 4 · 2026 2", "none", "verbatim", "app-specific", [])

# ---- PART 2 ----
c(15, "§2.1 Feature inventory derived from reviews table (verbatim); confirmed absent or removed", "feature",
  "Feature inventory: timeline day view of time blocks; 'blocks', 'activities' and 'sequences' as core objects; repeatable sequences; global schedule shift; colour categories + emoji; per-block alarms; a 'reality' view of what actually happened vs planned; 'planning eras'; schedule separate from system calendar; absent or removed: calendar integration (present in classic, removed — still blocking in 2025), iPad, Mac, Apple Watch, iCloud sync, in-app tutorial",
  "see table", "mixed", table("## 2.1 Feature inventory") + " ; absent: calendar integration, iPad, Mac, Watch, iCloud sync, tutorial", "research", "verbatim", "app-specific",
  ["7859394020","9504102829","10884354864","8557538403","8827339965","7780256223","7886496270","7975035126" if False else "7780256223","8275228824","9957602682","13441826130","11035825108","8013032927"])
c(16, "§2.1 Calendar integration — present in the classic version, removed in this one, still blocking in 2025", "feature",
  "Calendar integration was present in the classic version and removed in the relaunch ('the calendar integration is no more. I loved seeing my appointments, too') — and in 2025 it is the named trigger for switching to a competitor",
  "removed calendar integration", "churn", "2 reviews across 2021–2025", "must-have", "n=2", "yes",
  ["7780256223","13441826130"])
c(17, "§2.1 Two precise structural defects — a single instance of a repeating block cannot be edited or deleted; editing in 'reality' view does not cascade", "must-never-break",
  "Two precise structural defects, each reported independently by two engaged 4★ users: a single instance of a repeating block cannot be edited or deleted ('I can only change ALL workout blocks in the sequence for today and everyday going forward'), and editing a block in reality view does not cascade to following blocks ('getting ready for work will overlap with the workout block, rather than being pushed to 7:16am') — both break the promise the app is sold on: a time-blocking app whose blocks cannot absorb a real day's slippage fails when most needed; 'If these two features are added it is definitely 5⭐️'",
  "no single-instance edit; no cascade on slip", "complaint", "2 (5.26%) mean 4.00, both 4★", "must-never-break", "high-priority (counts)", "yes",
  ["7780256223","8557538403"])
c(18, "§2.2 Monetisation model table (verbatim); the migration failure is explicit — grandfathering, a loyalty discount, or not breaking the old app", "monetization",
  "Monetisation: Free label hard-gated in practice, no functional free tier, a trial gated behind payment confirmation, $1.99/mo, $19.99/yr, $64.99 lifetime; the classic app was a one-time purchase, discontinued with no migration path; the grievance group's core complaint is explicit — 'Without grandfathering the existing customers or even offering a discount so they could buy the lifetime at a discounted price. Or could have at least left the old app in a working state' — three asks, none done, every one cheaper than the six 1–2★ reviews it produced",
  "no grandfathering, no discount, classic left broken", "1★-burst", table("## 2.2 Monetisation model") + " ; legacy grievance 6 (15.79%) mean 1.17", "product-rule", "counts", "yes",
  ["8863711662","10621025077","12167506108","9289248731","9471017050","8013032927","8557538403","7849996761","8874399635","11033875205"])

with open("Tools/prd_ledger/17/cards.jsonl", "w") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards written")
