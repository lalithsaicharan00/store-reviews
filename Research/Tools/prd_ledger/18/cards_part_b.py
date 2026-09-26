import json, re
R = 18
rep = open("App Store Reports/18. MyRoutine - Organize your day - Built around your real life (REPORT).md").read().split("\n")
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
    return " ; ".join(re.sub(r"\s*\|\s*", " | ", l.strip("|")).replace("**","").replace("`","").strip() for l in rows)
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))

# ---- PART 1 ----
c(37, "§1.4 Processing method — precision audit; §1.5 Counts are floors; §10.3 method audit trail", "data-caveat",
  "Classifier precision audit: paywall_v3 45 sampled 36 true ≈80%; trial_billing_dispute ≈83%; data_loss ≈83%; crash ≈92%; entitlement_failure ≈83%; paid_confirmed ≈92%; two themes rejected and rebuilt (shift_work — bare '모드' matched 다크모드/가로모드; onboarding_friction 60% precision v1 → 1.66% v2); notifications split into a precise 'notification problem' subset; recall check on 136 unmatched 무료/無料/free/免費 reviews found several genuine paywall complaints — the paywall count of 139 is a floor; counts carry ~20% over-count risk; no app-version field, so every 'an update did X' is an inference from dated clusters — the three best-evidenced (Oct 2022 ads, Nov 2023–Jan 2024 tightening, Sept 2024 split) rest on 10+ same-window reviews",
  "n/a", "none", "34 themes; 21 batches of 100; 6 precision samples", "none", "method", "yes", [])
c(38, "§1.5 Developer replies are not in the corpus", "data-caveat",
  "90 reviews (4.39%) are flagged is_edited and several visibly edit in response to a developer reply, so support quality can only be assessed from the user side",
  "n/a", "none", "90 (4.39%) edited; 7 named IDs edited after a reply", "none", "method", "yes",
  ["8519301616","12023009972","13039376354","11103012143","14374239484","12109687708","14479635630"])
c(39, "§1.5 Possible seeded / marketing-style reviews", "data-caveat",
  "A cluster of native-English 4–5★ reviews with near-identical 'serial app-hopper who finally stuck with one' phrasing in a tight window (gb 10–29 Jun 2025 ×4, au 10 & 18 Jun 2025 ×2); a JP reviewer independently alleges fake reviews ('there are quite a few shills in the reviews') and a DE reviewer alleges fake lifetime promo codes; the six are treated as limited-evidence, excluded from qualitative conclusions, kept in counts",
  "possible seeded English reviews Jun 2025", "5★-burst", "6 reviews in 20 days; 2 independent allegations", "dont", "limited evidence", "app-specific",
  ["12757322029","12767129702","12778751472","12831425768","12756530951","12790218793","13997904350","12543396557"])
c(40, "§1.7 Corpus composition — by storefront table (verbatim); by rating", "market",
  "By storefront: KR 1,599 (78.08%, 3.95★), JP 223 (10.89%, 3.37★), US 84 (4.10%, 3.82★), TW 35 (1.71%, 2.60★ — lowest), GB 23 (3.48★), AU 17 (3.71★), CA 15 (3.20★), 22 others 52; by rating 5★ 1,069 (52.20%) · 4★ 322 (15.72%) · 3★ 216 (10.55%) · 2★ 109 (5.32%) · 1★ 332 (16.21%); mean 3.824; review length median 89 chars, 404 (19.73%) under 40 chars; 203 (9.91%) carry a helpfulness vote",
  "n/a", "none", table("**By storefront** (full table in"), "none", "corpus-level fact", "app-specific", [])
c(41, "§1.7 By year table (verbatim) — 2026 is the worst year on record, in every major storefront", "timeline",
  "Per-year means: 2020 4.111 (n72) · 2021 4.227 (132) · 2022 4.142 (253; JP 2.875) · 2023 3.976 (287; JP 3.267) · 2024 3.707 (475; JP 3.700) · 2025 3.928 (470; KR 4.048, JP 3.550) · 2026 to 6 Sep 3.290 (359; KR 3.527, JP 3.032) — 2026 is the worst year on record in every major storefront; the corpus ends on its lowest note",
  "rating decline 2021 peak 4.227 → 2026 3.290", "churn", table("**By year:**"), "none", "corpus-level fact", "app-specific", [])

# ---- PART 2 ----
c(42, "§2.1 Feature inventory derived from reviews (verbatim table)", "feature",
  "Feature inventory: habit checklist with custom emoji stamp (Jul 2020, free but completions metered); traffic light with user-set % threshold (free); badges/levels (free); retrospective/diary (partly Pro); short & long memo per habit (metered 20/week → 5/week → 14 ticks/week); web+PC (paid, discontinued ~2022/23, returned as beta 2025); social follow/copy/best routines/cheer messages (free); reminders (free); day-of-week / n-times-per-week repeat (partly Pro in some periods); rest/skip/postpone (free); free trial 3 weeks (Oct 2020) → 7 days by 2023; home-screen widget (Dec 2021, reported as Pro by some); Apple Watch (~Feb 2022, free with Pro); monthly report/statistics (~Mar 2022, Pro); goals with linked habits (~Dec 2022); Challenge (~Jan 2023, removed Sept 2024); highlighter (Pro May 2023, 1 colour free from Jan 2024); to-do (2021, Pro Nov 2023); tracking habits weight/condition/timestamp/numbers (2023–25, Pro with flip-flops); routine bundles + per-bundle timer (~Nov 2024, Pro); note (~Mar 2025, Pro); to-do calendar (~Apr 2025, Pro); per-habit streaks + shield (~Aug 2025, Pro); routine modes — swappable day templates (~Dec 2025, Pro); intensity levels (~Jun 2026, Pro); completion animation/sound (~May 2026, free)",
  "see table", "mixed", table("## 2.1 Feature inventory"), "none", "inventory", "app-specific",
  ["6162278434","6163620772","8997599884","6162253418","8789513059","6171352716","6225061945","6529812431","6529670915","10367219461","6526765963","8173262340","8409385715","9492696267","9611075637","8232574930","12350930181","11980527185","12461476430","12512686577","13056561637","13547363890","14184795326","14052908844"])
c(43, "§2.1 Web + PC version — paid, discontinued ~2022/23, returned as beta 2025", "feature",
  "A web + PC version existed from Jul 2020 as a paid feature, was discontinued ~2022/23 and returned as a beta in 2025",
  "web/PC: paid → removed → beta", "mixed", "3 inventory IDs; 4 removal IDs in §0.5", "paid", "inventory", "yes",
  ["6171352716","9513306665","13042903108"])
c(44, "§2.1 Apple Watch app (~Feb 2022), free with Pro account", "feature",
  "An Apple Watch app arrived ~Feb 2022, free with a Pro account", "watch app bundled with Pro", "mixed", "2 IDs", "paid", "inventory", "yes",
  ["8409385715","8412382382"])
c(45, "§2.1 Home-screen widget (Dec 2021), reported as Pro by some", "feature",
  "A home-screen widget arrived Dec 2021 and is reported as Pro by some users (jp: 'the widget is paid?')", "widget; free/paid status unclear to users", "mixed", "3 IDs", "undecided", "inventory", "yes",
  ["8173262340","8232445562","13496310680"])
c(46, "§2.1 Routine modes (루틴 모드) — swappable day templates (~Dec 2025, Pro)", "feature",
  "Routine modes — swappable day templates (weekday/weekend/shift etc.) — shipped ~Dec 2025 as Pro; five modes were wiped in the worst case in the corpus",
  "Pro day templates", "mixed", "2 inventory IDs", "undecided", "inventory", "yes",
  ["13547363890","13795524849"])
c(47, "§2.1 Routine bundles (묶음루틴) + per-bundle timer (~Nov 2024, Pro)", "feature",
  "Routine bundles with a per-bundle timer shipped ~Nov 2024 as Pro — the timer is the converting feature of §0.8", "Pro bundles + timer", "purchase-driver", "2 inventory IDs; 46 timer reviews", "paid", "inventory", "yes",
  ["11980527185","12023625379"])
c(48, "§2.2 Monetisation model — structure and trial length", "monetization",
  "Free download; Pro subscription with monthly, annual and lifetime tiers at four to five concurrent price points per tier per storefront; trial length moved from 3 weeks (2020–21) → 7 days (2023 onward), with 2-day and 3-day variants reported (de, hk, jp)",
  "monthly/annual/lifetime; trial shrank 3 weeks → 7 days → 2–3 days", "mixed", "listing 10 Sep 2026; 3 IDs for short trials", "undecided", "listing + reviews", "app-specific",
  ["13751955979","14429093675","12227960355"])
c(49, "§2.2 Free tier as reported, by period (verbatim table)", "timeline",
  "Free allowance by period: 2020 H2 3-week trial then a 'free membership'; Aug 2021 10 routines; Oct 2021–2023 15 routines (+ up to ~8 via friend invites → 23); Nov 2023 to-do Pro-only; Dec 2023–mid 2024 8 routines, short memo 5/week, invite bonuses revoked; late 2024–2026 10 habits but ticking consumes a 14/week memo quota — the cap number is the advertised limit, the binding limit is completions",
  "free cap shrank 15 → 8 → 10-with-metered-completions", "complaint", table("**Free tier as reported, by period**"), "product-rule", "review-derived", "yes",
  ["6526765963","7692904522","7952223213","10598930656","10754519109","12036038200","13202762473","14393820099"])
c(50, "§2.2 Price points named by reviewers (verbatim table)", "monetization",
  "Price points named by reviewers corroborate the listing: Korea ₩3,900/mo, ₩25,000 / ₩28,000 / ~₩30,000 / ₩33,000 annual, ₩45,000 and ₩47,000 mischarges, ₩61,000 double, lifetime ~₩89,000, ~₩70,000/yr; Japan ¥4,560/yr, ¥3,500/yr, ¥2,900 → ¥4,150 charged, lifetime ¥6,890 and ¥8,890; US $23/yr or $3/mo, $29.99 (au), '$50'; Taiwan NT$890 list, NT$590 promo, NT$790 renewal; Vietnam 600k VND/yr",
  "price points as named in reviews", "mixed", table("**Price points named by reviewers**"), "research", "review-derived", "app-specific",
  ["10656594581","14143250366","13734105920","12300507880","10259408955","10809417235","13420003023","10105520747","11881028381","11815241341","13637970269","14478284399","11187045021","11978156607","12214731690","14488115233","14238803827","12777592140","10771673004","13894901307","10857540454","14286926161","14344435230","11925026971"])
c(51, "§2.2 Ads — 2022 interstitials softened; 2025–26 persistent promo bar and Dynamic Island discount countdown experienced as worse", "anti-pattern",
  "Interstitial ads on check-off (~24–26 Oct 2022) were softened by ~Dec 2022 (Apr 2023: remaining ads 'minimal and clean'); a persistent bottom promo bar and a Dynamic Island discount countdown appear in 2025–26 and are experienced as worse than the 2022 ads — 'Absolutely the worst choice' (nl)",
  "in-app upsell bar + Dynamic Island countdown", "complaint", "11 named IDs 2025–26 incl. jp ×2, nl", "dont", "close reading", "yes",
  ["9349646831","9790998955","14164985475","14330193137","14472024199","13425678335","14510091242","14232460077","12941484108","12949129516","14071210641","14089424168","14117739778"])
c(52, "§2.2 Classification summary (verbatim table) — reviewers cannot tell what they are buying", "insight",
  "Free: habit creation to the cap, traffic light, badges, social/follow/copy, reminders, rest/skip, completion animation; Pro: to-do, statistics/monthly report, tracking habits, note, to-do calendar, highlighter beyond 1 colour, routine bundles + timer, routine modes, intensity levels, unlimited habits, unlimited completions; unclear/changed: widget, diary, day-of-week repeat, condition check — reported free by some and paid by others in overlapping periods; that last column is itself a finding: reviewers cannot tell what they are buying — 'the premium feature description says not one word about trackers'; 'it says the free version allows up to 2 tracking modes yet it tells me to pay'; a GB user bought Pro for a timer the screenshots advertise and could not find it",
  "free/paid boundary illegible and shifting", "blocked-conversion", table("**Classification summary:**") + " ; 7 named IDs", "must-have", "close reading", "yes",
  ["12350930181","13894400612","13534993454","14288774795","13496310680","12433476315","14331337303"])

with open("Tools/prd_ledger/18/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
