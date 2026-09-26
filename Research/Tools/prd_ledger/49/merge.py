"""Stage 3 merge for report 49."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C266", "must-never-break", "A generated programme escalates on observed completion, never on a fixed calendar — and never past what a health limit the user declared allows",
    "Report 49 (Life Reset): a 66-day programme whose targets rise on a fixed weekly schedule reaches 90-minute lifts plus 4-mile runs six days a week and 2 gallons of water a day for people who were sedentary at week 1 (ramp unrealistic / unsafe 20, mean 2.85; 3–4 litres prescribed without assessment); advanced users get beginner plans (13); reviewers who complete everything are still told they have not improved and a German reviewer who wanted habit stability found the escalation demotivating (guilt-inducing tone 13, Germany +3.34pp); asthma, post-surgical injury, nerve damage and mobility limits cannot be entered (10 — 'ableist and short-sighted'), running is the only cardio (20). The report calls it partly a safety matter and recommends adapting the ramp to observed completion, which addresses the ramp, level-mismatch and guilt complaints together, while keeping the 66-day structure itself (13 at 4.77★). Related: [[C160]] (a declared limitation must change the suggestions), [[C103]] (vulnerable users), [[C203]], [[C095]].")
add("C267", "dont", "No AI-generated art, copy or content in a paid product — reviewers accept an AI coach and reject AI decoration",
    "Report 49 (Life Reset): AI-generated task icons, achievement art, motivational copy and book summaries are criticised by 53 reviews (4.30%, mean 1.85) — the only product criticism rising in every era (0% → 4.4% → 4.0% → 5.5%), spreading from images to the writing ('replete with the odd linguistic signatures characteristic of an LLM'), typos and code, and double the global rate in Australia (10.34%). The objection is craft tied to price: 'I cannot see myself paying full price for something that is completely built by AI… Only then can I say this is something I'd actually tell my friends about'; 'for an app promoting ideas of doing the work and not being lazy, using AI instead of just paying an artist… seems like a very cheap move'; 'Just pay humans to do work'. AI planning is welcomed (6, mean 4.50) — 'The distinction is decoration versus function.' The report: commission at least the hero assets; fixing typos removes the most visible AI tell. Report 47 (DotHabit) is the complementary case: an AI coach replying to check-ins is praised unprompted ([[C263]]). Related: [[C056]], [[C185]].")

ext("C001", " Report 49: no free tier at any point in 29 months — the free product is the questionnaire, the 'analysis' and the paywall; hard paywall is the largest theme (256, 20.78%, mean 1.31) and a 331-review 'never used it' cohort (26.87%, 1.23) reviews only the funnel.")
ext("C002", " Report 49: the widest written-vs-store gap in the ledger — 2.77★ from 1,232 writers vs 4.7★ from ~12,000 ratings; monetisation friction (538, 43.67%, 1.49) supplies 74.6% of all 1–2★ while only 35 reviews carry both praise and friction — 'two largely separate populations, one reviewing the funnel and one reviewing the product'; on the 901 reviews from people who used it the mean is 3.34★; the product improved sharply in 2025 yet the 1–2★ share held at ~50% because 'every improvement in this corpus happened behind the paywall'.")
ext("C003", " Report 49: prefers a one-time purchase 23 (1.87%); a 66-day programme sold as a 12-month subscription is itself an objection (15).")
ext("C004", " Report 49: 'too expensive' (113, 1.65) is flat-to-rising while 'not worth it' (55) collapses 6.8% → 1.4% — 'reviewers increasingly accept that the product delivers, while continuing to object to what it costs'; 39 defend the price at 4.74 ('Yeah, You Have to Pay. Yeah, it's Worth it'); ten live price points from $12.99 to $59.99 under two product names.")
ext("C005", " Report 49: rivals named — Me+, Finch, Atoms (the model for customisation), Habitica ('a stylized version of Habitica but with cards'), Habit Legends ('no subscriptions… MUCH MUCH more flexible with editing tasks'), Level-Up ('At least it's free'), Opal, Notion templates; the threat named most is ChatGPT — 36 say the plan can be generated free; 'None of those [loop, art, community, removing the daily decision] is reproducible with a prompt. The checklist is.'")
ext("C025", " Report 49: 30 cannot afford it, 12 of them self-identified minors, in a 9+ app marketed on anime social media; an under-18 / student free programme exists but only 3 reviewers know of it — the report's experiment: surface it.")
ext("C026", " Report 49: dollar-pegged pricing in Türkiye, sanctions blocking cards, no UPI / local payment method (7).")
ext("C027", " Report 49: German added May 2025 but 'sprachlich nicht ganz sauber'; the book summaries and meditations stay English-only — 'localise the content, not just the chrome' — requested in DE, KR, JP, ES, BR, PL; Korea reports unnatural translation in 18.2% of its reviews; behaviour-change praise runs 7.69% in Germany vs 18.13% in the US, plausibly a localisation-quality gap.")
ext("C029", " Report 49: every overcharge review is a payer — €1.99/month becoming €30 at once, $2/month becoming $70, £25 on top of £29.99, a year charged during a trial, seven months of charges after cancellation (9; payers 8.49% vs 0.73% globally).")
ext("C031", " Report 49: a launch-crash cluster (Oct 2024, 37.5% of the window), a 22 May 2025 update that stopped the app opening for users 20–39 days into a 66-day programme (37.8% of the fortnight), a June 2026 crash-on-task-completion wave (32.1% of the month); crash on launch fell 10.2% → 0.0% by E4 while unspecified bugs rose to 7.9% in the new game layer.")
ext("C033", " Report 49: restore purchase fails 5 — every one a paying customer locked out of what they bought, all 1★ — 'the most severe five-review theme in the corpus'.")
ext("C034", " Report 49: progress reset or lost 36 (14.15% of payers vs 2.92%) — an update or logout restarts a 66-day programme at day 1: 46 of 66 days lost, a 177-day streak lost, six accounts lost within 48 hours in June 2025 (window mean 1.92) — 'destroys the exact asset the product is selling'.")
ext("C036", " Report 49: 'contact support' is not a button (3), App Support resolves to a 404, multi-day silence — 21 unreachable (1.43), 10 of them payers; when support does answer it is outstanding (9 at 4.89 — a refund plus a free year) — 'The capability exists; the routing and the staffing do not.'")
ext("C038", " Report 49: the day counter advances wrongly — 20 reviews, flat Oct 2024 – Jun 2026, never fixed; the daily recap closes scoring at a fixed ~9pm (10).")
ext("C040", " Report 49: the same blank / stuck-on-day-1 widget reported in Mar 2025, May 2025, Nov 2025, Dec 2025 and the final week of the corpus (8).")
ext("C044", " Report 49: iPad and Mac builds exist but layouts are broken (device incompatibility 15, mean 1.27).")
ext("C059", " Report 49: an official Discord with an active developer (17, 4.65) and visible responsiveness (19, 4.74) both rise across eras; an Indonesian reviewer abandoned over rigidity, wrote in, returned months later to find customisation built — 'THIS APP HAS BEEN IMPROVED A LOT'; 8 more noticed.")
ext("C062", " Report 49: US 47.00% at 2.97 (behaviour change +4.58pp); UK 2.43 is 'transaction-damaged' (payers 13.92%, misleading checkout +7.48pp); Germany rigidity-focused (cannot edit +9.70pp, no trial +8.08pp); Australia AI-critical (10.34%); the paywall grievance varies only 14.7–19.8% across five markets — universal; the praise is American.")
ext("C063", " Report 49 (the natural experiment): 90 asked for a trial; one arrived 24 Jan 2026 card-gated, auto-charging, annual-only, with a forced loop — hard-paywall complaints went 17.24% → 34.96%, 'advertised as free' 2.13% → 6.50%, 11 new 'trial charged immediately' reviews, mean unchanged (2.77 → 2.78) — 'the reputational cost of a paywall plus the reputational cost of a billing surprise'; reviewers propose 'allow the first week to run freely. Get the user on a run, and they'll pay to continue'; the report: no card and a free first week, or no trial and an honest price — 'The half-measure is the worst of the three options.'")
ext("C065", " Report 49: 106 payers average 1.92 — 97 (91.5%) carry a complaint; reliability 41.5% of payer reviews vs 13.4% of non-payers; login failure 11.32% vs 1.30%; 57 payers at 1★ 'the most serious group in this report'.")
ext("C070", " Report 49: 'Solo Leveling' is the language that sells — 38 name the anime as why they love it (4.87, the highest mean above 30), 'I wanted to level up like jinwoo sung and came across this app through an ad'; 15 name Instagram / TikTok.")
ext("C075", " Report 49: onboarding too long 29 (1.55), rising every era to 4.1% — some abandon during the questionnaire before any price is shown.")
ext("C076", " Report 49: 27 reviews invert their stars as a signalling channel ('THIS is actually a one star review. I just wanted you to see it'; 'Gunna remove the one Star as soon as I know you got the message').")
ext("C092", " Report 49: Canada itemises CA$79.99 plus 14.99% Quebec tax; Türkiye objects to dollar-pegged pricing.")
ext("C094", " Report 49: 1★ used as leverage — 'I am enjoying the app and will change the review once they fix it'.")
ext("C096", " Report 49: 20 frame the pre-paywall questionnaire as data collection (1.10) — one demands deletion.")
ext("C103", " Report 49: the acquired audience is young and emotionally timed — 12 minors, 'I saw it on insta at 2am and got the 2am motivation to change my life so now I have a year of this app', buyers 'at the lowest point in life' or in severe depression; mental-health-benefit reviews carry the taxonomy's highest mean (4.94).")
ext("C109", " Report 49: 'I signed up for the 1 week free trial and was immediately charged AU$17.98'; 'immediately charged for one year. It does not show up in your Apple subscriptions and there is no way to cancel your trial!'; cancelled a day early and still charged $50; 'a loop so you can not use the app if you don't accept the free trial'; a 7-day trial only on the annual plan billed €14.99 immediately.")
ext("C110", " Report 49: no 'continue free' path exists at all — 256 say the only free thing is the questionnaire and its result.")
ext("C111", " Report 49 (the strongest case): a 10–20 minute questionnaire plus a pledge before a hard paywall — onboarding-before-price 156 (12.66%, mean 1.15, the lowest of any theme above 20; 140 of 156 at 1★); many do not object to paying, only to the sequence ('they ask for tons of personal stuff before displaying the price wall instead of after'; '30分かけて設定したのに…初めに言って欲しい'), identical in 15+ languages; the never-used cohort (331) grew to 33.1% of the latest era; all 40 'scam' accusations are about this payment experience; the report's fix #1: 'A price shown on the first screen converts a one-star review into a non-download.'")
ext("C113", " Report 49: a countdown discount that does not apply (an 80% notification resolving to 70%) and 'limited time offers' that tipped purchases (misleading checkout 17).")
ext("C117", " Report 49: a character / hero mode with equipment, loot and battles shipped late 2025, cut 'just a checklist' to 1.0% of E4 and immediately generated its own bug theme (5).")
ext("C131", " Report 49: social / guild features requested by only 2 — the community lives in Discord.")
ext("C133", " Report 49: 'just a checklist' 38 (1.68) and 'do it yourself instead' 36 (1.36) — a bare checklist reproducible by ChatGPT cannot carry the price; the level-up loop, art and community can.")
ext("C136", " Report 49: advanced users given a beginner plan (13) — let users enter existing fitness so the plan starts at the right level.")
ext("C141", " Report 49: iPad layout reported broken (part of device incompatibility 15).")
ext("C144", " Report 49: a bundle of screen blocker ('a godsend… the typical screen time limit apple has… doesn't cut it' — no detractors), Pomodoro, workout and calorie trackers, journal, meditation and book summaries (22 + 23 praise) around the habit core.")
ext("C148", " Report 49: Solo Leveling ads promise an avatar, quests and penalties — 15 'not what the ad promised' (1.40) and 38 'just a checklist' (1.68) vs 38 who love the framing (4.87); an Instagram ad said 'get your free life reset plan today' (advertised free 37, 1.08) — 'the fix is in the ad, not the app'.")
ext("C157", " Report 49: an optional hard mode that resets to day 1 with penalty tasks on a miss is loved by a small, intense, entirely satisfied group (13, 4.77) — opt-in severity works; guilt-inducing tone as a default is criticised (13).")
ext("C160", " Report 49: asthma, post-surgical injury, nerve damage and mobility limits cannot be entered and running stays the only cardio (10 + 20) — see [[C266]].")
ext("C170", " Report 49: the wake-time control permits only ~5–10am, excluding night-shift, graveyard and FIFO workers — 31 reviews at 3.42 (well above the corpus), 23 stating their shift, US +2.15pp, several saying they want the product while uninstalling; the daily recap closes the day at a fixed ~9pm (10) — 'the cheapest high-value fix in the report'; a partial fix turned a 4★ into 5★.")
ext("C177", " Report 49: the UK's advertised £1.99–£2/month resolves to a £24.99–£29.99 annual charge at checkout (misleading checkout 8.86% of GB, +7.48pp) while 'price too high' runs below global — 'the checkout presentation, not the price level, is what is generating one-star reviews'; a monthly plan costing more for two months than the annual for twelve (15).")
ext("C182", " Report 49: a hard paywall before any use — 43.67% of the corpus attacks how it is sold; buyers convert on a 2am impulse, the Solo Leveling frame or a low point, and payers then average 1.92.")
ext("C185", " Report 49: the questionnaire and personalised 'analysis' convert the segment it fits, but fit, disciplined reviewers told they have '40% more bad habits than the average person your age' read the assessment as a sales device (13).")
ext("C203", " Report 49: cannot add own tasks 80 and cannot edit the generated programme 70 are the top themes of the 3★ and 4★ bands (9.43% / 15.09% among payers) — 'the design is excellent, the idea is right, and I cannot make it fit my life'; custom tasks shipped mid-2025 cut 'cannot add' 10.2% → 1.0%; still needed: week-by-week edits, swapping running, entering existing fitness.")
ext("C212", " Report 49: a marketed '66-day money-back guarantee' cited 13 times (1.85) with undisclosed conditions (66 logged days at ≥ 50% completion — 'Very misleading'), met conditions and no refund, a confirmed PayPal transfer that never arrived, 'nowhere to be found'; 21 of 36 refund requests refused or ignored (1.14) — 'a marketing promise generating one-star reviews at a higher rate than having no promise would'.")
ext("C215", " Report 49: reviewers emailed for days about refunds, were told the app is not eligible for an App Store refund, then hit a 404 on App Support.")
ext("C218", " Report 49: 'Free with In-App Purchases' and an ad saying 'get your free life reset plan today' front a product with no free use — advertised as free 37 (1.08), tripling after the trial launched.")
ext("C222", " Report 49: 40 want a free tier, ads or donations instead of a hard paywall (several volunteering heavy advertising); an Indian reviewer proposes 3–5 free habits with premium above — a report experiment.")
ext("C235", " Report 49: signup blocked — a name field that could not be scrolled past (Aug–Sep 2025 cluster, 23 at 1.13).")
ext("C237", " Report 49: 'what happens after day 66' and further programmes requested (5); several describe second, third and fourth 66-day cycles.")
ext("C241", " Report 49: an under-18 / student free programme granted case by case is invisible to almost everyone.")
ext("C251", " Report 49: no restore between iPhone and iPad (3).")
ext("C256", " Report 49: tasks marked done / partial / skipped by swipe; no pause for illness or absence (3).")
ext("C263", " Report 49: AI planning is welcomed (6, 4.50) while AI decoration is rejected (53) — see [[C267]].")

M = {
 "R49-003":["C002"], "R49-004":["C064","C065"], "R49-005":["C002","C111","C182"], "R49-006":["C111","C001","C218","C096","C113"], "R49-007":["C063","C109"],
 "R49-008":["C203","C160","C170","C266"], "R49-009":["C065","C036","C212","C034"], "R49-010":["C031","C175"], "R49-011":["C267"], "R49-012":["C148","C070","C117","C058"],
 "R49-013":["C170","C042"], "R49-014":["C111","C063","C203","C036"], "R49-015":["C058","C002"], "R49-016":["C002"],
 "R49-018":["C024","C157","C117","C266"], "R49-019":["C144","C040","C044","C059","C027","C025","C212","C170","C116"], "R49-020":["C001","C182","C063","C177","C212"], "R49-021":["C064","C177"],
 "R49-022":["C002","C111"], "R49-023":["C111","C001","C182"], "R49-024":["C067","C101"], "R49-025":["C117","C024","C052"], "R49-026":["C183","C203"], "R49-027":["C144","C116","C027"],
 "R49-028":["C059"], "R49-029":["C061","C004"], "R49-030":["C111","C001"], "R49-031":["C218","C096","C113","C185","C075","C180"], "R49-032":["C004","C003","C222","C025","C026","C092"],
 "R49-033":["C203","C170","C266","C136","C160"], "R49-034":["C266","C160","C103"], "R49-035":["C203","C059"], "R49-036":["C031","C034","C033","C038","C040","C044","C175","C235"],
 "R49-037":["C267","C133","C148"], "R49-038":["C267","C263","C056"], "R49-039":["C036","C212","C215"], "R49-040":["C203","C237","C021","C147","C148","C063"], "R49-041":["C002"],
 "R49-043":["C111","C065","C212"], "R49-044":["C203","C004"], "R49-046":["C111","C203"], "R49-047":["C076","C094"], "R49-048":["C065"],
 "R49-049":["C058","C070","C103","C113","C185"], "R49-050":["C065"], "R49-051":["C029"], "R49-052":["C034","C033","C203"], "R49-053":["C212","C215","C112"],
 "R49-054":["C063","C147","C177","C025","C026"], "R49-055":["C063","C109","C218"], "R49-056":["C005","C133"],
 "R49-058":["C062","C170"], "R49-059":["C062","C092"], "R49-060":["C062","C063","C027","C266"], "R49-061":["C177","C062"], "R49-062":["C267","C062"], "R49-063":["C027","C222","C062"],
 "R49-064":["C062","C231"], "R49-065":["C231","C062"], "R49-066":["C027"], "R49-068":["C002"],
 "R49-070":["C059","C002"], "R49-071":["C111","C001"], "R49-072":["C063","C109"], "R49-073":["C031","C117","C175"], "R49-074":["C203","C059"], "R49-075":["C267"],
 "R49-076":["C175","C034","C031"], "R49-077":["C038","C040"],
 "R49-078":["C111","C218"], "R49-079":["C063","C109"], "R49-080":["C170"], "R49-081":["C036","C215"], "R49-082":["C034","C033"], "R49-083":["C212"], "R49-084":["C203","C136"],
 "R49-085":["C266","C160","C095"], "R49-086":["C267"], "R49-087":["C148","C117"], "R49-088":["C027"], "R49-089":["C157","C117","C144","C059","C006"], "R49-090":["C111","C063","C222","C266","C267","C025"],
 "R49-091":["C002","C063"], "R49-092":["C027","C025","C212","C237"], "R49-093":["C103","C025","C058"], "R49-094":["C002","C004","C076"],
 "R49-095":["C062"], "R49-096":["C062"], "R49-097":["C062"], "R49-098":["C062"], "R49-099":["C062"],
}
# unattached (nuance register): 001 positioning, 002 method, 017 inventory table, 042 distribution, 045 cross-tab, 057 storefront table, 067 era method, 069 era theme table
cards = [json.loads(l) for l in open("Tools/prd_ledger/49/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/49/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
