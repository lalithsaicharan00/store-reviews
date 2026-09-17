"""Stage 3 merge for report 41."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C255", "must-have", "An in-app language selector that respects the user's choice — shipping a localisation must never trap someone in a language",
    "Report 41: after Czech shipped, a Czech user wanted to keep English and 'there's no way to change the language' (13309363635, 5★); a French user's app switched itself to German — 'Why this language change to German??? I can't set it back to French? I'm so disappointed, I loved this app' (13509177027, 1★, Dec 2025). A regression introduced by localising, which converts a feature investment into a rating loss; the report's fix F5 is an explicit in-app language selector.")
add("C256", "must-have", "Skip, miss and not-yet-logged are visibly distinct states, and the stats explain which is which",
    "Report 41: a paying user never used the app because 'what does it mean when you forget to record a habit as completed, is that skipped or recorded as a miss. I don't understand how the stats work' (9373324084, GB, 3★); five years later 'when you go into a habit's history and see gaps, you don't understand whether you forgot to tick that day or whether it was a skip' (14303067862, UA, 4★); others ask for an explicit 'not achieved' (未達) state distinct from skip and to 'mark no if you missed it' (11107932681, 11725650343). Onboarding is the lowest-rated non-monetisation theme (8, mean 2.88).")

ext("C001", " Report 41 (counter-case: a gate that never moved): the 3-habit cap has stayed at 3 since 2020 and is still the only negative worse now than at launch (0.0% → 6.4% in 2025 → 4.2%) as category norms, features and price moved around it.")
ext("C002", " Report 41: a 4.591★ corpus where monetisation friction (46, mean 2.80) produces 47.7% of all 1–2★ and every reliability defect together (50, mean 3.46) only 29.5%; nine of ten paywall 2★ reviewers praise the product in the same sentence — 'the rating is set at the paywall, not in the app'.")
ext("C003", " Report 41: Lifetime Premium ($22.99 beside $4.99/mo and $12.99/yr) is the most-cited commercial feature — 81 reviews (9.94%, mean 4.70, 67 at 5★) and the top purchase trigger: 'Thank you very much for providing a single purchase option. It is much appreciated in the sea of subscriptions'; 'the option to pay once makes this a no-brainer'; zero US subscription objections with lifetime mentioned by 14.4% of US reviewers; a lost sale when it was not visible at the moment of friction ('It's been deleted and I've bought an app that just has one payment').")
ext("C004", " Report 41: positioned as the value option by 6 reviews ('My favourite app was Strides but I refused to pay the almost £80 premium'; 'die schönste und günstigste') against 1 calling it expensive; 'It is worth the absolutely fair (!) price of only 25 euros for the lifetime version'.")
ext("C005", " Report 41: 160 comparison-victory reviews (19.63%, mean 4.94, zero 1–2★) — arrivals after WabiTime, Focus, Structured, Habitify, Habitica, Done, Strides, Grit, Loop; Streaks named in 21 as the benchmark being displaced ('I loved Streaks, but hated its UI'; 'Streaks has a limit of 12').")
ext("C006", " Report 41: 'add nothing' is stated every year 2021–2026 and more emphatically than any feature request — 'Please don't try to be an all in one app!'; 'No plant that grows along, no timer you never use, just habit tracking'; 'no feeling that managing the habit tracker becomes a habit in itself'.")
ext("C007", " Report 41: a 3-habit cap is 28 complaints (3.44%, mean 2.32) — 66.7% of 2★ and 31.0% of 1★, spiking to 6.4% in 2025 — while 5 describe it as a working trial and 4 of them paid; fans inside the complaint name 5–10 habits as the line ('at least 8 or 10'; '10ish'; '5/7'; '4/5'); the cap hurts 2.3× more outside high-spend markets.")
ext("C009", " Report 41: interactive widgets (111 mentions, 13.62%) are the most-praised surface, stronger in the US (17.4%) and GB (18.8%) than DE / CA (~9.9%).")
ext("C010", " Report 41: a payer upgraded specifically to backfill an 8-day streak and backfilling did not exist (1★); can't backfill / edit past days 5 (mean 3.40).")
ext("C011", " Report 41: statistics are Premium ('in free version… No statistics'), named as a purchase trigger ('love statistics now visible'), and 'better / deeper statistics' is still requested by 9.")
ext("C019", " Report 41: break-a-bad-habit mode (max units per day) praised by 36 (mean 4.69); Screen Time as a trackable bad habit requested by 4.")
ext("C020", " Report 41: CSV export shipped Feb 2023 after a year of requests ('Now that the developer has added CSV export… the app is 5-star awesome for me') and is named as a purchase reason ('so my data is safe'); praised by 14 (mean 4.71).")
ext("C021", " Report 41: Apple Health auto-completion (53 mentions) is a switch reason ('Coming from Grit, I almost instantly bought it because the Apple Health habits actually work') and a payer failure ('I paid for it specifically for synching with the health app'); Health gaps 8.")
ext("C022", " Report 41: the Watch app shipped in 2021 on request (discussion peaked 13.7% then normalised); a privacy-minded payer cancelled because Watch sync requires iCloud and will return for 'easy normal Bluetooth sync between the phone and the watch'.")
ext("C025", " Report 41: a high-school student asks for a student deal; a Turkish 5★ says the one-time fee is too much 'at least in my country'; the report proposes purchasing-power-adjusted lifetime tiers in the long-tail storefronts.")
ext("C027", " Report 41: shipping Italian and Traditional Chinese (Jun 2026) brought reviewers straight back to rate 5★ ('I ran straight here to give 5 stars'); missing Spanish blocked a purchase ('es por eso que aún no acabo de lanzarme a comprarla'); Russian — requested from five unrelated storefronts — is the largest unserved language; non-English storefronts like the app equally (4.581) but self-report paying at 5.52% vs 9.9%.")
ext("C030", " Report 41: cross-device iCloud sync with no account is praised by 90 (11.04%) and fails for 13 (1.60%, mean 3.08) — four of them payers, because sync is the promise the app is bought on.")
ext("C033", " Report 41: premium bought on iPhone never reached the iPad (2022) and premium intermittently reverted to free with Restore Purchases failing (2025) — 'a paying customer being shown a paywall is the most damaging possible bug'.")
ext("C034", " Report 41: 6 data-loss reports (0.74%, mean 3.33) — 'After 215 days of tracking… everything… deleted, all history lost! No chance to restore'; 'deleted from BOTH old and new device' on migration; one recovered only by the developer by hand; a 6-month total loss filed at 5★.")
ext("C035", " Report 41 (counter-evidence): no account is praised (privacy / no account 10, all 5★: 'Pas de compte à créer, pas de données collectées'), and the report lists 'do not require an account' among what not to change.")
ext("C036", " Report 41: the only support channel is a mailto: link that dead-ends users without the Mail app ('forcing me to add a mail account'; a trial user 'likely will cancel'), in an app where support closes sales and is the only data-recovery path; support praise collapsed to 1.7% in 2025 as volume tripled, then recovered.")
ext("C043", " Report 41: 'X times per week, any days' / 'every N days' (13) and seeing which day a weekly habit was done (9) — one request asked twice, every year 2021–2026, 8 of 13 at 4★: 'I would like the option of doing something 3 times a week, not necessarily on the same day'; the app models which-days and how-many-times as alternatives.")
ext("C045", " Report 41: lists / tags with per-list rings and widget filtering (2022).")
ext("C046", " Report 41: Siri Shortcuts with near-full app control praised by 36 ('I was able to automate 80% of habits tracking'); public API / Zapier / IFTTT requested by 5.")
ext("C049", " Report 41: mood tracking added via Apple Health (Sep 2024, 'I'm very happy to see mood tracking added'); 5 wanted it inside the app's own history.")
ext("C056", " Report 41: Apple Intelligence habit suggestions shipped (Sep 2025) drew one light positive ('I like the apple AI to help with ideas'), while 'an AI coach' is on the report's do-not-add list.")
ext("C059", " Report 41: eleven requested capabilities shipped inside the corpus with requesters returning to confirm (notes, Watch, % widget — review edited twice, Shortcuts in the same month, CSV export, vacation mode, heat maps, mood, custom day start 'It was not available at that time, but it is now', Czech / Italian / Traditional Chinese); a support reply 'within hours. Twice' closed a lifetime sale.")
ext("C061", " Report 41: 'Just bought the premium to support the developer i don't even need the features tbh'; decisions made in 20 minutes to a few days on a 3-habit free tier.")
ext("C062", " Report 41: high-spend markets self-report paying 2.4× more (9.59% vs 4.00%) and hit the cap 2.3× less; subscription objections are 9 of 10 inside high-spend markets; the UK is the best market (zero cap complaints, 12.5% payers), Canada the most price-sensitive yet most-converting (17.6% objections, 13.7% payers).")
ext("C064", " Report 41: lifetime moved €22 (2021) → €28 (2023) → €22–25 / $22.99 (2026) and price objections tracked it (4.2% 2022, 4.6% 2025, 0% 2026); reserve prices named €10, <$5, £3.99.")
ext("C065", " Report 41: 5 of 29 1★ (17.2%) are payers whose specific purchase rationale failed — backfill, Mac sync, Watch sync without iCloud, Health sync, refund; 10 of 60 payers report a post-purchase failure.")
ext("C066", " Report 41: a per-habit timer with Live Activities praised by 27.")
ext("C075", " Report 41: onboarding 8 (mean 2.88, lowest non-monetisation) — 'How to use this app🤡 :: Is there a tutorial?'; could not find how to edit a habit; a paying user never started because the skip / miss / stats model was opaque; the report proposes a one-screen 'how this app models habits' card.")
ext("C078", " Report 41: four of ten post-purchase failures bought for one named capability that then failed (backfill, widget ×2, Health sync) — any single-feature failure is a total failure of the purchase.")
ext("C085", " Report 41: 'This app doesn't hoard your data'; privacy / no account 10 reviews, all 5★.")
ext("C092", " Report 41: purchasing-power-adjusted lifetime tiers proposed for the 63 sub-50 storefronts, where cap complaints are 2.1× the high-volume markets.")
ext("C094", " Report 41: 'it asks for a review every day which is needlessly annoying even if you've rated the app' (1★, Aug 2026); 111 of 815 (13.6%) contentless praise at a 69-character median — the signature of prompted reviews.")
ext("C107", " Report 41: widgets are icon-only — 'When you have +10 habits, one habit widget with only icon and no clue to remembering the habit is a pain'; one runs a competitor alongside for text labels (8 requests); widget icons 'Make them bigger and it is 5 stars!'.")
ext("C108", " Report 41: yearly / long-horizon goals requested by 6.")
ext("C112", " Report 41: 'I would like to unsubscribe and delete the app but there are no means to do that via the app'.")
ext("C133", " Report 41: the report's experiment E1 is to move the gate off habit count onto history depth, statistics, widgets, sync or customisation, measuring conversion and the 1–2★ rate together.")
ext("C134", " Report 41: an app that wins 19.63% of reviews on comparison is under-discovered ('It deserves a way higher ranking and visibility in the search results'; 'I didn't find it the first time'); the listing does not lead with the one-time option, the non-binary ring, full Apple-ecosystem coverage or no ads / no account; outcome stories (10.4% of 2026) are an unused asset.")
ext("C143", " Report 41: countable goals with over-achievement and partial credit ('if a habit needs a count of seven… and you have only performed it four times, you get credit for that').")
ext("C147", " Report 41: purchase decisions in hours on a 3-habit free tier ('I bought the lifetime after trying it for like 20 minutes'), while others say 'you can't get a proper demo out of this without having at least 8 or 10 habits'.")
ext("C148", " Report 41: a buyer paid for the Home Screen widget shown in the listing screenshots while it was 'coming soon' (2★); another: 'no widgets… which was the entire reason I bought it. The preview looks nothing like the app this is a scam'.")
ext("C153", " Report 41: a recoverable migration loss was recovered only by the developer by hand — the report asks for visible backup / restore with a 'last backed up' state.")
ext("C157", " Report 41: 'the percentage focus and backseating of streaks made this a thing i actually use' — one streak-prominence request is treated as a minority against the differentiator.")
ext("C170", " Report 41: custom day-start and week-start shipped May 2025 after being requested from 2021; night-shift day reset 5.")
ext("C171", " Report 41: the Mac app has no text zoom — 'text and icons are too small on my 27-inch display' (the only accessibility report).")
ext("C173", " Report 41: sub-tasks with time per step requested by 7, one blocking a purchase ('I need sub tasks with time for each').")
ext("C177", " Report 41: the Lifetime SKU was intermittently invisible — 'I can no longer see the lifetime plan which I would like to purchase!'; 'When activated trial there was a lifetime subscription option. Now don't see it'; 'bummed I missed out on the lifetime deal'; and a Chinese user found no purchase entry at all — 'the cheapest revenue recovery in the report'.")
ext("C178", " Report 41: 'What you will not find here: being told which habit to do. Challenges against other people'; the report's do-not-add list — to-do list, journal, pet, plant, challenges, social feed, AI coach.")
ext("C196", " Report 41: a German reviewer chose the subscription over lifetime deliberately — 'I want the app to still work in 3 years'.")
ext("C199", " Report 41: calendar view / calendar integration requested by 7.")
ext("C201", " Report 41: a daily completion percentage ring with partial credit is the quiet differentiator (40, mean 4.67) — 'as someone who suffers from perfectionism and binary thinking… you're never thinking about the cliff edge of losing a streak… made this a thing i actually use and bought over the hundreds of habit apps i browsed'; 'a meh day means about 70%— C work, but a better baseline'; two want weighted habits, one dislikes 'out of 100%'.")
ext("C209", " Report 41: 'No account or login is needed' is a reason to choose the app; one payer cancelled rather than enable iCloud.")
ext("C216", " Report 41: the non-binary percentage ring rather than streaks is why a perfectionist bought.")
ext("C218", " Report 41: Spanish and Portuguese are on the listing while reviewers in ES / CL / BR report them missing (2024–2026).")
ext("C225", " Report 41: two early users were given the full version free at the 2020 launch and rated 5★.")
ext("C226", " Report 41: app badge counter broken / absent (3).")
ext("C246", " Report 41: no ads anywhere; six name the absence as a reason they chose the app vs one who would prefer ads to paying €1.99/month.")

M = {
 "R41-001":["C005"], "R41-006":[], "R41-008":["C005","C134"], "R41-009":["C134"], "R41-010":["C007","C002"], "R41-011":["C007","C147","C133"],
 "R41-012":["C002"], "R41-013":["C003"], "R41-014":["C177","C003"], "R41-015":["C034","C153"], "R41-016":["C030","C065"], "R41-017":["C043"],
 "R41-018":["C027"], "R41-019":["C027","C059"], "R41-020":["C062","C064","C003"], "R41-021":["C059","C036","C061"], "R41-022":["C036"], "R41-023":["C112","C212"],
 "R41-024":["C007","C177","C043","C034","C027","C036","C107","C108"],
 "R41-026":["C059"], "R41-027":["C218","C027"], "R41-028":["C056"], "R41-030":[], "R41-031":["C007","C011","C009","C080"], "R41-032":["C011","C234"], "R41-033":["C153","C020"],
 "R41-034":["C064","C003"], "R41-035":["C064"], "R41-037":["C002"],
 "R41-038":["C006"], "R41-039":["C006","C178"], "R41-040":["C009","C023"], "R41-043":["C011"], "R41-044":["C021"], "R41-045":["C022"], "R41-046":["C019"], "R41-047":["C046"],
 "R41-048":["C039"], "R41-049":["C066"], "R41-050":["C043"], "R41-051":["C031","C175"], "R41-052":["C020"], "R41-053":["C040"], "R41-054":["C085","C209"], "R41-056":["C011"],
 "R41-057":["C021","C072"], "R41-058":["C075"], "R41-059":["C107"], "R41-060":["C173"], "R41-061":["C199"], "R41-062":["C108"], "R41-063":["C246","C006"], "R41-064":["C177"],
 "R41-065":["C170"], "R41-066":["C010"], "R41-067":["C065"], "R41-068":["C049"], "R41-069":["C172"], "R41-070":["C043"], "R41-071":["C046"],
 "R41-073":["C005"], "R41-074":["C005"], "R41-075":["C006","C178"], "R41-076":["C134"], "R41-077":["C201","C216","C157"], "R41-078":["C201"],
 "R41-079":["C030","C009","C022","C021","C046","C085"], "R41-080":["C009","C062"], "R41-081":["C007"], "R41-082":["C007","C246"], "R41-083":["C007"],
 "R41-084":["C003","C177"], "R41-085":["C064","C025","C092"], "R41-086":["C031","C030","C040","C021","C034"], "R41-088":["C075"], "R41-089":["C256","C217"],
 "R41-091":["C011"], "R41-092":["C107"], "R41-093":["C173"], "R41-094":["C199"], "R41-095":["C108"], "R41-096":["C049","C021"], "R41-097":["C043"], "R41-098":["C046"],
 "R41-099":["C019"], "R41-100":["C051","C037","C226"], "R41-101":["C059"],
 "R41-103":["C094"], "R41-104":["C043","C007"], "R41-105":["C171","C044"], "R41-106":["C007","C002"], "R41-107":["C065"], "R41-108":["C094"], "R41-109":["C007","C002","C005"],
 "R41-111":["C225"], "R41-113":["C003"], "R41-114":["C059","C036"], "R41-115":["C007"], "R41-116":["C011"], "R41-117":["C021","C005"], "R41-118":["C020"], "R41-119":["C147"],
 "R41-120":["C061"], "R41-121":["C025"], "R41-122":["C003","C059"], "R41-123":["C003"], "R41-124":["C065","C078"], "R41-125":["C078"], "R41-126":["C033","C139"], "R41-127":["C148","C218"],
 "R41-128":["C177","C027","C173","C025"], "R41-129":["C112","C022"], "R41-130":["C022"], "R41-131":["C004"],
 "R41-133":["C062","C003"], "R41-135":["C006"], "R41-136":["C196"], "R41-137":["C062","C003"], "R41-138":["C062","C064"], "R41-139":["C062"], "R41-140":["C062"], "R41-141":["C027","C007"],
 "R41-142":["C027"], "R41-144":["C255"], "R41-145":["C027","C218"],
 "R41-148":["C007","C002"], "R41-149":["C005"], "R41-150":["C134"], "R41-151":["C036","C059"], "R41-152":["C022"], "R41-153":["C007","C001"], "R41-154":["C027"], "R41-155":["C006","C043"],
 "R41-156":["C177"], "R41-157":["C036"], "R41-158":["C034","C153"], "R41-159":["C033","C139"], "R41-160":["C255"], "R41-161":["C256"], "R41-162":["C107"],
 "R41-163":["C133","C007"], "R41-164":["C043"], "R41-165":["C027"], "R41-166":["C092","C025"], "R41-167":["C134"], "R41-168":["C075","C256"],
 "R41-169":["C002"], "R41-170":["C218"], "R41-171":["C177"], "R41-172":["C022"], "R41-174":["C094"], "R41-175":["C094"],
 "R41-176":["C006","C178","C056"], "R41-177":["C246"], "R41-178":["C209","C085","C035"], "R41-179":["C003","C155"], "R41-180":["C201","C157"],
 "R41-181":["C201","C216"], "R41-182":["C025","C092"], "R41-183":["C177","C148"],
}
# unattached (nuance register): 002 method, 003 positive corpus, 004 eligibility, 005 payers, 006 misrates, 007 price caveat, 025 year table, 029 SetApp, 030 NFC,
# 036 master table, 041 motivation, 042 payers, 055 trial, 072 weak rows, 087 stability, 090 unmet table, 102 distribution, 110 payer table, 112 triggers table,
# 132 storefronts, 134 US low ratings, 143 AU, 146 method, 147 headline series, 173 conversion question
cards = [json.loads(l) for l in open("Tools/prd_ledger/41/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/41/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
