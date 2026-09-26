import json, re
R = 16
rep = open("App Store Reports/16. Atoms - from Atomic Habits - The official Atomic Habits app (REPORT).md").read().split("\n")
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

c(1, "header lines 1-9", "positioning",
  "Atoms — from Atomic Habits (App Store ID 6474421906) is the official James Clear / Atomic Habits app: a beautifully crafted, brand-led habit tracker whose packaging (one free habit, a capped paid tier, a 28-day trial ending in a wall, launch pricing of $120/yr) destroyed its written reception",
  "developer Atomic Development Inc.; bundle app.getatoms.ios; English-only; iPhone-only (no iPad, Watch, Mac or Android); subscription; store rank 16", "mixed",
  "1,168 written reviews, 76 storefronts, 15 Feb 2024 → 4 Sep 2026; mean 3.604; 5★ 581 (49.74%) · 4★ 102 (8.73%) · 3★ 135 (11.56%) · 2★ 142 (12.16%) · 1★ 208 (17.81%)", "none", "corpus-level fact", "app-specific", [])
c(2, "How to read this; §1.1–1.5 files, schema, coverage, method, limitations; §1.6 External sources; §9.1 counting rules; §9.3 method audit trail", "data-caveat",
  "Method: denominator 1,168, non-exclusive themes, standard bands; segment rates always labelled with segment denominator; only four storefronts clear 50 (US 542, GB 103, CA 73, AU 52); external facts marked [external] — live App Store lookup was blocked by network policy (403 at egress proxy) so store ratings come from Tools/habit_apps_ranked.json cached 9 Sep 2026; the corpus is 58% launch-week, so global percentages are not a picture of the app today; 100% of records read individually, perfect reconciliation, zero duplicates",
  "n/a", "none", "1,168 / 1,168; 76 storefronts; launch-week 58%; 5.6% of raters write (1,168 of 20,857)", "none", "method", "yes", [])

# ---- PART 0 ----
c(3, "Part 0 §1 This is the most monetisation-damaged corpus in the set, and the damage is a single decision; band table (verbatim)", "product-rule",
  "The most monetisation-damaged corpus in the set: Atoms is not a broken app, it is a well-built app whose packaging destroyed its written reception — nearly three of four 1★ reviews are about the price not the product, and over a quarter of price objectors praise the app in the same review ('the best looking habit tracking app I've downloaded… However, due to the ridiculous subscription fee it was a very quick uninstall'; 'it really was making a difference')",
  "subscription; $120/yr at launch", "1★-burst", "money 457 (39.13%) mean 2.38; price objection 392 (33.56%, HIGH-PRIORITY) mean 2.18, 65.3% 1–2★; " + table("## 1. This is the most monetisation-damaged") + " ; 109 of 392 objectors praise the app; 43 of 208 1★ (20.7%) contain praise; only 15 1★ about loading, 12 about logging", "product-rule", "high-priority", "yes",
  ["10995055502","11090232087"])
c(4, "Part 0 §2 The free tier is one habit — and that single number is the mechanism", "product-rule",
  "The free tier is one habit and that single number is the mechanism: 'a habit tracker that tracks one habit is not a habit tracker' — 'This is useless for me, I have more than 3 habits to track before I have breakfast'; 'the free version would better be renamed to Atom'; the cap has been 1 continuously for 27 months; because the free tier is unusable it cannot do trial work — every other habit app in the folder converts through a usable free tier",
  "free tier = 1 habit", "blocked-conversion", "76 (6.51%, HIGH-PRIORITY) mean 2.22, 61.8% 1–2★, 7.9% 5★; 24 Feb 2024 → 14 May 2026 unchanged", "product-rule", "high-priority", "yes",
  ["10984314443","11340151425","12199586867","11400713510","10975917055","14064134860"])
c(5, "Part 0 §3 The paid tier is capped too — and that is the finding nobody expects; cap table (verbatim)", "product-rule",
  "The PAID tier is capped too: Pro was 3 habits at launch, raised to 6 in the second week of March 2024 ('They went from 3 to 6 habits for pro at $100+/yr?! That's your fix? Absolutely not. Deleted' — the most-voted cap complaint), and paying customers are still hitting the ceiling in 2026 ('A paid user pays $5/month or $40/year just to create only 6 habits simultaneously? Other similar apps use hard limit to incentivize in-app purchase, not locking them down'); combined the two caps are the single largest addressable product decision in the corpus",
  "Pro capped at 3 → 6 habits", "churn", "75 (6.42%, HIGH-PRIORITY) mean 2.57, 57.3% 1–2★; " + table("## 3. The *paid* tier is capped too") + " ; both caps combined 135 (11.56%) mean 2.44, 57.8% 1–2★", "product-rule", "high-priority", "yes",
  ["10975518449","11883256863","11033626383","14287877372","13573785597","13222746779"])
c(6, "Part 0 §3 The counter-case is real — 20 reviews defend the constraint; loved at 3–6 habits and hated at 1", "contradiction",
  "The counter-case is real: 20 reviews defend the constraint at mean 4.60 — 'you can only add a second habit after you've done your first at least 3 times. It forces you to slow down'; 'People complain about only 6 habits but they're missing the point'; 'the gamification that rewards you with ability to record more habits by recording habits' — the constraint is loved at 3–6 habits and hated at 1; the design principle survives raising the free tier, it does not survive a free tier of one",
  "earn-a-slot constraint", "praise", "20 (1.71%, MEANINGFUL) mean 4.60, 80% 5★", "undecided", "meaningful", "yes",
  ["10950990017","12115363939","13329955083","10980656747"],
  cond="works at 3–6 habits, fails at 1")
c(7, "Part 0 §4 The 28-day trial is experienced as a trap, and it is producing the app's angriest reviews", "dont",
  "The 28-day all-features trial is experienced as a trap: the app encourages you to build a streak, then removes the ability to log it — 'the trial model is a bit sly in that it encourages people to start habits and continue them for three weeks and then hits you with a steep bill. It's counter to the mission'; 'I feel like this is manipulative from James Clear'; 'Being suddenly locked out and charged is NOT the principles the book taught'; the only major negative still growing",
  "28-day trial → wall; streak built then locked", "1★-burst", "41 (3.51%, VERY STRONG) mean 2.44, 58.5% 1–2★; 2.36% (P1) → 5.07% (P2) → 4.21% (P3) → 7.23% (P4)", "dont", "very strong, rising", "yes",
  ["12482534390","13613868361","12600470632","14302077000","13882025149"])
c(8, "Part 0 §4 Losing the subscription does not return you to a usable free tier — 'the app is bricked for me now'", "must-never-break",
  "Losing the subscription does not return you to a usable free tier: a former payer who deleted 3 of 4 habits 'still can't edit my 1 remaining habit, view detailed history, or even mark it completed. It's my habit for walking my dog, who is recently deceased… I guess the app is bricked for me now'; 'The copywriting even says we wouldn't leave you hanging! But then they left me hanging' — a churn mechanic that destroys the goodwill of the people most likely to come back",
  "lapsed subscription locks even the one free habit", "1★-burst", "2 cited (one confirmed former payer)", "must-never-break", "qualitative", "yes",
  ["13573892543","11150554851"])
c(9, "Part 0 §5 Confirmed payers are the angriest group in the corpus; comparison table (verbatim); complaint table (verbatim)", "must-never-break",
  "Confirmed payers are the angriest group: they rate 1.21 stars below everyone else and are twice as likely to leave 1–2★ — every buyer already got past the price objection and a majority still wrote a negative review; five of the seven billing complaints in the whole corpus come from the seventeen who paid — 'I have now subscribed three separate times ($360 in total)… every day it says I do not have a paid account'; 'auto-charged for an annual renewal with no reminder and no warning… told it was my fault'; 'It looks like you are signing up for a free subscription of 28 days but they actually charge you right away'",
  "entitlement not recognised; auto-renewal without warning; refunds refused", "1★-burst", "17 payers (1.46%) mean 2.41 vs 3.62; 1–2★ 58.8% vs 29.5%; 5★ 17.6% vs 50.2%; " + table("## 5. Confirmed payers", 1), "must-never-break", "meaningful, segment", "yes",
  ["11015185142","12988241997","11990095414"])
c(10, "Part 0 §6 The price came down twice and the corpus barely noticed; price table (verbatim)", "monetization",
  "The price fell by roughly two-thirds ($16.99/mo and $119.99/yr at launch → $69.99/yr Jun 2024 → $40/yr 2026) and the price-objection rate barely moved; only 6 reviews acknowledge the drop and five of those are still 1–2★ ('$70 a year still seems over priced') — the objection is not to the number, it is to the shape: 'I will not rent a checklist'",
  "$119.99/yr → $69.99 → $40; monthly $16.99 → $4.99–6", "complaint", table("## 6. The price came down twice") + " ; price-objection 30.97% (P1) → 50.69% (P2) → 24.74% (P3) → 30.12% (P4); 6 (0.51%) acknowledge drop, 5 still 1–2★", "product-rule", "very strong", "yes",
  ["10960582078","10975518449","11345550974","11346837271","11438714327","12006236731","12545506654","14287877372","11980741663"])
c(11, "Part 0 §6 37 reviews ask for a one-time or lifetime purchase; 53 ask for a cheaper tier, student rate or discount", "monetization",
  "Reviewers ask for a different shape, not a lower number: a one-time or lifetime purchase ('I would gladly pay a one-time $20 for just the habit tracking, but that's not an option'; 'Procreate is a one time purchase of £12… Built once, pay once. £10 per month is insane'; 'WHY isn't there a lifetime subscription option??? Pay 125$ once') and a cheaper tier, student rate or discount",
  "subscription only", "blocked-conversion", "one-time 37 (3.17%, VERY STRONG) mean 2.16; cheaper tier / student / discount 53 (4.54%, VERY STRONG)", "build-paid", "very strong", "yes",
  ["13613868361","12356777390","11685719155"])
c(12, "Part 0 §7 The public rating is 1.21 stars higher than what people write — the largest gap in this folder; table (verbatim)", "data-caveat",
  "The public rating is 1.21 stars above the written mean — the largest gap in the folder; only 5.6% of raters write; the 4.81 is real and not the whole story: the people motivated enough to write are, two-to-one, writing about money — do not read it as 'the app is secretly a 3.6'",
  "n/a", "mixed", table("## 7. The public rating"), "none", "external + corpus", "app-specific", [])
c(13, "Part 0 §8 What people actually love — and it is not the tracker: simplicity; design; the James Clear brand halo; Mindset tab; identity framing; life change", "insight",
  "What people love is content and craft, not tracking: simplicity (zero 1–2★), design/animation, the James Clear brand halo (mean 4.90 when 4–5★), the Mindset tab / daily lessons / articles, identity framing ('cast a vote for the person you want to become'), life change",
  "brand-led content + crafted UI", "praise", "simplicity 183 (15.67%) mean 4.73, 82.0% 5★, zero 1–2★; design 179 (15.33%) mean 3.49; brand references 435 (37.24%), halo 268 (22.95%) mean 4.90, 90.3% 5★; Mindset 59 (5.05%) mean 4.07; haptics 45 (3.85%) 4.02; identity 35 (3.00%) 4.43; life change 72 (6.16%) 4.49", "must-have", "high-priority", "app-specific", [])
c(14, "Part 0 §8 Design praise is the most rating-agnostic theme — people complimenting the craft on the way out the door", "insight",
  "Design praise is the most rating-agnostic theme: 31% of design-praise reviews are 1–2★ — people complimenting the craft on the way out the door ('It's a beautifully designed app with some lovely haptic elements. However it's light on substance, especially for the price')",
  "beautiful UI behind a resented paywall", "mixed", "56 of 179 design-praise reviews 1–2★ (31.3%); design + price objection 85 reviews mean 2.36", "insight", "very strong", "yes",
  ["10993476523","10984334544"])
c(15, "Part 0 §8 The haptic completion loop is the product's genuine, defensible craft asset — and praise for it is decaying fast after a redesign", "feature",
  "The press-and-hold haptic completion loop is the product's genuine, defensible craft asset — 'Surprisingly satisfying to hold and fill the circle'; 'a satisfying hold while the circle expands ending with a vibrate reward… Pavlovian in a good way'; 'I'm beginning to crave that feeling' — and praise for it is decaying fast after a 2024 redesign replaced the floating circles with a list; three reviewers name the loss directly",
  "press-and-hold fill + haptic; floating circles replaced by a list", "praise", "45 (3.85%) mean 4.02; 4.87% (P1) → 4.15% (P2) → 1.05% (P3) → 1.20% (P4)", "must-have", "very strong, decaying", "yes",
  ["10979085353","10989132915","10992749538","11343906321","11814577640","11390526677","11368755180"])
c(16, "Part 0 §9 The brand is being spent, and 16 reviewers say so explicitly; moral language; broken bargain with book buyers", "anti-pattern",
  "The brand is being spent: 16 reviews attack James Clear personally or say the app damaged the book for them — the lowest-rated theme, not one above 3★ ('How to ruin your brand overnight… just another hypocrit selling himself out'; 'changed my view of James'; 'Please don't become greedy') and the only negative theme worse in 2026 than at launch; 69 reviews use explicitly moral language ('cash grab', 'greedy', 'predatory', 'scam') — the only theme with a zero 5★ rate; 18 frame a broken bargain with book buyers ('although I bought the book it did nothing… maybe a discount or even a free membership'; 'scan the barcode and get a special price')",
  "premium pricing on a trust-based personal brand; no book-buyer recognition", "1★-burst", "brand damage 16 (1.37%) mean 1.38, 93.8% 1–2★, 0.88% (P1) → 3.61% (P4); moral language 69 (5.91%, HIGH-PRIORITY) mean 1.38, 91.3% 1–2★, 0 5★; book-buyer bargain 18 (1.54%)", "dont", "high-priority", "yes",
  ["11044837304","10993434698","11197168795","13558310210","14136029170","10983993222","12513582477","11097642923"])
c(17, "Part 0 §10 Reliability is getting worse, not better — and it is now the second story; rate table (verbatim)", "must-never-break",
  "Reliability is worsening and is now the second story — the rate more than doubled; launch bugs were fixed within days ('There's no bug! Those were old reviews before the app was launched'), but 2025–26 failures are core-loop failures: the app freezes and will not get past habit creation (a live, unresolved onboarding failure fifteen months old, zero 5★), logging silently fails (including a payer: 'Randomly stopped updating when I tracked my habits. I pay for this app'), data/history loss (a payer lost a week of logs for all 6 habits), repeated forced logout after a two-factor change, and the app requires a live internet connection to tick a box ('I work in remote areas… I can't use the app')",
  "network-required logging; onboarding freeze; silent log failure; forced logouts", "1★-burst", "103 (8.82%, HIGH-PRIORITY) mean 2.45, 59.2% 1–2★; " + table("## 10. Reliability is getting worse") + " ; freeze at creation 31 (2.65%) mean 1.90, 0 5★, 15 dated 2025+; logging fails 12 (1.03%) mean 2.00; data loss 9 (0.77%) mean 2.78; forced logout 10 (0.86%) mean 2.10; needs internet 9 (0.77%) mean 2.56", "must-never-break", "high-priority, rising", "yes",
  ["10976173296","12492982373","12515484177","12539170479","13453138963","13724948462","13837724169","11858415210","13732701636","11928001093","10977084069","11339178421"])
c(18, "Part 0 §11 The two cheapest missing features: no dark mode (accessibility); no back-logging", "feature",
  "The two cheapest missing features, both sitting in the 3★/4★ band and neither shipped in 31 months: no dark mode — a high-goodwill request, the fastest-growing, framed by two reviewers as accessibility ('some of us can't read a blinding white screen… with such shoddy accessibility I would never pay'; 'My eyes hurt'); and no back-logging beyond yesterday — reviewers lose streaks they actually earned ('I accidentally lost my streak because I forgot to log my activity 2 days ago… permanently reset'; 'Especially for someone with ADHD who struggles with admin'; support refused to help create a habit in the past)",
  "no dark mode; log only today and yesterday", "complaint", "dark mode 21 (1.80%, MEANINGFUL) mean 3.76, 9.5% 1–2★, 0.29% → 2.76% → 5.26% → 3.61%; back-logging 33 (2.83%, MEANINGFUL) mean 3.39, 21.2% 1–2★", "build-free", "meaningful", "yes",
  ["11936034388","14138142114","11049027904","11245427777","12909615292","11572795669"])

with open("Tools/prd_ledger/16/cards.jsonl", "w") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards written")
