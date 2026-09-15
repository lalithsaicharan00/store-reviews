import json, re
R = 14
rep = open("App Store Reports/14. My Habits - Daily Habit Builder - Tracker for Goals & Routine (REPORT).md").read().split("\n")
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
  "My Habits: Daily Habit Builder (App Store ID 814998643), originally shipped as 'Hab-It', is a small freemium 'Seinfeld streak' tracker by a solo developer — read as a post-mortem: last version 1.7 shipped 29 Dec 2020, roughly five years eight months without an update",
  "developer Siarhei Marozau; bundle savefon.mobi.Hab-It-; free with 'Premium Access' $1.99 one-time IAP; English only; iOS 9+; store rank 14", "mixed",
  "70 written reviews, 14 storefronts, 15 Mar 2014 → 19 Oct 2021; written mean 3.857; " + table("## 1.6 External source"), "none", "corpus-level fact", "app-specific", [])
c(2, "How to read this; ⚠️ Four warnings; §1.1–1.5 files, schema, coverage, method, limitations; §1.7 Corpus composition; §9.1 counting rules", "data-caveat",
  "Method: n=70 so one review = 1.43% and 'high-priority' means 4–14 people — counts are the honest unit; no country reaches 50 (US 20) so no per-country section; the corpus is history not current state (85.71% of reviews 2014–15, app unupdated since Dec 2020); the store's 3-rating count cannot be reconciled with 20 US written reviews (likely a ratings reset) — do not use the 4.3★ figure; all 70 read in full chronologically, 25 non-English translated, manual non-exclusive labels counted by script; judgement calls disclosed (a Korean 'purchase list' review not counted as paid; an implied payer kept separate; a body reading 'Review' coded low-information); 18 reviews (25.71%) ≤30 chars of substance, 12 of 34 five-star; two gaps: 8 Jul 2016 → 11 May 2020 (1,403 days) and Mar–Oct 2021",
  "n/a", "none", "70/70 read; 0 duplicates; 14 storefronts reconcile; 5★34 / 4★16 / 3★5 / 2★6 / 1★9; storefronts us 20 · kr 12 · ru 11 · gb 6 · jp 4 · au 3 · by 3 · mx 3 · br 2 · cn 2 · de 1 · in 1 · mo 1 · ua 1; language EN 45, Cyrillic 10, KO 8, ES/PT 3, ZH 2, JA 2; votes on 3 records; is_edited false on all", "none", "method", "yes", [])

# ---- PART 0 ----
c(3, "Part 0 §1 The core mechanic worked. The business around it did not.", "insight",
  "The core mechanic worked and the business around it did not: a fifth of reviewers say the app changed their behaviour, simplicity praise is unanimously 5★, and several tried multiple competitors and picked this one — 'a great app if you're looking for a Seinfeld streak tracker that's simple and easy to use… Marking off another green day and keeping the streak going is really satisfying'; what killed it is a short list of execution failures — nag prompts, crashes, data loss, a broken purchase button, abandonment",
  "simple streak grid, freemium", "praise", "outcome 14 (20.00%) mean 4.93 (13 of 14 5★); simplicity 10 (14.29%) mean 5.00; chose over competitors 5 (7.14%) mean 5.00", "product-rule", "high-priority (counts)", "yes",
  ["1076855737"])
c(4, "Part 0 §2 The single most transferable finding: nagging cost this app a full star, and the corpus proves the fix worked", "timeline",
  "Nagging cost this app a full star and the corpus proves the fix worked: the only theme where users state the exact star penalty — 'every time I run the free version, windows keep popping up telling me to write a review or buy. I docked one star for this'; 'Happy now??'; 'killed with constant nagging for a rating and upgrade. Deleted'; 'making me wait for the message then dismiss it is counterproductive. I'm very unlikely to pay for the upgrade just to get rid of the pestering' — every complaint falls 18 Nov 2014 – 21 Jan 2015, then 'They removed the pop ups. Nice!!' (5★) and 'not annoying at all… Their competitor Way of Life already managed to become tiresome by begging for an upgrade within the first minute' — no further nag complaint in 6.4 years",
  "rating + upsell pop-ups on every launch of the free version, removed early 2015", "1★-burst", "nag complaints 6 (8.57%) mean 3.00; any mention 9 (12.86%) mean 3.67; complaints 18 Nov 2014 – 21 Jan 2015; 5★ praise for removal May–Jun 2015", "dont", "high-priority (counts), cleanest before/after", "yes",
  ["1113922936","1115315804","1126869931","1130477064","1133797353","1099032136","1193853972","1208386132"],
  side="the rival Way of Life was still giving away the same advantage")
c(5, "Part 0 §2 Two second-order effects: the nagging polluted the ratings data; it directly caused a lost sale", "dont",
  "Two second-order effects of the nag prompt: it polluted the ratings data (at least 3 records exist only because the app demanded a review — 'I don't usually leave reviews, but it kept telling me to, so here's one'; a review whose title and body are the word 'Review'), and it directly caused a lost sale — an explicit refusal to pay BECAUSE of the upsell mechanism; the upsell destroyed the conversion it was built to create",
  "prompt-driven reviews; upsell refusal", "churn", "3 records (4.29%) prompt-driven; 2 (2.86%) refused to pay citing nags", "dont", "meaningful (counts)", "yes",
  ["1115315804","1126869931","1122529516","1099032136","1133797353"])
c(6, "Part 0 §3 Data loss is the only theme with a perfect 1★ record", "must-never-break",
  "Data loss is the only theme with a perfect 1★ record: 'After months of tracking it's all gone in the latest update. Stay away from this app if you value your data'; 'After the update all my marks disappeared'; 'I don't want to backdate all my progress by memory (again)' — the first two are one day apart (a single bad release in May 2015), the 2020 '(again)' shows it recurred 5.5 years later; for a streak tracker the accumulated chain IS the product; the only review telling other buyers to stay away",
  "update wiped tracked history, twice", "1★-burst", "3 (4.29%) mean 1.00, all 1★; 9–10 May 2015 + 25 Nov 2020", "must-never-break", "very strong (counts)", "yes",
  ["1195475837","1194862743","6684084592"])
c(7, "Part 0 §4 Crashes bracket the entire lifespan and are what the app died of; table (verbatim)", "must-never-break",
  "Crashes bracket the entire lifespan and are what the app died of: the lowest-rated theme; the app broke at each major iOS transition and was repaired slowly or not at all — 'Opens but then crashes with new iOS 14. Same thing happened with iOS 13 and it took them a while to fix it… if this is not fixed by next week I will just delete the app'; the 2020 crash fires on the single most-used action, checking a habit off; a date that never rolls over requiring a device restart every day; v1.7 shipped five weeks after and is still current — whether it fixed the crash is unknowable from two later 4★ reviews; the reliability problem is a maintenance-capacity problem, not a coding problem",
  "crashes at iOS 13/14 transitions; slow or no fixes", "1★-burst", "6 (8.57%) mean 1.50 (4 of 6 1★); " + table("## 4. Crashes bracket"), "must-never-break", "high-priority (counts)", "yes",
  ["961881835","1077393973","1176859130","1241930865","6678082433","6684084592","7082831771","7929736347"])
c(8, "Part 0 §5 Purchase intent is three times more common than evidence of purchase, and the buy button was broken; intent table (verbatim)", "monetization",
  "Purchase intent is three times more common than evidence of purchase — 'With free apps the whole point is to try it before you decide'; 'Will continue to evaluate for a week or so but if I'm still just as happy I'll be upgrading'; 'Well worth trying out and paying for the upgrade' — while the only confirmed buyer at $3 found it 'too basic for the $3 expended' (wanted weekly/monthly trends), and two willing buyers in 2020 could not complete the purchase ('When I click upgrade button, it only appears an orange screen and then disappears'; 'I couldn't find the extended version') five to seven months before the last-ever release; demand to pay was present, articulated and repeatedly obstructed — first by the upsell's tone, later by a broken checkout",
  "3-habit free cap; one-time Pro unlock; upgrade button broken in 2020", "blocked-conversion", "intent 6 (8.57%) mean 4.50; paid explicit 2 (2.86%) + 1 implied; purchase blocked 2 (2.86%) both 4★; refused 2 (2.86%) both 2★; " + table("## 5. Purchase intent"), "must-never-break", "high-priority (counts)", "yes",
  ["1056568978","1128016301","1130585398","1137963077","1184550500","1222427563","1026996445","1036447473","6183382407","5929885128","1174519073"])
c(9, "Part 0 §5 the only support interaction in the corpus, which was excellent — promo code after a monetisation model change", "tactic",
  "The only support interaction in the corpus was excellent: 'when my account had problems due to the move to a new monetisation model, they immediately sent me a promo code for the new app (which is paid)' — a 5★ that also records a mid-2014 monetisation model change",
  "promo code to bridge a model change", "praise", "n=1 (1.43%)", "do", "n=1", "yes",
  ["1036447473"])
c(10, "Part 0 §5 What this does not show — no conversion rate, ARPU or paid-satisfaction rate", "data-caveat",
  "With 2 confirmed payers out of 70, no conversion rate, ARPU or paid-satisfaction rate can be computed and none is claimed",
  "n/a", "none", "2 of 70", "none", "method", "yes", [])
c(11, "Part 0 §6 Localisation was asked for, never delivered, and the store listing still shows English only", "market",
  "Localisation was asked for, never delivered, and the listing still shows English only: over a third of reviews are non-English and Russian-language storefronts are the second-largest group after the US; 'I can't rate it, because I've spent 20 minutes and still can't switch the language. I really need an app like this, but in Russian!' — both requests unanswered for a decade in a product whose entire UI is a handful of labels",
  "English only", "blocked-conversion", "25 of 70 (35.71%) non-English; ru+by+ua 15 (21.43%); explicit Russian asks 2 (2.86%) [limited evidence]", "build-free", "limited evidence", "yes",
  ["1157833711","1265490751"])

# ---- PART 1 ----
c(12, "§1.5 Limitations — the app actively solicited ratings in-app during 2014–15, so an unknown share of early positive records exist because of a prompt", "data-caveat",
  "Selection bias is unquantifiable and worsened by the app soliciting ratings in-app during 2014–15 — an unknown share of the early positive records exist because of a prompt, at least 3 say so outright",
  "n/a", "none", "3 (4.29%) say so", "none", "method", "yes", [])
c(13, "§1.7 Corpus composition ratings table (verbatim); storefronts; language; date gaps", "data-caveat",
  "Corpus composition: ratings, storefronts, language, and two gaps exceeding 200 days including a 1,403-day hole",
  "n/a", "mixed", table("## 1.7 Corpus composition") + " ; gaps 8 Jul 2016 → 11 May 2020 (1,403 days), 9 Mar → 19 Oct 2021 (224 days)", "none", "verbatim", "app-specific", [])

# ---- PART 2 ----
c(14, "§2.1 Feature inventory derived from reviews table (verbatim); confirmed absent list", "feature",
  "Feature inventory: calendar/grid check-off ('green day'), streak/chain, good and bad habits, statistics and graphs, reminders, editing/backdating, works fully offline, multiple habits at a glance, counted habits with a max of 6 per day, a habit 'diary'; confirmed absent and requested: iPad/universal, widget, colour schemes, adjustable font size, per-day alarm scheduling, weekly/monthly trend views, non-daily periodicity, onboarding tutorial, Russian localisation",
  "see table", "mixed", table("## 2.1 Feature inventory") + " ; absent: iPad, widget, colour schemes, font size, per-day alarms, trend views, non-daily periodicity, tutorial, Russian", "research", "verbatim", "app-specific",
  ["1076855737","1184550500","6678082433","1002707223","959856482","1036447473","1147730742","1208386132","1195988013","1113922936","1054073250","1195162150","1407746285","1056568978","1190931941","1026996445","7082831771","1174519073"])
c(15, "§2.1 Works fully offline, no network needed to check in; Tracks both good habits to build and bad habits to break; Counted habits with a maximum of 6 entries per day", "feature",
  "Praised or noted capabilities: works fully offline; tracks both good habits to build and bad habits to break; counted habits capped at 6 entries per day",
  "offline; good + bad habits; counted habits max 6/day", "praise", "offline n=1; good/bad 3; 6/day cap n=1", "build-free", "medium/low", "yes",
  ["1195988013","1002707223","959856482","1054073250"])
c(16, "§2.2 Monetisation model table (verbatim); two model changes; one disclosure complaint", "monetization",
  "Monetisation: free download capped at 3 habits, one-time 'full version'/'Pro' IAP — $3 in 2014, $1.99 'Premium Access' today; weekly/monthly trend analysis evidently not in the paid tier either (requested by a paying user); two model changes visible — a mid-2014 monetisation model change with a separate paid SKU, and a price reduction; one 2016 disclosure complaint that IAPs were not indicated in the store (now labelled)",
  "free (3 habits) + $1.99–$3 one-time unlock", "mixed", table("## 2.2 Monetisation model") + " ; disclosure complaint 1 (1.43%)", "build-paid", "review-derived", "yes",
  ["1174519073","1130585398","1184550500","1137963077","1222427563","1026996445","1036447473","1374720328"])

with open("Tools/prd_ledger/14/cards.jsonl", "w") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards written")
