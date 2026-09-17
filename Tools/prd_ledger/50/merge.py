"""Stage 3 merge for report 50."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C268", "must-have", "Journal / notes prompts are optional — a toggle to stop the post-completion journal prompt, and a text editor that never corrupts input",
    "Report 50 (HelloHabit): the built-in journal (notes on habits reviewable in a diary view) is a primary reason people choose and keep the app — 19 reviews (9.27%, mean 4.74; 'To me this is gold, and the best implementation I've seen of this feature'; 'it let me delete a couple other apps') — yet it is also the worst-quality surface: the notes editor corrupts input (3 reviews, mean 3.33, Jan 2025 → Apr 2026, unresolved 16 months — keyboard covers the cursor, a letter stuck by the cursor, 'my second sentence somehow gets pieced into my first'; two name it as the withheld fifth star), and a journal prompt fires after every task with no way to switch it off (2, both 5★ — 'I don't use the journaling feature and wish there were a way to turn off the prompt') — the report's 'cheapest fix' and 'cheapest rating repair'. Related: [[C172]] (per-day notes), [[C006]] (every addition opt-in), [[C228]] (IME-safe text fields).")

ext("C001", " Report 50: the free cap was cut 5 → 3 between 26 Jan and 17 May 2026 (nine reviewers state 5 at mean 3.78, five state 3 at 2.20, zero overlap); monetisation friction rose 3.1% → 35.3% of reviews across six half-years and August 2026 (9 reviews, 2.89) is the worst month; a Turkish-storefront reviewer had unlimited habits 'only for the first few days' then was told to 'buy a subscription or keep only three habits' and locked out of her own statistics.")
ext("C002", " Report 50: a 4.263★ corpus (69.3% 5★) where monetisation friction (26, 2.42) supplies 48% of the 25 1–2★ while more reviewers praise the pricing than complain (31 at 4.87 vs 26) — 'this product's pricing reputation was, until 2026, a net asset' — and 40 feature-gap reviewers average 4.38 and supply only 2 bad reviews: 'do not treat the feature backlog as a rating-recovery lever'.")
ext("C003", " Report 50: a lifetime tier existed ('Love that there is a lifetime membership so I don't have to pay monthly', Aug 2025) but later reviewers ask for one as if absent — 'I would like purchase a lifetime access subscription for this' (4★, Nov 2025) — withdrawn or undiscoverable; the report's S2: make it discoverable; subscription-model objectors 4 (mean 2.00).")
ext("C004", " Report 50: payers judge the price low for the category ('relatively low compared to similar services'; 'Honestly would pay more for this'); price objectors 3 (a French student: '2,99€/month would be fair'); quoted $5 / €5.99 / ≈$2.99 monthly and $14.99–$20 yearly.")
ext("C005", " Report 50: 37 reviews (18.05%, 4.89) rank it first after trying others — the largest theme — 'I reckon I've tried almost every habit tracking app on the App Store, and this is the one I've settled on'; 'trying different habit trackers since 2018 and HelloHabit is the only one that stuck'; the one counter-teardown says 'Reminders, Things, etc, all do a much better job'.")
ext("C006", " Report 50: simplicity (20, 4.90) and flexibility (14, 5.00) praised simultaneously — 'the moat is that the app is both deep and uncluttered. Every roadmap decision should be tested against whether it preserves that'; 'Nothing comes close to the ease in navigation, creativity, options, and customizability'.")
ext("C007", " Report 50 (the direct 5-vs-3 comparison): at 5 free habits reviewers defend the cap — 'Tienes 5 hábitos por elegir gratis lo que considero perfecto ya que te hace ser prioritario' ('perfect since it makes you prioritise'); '5 x free habits is a great option for new habit trackers'; 'I have 5 and it's all I need, when I get a job I will actually buy a subscription' — while at 3 nobody does: '3 hábitos gratis es una mierda'; 'la versión gratuita debería ser funcional' — 'Five habits was above the threshold at which a user can demonstrate a routine to themselves… Three is below it'; the 3★ band is five convinced users stalled by the cap (praise → cap → rating, none objecting to the price); 'Give me like 6 or 7 free habits and I'll be happy'; the report's S1: revert to 5, grandfather existing users, or disclose before install; experiment: A/B 3 vs 5 vs 7 on conversion, retention and rating.")
ext("C013", " Report 50: one account across iPhone, iPad and Mac, free within the cap.")
ext("C016", " Report 50: streak freeze / habit pause is the most-requested missing capability (3, mean 4.33) and archive (2) — 'It makes me feel guilty for losing my streaks, but like sometimes your routine has to change for a few days!'; 'it's much easier for me to continue a streak when it's large rather than from ground zero'; skipped days visually distinct (1) — the report's S4: ship freeze / pause / archive together as retention mechanics.")
ext("C019", " Report 50: a quit / reduce mode with a reset-on-relapse counter praised by 6 (4.83) — trichotillomania ('The fact that I have to reset the tracker every time I \"fall back\" gives me the more motivation'), drinking.")
ext("C021", " Report 50: Health auto-tracking of steps, calories, distance and exercise with historical import praised by 7 (4.71, 5 US); 5 (4.60; 4.50% of US) want weight, sleep, mindful minutes and Apple Fitness session types synced instead of hand-entered — one says weight sync would move the rating to 5; a Health sync break after an update (1).")
ext("C022", " Report 50: a Watch app shipped Jan–May 2025 after requests ('almost perfect, it just needs a watch app'); one 1★ calls it useless — no habit complication, notifications not working.")
ext("C023", " Report 50: widgets with check-off shipped by Nov 2024 after a Mar 2024 request; interactive check-off, quick-append journal, compact and weekly-progress widgets still requested (3); widget lag (1).")
ext("C027", " Report 50: Korea — 4 reviews all 5★, two asking for Korean ('Add korean'; a detailed 5★ written in Korean that still cannot use the app in Korean) — the cleanest unmet-demand signal from a small storefront; experiment: localise into Korean.")
ext("C029", " Report 50: 3 reviews (mean 1.00, all 1★, Aug 2024 → Jan 2026) charged an amount not matching the quote — '$14.99 for the yearly membership' vs a $31.01 bank charge; 'said to be $14.99 after the free trial but I was charged $30 before my free trial was up. This app is a scam'; ~$50 annual auto-charge — the same ~$15 advertised vs ~$30 charged 17 months apart; 'The app does not accept any of my cards' (2 cannot pay) — the only defect class with a 1.00 mean and no exceptions; fix F1 and experiment: instrument price displayed vs charged per storefront.")
ext("C031", " Report 50: reliability flat and thin (21, 10.24%, no defect above 4 reviews in 31 months) — 'a well-built app and it has stayed well-built… the rating risk… cannot be engineered away'; 4 of 20 one-stars never used the product (crash, would not initialise, login failed).")
ext("C034", " Report 50: 'the app just pushed an update and erased all my data without any warning or options to save' (1★, May 2026); a Premium user's to-do entries lost and unrecoverable (Apr 2026) — no reviewer in 205 mentions a backup; fix F6: visible backup / restore and no destructive migrations.")
ext("C035", " Report 50 (counter-evidence): a mandatory account limited to Sign in with Apple or Google before first use lost two GB users at the gate — 'Why would I want to expose every aspect of my life to data mining in this way? Stay clear.' and 'unable to login with apple' — 'a conversion risk and a single point of failure'; S6: consider a local-first trial mode.")
ext("C036", " Report 50: in-app support chat praised by 8 (5.00) and developer responsiveness by 11 (4.91) — 17 unique; one negative ('sometimes customer service give is not very caring'); support re-sent a lost discount offer and closed the sale — 'an asset to protect… not a cost centre to optimise'.")
ext("C040", " Report 50: widget lag (1, 5★).")
ext("C042", " Report 50: ADHD users 7 (3.41%, 4.29; 5 US at 4.80 — 'ADHD life saver ❤️'; 'the best app to help me with my crazy ADHD'; 'ADD/ADHD/OCD me Loves You!!!'); the one 1★ is an ADHD user whose household tasks no longer fit in 3 free habits; mental health 4 (5.00 — depression, bipolar 1, memory loss, low mood).")
ext("C043", " Report 50: 'at least N per week' goals missing (2, 5.00 — a weekly goal marked complete at Mon–Thu cannot record Friday and Sunday); every-other-day, future start date and 15-minute increments requested (4).")
ext("C044", " Report 50: Mac and iPad companion with one account (praised).")
ext("C045", " Report 50: journal notes filterable by activity or category.")
ext("C047", " Report 50: stats praised by 23 (4.83) — weekly / monthly / yearly reports, grid map, success percentage, 'consistency (not only streaks)'; payers name statistics depth as the value.")
ext("C049", " Report 50: a mood tracker and body-weight tracker bundled in.")
ext("C050", " Report 50: tasks / to-dos and 'Lista' sections alongside habits (requested May 2024, shipped); the list section reported broken (MX, Aug 2026).")
ext("C059", " Report 50: 'the developer implemented what I asked and more - he pretty much filled all the gaps I identified'; 'crowdsourcing feature ideas from the community(!!!)'; 'reorder habits without scheduling (*this was updated very soon, thank you)'; requests moved from 'does it exist' (widgets, Watch, to-dos) to 'does it go deep enough' within ~18 months.")
ext("C061", " Report 50: free tier praised by 12 (4.92) and price-positive 16 (4.81) — 14 five-stars volunteer the fair price unprompted; 'Has everything that u need and even more for free'; the documented purchase path runs through sustained free use first (a month; six months; 'Once [the habits are] internalised I'll be delighted to pay for more options').")
ext("C062", " Report 50: monetisation friction 9.0% in the US vs 17.0% elsewhere and 10.8% in the (effectively English-language) high-spend group vs 20.5%; every 3-habit-cap report is non-US (TR, AU, MX ×3) — 'US-only dashboards would not have surfaced finding 1 at all'; Japan returned zero written reviews.")
ext("C063", " Report 50: a 7-day trial ('Download, 7day free trial, then u gotta subscribe') with charges landing before it ended and no expiry reminder (see C029, C152).")
ext("C065", " Report 50 (counter-case): payers are happy — 9 direct at 4.11 (7 at 5★), 13 with probable at 4.23 vs 4.27 for non-payers; both unhappy payers were hurt by billing, not the product; a Premium user who lost data still wrote a 2,020-character defence — 'Every monetization change should be evaluated against whether it risks converting this segment into the angry-payer segment that most competitors have.'")
ext("C069", " Report 50: vibration cannot be disabled — 'especially for a (supposedly) peace-of-mind application' (1★, KZ).")
ext("C073", " Report 50: an August 2026 update removed editing or deleting a single occurrence of a recurring habit ('I love this but I was really disappointed in the update that took away ability to modify time or delete single reoccurring events in a day') — fix F5: a straight revert.")
ext("C075", " Report 50: onboarding bimodal — confusion 4 (2.75) vs 'The onboarding and habit creation are straight to the point' 3 (5.00).")
ext("C080", " Report 50: colour coding, app-wide font, text size, dark mode, week-start day and per-habit units praised (customisation 25, 4.80); hex colours, longer habit titles, hide streak count requested.")
ext("C094", " Report 50: the review prompt fires during onboarding alongside 'a page of positive reviews less than two minutes after I opened the app' — two 1★ reviews about nothing else ('I don't even star using this app and you ask me for a review'; 'participant reactivity bias plus peer pressure… Absolutely disgusting'); 27 of 142 five-stars ≤ 60 characters — fix F3: move it behind a streak milestone, which also stops inflating the corpus.")
ext("C101", " Report 50: badges / achievements requested (1).")
ext("C104", " Report 50: the 5 → 3 cap cut reached users without notice — four say they were not told the terms before installing, and the angriest reviews are from people who lost capacity they already had.")
ext("C109", " Report 50: 'I was charged $30 before my free trial was up'; 'They absolutely DONT SEND THE REMINDER when the trial is about to finish… they charge you automatically the whole year'.")
ext("C110", " Report 50: a pop-up 'insisting I pay for premium every time I open the app… it stops me from just being able to use the app' (GB, 1★) — the only report of the paywall obstructing ongoing free use; 'it takes 15 Seconds to ask you for 5,99 every month' (DE).")
ext("C118", " Report 50: habit templates / suggestions at setup exist; recurring journal templates promised by the listing are still missing ('I hope vote templates are coming as it promises').")
ext("C119", " Report 50: repeated UI redesigns drew three long-term US users in five weeks (Jan–Feb 2025, all churn risk) — 'it's also counter intuitive to create an app about routine and habits and make your users keep adjusting to new layouts'; 'this was perfect as it was when I first downloaded it!… now it's messy' — not repeated in 19 months; 'do not redesign the UI again without a migration path'.")
ext("C120", " Report 50: stopwatch and countdown for duration habits; Pomodoro / focus music requested (2).")
ext("C127", " Report 50: no ads at any tier (5 confirm).")
ext("C133", " Report 50: 'the entire monetization surface is one number' — no reviewer reports reminders, statistics, journaling, widgets, Health or the Watch app individually gated — 'That clean one-gate model is worth protecting — and §7.2 shows what happens when the one gate moves.'")
ext("C134", " Report 50: a Reddit user was acquired by a screenshot of the monthly report ('so pretty'); Instagram-ad and Reddit acquisitions are all 5★.")
ext("C141", " Report 50: marking done 'somewhat better on iPad' than iPhone per one teardown.")
ext("C144", " Report 50: all-in-one praised by 17 (4.94) — habits + tasks + schedule with time blocks + journal + mood + weight in one place.")
ext("C147", " Report 50: three of four intent-to-pay reviewers use the free tier first, and two actual payers state the sequence (months free, then pro) — the path a cap cut interferes with.")
ext("C150", " Report 50: see C094 — a prompt during the intro produces 1★ from users with no opinion.")
ext("C152", " Report 50: no trial-expiry reminder before a ~$50 annual charge (AU) — fix F1 pairs it with the price mismatch.")
ext("C153", " Report 50: no backup or restore capability mentioned anywhere in 205 reviews after two data-loss reports.")
ext("C155", " Report 50: an update removed single-occurrence editing of recurring habits (see C073).")
ext("C172", " Report 50: see [[C268]] — the journal is a primary reason to choose the app and its editor the worst-quality surface.")
ext("C181", " Report 50: a listing that says 5 free habits while users get 3; journal-app sync 'as advertised' that does not work; templates the listing 'promises' — fix F7.")
ext("C199", " Report 50: Apple / Google Calendar integration requested by 3 (4.67).")
ext("C209", " Report 50: sign-in required before first use, Apple or Google only (see C035).")
ext("C218", " Report 50: search summaries of the listing state a 5-habit free cap, 1 reminder per habit and 3 journal notes per day while five 2026 reviewers in four storefronts get 3 habits and nobody mentions the other caps — 'Either way this is a disclosure problem'.")
ext("C225", " Report 50: two 5★ reviewers ask for a referral / discount programme ('rewards for recommending the app to friends… in the form of discounts') while 37 evangelise it — S3: build one.")
ext("C227", " Report 50: archive completed habits requested (2) — a completed short-term goal cluttering the screen.")
ext("C230", " Report 50: to-do entries lost and unrecoverable for a Premium user (Apr 2026).")
ext("C231", " Report 50: the cap change is invisible in the US (all four US cap statements say 5) and concentrated in Turkey, Australia and Mexico (four of Mexico's five reviews in 18–24 Aug 2026) — hypothesis: it lands hardest where the subscription is expensive relative to local purchasing power.")
ext("C236", " Report 50: own statistics locked after hitting the reduced cap (TR).")
ext("C237", " Report 50: long-tenure reviewers (9) all rate 5★; requests deepen rather than stop.")
ext("C253", " Report 50: per-habit reminders praised by 10 (4.90); notifications broken on the new Watch app (1).")
ext("C256", " Report 50: skipped days should be visually distinct (1); a Skip that breaks daily completion is part of the pause request.")
ext("C191", " Report 50: grandfather existing free users at 5 — the two cap-cut reviews describe loss, not a low starting cap; experiment: grandfather-vs-migrate.")
ext("C219", " Report 50: 'unlimited for the first few days' then 'keep only three habits' — the cap applied retroactively to habits already created.")

M = {
 "R50-004":["C094","C150","C076"], "R50-006":["C001","C007","C104","C191","C219"], "R50-007":["C001","C002"], "R50-008":["C065","C029"], "R50-009":["C029","C109","C152","C033"],
 "R50-010":["C005","C006"], "R50-011":["C268","C172"], "R50-012":["C268","C228"], "R50-013":["C036","C059"], "R50-014":["C016","C227","C256"], "R50-015":["C021"], "R50-016":["C094","C150"],
 "R50-017":["C119"], "R50-018":["C007","C029","C268","C094","C016","C021","C073","C181"], "R50-019":["C002","C032"],
 "R50-021":["C144","C019","C050","C047","C021","C022","C013","C044","C023","C080","C118","C020","C036","C209","C049","C120"], "R50-022":["C016","C227","C199","C021","C043","C120","C027","C101","C080","C023"],
 "R50-023":["C007","C063","C003","C004","C133","C127","C061"], "R50-024":["C133"], "R50-025":["C218","C181"],
 "R50-026":["C002","C061"], "R50-028":["C005","C006","C047","C144"], "R50-029":["C007","C029","C016","C021","C043"],
 "R50-030":["C007","C001","C219","C236"], "R50-031":["C007","C191"], "R50-032":["C029","C109","C152"], "R50-033":["C031","C268","C034","C073","C022"], "R50-034":["C034","C153","C230"],
 "R50-035":["C005","C022"], "R50-036":["C094","C119","C075","C036"], "R50-037":["C268"], "R50-038":["C035","C209"],
 "R50-039":["C005","C006","C268","C036","C019","C042","C144"], "R50-040":["C019","C067"], "R50-041":["C021","C043","C199","C016","C080","C027","C023","C227","C118","C120","C225","C181"],
 "R50-042":["C043"], "R50-043":["C027"],
 "R50-045":["C061","C094"], "R50-046":["C016","C268","C022","C073","C199","C007"], "R50-047":["C007","C147"], "R50-049":["C001","C029","C031","C094"],
 "R50-051":["C007","C029"], "R50-053":["C065"], "R50-054":["C147","C036","C061","C004"], "R50-055":["C147","C007"], "R50-056":["C047","C036","C021"],
 "R50-057":["C007","C029","C003","C004","C218","C110","C236"], "R50-058":["C003"], "R50-059":["C225"], "R50-060":["C134","C058"],
 "R50-063":["C062","C021","C042","C119"], "R50-064":["C034","C073"], "R50-065":["C035","C094","C110","C062"], "R50-066":["C007","C029"], "R50-067":["C062","C231"], "R50-068":["C231","C007"],
 "R50-069":["C027"], "R50-070":["C062"], "R50-071":["C236","C029","C069"],
 "R50-073":["C001","C002"], "R50-074":["C001","C007"], "R50-075":["C001","C073"], "R50-076":["C002"], "R50-077":["C031"], "R50-078":["C119","C059"], "R50-079":["C059","C022","C023"], "R50-080":["C005","C065","C029","C268"],
 "R50-081":["C029","C109","C152"], "R50-082":["C268"], "R50-083":["C094","C150"], "R50-084":["C268"], "R50-085":["C073","C155"], "R50-086":["C034","C153"], "R50-087":["C181","C218"],
 "R50-088":["C007","C191","C104","C218"], "R50-089":["C003"], "R50-090":["C225"], "R50-091":["C016","C227"], "R50-092":["C021"], "R50-093":["C035","C209"], "R50-094":["C007","C191","C094","C003","C027","C029"],
 "R50-095":["C007","C062","C003"], "R50-096":["C034","C042"], "R50-097":["C006","C119","C036","C133"], "R50-098":["C042","C019","C103"],
}
# unattached (nuance register): 001 positioning, 002 method, 003 & 005 warnings, 020 inventory table, 027 master table, 044 distribution, 048 2★ table, 050 contradictions, 052 payer table, 061 & 062 storefront tables, 072 half-year table, 099 band lists, 100 minor numbers
cards = [json.loads(l) for l in open("Tools/prd_ledger/50/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/50/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
