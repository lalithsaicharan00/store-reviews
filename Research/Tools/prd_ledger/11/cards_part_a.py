import json, re
R = 11
rep = open("App Store Reports/11. Daily Habits - Streak Tracker - Morning Routine & Goal Planner (REPORT).md").read().split("\n")
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

c(1, "header lines 1-7", "positioning",
  "Daily Habits: Streak Tracker (App Store ID 1523643868) is a six-year-old, deliberately minimal habit tracker by a solo developer, historically free with everything unlocked, now with four in-app purchases and a separate paid twin app; a tiny written corpus of 33 reviews",
  "developer Sergey Belychev; bundle com.free-simple-apps.habits; site daily-habits.app; free download; v1.0.165 12 Jul 2026; first released 25 Jul 2020; min iOS 16.6; Lifestyle; 4+; 70 MB; listing declares EN, FR, DE, IT, PT, RU, ES; IAPs 'Habits PRO Functions' $1.99 / $6.99 / $8.99 + 'Daily Habits All Features Pack' $14.99; paid twin 'Daily Habits: Lifetime Premium' $9.99 (ID 1550003470, bundle …habits.paid) = app #63 in this set; store rank 11", "praise",
  "33 reviews, 18 storefronts, 14 Jan 2021 → 25 Aug 2026; distribution 27 / 3 / 0 / 1 / 2; mean 4.576", "none", "corpus-level fact", "app-specific", [])
c(2, "How to read this; ⚠️ The threshold table does not function at this sample size; §10.3 Method; §10.4 Known limitations; §10.5 Counting rules", "data-caveat",
  "Method: n = 33 so one review = 3.03% and lands in the 'very strong' band automatically — the raw count is the primary unit and the percentage is decoration; every finding is a hypothesis with named witnesses; no storefront reaches 50 (largest RU 9) so every country statement is [limited evidence]; 29 of 33 reviews predate 15 Apr 2026 and only 4 come from Aug 2026, and the most consequential findings rest on those four — reported as high-severity because of what they describe and their unanimity, not statistical sufficiency; all 33 read in original language; external store data (iTunes Lookup + US page, 9 Sep 2026) used for listing/price facts",
  "n/a", "none", "signal bands as standard; 1 review = 3.03%; 29 pre-Apr-2026 / 4 Aug-2026; Part 11 indexes all 33", "none", "method", "yes", [])

# ---- PART 0 ----
c(3, "Part 0 Executive summary in one line", "insight",
  "A six-year-old, genuinely loved, deliberately minimal habit tracker whose single largest stated value driver was 'it's free and it doesn't nag you' retrofitted a paywall over previously-free features between Dec 2025 and Apr 2026 — and every one of the three reviewers who then paid lost the access they bought, taking the corpus from 29 consecutive 4–5★ reviews to 1★/2★/1★ in nine days",
  "paywall retrofit + broken entitlements", "1★-burst", "29 reviews mean 4.90, zero below 4★ in five years → 3 of 4 Aug 2026 reviews at 1–2★", "product-rule", "headline", "yes", [])
c(4, "Part 0 §1 Five years without a single bad review, then three in nine days; table (verbatim)", "timeline",
  "The cleanest before/after signal in the analysis set: zero reviews below 4★ for five years and three months (no 3★ in the corpus at all), then two 1★ and one 2★ in nine days of August 2026 — all three about money paid, access lost, in three countries, on three different SKUs (annual / 'VIP' / lifetime)",
  "entitlement failure after paywall retrofit", "1★-burst", table("## 1. Five years without") + " ; distribution 27/3/0/1/2", "must-never-break", "high-severity (n=3, unanimous)", "yes",
  ["14438257886","14446220984","14472099021"])
c(5, "Part 0 §2 100% of direct paid-user evidence in this corpus is an entitlement failure; table (verbatim)", "must-never-break",
  "100% of direct paid-user evidence is an entitlement failure: restore-purchases does not work (BR 'VIP' unlocked a week then re-locked, reinstall did not restore, support silent), a non-consumable lifetime entitlement expired (PK 'worked properly for few months then suddenly my membership cancelled and there is no way in app to talk with developer'), and an active annual subscription is being re-charged (IE 'trying to charge again even though I have a subscription for another 7 months… Appears to be a scam now') — consistent with one receipt-validation / entitlement-persistence defect; two reviewers title their reviews 'scam' and 'Purchase fraud'; promoted under the billing-integrity carve-out",
  "receipts not validated / entitlements not persisted; no in-app support path", "1★-burst", "3 of 33 (9.09%) paid; 3 of 3 (100%) lost access; paid mean 1.33 vs corpus 4.576; " + table("## 2. 100% of direct paid-user"), "must-never-break", "high-severity carve-out", "yes",
  ["14438257886","14446220984","14472099021"])
c(6, "Part 0 §3 The paywall was retrofitted over features that were previously free, and the corpus dates it", "product-rule",
  "The paywall was retrofitted over previously-free features and the corpus dates it to a ~4-month window: 'all functions are free' attested 30 Jan 2025 and 5 Dec 2025 (RU), then 'charging for features that were previously free' by April 2026 (IE); 'free' was the third-most-cited praise theme and was praised in the same breath as 'no pressure' and 'no imposed junk' — a 5★ reviewer explicitly declined to buy ('sorry that I didn't buy'); the free tier WAS the positioning",
  "moved free features behind IAPs Dec 2025–Apr 2026 without disclosure", "1★-burst", "7 of 33 (21.21%, mean 4.86) name 'free' as a reason; window Dec 2025 – Apr 2026; v1.0.165 12 Jul 2026, paid twin last updated 15 Apr 2026", "product-rule", "very strong (count 7)", "yes",
  ["8800831234","10285428672","10985521600","11468101739","12221849177","12249396648","13476851347","14438257886"])
c(7, "Part 0 §4 The purchase driver named in the corpus is data hostage, not feature value", "insight",
  "The only stated purchase motivation in the corpus is data hostage, not feature value — 'I paid the annual fee as I had 3 years worth of history I didn't want to lose' — on a product with no backup or export (the listing has zero mentions of iCloud/sync/backup/cloud/export; the oldest unmet request, Nov 2022, is cloud/iCloud history); long-tenure users are maximally exposed: no way to leave, no way to keep the record if the entitlement lapses — a monetization design where the strongest purchase driver is fear of data loss converts loyal users into 1★ reviewers when billing misfires",
  "no export/backup; history local-only; paywall over history", "1★-burst", "1 stated purchase motive (n=1); cloud request from 25 Nov 2022 still absent 4 years later", "dont", "structural (n=1 + listing check)", "yes",
  ["14438257886","9327859322"])
c(8, "Part 0 §5 The paid ladder is incoherent and undisclosed; table (verbatim)", "monetization",
  "The paid ladder is incoherent and undisclosed: three SKUs share the identical display name 'Habits PRO Functions' at $1.99 / $6.99 / $8.99 (a user cannot tell from a receipt which they own — exactly what two reviewers are trying to describe to support); the lifetime option is $5 cheaper as a separate app ($9.99) than as an IAP ($14.99); reviewers describe subscriptions ('annual fee', 'assinatura', 'subscription for another 7 months') but the IAP list names no periods; and the store description discloses no paywall at all (zero occurrences of 'premium', 'subscription', 'free', 'PRO' as a tier, 'ads' or 'unlock')",
  "4 IAPs with duplicate names, no period disclosure, no paywall disclosure; separate cheaper lifetime app", "1★-burst", table("## 5. The paid ladder"), "dont", "listing check", "yes",
  ["14438257886","14446220984","14472099021"])
c(9, "Part 0 §5 Inference, labelled as such: the free app now shows ads (monitoring item)", "data-caveat",
  "Inference, labelled as such: the paid twin's pitch 'no ads, no banners, no subscriptions' implies the free app now shows ads — but no reviewer mentions ads and the corpus is thin after April 2026; flagged as a monitoring item, not a finding",
  "ads possibly introduced 2026", "none", "0 of 33 mention ads; newest review 25 Aug 2026", "research", "inference", "app-specific", [])
c(10, "Part 0 §6 What people actually love: simplicity, and the absence of pressure", "insight",
  "What people love is simplicity and the absence of pressure — the single dominant theme, stated in five languages across six years; a sharper positioning claim underneath: praise for what the app does NOT do — 'I hate apps that demand set times, and it doesn't bother me about that'; 'not overwhelm me with settings and frills'; 'without any imposed junk'",
  "minimal, no forced schedule, no nag", "praise", "19 of 33 (57.58%, mean 4.95) praise simplicity; 4 of 33 (12.12%, mean 5.00) praise absence of things", "product-rule", "dominant theme", "yes",
  ["8756804446","8800831234","9327859322","9332848196","9758570716","9809639708","10285428672","10315480705","10796416820","10874846443","11375045777","11468101739","12113191512","12221849177","12269558510","12285262144","13469176367","13476851347","13685904641"])
c(11, "Part 0 §6 'No infantilization' is the most commercially interesting phrase in the corpus", "positioning",
  "'Functional, no frills and no infantilization. I tested half a dozen similar apps before finding this one and sticking with it' — a direct rejection of the gamified-pet / cute-companion design language that dominates the category (Finch, Habit Rabbit, Roubit, Blossom); the reviewer tested six competitors and chose this app for what it refuses to do; three reviewers explicitly switched from or compared against competitors ('I deleted all the other apps and kept yours')",
  "non-gamified, adult, plain", "purchase-driver", "1 review ('no infantilization'); 3 of 33 (9.09%, mean 5.00) switched from competitors", "do", "n=1 / n=3", "yes",
  ["13685904641","11904287504","13469176367"])
c(12, "Part 0 §7 Free unlimited habits was the acquisition wedge — and it is the thing that was monetized", "product-rule",
  "Free unlimited habits was the acquisition wedge — 'First app that has more than 3 habits' is a reviewer's entire body — the app won its audience by being the un-paywalled option in a paywalled category, then adopted the category's paywall (up to $14.99 for 'All Features') without disclosure and with broken billing; nothing says the app cannot be monetized — a 5★ reviewer apologises for NOT buying — but the free tier was the differentiator",
  "no 3-habit cap (historically free); status after retrofit unknown", "purchase-driver", "1 review (n=1, diagnostic)", "product-rule", "n=1", "yes",
  ["11904287504","12221849177"])
c(13, "Part 0 §8 The one recurring usability pattern: everything moves one step at a time", "feature",
  "The one recurring usability pattern: the UI offers only single-step increments where a jump is needed — history navigation ('No month view, can only see the active week… Literally have to skip back one day at a time') and list reordering ('it only moves up one position at a time'; 'wish that you add rearranging the tasks') — two screens, 17 months and two countries apart",
  "week-only history; one-step reordering; no drag", "complaint", "2 of 33 (6.06%, mean 4.50) single-step pattern; reordering 2 of 33 (6.06%) on its own", "build-free", "n=2", "yes",
  ["10985521600","11490387774","10016901878"])
c(14, "Part 0 §9 The biggest feature gap is history depth — and the current listing claims it is now fixed", "feature",
  "The biggest feature gap is history depth — cloud/iCloud history, weekly/monthly/yearly statistics, month view, date-range filter, search, per-task completion stats — and the current listing claims 'ADVANCED STATISTICS — weeks, months and individual tasks' and 'DARK THEME' (answering a 4★ 'only yellow-white… not comfortable for eyes in the evening') are shipped; the developer does ship what users ask for, but there is no post-ship review evidence confirming it; cloud backup / export remains unaddressed and is now load-bearing",
  "month/period stats and dark theme claimed shipped Jul 2026; backup/export absent", "complaint", "3 of 33 (9.09%, mean 4.67) ask for history depth; the most detailed critical review is a product brief with 4 asks; 6 reviews after Dec 2025, none confirm", "build-free", "n=3 + listing", "yes",
  ["9327859322","9332848196","10985521600","9809639708"])
c(15, "Part 0 §10 The written corpus is 6% of the ratings, and it is not where the market is; table (verbatim)", "market",
  "The written corpus is 6% of the ratings and is not where the market is: this is a Russia- and Latin-America-first product with a US tail — the US contributes 6.3% of ratings and 1 of 33 written reviews; Mexico (76 ratings) and Colombia (67) are almost silent in the written corpus — the single largest blind spot and the highest-value gap to fill with research",
  "n/a", "none", table("## 10. The written corpus") + " ; ratings by storefront: RU 170, MX 76, CO 67, BR 49, CL 39, US 34, IN 30, AR 27, ES 25, FR 19, DE 15, UA 13, IT 11, GB 10; written 4.576 vs displayed 4.862, gap −0.286", "research", "external data", "app-specific", [])

# ---- PART 1 ----
c(16, "§1.1 Feature inventory table (verbatim)", "feature",
  "Feature inventory: what reviews prove vs what the 12 Jul 2026 listing claims — daily checklist, per-habit reminders, weekly view + daily %, rewards/badges, unlimited habits, optional times (all historically free); month/period stats and dark theme (requested, claimed shipped, unverified); drag-to-reorder, date filter/search (requested, no evidence shipped); cloud backup/export (still missing); widget, multiple lists, AI habit generator, share list (listed, never mentioned by a reviewer); ads (inferred)",
  "see table", "mixed", table("## 1.1 Feature inventory"), "research", "verbatim", "app-specific",
  ["11375045777","12249396648","10874846443","11904287504","8756804446","9332848196","10985521600","9809639708","10016901878","11490387774","9327859322","14438257886"])
c(17, "§1.1 Per-habit reminders; rewards / achievement badges; weekly view + daily completion %", "feature",
  "Small free features draw explicit praise: a separate notification per habit, achievement badges that 'motivate me to come in and check off habits', and the daily percentage with a weekly view",
  "per-habit reminder, badges, weekly view all free", "praise", "1 review each (RU Jan 2025; US Jun 2024)", "build-free", "n=1 each", "yes",
  ["12249396648","11375045777"])
c(18, "§1.1 The most striking row is the AI habit generator", "contradiction",
  "The app's entire current positioning is unvalidated by user feedback: the AI habit generator is the first thing in the description in every storefront, labelled 'NEW', and several storefronts renamed the app around it ('Habit Builder with AI Planner'; 'Hábitos y metas diarias con IA') — yet zero of 33 reviews mention AI in any language (absence of evidence, not rejection: only 6 reviews postdate Dec 2025)",
  "AI habit generator as headline feature", "none", "0 of 33 mention AI", "research", "listing check", "yes", [])
c(19, "§1.2 Monetization architecture — two products against the same feature set; table (verbatim); The paid twin has one rating in six years", "anti-pattern",
  "The developer runs two products against the same feature set: the free app with 4 IAPs and a paid twin at $9.99 up front that has ONE rating in six years — not a distribution channel but a duplicate binary running one version behind, undercutting the in-app lifetime SKU by $5 and creating a second entitlement surface, a plausible contributor to the 'lifetime subscription… suddenly cancelled' confusion",
  "free app + paid twin app", "1★-burst", table("## 1.2 Monetization architecture") + " ; paid twin 1 rating @ 5.00 (US)", "dont", "listing check", "yes",
  ["14472099021"])
c(20, "§1.3 Direct paid-user evidence — 3 reviewers (9.09%), mean 1.33", "monetization",
  "3 of 3 direct paid reviewers report losing purchased access; no conversion rate is claimed or claimable",
  "n/a", "1★-burst", "3 of 33 (9.09%), mean 1.33; segment 3 of 3 (100%)", "must-never-break", "n=3", "yes",
  ["14438257886","14446220984","14472099021"])
c(21, "§1.4 Inferred, non-purchasing interest — purchase_declined", "insight",
  "The only evidence a purchasable option existed before 2026 is a satisfied 5★ user who declined to buy — 'I like that it's free (sorry that I didn't buy)' — coded purchase_declined and excluded from paid evidence",
  "optional purchase existed pre-2026", "praise", "1 review", "research", "n=1", "yes",
  ["12221849177"])

with open("Tools/prd_ledger/11/cards.jsonl", "w") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards written")
