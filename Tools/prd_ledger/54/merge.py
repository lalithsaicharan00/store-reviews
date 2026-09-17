"""Stage 3 merge for report 54."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C273", "must-never-break", "The reward mechanic must never silently stall — a plant, pet or garden that stops growing reads as the app taking the reward away",
    "Report 54 (Avocation): a plant watered by completing habits is the emotional engine — 35 reviewers (9.49%, mean 4.43) motivated by it ('Growing my plant has 100% been the thing that has kept me on track') — and when it stalls the product stops working: a signature state 'my plant says infinity days until next growth … It makes me want to stop using the app, since the little reward of growing the plant has been taken away' (US, 3★, payer) and 'Says infinite days until new growth. Does this mean my tree is dead?' (ZA), seven weeks apart, plus growth stopping at exactly 67 days (ES) and in 2026 for a Pro buyer (DE, 1★) — 5 reviewers (1.36%, mean 2.40), all 3★ or below, 3 payers; 'the highest-leverage bug in the report' (F2). Related: [[C237]] (content runway), [[C117]] (companion character), [[C024]] (gamification).")

ext("C001", " Report 54: reviewers report the free cap moving 5 (early 2020) → 3 (late 2020) and one existing user's 'three habits got cut down to two' (CN, 2★).")
ext("C003", " Report 54: a one-time lifetime Pro with 14 advocates at mean 4.93 and zero detractors of the model — 'I love the honesty of a pricier lifetime membership versus the subscription model that so many extortionists are using now'; 'subscriptions totally stress me out' (DE); D2: do not move to a subscription.")
ext("C004", " Report 54: price fair 16 (4.69) against too high 16 (2.75), the objections clustered in lower-ARPU storefronts (CN, TW, PH, TR, CO: 9 of 16); US price sentiment net positive 21 to 1.")
ext("C005", " Report 54: displacement 35 (9.49%, 4.83) — 'I literally downloaded 30 different habit/productivity/tracker apps… this is the only one that came remotely close' — halved in 2023–26 (11.3% → 5.0%).")
ext("C006", " Report 54: simplicity 60 (16.26%, 4.50) is 'the constraint on every feature request' — 'Other apps feel overwhelming… cluttered with lists, graphs, and other features that can be anxiety producing' — anything shipped must not be visible to the 60.")
ext("C007", " Report 54: a 3-habit cap — the most-discussed decision (44, 11.92%, 3.16; 11 more call the free tier useless at 1.91) — hit mid-setup ('I was having fun setting up my habits until I maxed out my 3 free habits … Deleted immediately'; 'sleep, wake, exercise, and all three are used up', TW); reviewers name their own number, modal 5–8 (5, 5–7, 7–8, 8, 9 as 3×3 across time-of-day sections, 10); 23 of 44 rated 1–3★; D1: raise to 5–8 as a measured experiment.")
ext("C009", " Report 54: colours, pots and reminders gated resented (8, 3.00); more icons / colours / pots / themes requested (17, 4.35).")
ext("C010", " Report 54: backfill only to yesterday — 15 (4.07%, 3.67); 'deleted on the second day because of the issue' (UA); if the schedule says Mon/Wed/Thu and you worked out Tuesday, you cannot record it at all.")
ext("C011", " Report 54: long-range history requested by 28 (7.59%) and per-habit stats by 16; 48 unique (13.01%, 3.83) want 'proof that they have been consistent, over a period longer than a week, for a habit they can name' — the second-largest need after the paywall.")
ext("C013", " Report 54: iCloud sync / backup absent (8, 4.12) — 'I don't give it 5 stars because it lacks iCloud sync'.")
ext("C019", " Report 54: quit-habit tracking requested (4).")
ext("C021", " Report 54: Health app / Fitbit sync requested (2).")
ext("C022", " Report 54: no Watch app (9, 4.22) — 'now I'm forced to use another app' (DE); 'lemme know if you're working on the watch app and I'll be the first one to buy this app' (PK).")
ext("C023", " Report 54: the top request (41, 11.11%, 4.29; P1 7.5% → P3 17.6%, open since Oct 2020, first asked one month after iOS 14), 19 of them five-star and a named purchase blocker for 3 of 5 ('If there were a home-screen widget I'd open it far more often — then I'd be more willing to buy', TW); framed as retention by ADHD and autistic users ('once it's closed i never use it'); D3: build it as a completion surface, not a display surface.")
ext("C025", " Report 54: in CN the one-time ¥98 price competes against a ¥3/month anchor (a pricing-architecture problem).")
ext("C027", " Report 54: habit lessons English-only inside localised UIs ('this software is all in English', CN; 'English texts are not translated', DE); Arabic and full Chinese requested; a German reviewer calls it 'the only habit tracker in German'; outcome language 16.9% in developed markets vs 4.6% elsewhere — 'a behaviour-change tool in developed markets and a cute utility elsewhere'.")
ext("C029", " Report 54: a purchase that never unlocked ('I paid for the app and absolutely nothing. It's exactly as it was before', AU; 'Still telling me Become a habit pro!', KR) — 6, mean 1.17.")
ext("C033", " Report 54: 'for a one-time-purchase product, restore-purchases is not a feature, it is the product's warranty' — 7 restore failures (every one 1★) across BR, ES, GR, TH, UA×2, US, 2021 → 2026, P3 rate 4.2% (five-fold rise), 6× more concentrated outside high-spend storefronts; F1: a visible, labelled Restore button — the single largest source of one-star reviews.")
ext("C036", " Report 54: support unresponsive 6 (1.50), rising to 4.2% of 2023–26; 'Your support pages and email are down' (GR, Aug 2026); 'there's no app support to write any of this to… which I feel like should be a thing if you have to pay for an app'.")
ext("C038", " Report 54: the paid calendar rings show the wrong completion — two reviewers on two continents tie it to the long-press undo not propagating to the calendar (9, 2.56, 5 payers).")
ext("C039", " Report 54: notification defects — no badge, nagging after completion, wrong sound (6, 2.50).")
ext("C042", " Report 54: 7 self-identified ADHD, autistic or anxious reviewers all at 4–5★ discovered the fit themselves though the subtitle names ADHD; 'with my adhd, once it's closed i never use it' (widget).")
ext("C043", " Report 54: 'X times a week without naming the days' — 24 (6.50%, 3.79); two call the scheduling model 'unusable' ('I don't care or know when those days will be but this app makes you designate them'; shift workers, DE).")
ext("C053", " Report 54: time-of-day grouping named as a differentiator by 10 (2.71%).")
ext("C059", " Report 54: 'I know from Reddit that you aren't spending much time on this app anymore, but please fix this small necessary thing! I would pay for the premium version again in a heartbeat!' (4★).")
ext("C061", " Report 54: 4 bought to support the developer, all 5★ — 'make a high quality product, offer it for free without junky ads, and without high pressure sales tactics. Let the app speak for itself'.")
ext("C062", " Report 54: a developed-market proxy group (70.73%, mean 4.103) vs rest of world (3.685): price resistance 2.7% vs 8.3%, restore failures 0.8% vs 4.6%, outcome language 16.9% vs 4.6%.")
ext("C063", " Report 54: no trial — 7 ask for one ('It's kind of expensive to buy the premium to see if I will like it'; 'use the app fully for 2–3 months before spending the twenty').")
ext("C065", " Report 54: confirmed payers average 3.091 against 3.981 and are 3.3× more likely to leave one star (27.3% vs 8.4%); 12 of 31 one-stars are payers — 'the one-star population is, disproportionately, the company's customers'; the payer segment holds nearly all of six failure themes (10 of 12 value gap, 6 of 6 never unlocked, 6 of 7 restore, 5 of 5 refunds) — 'Free users complain about the gate; paying users complain about the goods'.")
ext("C071", " Report 54: abandonment 0.9% → 1.4% → 5.0% and support-unresponsive 0 → 0.7% → 4.2% across periods; reviewers escalate from inferring neglect ('after apparently a year since the last update') to reporting a closed channel; a six-year request backlog (widget since Oct 2020, long-range stats since Apr 2020); F6: publish any maintenance signal.")
ext("C073", " Report 54: reorder / drag habits (13, 4.54; 5 payers).")
ext("C075", " Report 54: onboarding_confusion 10 (2.71%, 3.70) — the water jar, 'repot' ('Will it restart all my progress?') and where to add a second habit are unexplained.")
ext("C078", " Report 54: the paid tier's named benefit 'Advanced Statistics' is a calendar — 12 value-gap reviews (2.58), 10 payers (22.7% of payers), three quoting the phrase back ('I bought this app bcs it stated advanced statistics for paid version. But I can not call these statistics even basic'); both payers who bought specifically for statistics were disappointed; F4: build it or delete the claim.")
ext("C080", " Report 54: dark mode requested (5), once for light sensitivity.")
ext("C092", " Report 54: price objections 3.1× more frequent outside developed storefronts; D2: storefront-tiered pricing for CN/TW/PH/TR/BR/CO.")
ext("C093", " Report 54: upgrade nag including after paying (5, 2.80); 'The paywall is so obtrusive' (GB).")
ext("C110", " Report 54: 'told to upgrade, no way to' (1).")
ext("C117", " Report 54: an avocado mascot with facial expressions (9, 4.78 — 'the little avocado characters really motivate me').")
ext("C141", " Report 54: iPhone only — iPad / Mac requested (7, 4.57; CN 3 of 7).")
ext("C147", " Report 54: the strongest conversion stories got enough free room to be convinced — two weeks, one week, a few minutes with the whole feature set visible — while the cap 'terminates evaluation rather than gating it'.")
ext("C157", " Report 54: 12 (3.25%, 4.75) praise the deliberate absence of streaks — 'most likely because it does not track streaks (which my black and white brain reads as failure if I am not perfect)… These are skills. Skills can be learned. I am not broken'; 'I have adhd and using streaks has always resulted in beating myself up'; one downloaded because a review said there were no streaks; D6: claim it; §8.5: do not add streaks with penalties.")
ext("C171", " Report 54: a detailed VoiceOver report (many fields and buttons unreadable, DE, 1★, offering to re-review once fixed) and Dynamic Type text cut off — 'below the 1% bar, but flagged under the standing exception for accessibility, and cheap to fix'.")
ext("C172", " Report 54: notes per habit requested (3, 4.67).")
ext("C177", " Report 54: a one-time purchase that 5 reviewers think is a subscription ('the one time fee for a whole year'; 'is the ¥68 membership a one-off lifetime buyout?').")
ext("C178", " Report 54: 'Unlike some other apps which include too many unnecessary settings, this app has just what you need. No distractions, and no complications'.")
ext("C216", " Report 54: 'the evidence of consistency and the punishment for breaking it are separable, and this user base wants the first without the second' — colour-density calendars, per-habit completion counts and monthly totals, not a streak counter with a reset (D4, 48 reviewers).")
ext("C218", " Report 54: three reviewer-reported listing-versus-product disagreements — 'Advanced Statistics' that is a calendar, a €2.50 subscription on the listing the app did not sell (a reader who 'would book that immediately'), and a listing that said 5 free habits when the app gave 3.")
ext("C231", " Report 54: payer and cap-complaint rates are identical in the high-volume group and globally (11.9%), so those are product properties, while price objection (CN 16.7%), restore failure (non-US) and outcome language (US 24.4%) are market-specific.")
ext("C237", " Report 54: more plants / a garden or shelf (9) and richer plant behaviour (9); growth stopping at 67 days — see [[C273]].")
ext("C246", " Report 54: no ads — the 7 reviewers who praise the absence are all 5★.")
ext("C251", " Report 54: a Google Play buyer must rebuy on the App Store (ES, 1★).")
ext("C271", " Report 54: a buyer on Google Play had to pay again on the App Store (ES, 2023).")
ext("C119", " Report 54: §8.5 'Do not redesign' — 128 praise the design and no 1★ criticises it.")
ext("C212", " Report 54: every refund request (5, all 1★) was caused by a failed entitlement, not dissatisfaction with the feature set.")

M = {
 "R54-006":["C147"], "R54-009":["C007","C002"], "R54-010":["C007","C147"], "R54-011":["C033","C029","C065"], "R54-012":["C078","C218"], "R54-013":["C065"],
 "R54-014":["C023","C042"], "R54-015":["C157","C216"], "R54-016":["C273","C237"], "R54-017":["C043","C010"], "R54-018":["C071","C036"], "R54-019":["C003","C004","C061"],
 "R54-020":["C033","C273","C078","C007","C023","C043","C010","C071"], "R54-023":["C053"], "R54-024":["C116","C027"], "R54-027":["C063"], "R54-028":["C246"],
 "R54-029":["C009","C014"], "R54-030":["C001","C191","C218"], "R54-031":["C064","C113"], "R54-032":["C177","C218"], "R54-034":["C119"], "R54-035":["C006","C178"],
 "R54-036":["C237","C117"], "R54-037":["C117"], "R54-038":["C005"], "R54-040":["C003","C004","C246","C061"], "R54-041":["C061"], "R54-043":["C071"],
 "R54-044":["C011","C216","C012"], "R54-045":["C009"], "R54-046":["C073"], "R54-047":["C022","C141","C080"], "R54-048":["C237"], "R54-049":["C013","C153"],
 "R54-050":["C019","C172","C021","C027"], "R54-052":["C007"], "R54-053":["C023","C022"], "R54-054":["C093","C127","C009","C110"], "R54-056":["C038","C078"], "R54-057":["C273"],
 "R54-058":["C033","C029","C212"], "R54-059":["C271","C251"], "R54-060":["C059","C071"], "R54-061":["C075"], "R54-062":["C171"], "R54-063":["C027"],
 "R54-066":["C023","C011","C007","C043"], "R54-067":["C010"], "R54-069":["C078","C065"], "R54-070":["C065","C033"], "R54-073":["C007"], "R54-074":["C147"],
 "R54-075":["C061"], "R54-076":["C003"], "R54-077":["C078"], "R54-078":["C065"], "R54-079":["C007","C063","C092"], "R54-080":["C092","C025","C004"],
 "R54-081":["C212","C033"], "R54-084":["C134"], "R54-085":["C157","C134"], "R54-086":["C033","C062"], "R54-089":["C237"], "R54-091":["C039"], "R54-092":["C092"],
 "R54-095":["C033"], "R54-096":["C092","C062","C027"], "R54-097":["C231"], "R54-100":["C023"], "R54-101":["C065","C078"], "R54-102":["C071","C036"],
 "R54-108":["C033"], "R54-109":["C273"], "R54-110":["C038","C078"], "R54-111":["C078","C218"], "R54-112":["C036"], "R54-113":["C071","C059"],
 "R54-114":["C007"], "R54-115":["C003","C092","C177"], "R54-116":["C023"], "R54-117":["C216","C157"], "R54-118":["C043","C010"], "R54-119":["C042","C134","C157"],
 "R54-122":["C157","C006","C119","C003","C273"], "R54-123":["C218"], "R54-124":["C007","C065"],
}
cards = [json.loads(l) for l in open("Tools/prd_ledger/54/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/54/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
print("unbacked:", [x["id"] for x in C.values() if "Report 54" in x["statement"] and not any(k.startswith("R54-") for k in x["cards"])])
