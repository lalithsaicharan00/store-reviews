import json, re
R = 8
rep = open("App Store Reports/8. Onrise - Habit Tracker & Focus - Build habits, focus & journal (REPORT).md").read().split("\n")
def table(after, k=0):
    """k-th markdown table after the first line containing `after`, flattened."""
    i = next(n for n, l in enumerate(rep) if after in l)
    blocks, cur = [], []
    for l in rep[i+1:]:
        if l.startswith("|"): cur.append(l)
        elif cur:
            blocks.append(cur); cur = []
            if len(blocks) > k: break
        elif l.startswith("#") and blocks == [] and k == 0 and False: pass
    if cur: blocks.append(cur)
    rows = [l for l in blocks[k] if not re.match(r"^\|[\s\-:|]+\|$", l)]
    return " ; ".join(re.sub(r"\s*\|\s*", " | ", l.strip("|")).replace("**","").strip() for l in rows)
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))


# ---- PART 1 — MONETIZATION ----
c(30, "Part 1 intro; §1.1 The model, reconstructed from the corpus + listing; Free / paid split as reviewers experience it table (verbatim)", "data-caveat",
  "Everything is free — unlimited habits, multiple reminders, widget, focus timer, journal, streaks, summaries, custom names/colours; nothing paid exists; export, iCloud sync/backup/account, Apple Watch, iPad-native and macOS do not exist",
  "free: price 0.0, no subscription, no IAP, no ads, no account, no server-side data", "praise",
  "308 reviews (36.24%) touch money; " + table("### Free / paid split as reviewers"), "none", "verbatim", "app-specific",
  ["7804733382","11533284738","14060433155","10477081447","11753781965","11170921819","10400204219","13469873434","13742512516","14254399815","14359179692","14326501421","13581401872","13311871983","12874016631","12082430684"])
c(31, "§1.1 Unlimited habits Free row; Part 3 praise_unlimited", "feature",
  "Unlimited habits free, confirmed continuously 2021 → 2026, praised explicitly with zero 1–2★ — users arrive expecting the category's 3–5-habit cap and are surprised it never appears",
  "free unlimited habits", "praise", "praise_unlimited 37 (4.35%, VERY STRONG), mean 4.84, 0.0% 1–2★, 86.5% 5★", "build-free", "very strong", "yes",
  ["7804733382","11533284738","14060433155","10972915619"])
c(32, "§1.1 Home-screen widget Free row", "feature",
  "A free widget is itself remarkable to users — 'the first habit tracking app that I don't have to pay for and can have a widget'",
  "free widget", "praise", "1 quoted (5★, CA); widget_positive_only 28 (3.29%), mean 4.61", "build-free", "quoted", "yes", ["11170921819"])
c(33, "§1.1 Data export / CSV does not exist row; Part 4 want_export; Part 6 #5", "feature",
  "Data export / CSV does not exist and is requested; one user asked support for an export and was ignored",
  "absent", "complaint", "want_export 12 (1.41%, MEANINGFUL), mean 4.08, 8.3% 1–2★", "build-free", "meaningful", "yes", ["13311871983"])
c(34, "§3.1 One counter-case, and it is severe; Part 9 #6", "must-have",
  "A data-access request left unanswered for seven months: 'I wrote the support to ask for a data export in March! They ignored my email and didn't even refuse to offer an export of my data' (1★) — below threshold at n=1 but promoted because an unanswered data-rights request is a reputational and regulatory exposure that costs nothing to close",
  "support email unanswered", "1★-burst", "1 (1★, EG, Oct 2025; asked Mar 2025)", "must-have", "promoted despite n = 1", "yes", ["13311871983"])
c(35, "§1.2 There is no paid cohort — so here is the cohort that matters instead table (verbatim)", "data-caveat",
  "The money-aware cohort (308) rates far higher than the rest — but it is a selection artefact as much as a satisfaction one: people who write about the price being zero liked it enough to notice; it establishes a positioning fact (a third of writers spend their review on the free position), not that free causes satisfaction",
  "n/a", "praise", table("## 1.2 There is no paid cohort"), "none", "segment rate caution", "app-specific", [])
c(36, "§1.3 What would trigger a purchase — stated in reviewers' own words table (verbatim)", "data-caveat",
  "Stated purchase triggers (intentions only): Apple Watch app 2, folders + journal prompts 1 (the only $/month statement), 'the full experience forever' 1 ($5–10 one-time), unspecified more features 2, support the dev 7, 'worth a fee' 5 — do not read conversion into this: 20 of 850 writers is sentiment, and writers are ~9.4% of raters self-selected for enthusiasm",
  "n/a", "purchase-driver", table("## 1.3 What would trigger"), "research", "stated intentions only", "app-specific",
  ["8082446036","10117160205","14359179692","13920667278","14491074038","14051428806","9473744662","9853721563","9979231109","10066041778","10153094810"])
c(37, "§1.4 friction 2 — the free position invites suspicion; Part 4 privacy_concern; Part 9 #18", "do",
  "A free app with no visible business model invites suspicion: 'I'm aware that you need to get money from somewhere since this app is 100% free… but I wish there was more transparency' (asked whether journal entries are collected, could not find it in the privacy policy); 'i dont know how creators of this app make money'; a 1★ escalated it to a tracking accusation — 'it is constantly on and running watching my every move' — publish a one-line in-app note on how the app is funded and what data it collects",
  "no funding / data statement", "1★-burst", "3 reviews speculate; privacy_concern 2 (0.24%), mean 2.50; praise_privacy 6 (0.71%), mean 4.00", "do", "weak, cheap", "yes",
  ["10309724588","11504152895","14220350355"])
c(38, "§1.4 friction 3 — the free position creates abandonment anxiety", "insight",
  "A free app with no visible revenue creates abandonment anxiety: users correctly infer there is no business model sustaining it, and the abandonment-concern reviews are its direct product",
  "free, no revenue", "mixed", "abandonment_concern 7 (0.82%); fear_monetization peaked 2025 (2.5%)", "do", "emerging", "yes",
  ["11504152895","12936436921"], side="a tip jar both answers the users who want to pay and signals the product is sustained")
c(39, "§1.5 Upsell pressure is zero — and reviewers name that as a feature", "product-rule",
  "No nag, no interstitial, no upgrade prompt in 850 reviews — and reviewers cite it favourably: 'it doesn't bug me everyday to upgrade to premium'; 'no in-app purchases or premium version nag pop ups'; 'they don't [nag] you with their premium plans'; the only nag in the corpus is non-commercial (the widget-onboarding overlay)",
  "zero upsell", "praise", "0 upsell complaints; 3 quoted praise", "product-rule", "observed", "yes",
  ["14281675824","10908785407","12223448511"])

# ---- PART 2 — RATING DRIVERS ----
c(40, "Part 2 5★ — n = 601 (70.71%) table (verbatim)", "data-caveat",
  "5★ themes (segment rates of 601): simplicity 46.9%, money / free position 45.6%, design 27.6%, no ads 12.3%, developer 10.0%, journal 8.0%, all-in-one 7.2%, focus 7.2%, unlimited 5.3%, switched from paid 5.0%",
  "n/a", "5★-burst", table("## 5★ — n = 601"), "none", "verbatim", "app-specific", [])
c(41, "Part 2 5★ The 5★ formula is exact", "insight",
  "The 5★ formula is exact: the app is simple, it looks good, it costs nothing, it never nags, and it does habits + focus + journal 'without asking me to be anyone' — 'a testament of the less is more philosophy… It's not littered with ads or stripped down to encourage a premium purchase'",
  "n/a", "5★-burst", "5★ n = 601 (70.71%)", "product-rule", "observed", "yes", ["12159330464"])
c(42, "Part 2 5★ praise_effect_outcome", "insight",
  "Everyone describing a concrete life outcome gives 5★ — title 'Depression Buster'; 'far more successful in stopping bad habits (alcohol and flower)'; 'I'm a Stroke and Aphasia survivor… this definitely helps me be a better version of myself'",
  "n/a", "5★-burst", "praise_effect_outcome 20 (2.35%, MEANINGFUL), mean 5.00, 100% 5★", "none", "meaningful", "yes",
  ["12738414001","12136485316","7177041505"])
c(43, "Part 2 4★ — n = 165 (19.41%) — the 'one missing thing' band table (verbatim)", "insight",
  "The 4★ band is where the roadmap is written: stats dominated historically and has now shipped (2026 rate halved), so the live 4★ blockers are multi-daily check-in, frequency modelling and sync",
  "n/a", "mixed", table("## 4★ — n = 165"), "none", "verbatim", "app-specific", [])
c(44, "Part 2 3★ — n = 42 (4.94%) — capability gaps, stated calmly table (verbatim)", "insight",
  "3★ is capability gaps stated calmly — the canonical 3★ names three at once: 'if I forget to document my tracking… I can't go back and track the day before. I also don't have a snapshot of the entire week or month… Every time I feel like I'm starting over with zero credit for previous accomplishments. I'm fishing for another app'",
  "n/a", "complaint", table("## 3★ — n = 42"), "none", "verbatim", "app-specific", ["13182431485"])
c(45, "Part 2 2★ — n = 20 (2.35%) — data loss and UI dead-ends table (verbatim)", "insight",
  "2★ is 'I want to love this and cannot use it': 7 of 20 praise the design in the same review — 'It looks awesome, I'd love to use it but a pop up comes up over the whole screen… and the button at the bottom to get rid of it is just cut off enough so I can't register a tap'",
  "n/a", "complaint", table("## 2★ — n = 20") + " ; 7 of 20 (35%) praise design in the same review", "none", "verbatim", "app-specific", ["11904827409"])
c(46, "Part 2 1★ — n = 22 (2.59%) — broken, not expensive table (verbatim)", "data-caveat",
  "1★ causes: can't log today 3, can't create 3, lag/crash 2, white screen 2, no backfill 2 — money/price objection 0; full chronological list of 22 with cause",
  "n/a", "1★-burst", table("## 1★ — n = 22"), "none", "verbatim", "app-specific",
  ["8922203790","10105619469","11648694059","12002553577","12122331747","12164874968","12189113218","12874016631","12982290428","13032792258","13089378849","13120591145","13311871983","13343619642","13344176512","13633911646","13650696629","13724690797","13742512516","14021302236","14051523206","14220350355"])
c(47, "Part 2 1★ Three of the seven 2026 one-star reviews contain net-positive text", "data-caveat",
  "Rating/text mismatches inflate the 2026 1★ rate: three of seven 2026 one-stars contain net-positive text — one is unbroken praise ('The perfect habit tracker with reminders and an helpful widget… super cool that it's free too'); the true 2026 defect-driven 1★ rate is closer to 4/146 (2.7%) than 7/146 (4.8%)",
  "n/a", "none", "2026 1★ 7/146 (4.8%) → defect-driven 4/146 (2.7%)", "none", "observed", "yes",
  ["13633911646","13724690797"])

with open("Tools/prd_ledger/8/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
