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

# ---- PART 5 ----
c(30, "§5.1 The evidence base, stated honestly table (verbatim)", "data-caveat",
  "Paid evidence base: confirmed paid 2, implied 1, stated intent 6, blocked 2, refused 2, any monetisation content 12; the value is the mechanism, not the magnitude",
  "n/a", "mixed", table("## 5.1 The evidence base"), "none", "method", "yes", [])
c(31, "§5.2 What made people want to pay — use the free tier → find it works → decide to upgrade; the 3-habit cap is a delicate setting", "insight",
  "All six purchase-intent reviewers describe the same sequence — use the free tier, find it genuinely works, decide to upgrade — none mentions a paywall, trial timer, onboarding pitch or discount; the conversion driver is demonstrated value over days of real use, which is why the 3-habit cap is a delicate setting: too tight and the user never accumulates the streak that creates the desire to pay; intent survived DESPITE the pop-ups ('Other than the in app purchase Pop ups every time I open it, this is a fantastic free app. Trying it out a little longer before I purchase')",
  "free tier → one-time unlock", "purchase-driver", "6 intent (8.57%) mean 4.50", "product-rule", "counts", "yes",
  ["1184550500","1128016301","1130585398","1056568978","1174519073"])
c(32, "§5.3 What stopped people from paying — four barriers in descending order", "monetization",
  "Four barriers to paying, in descending order of how badly they reflect on the business: the checkout was broken (revenue lost at the last step from users who had already decided); the upsell mechanism repelled the buyer; the paid tier did not contain what the buyer wanted — a 1★ from a payer that names its own remedy ('Might be worth it if weekly and monthly trending were added. I know I'd change my opinion'), the single most actionable paid-user record; disclosure",
  "broken checkout; nags; shallow paid tier", "blocked-conversion", "checkout 2 (2.86%); nags 2 (2.86%); shallow tier 1; disclosure 1", "must-never-break", "counts", "yes",
  ["6183382407","5929885128","1099032136","1133797353","1026996445","1374720328"])
c(33, "§5.4 Post-purchase experience — a one-time IAP at $1.99–$3 generated no billing-integrity grievances at all", "monetization",
  "The two confirmed payers land at opposite poles (a 1★ who found the analysis too shallow; a 5★ rescued with a promo code), and no refund request, unexpected charge, charge-after-cancel or failed restore appears anywhere — a one-time IAP at $1.99–$3 generated no billing-integrity grievances at all, in sharp contrast to the subscription apps in this dataset",
  "$1.99–$3 one-time unlock", "praise", "0 billing grievances of 70; 2 payers at 1★ and 5★", "build-paid", "clean record (n=70)", "yes",
  ["1026996445","1036447473"])

# ---- PART 6 ----
c(34, "Part 6 MARKET AND LANGUAGE NOTES (limited evidence)", "market",
  "Limited-evidence market notes: the corpus is broadly distributed (US only 28.57%; Korea and Russia together exceed it); Russian-language storefronts are the largest bloc after English and produced the only localisation requests; every nag-prompt complaint outside the US came from Korea or the UK, and the three Korean records are the only ones quantifying the star penalty or writing a review purely to satisfy the prompt (n=4, not a market finding); both 2020 crash reports came from Europe two days apart — a single iOS 14 regression",
  "n/a", "mixed", "us 20 (28.57%); kr 12; ru 11; ru+by+ua 15 (21.43%); nag outside US n=4; 2020 crashes de+gb", "research", "limited evidence", "app-specific",
  ["1157833711","1265490751","1113922936","1115315804","1126869931","1099032136","6678082433","6684084592"])

# ---- PART 7 ----
c(35, "§7.1 Method — unbalanced buckets; year table (verbatim)", "timeline",
  "Year buckets are severely unbalanced (2014: 23, 2015: 37, 2016: 4, 2020: 4, 2021: 2) so 2016–21 is treated as one thin tail; mean 4.30 (2014) → 3.78 (2015) → 3.25 → 2.50 (2020) → 4.00 (2021, n=2)",
  "n/a", "mixed", table("## 7.1 Method"), "none", "verbatim", "app-specific", [])
c(36, "§7.2 Trend 1 — Review volume collapsed, and there is a 3.8-year hole in the corpus", "data-caveat",
  "Review volume collapsed: 85.71% of reviews in the first 22 months, then nothing for 1,403 days (Jul 2016 → May 2020); consistent with an app that stopped being marketed and updated, but the corpus cannot distinguish 'nobody used it' from 'users stopped writing' from crawl retention — an observation, not a measured decline",
  "abandoned", "none", "60 of 70 in first 22 months; 1,403-day gap; 6 reviews (8.57%) from 2020–21", "none", "interpretation flagged", "yes",
  ["1407746285","5929885128"])
c(37, "§7.3 Trend 2 — Mean rating declined across the app's life; the rating decline is a reliability decline", "timeline",
  "The mean declined across the app's life and the only movement with a usable sample (2014 → 2015, −0.52) is driven by 1★ reviews rising from 4.35% to 16.22%, five of six being reliability or data-loss reports — the rating decline is a reliability decline",
  "reliability regressions", "1★-burst", "4.30 → 3.78; 1★ 1 of 23 → 6 of 37; 5 of 6 reliability/data", "must-never-break", "usable sample both sides", "yes",
  ["1176859130","1194862743","1195475837","1241930865","1174519073"])
c(38, "§7.4 Trend 3 — Fixed: the nag prompts (the corpus's one clear success); table (verbatim)", "timeline",
  "The nag prompts were fixed — the corpus's one clear success: 6 complaints in the Nov 2014 – Jan 2015 window (37.5% of reviews then), zero in the following 44 reviews over 6.7 years; a single, cheap change eliminated the theme responsible for half of all 2★ reviews and it never resurfaced",
  "pop-ups removed early 2015", "praise", table("## 7.4 Trend 3"), "do", "clean before/after", "yes",
  ["1193853972","1208386132"])
c(39, "§7.5 Trend 4 — Persistent: crashes at every OS transition; the counterfactual — when this developer fixed things, users noticed and rewarded it", "timeline",
  "Crashes persist at every OS transition across 6.7 years ('Same thing happened with the new iOS 13 and it took them a while to fix it'); the counterfactual: a 1.4.2 bug that made recorded habits inaccessible WAS fixed and the reviewer returned to post 5★ — the problem was cadence, not capability",
  "slow fixes at iOS transitions", "1★-burst", "crash reports 2014 (2), 2015 (2), 2020 (2)", "must-never-break", "persistent", "yes",
  ["961881835","1077393973","1176859130","1241930865","6678082433","6684084592","1197160923"])
c(40, "§7.6 Trend 5 — Emerging late: monetisation plumbing broke before the app died", "timeline",
  "The last thing the corpus records before the app went quiet is that both the product and its checkout stopped working at once: both broken-upgrade reports (May and Jul 2020) are among the final six substantive records, in the same window as the iOS 14 crashes",
  "checkout broken in final months", "blocked-conversion", "2 broken-upgrade reports 2020; 0 earlier", "must-never-break", "late-emerging", "yes",
  ["5929885128","6183382407"])
c(41, "§7.7 What persisted unchanged across the whole corpus", "insight",
  "Persisted unchanged: simplicity as the core attraction, praised from Mar 2014 to Oct 2021 ('Great interface, works well'); feature requests stayed small and stayed unmet — iPad (2014), font size (2014), widget (2015), colour schemes (2016), custom periodicity (2021) — not one resolved, no release since Dec 2020",
  "minimal; requests unmet", "praise", "simplicity praised 2014–2021; 5 named requests unmet", "product-rule", "persistent", "yes",
  ["961128068","1076855737","1195988013","1222427563","7929736347"])

# ---- PART 8 ----
c(42, "§8.1 I1 Never destroy user history on update — migration tests, automatic pre-migration backup, visible restore path", "must-never-break",
  "Never destroy user history on update: migration tests, automatic pre-migration backup and a visible restore path — in a streak tracker the accumulated chain IS the product",
  "history wiped on update", "1★-burst", "N3 3 (4.29%) mean 1.00", "must-never-break", "recommendation (immediate)", "yes",
  ["1195475837"])
c(43, "§8.1 I2 Treat the check-off action as tier-zero — never crash, OS-beta regression test before every major iOS release", "must-never-break",
  "Treat the check-off action as tier-zero: it must never crash and must be covered by an OS-beta regression test before every major iOS release — the app broke on iOS 13 and again on iOS 14",
  "check-off crashes after OS updates", "1★-burst", "N2 6 (8.57%) mean 1.50", "must-never-break", "recommendation (immediate)", "yes",
  ["6678082433"])
c(44, "§8.1 I3 Remove or hard-cap in-app rating and upgrade prompts — at most one, dismissible permanently, never on launch, never before demonstrated value", "dont",
  "Remove or hard-cap in-app rating and upgrade prompts — at most one, dismissible permanently, never on launch, never before demonstrated value; the corpus contains its own before/after result; the cheapest rating improvement available",
  "prompts on every launch", "1★-burst", "6 negative reviews in 9 weeks; removal → 5★ praise", "dont", "recommendation (immediate)", "yes",
  ["1193853972","1208386132"])
c(45, "§8.1 I4 Instrument and repair the upgrade flow; alert on purchase-sheet failures", "must-never-break",
  "Instrument and repair the upgrade flow and alert on purchase-sheet failures — 'the orange screen' is willing money that never arrived; a freemium app with a broken buy button monetises nothing",
  "purchase sheet fails silently", "blocked-conversion", "N6 2 (2.86%), both 4★", "must-never-break", "recommendation (immediate)", "yes",
  ["6183382407"])
c(46, "§8.1 I5 Fix date rollover — the app must advance to the new day without a restart", "must-never-break",
  "Fix date rollover: the app must advance to the new day without a restart — 'having to restart every single day' breaks the one daily interaction the product exists for",
  "date never rolls over", "complaint", "n=1 (jp, 2★)", "must-never-break", "recommendation (immediate)", "yes",
  ["1077393973"])
c(47, "§8.2 B1 Support non-daily habit periodicity and per-day-of-week reminder schedules", "feature",
  "Support non-daily periodicity (n× per week, every n days) and per-day-of-week reminder schedules — a data-model limit and the app's most recent substantive feedback",
  "daily-only", "complaint", "n=1 + n=1", "must-have", "recommendation (build next)", "yes",
  ["7082831771","1190931941"])
c(48, "§8.2 B2 Add weekly and monthly trend views above the daily grid", "feature",
  "Add weekly and monthly trend views above the daily grid — the only dissatisfied confirmed payer named this exact gap and said they would revise their rating; aligns with statistics praise (5 reviews, all 5★)",
  "daily trend only", "complaint", "N8 n=1 (1★ payer); P4 5 (7.14%) 5.00", "build-paid", "recommendation (build next)", "yes",
  ["1026996445"])
c(49, "§8.2 B3 Protect and market the two named differentiators: offline check-in and editable past days", "do",
  "Protect and market the two named differentiators — offline check-in and editable past days — the reasons two reviewers chose this app over rivals; neither appears in the store listing",
  "offline + backdating exist but are unmarketed", "purchase-driver", "n=1 each", "do", "recommendation (build next)", "yes",
  ["1195988013","1184550500"])
c(50, "§8.2 B4 Refresh the visual language on a schedule", "do",
  "Refresh the visual language on a schedule — the UI was praised as attractive in 2014 and called dated by Jan 2015; a 2020-era build in 2026 has no chance",
  "stale UI", "complaint", "N5 3 (4.29%)", "do", "recommendation (build next)", "yes", [])
c(51, "§8.2 B5 Localise — Russian first; the UI is a few dozen strings", "market",
  "Localise, Russian first — 21% of reviews come from Russian-language storefronts, the only two language requests are Russian, and the UI is a few dozen strings; one user spent 20 minutes hunting for a language switch and withheld a rating [limited evidence]",
  "English only", "blocked-conversion", "N7 2 (2.86%); ru/by/ua 15 (21.43%)", "build-free", "recommendation (build next), limited evidence", "yes",
  ["1157833711"])
c(52, "§8.2 B6 Ship the small asks — iPad/universal, widget, colour schemes, font size, raise the 6-entry cap", "feature",
  "Ship the small asks — iPad/universal, widget, colour schemes, adjustable font size, raise the 6-entry cap: each is one review, collectively 5 of 12 requests, all from 4–5★ users, and one makes a purchase conditional on font size",
  "absent", "praise", "5 of 12 requests, all 4–5★", "build-free", "recommendation (build next)", "yes",
  ["1002707223","1195162150","1407746285","1056568978","1054073250"])
c(53, "§8.3 M1 Keep the try-then-buy structure and the one-time purchase", "monetization",
  "Keep the try-then-buy structure and the one-time purchase — every purchase-intent reviewer describes use-free → see-it-work → upgrade, and a $1.99–$3 one-time IAP generated no billing grievances in 70 reviews",
  "free tier + one-time unlock", "purchase-driver", "6 intent mean 4.50; 0 refund complaints", "build-paid", "recommendation", "yes", [])
c(54, "§8.3 M2 Re-test the free habit cap — 3 may be below the threshold at which a user accumulates a streak worth paying to keep", "monetization",
  "Re-test the free habit cap: 3 may be below the threshold at which a user accumulates a streak worth paying to keep — the cap must be generous enough to create the streak that creates the desire; today it is the only free-tier complaint that reached 1★",
  "3-habit free cap", "blocked-conversion", "N4 3 (4.29%); 1 at 1★", "undecided", "recommendation", "yes",
  ["1174519073","6183382407"])
c(55, "§8.3 M3 Make the upsell earn its place — trigger it on a value moment, never on launch", "product-rule",
  "Make the upsell earn its place: trigger it on a value moment (a completed week, the cap being hit), never on launch — one user kept intent despite the pop-ups, another lost it because of them; same mechanism, opposite outcomes, decided by timing",
  "upsell on launch", "mixed", "n=2 contrasting", "product-rule", "recommendation", "yes",
  ["1099032136","1130585398"])
c(56, "§8.3 M4 Answer support — the highest-leverage single action in the corpus", "must-have",
  "Answer support — the one recorded support interaction turned a billing failure into a 5★ review; the highest-leverage single action in the corpus",
  "responsive support (once)", "praise", "n=1 (5★)", "must-have", "recommendation", "yes",
  ["1036447473"])
c(57, "§8.4 Research questions this corpus cannot answer; part 8 #1; part 8 #2; part 8 #3; part 8 #4; part 8 #5", "data-caveat",
  "Research questions: did v1.7 fix the iOS 14 crash; actual free→paid conversion; why the US listing shows 3 ratings against 20 written reviews (resolve before using any store-rating figure); how many users hit the 3-habit cap and churned silently; did the mid-2014 monetisation change cost users",
  "n/a", "none", "5 questions", "research", "research questions", "yes",
  ["7082831771","7929736347","1036447473"])

with open("Tools/prd_ledger/14/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
