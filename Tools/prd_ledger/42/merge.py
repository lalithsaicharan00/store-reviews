"""Stage 3 merge for report 42."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C257", "product-rule", "Never paywall reminders — it moves the comparison from 'which habit tracker' to 'why pay for an alarm'",
    "Report 42: reminders sit behind the paywall and are the feature most often named as the thing behind the wall (5 reviews, mean 2.60 — 'I just wanted to use the habit reminder feature and that would cost me 40 a year? Come on. That's insane!'), while working reminders are praised at mean 5.00 (6); three reviewers independently conclude the phone's own tools substitute — 'better to use the native Lista app on iPhone… doesn't freeze and is free'; 'the paid version adds a reminder — you can set that in the calendar too'; 'Your alarm or reminder on your phone can do everything this app does. Wasted $20!' The report calls un-paywalling reminders 'the most defensible single paywall change'.")

ext("C001", " Report 42: three long-tenured users describe free features becoming paid on update — 'I've used the app a long time, until today's subscription screen appeared… forcing subscription, disabling buttons… I and those around me will stop using it and stop recommending it' (TR, 1★); 'An app I used to love… but everything has become paid'; 'after the update, only useful in the paid version' — and the paywall complaint rose 7.7% (2020) → 35.4% (2024) → 57.1% (2026).")
ext("C002", " Report 42: a 3.136★ written corpus (store aggregate 4.6) where monetisation friction (87, 42.23%, mean 1.85) produces 73.5% of all 1–2★ and every reliability defect together (31, mean 2.45) only 20.5% — 'fixing every bug in this app would recover roughly a fifth of its bad reviews; fixing the paywall would address three-quarters'; the written mean fell monotonically 3.96 → 2.69 as the paywall tightened and quality fell.")
ext("C003", " Report 42 (absence): no lifetime tier — seven concurrent subscription SKUs at $4.99–$59.99; the only explicit lifetime request is 'Нет перманентной, только подписка на год'.")
ext("C007", " Report 42: a 3-habit cap where time, date, reminders and repetition are also paid is 55 complaints (26.70%, mean 1.96) — the largest theme — read as the product being broken ('Everything is paid! Writing a routine, only the title is free'; 'There is no reason to subscribe to the app to only have 3 habits'); four reviewers say the free tier proves there is no reason to subscribe; the number 3 has been cited every year 2022–2026.")
ext("C011", " Report 42: statistics are the actual premium value proposition — three of six named purchase triggers ('Seeing the progress percentage of habits and which days they were done… because I found it in this app I bought the premium version'; 'The detailed stats in premium version are worth it') — while the same feature miscalculates for non-daily habits (a payer) and history is capped for free users.")
ext("C020", " Report 42: no export or backup; history beyond ~2 weeks paywalled ('if you don't pay you won't see last month's result').")
ext("C025", " Report 42: 'I was ready to pay, but it has to be reasonable… I'm sure if you lower the price, revenue will grow' (RU); price objections at $39.99–$59.99 in high-income markets vs '500₽ a year, that's nothing'.")
ext("C029", " Report 42: three payers charged without intending — 'immediately charged for a subscription upon opening the app for the first time'; 'auto-selected a package and deducted money… hadn't even tried it' (499k₫); a promotional R$39.90/year that became R$99.90 at checkout — plus a trial that 'won't get the refund even if you cancel two minutes after'; 11 of 29 writing payers (37.9%) request refunds.")
ext("C031", " Report 42: a launch-blocking regression 4 Dec 2024 – 11 Jan 2025 — 7 'won't open' reviews (mean 1.71), 5 Russian inside 40 days, one a payer three months into an annual subscription ('Give my money back, crooks').")
ext("C034", " Report 42: data loss 6 (mean 1.33, acted on regardless of share) — 'last night it updated… All my data and tracking… is gone'; 'I had 90 days of progress on every habit, now it's all gone and became 9 days'; 'I used it for many years… After the last update progress isn't visible… looking for a replacement' — the update → restart → history-truncated pattern recurs, four of six Russian.")
ext("C036", " Report 42: a paying customer with data loss had no route to a human — 'it says mail isn't connected, but there's no section in the app to connect it' — and replies are canned ('they just reply the same thing to everyone', a 10-vote review).")
ext("C043", " Report 42: setting which days, dates and repetition is Premium ('task repetition is paid-plan only', JP 1★); 'Tue & Thu' and shifting a habit to another day requested.")
ext("C062", " Report 42: a $39.99–$59.99 app almost absent from high-spend markets (63 of 206; Germany, Australia, China zero) and rated worst there once bursts are removed (2.587); its review base moved to Brazil and Russia, and 20 long-tail storefronts show 46.9% cap complaints with one payer — 'an uncontrolled A/B test of paywall-first onboarding with no trial' (mean 2.906).")
ext("C063", " Report 42: 'no trial' is the lowest-mean theme in the corpus (14, 6.80%, mean 1.29); reviewers name the length they wanted (1 day, 3 days, 7 days, a month) and four met the paywall before any use ('Literally two seconds after downloading'); the report distinguishes it from the cap complaint — a trial asks for temporary full product and is strictly cheaper to grant.")
ext("C064", " Report 42: $39.99–$59.99/yr (US), ¥6,900 (JP, both reviews 1★), R$79.90 per 12 weeks (BR) vs 500₽ (RU, 'that's nothing'); price objection 18 (mean 1.67, never above 3★) — 'you pay that much for barely any technology'; 'the subscription price is unreal for what the app delivers'.")
ext("C065", " Report 42: payers (29) rate 2.72 vs non-payers 3.20, 44.8% of them 1★, none 4★ — 'no such thing as a mildly satisfied paying customer'; 9 of 29 hit a defect after paying (freezing '5 minutes to mark two tasks', a launch crash, disappearing habits, premium stats miscalculating).")
ext("C075", " Report 42: 'Endless screens asking unnecessary questions with no option to skip. I deleted the app after about 15 non-shippable screens, never got to use it'; '~30 questions before I gave up' (both 1★).")
ext("C082", " Report 42: zero mentions of ads; upsell interstitials play the role ('the popups for premium are annoying and difficult to click out of'); one would rather see ads than pay €1.99/month (report 34).")
ext("C083", " Report 42: lag scales with habit count ('the more goals you add the slower it gets'; hit at 15 habits) — 12 reviews (mean 2.58), 9 Brazilian, 4 payers — 'the users most affected are the ones who bought the app to have more than three habits'.")
ext("C089", " Report 42: a promotional R$39.90/year shown, R$99.90 charged at confirm (1★, 'I'm waiting to adjust my rating of the app').")
ext("C093", " Report 42: upsell interstitials 'annoying and difficult to click out of' (3, mean 1.67).")
ext("C094", " Report 42: a rating prompt inside onboarding — 'Asking for a rating the first time I log in? How could I possibly know. But, since I'm being asked I must give it a one star' — the clearest causal chain to a 1★ in the corpus (2, both 1★).")
ext("C111", " Report 42: ~15–30 unskippable setup screens before the price, with a rating prompt inside them (3 reviews, all 1★, never used the app).")
ext("C112", " Report 42: two cancelled; one could not find how to refund; 'Don't fall for the free-trial trap.. you won't get a refund even if you cancel two minutes after'.")
ext("C133", " Report 42: the report proposes moving the wall to history depth, statistics depth or reminder count rather than habit count — statistics already being the top named purchase trigger.")
ext("C143", " Report 42: multiple completions per day for water, meals and reps do not exist — 6 reviews (all US, 13.0% of US, mean 1.50), two refund-seeking payers: 'Track your food? Great - you can track it ONCE/day'; 'So you're going to eat or drink water just once a day?' — the marketing promises a counter, the product delivers a daily checkbox.")
ext("C147", " Report 42: 'you can't get… a test to see whether it's actually worth paying'; a migrating HabitBull power user lost at the wall ('I couldn't move around or familiarize myself enough to justify paying to unlock integral features'); 'every tab I open to poke around is locked'; the 1★ band's 'never used the product' population (~20) needs a trial, the 'paid and regret it' population (13) needs the product to be worth it.")
ext("C148", " Report 42: a 'goal for the day' shown in marketing could not be found (1).")
ext("C153", " Report 42: no visible backup / restore; 'update → restart → history truncated' recurs across 2020–2026.")
ext("C171", " Report 42: premium pop-ups 'difficult to click out of' alongside a text-size accessibility complaint.")
ext("C177", " Report 42: seven concurrent IAPs, five near-identically named at $39.99 / $59.99 — reviewers quote wildly different prices by year and storefront.")
ext("C186", " Report 42: retroactive paywalling of an installed base — 'forcing subscription, disabling buttons'; 'everything has become paid'.")
ext("C218", " Report 42: the listing names 36 languages including Hebrew and Ukrainian which the app does not deliver — 'They present it as if it's in Hebrew. In practice there's no option for a Hebrew interface' (IL, 1★); 'Preview on AppStore was on Ukrainian, I don't like that it's on russian' (three of Ukraine's eight reviews) — a factual misstatement, not a backlog item; a 'goal for the day' advertised and absent.")
ext("C240", " Report 42: a mandatory 'congratulations' trophy modal on every check-off blocks the Continue button and freezes the app for heavy users ('It takes me at least 5 minutes to mark two tasks as done'; 'pops up far too often'; messages 'not coherent') — 4 reviews; a settings toggle is the cheapest fix in the report.")
ext("C246", " Report 42: no ads and none asked for — the complaint is the upsell interstitial.")
ext("C255", " Report 42: Ukrainian users served a Russian interface with no way to switch ('How to switch to Ukrainian/English interface?').")
ext("C006", " Report 42: simplicity ('nothing extra', 'no fluff', 'not over-engineered') is the one stable praise across seven years and six languages (22, mean 4.68) — the complaints are about access, reliability and two missing primitives, not about the app being too simple.")
ext("C059", " Report 42: reviewers notice fixes — 'Thanks for the update, it helped remove the lag. I'll bring my subscription back'; 'how much the app has improved in that time! Progress details, results info, charts' — vs 'they just reply the same thing to everyone'.")
ext("C027", " Report 42: Russian-language support was the original wedge in Russia ('the competitor has no Russian'), and Russia is both the most appreciative and the most defect-exposed market — where users now cannot pay at all.")
ext("C026", " Report 42: 'there's no way to pay from Russia' (Jun 2026) — a market with the worst defect exposure receiving paywall pressure it cannot convert.")
ext("C054", " Report 42: six US 5★ reviews in three days (Aug 2020) with 13–30 helpful votes each and nonsense titles ('Hgfgg', 'Bdbdbd'), and eleven of Canada's twelve reviews 5★ generic praise in 13 days (May 2021) — 17 reviews (8.25%) that inflate the mean from 2.968 to 3.136 and leave Canada unmeasurable.")
ext("C231", " Report 42: Brazil (41.8% cap complaints, 9 of 12 lag reports), the US (all six multi-count complaints, near-zero cap), Russia (5 of 7 crashes, 4 of 6 data losses, no payment rail) and Japan (both reviews 1★ on price) each fail differently on the same product.")
ext("C009", " Report 42: no widgets at all, framed as a competitive deficit — 'it has no widgets, so it loses against the rest of similar apps'; 'It's a paid app, so I have higher requirements… PLEASE add a WIDGET section' (a payer).")

M = {
 "R42-001":["C003","C177"], "R42-003":[], "R42-004":[], "R42-005":["C054"], "R42-006":["C054","C076"], "R42-008":[], "R42-009":["C177","C064"],
 "R42-010":["C002"], "R42-011":["C007","C002"], "R42-012":["C063","C109","C182"], "R42-013":["C065","C029"], "R42-014":["C031","C065"], "R42-015":["C083","C240"],
 "R42-016":["C240"], "R42-017":["C006"], "R42-018":["C143","C048","C078"], "R42-019":["C218","C255"], "R42-020":["C002","C001"], "R42-021":["C001","C186"],
 "R42-022":["C063","C007","C143","C240","C031","C218","C257","C036"],
 "R42-025":["C257","C008"], "R42-026":["C043"], "R42-027":["C011","C020","C234"], "R42-028":["C080","C118"], "R42-029":["C009"], "R42-030":["C036"], "R42-031":["C172","C013","C202"],
 "R42-032":["C007","C133"], "R42-033":["C089","C177"], "R42-034":["C109","C029","C212"], "R42-035":["C246","C093"],
 "R42-037":["C005"], "R42-039":["C065"], "R42-040":["C175"], "R42-041":["C011"], "R42-042":["C218","C181"], "R42-045":["C093"], "R42-046":["C038","C011"], "R42-048":["C214","C257"],
 "R42-051":["C002"], "R42-052":["C007","C257","C043"], "R42-053":["C147","C007"], "R42-054":["C064"], "R42-055":["C003"], "R42-056":["C063","C147"],
 "R42-057":["C031","C083","C034","C175"], "R42-058":["C034","C153"], "R42-059":["C111","C075"], "R42-060":["C094","C150"], "R42-062":["C218","C148"],
 "R42-064":["C185","C006"], "R42-066":["C007","C257"], "R42-067":["C083"], "R42-068":["C147","C065"], "R42-069":["C065"],
 "R42-071":["C011"], "R42-072":["C059"], "R42-073":["C065","C078"], "R42-074":["C133","C214"], "R42-075":["C029","C212","C112"], "R42-076":["C026"], "R42-077":["C147","C063"],
 "R42-078":["C005","C027"], "R42-079":["C257"],
 "R42-082":["C007","C231"], "R42-083":["C083","C231"], "R42-084":["C064","C036"], "R42-085":["C143","C231"], "R42-087":["C031","C034","C027","C026"], "R42-088":["C054"],
 "R42-089":["C062","C231"], "R42-090":["C064"], "R42-091":["C062","C147"], "R42-092":["C218","C255"],
 "R42-095":["C002"], "R42-096":["C001"], "R42-097":["C175","C059"], "R42-099":["C065"], "R42-100":["C029","C065"], "R42-102":["C006","C007"],
 "R42-103":["C063","C109"], "R42-104":["C240"], "R42-105":["C150","C094"], "R42-106":["C111"], "R42-107":["C031","C153"], "R42-108":["C218"], "R42-109":["C036"], "R42-110":["C089"],
 "R42-111":["C007","C133"], "R42-112":["C257"], "R42-113":["C143"], "R42-114":["C009"], "R42-115":["C083"], "R42-116":["C007"], "R42-117":["C063"], "R42-118":["C062","C064"], "R42-119":["C011","C133"],
 "R42-121":["C001"], "R42-126":["C006","C002"],
 "R42-127":["C064","C092"], "R42-128":["C065","C231"], "R42-130":["C147","C001","C029"],
}
# unattached (nuance register): 002 method, 003 bimodal, 004 aggregate gap, 007 eligibility, 008 misrates, 023 year table, 024 inventory table, 036 master table,
# 038 motivation, 043 churn, 044 requests, 047 design, 049–050 weak rows, 061 unmet table, 063 distribution, 065 4★, 070 payer table, 080 storefronts, 081 BR table,
# 086 US volume, 093 other storefronts, 094 era method, 098 praise collapse, 101 geography, 120/122–125 research questions, 129 aggregate contradiction
cards = [json.loads(l) for l in open("Tools/prd_ledger/42/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/42/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
