"""Stage 3 merge for report 18."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C200","product-rule","Never meter the completion action — a free cap may limit habits, never check-offs","Report 18: the free tier advertised 10 habits but ticking a habit consumed a 14-per-week memo quota (two check-offs a day), so tapping 'complete' produced a purchase sheet; 139 reviews (6.79%, mean 2.32★, 19.6% of all 1★) and five years of 'stops working on day 3/5/6/10'. A habit tracker that refuses to record a completion in the first week demonstrates that it does not work, to a user deciding whether it works — 'I was 90% ready to buy… I just lost all feeling for it and deleted it.'")
add("C201","must-have","A user-set partial-completion threshold — a 'good day' below 100%","Report 18: a traffic-light day status that turns green at a user-chosen ~60–80% is the most-articulated praise in a 2,048-review corpus (92 reviews at 4.24★; explicit partial-completion praise at 4.80★): 'with percentage apps you aim for 100 and suffer; here you switch to \"green is good enough\"'; 'a 60% check feels like 100% achievement'; 'I never feel guilted or pressured'. Rest / postpone / skip options sit alongside it. Some users want it harder (a must-do habit that gates the light, a 90% threshold) — so the threshold is a setting, not a constant.")
add("C202","undecided","A light social layer that is explicitly not a social network","Report 18: seeing other users' routines, copying them and sending cheer messages was praised by 66 reviewers (3.22%, mean 4.45★) precisely because 'it isn't like SNS'; a teacher chose the app over rivals because its social features are lighter, and following a friend was described as a shared exchange diary. Very strong only in Korea (3.69%); emerging elsewhere.")
add("C203","product-rule","Onboarding lets the user author their own routine first — suggested plans, surveys and pledges are optional","Report 18: the lowest-rated theme (34 reviews, mean 2.03★) was an onboarding that ran a long survey, built the routine for the user, assumed a 9-to-5 weekday life, demanded a signed pledge and then showed the paywall — 'I wanted to create my own routine not have you suggest one for me. Hence the name of your app. MY routine not your routine'; 'an app that wants to turn you into a very ordinary machine'. Shift workers, night workers and parents were excluded before they reached the product.")
add("C204","product-rule","Never destroy user work at the paywall; label paid features before they are used","Report 18: two users each spent an hour building routines, were asked to pay to save them, and lost the work anyway; others were paywalled on features the listing documented as free; a GB buyer paid for a timer the screenshots advertise and could not find it. Reviewers 'cannot tell what they are buying' when the same feature is free for some and paid for others in overlapping periods.")
add("C205","research","Aggregated, searchable journal / diary across days","Report 18: people wrote daily reflections for years and could read them back only one date at a time; diary/memo aggregation, a calendar of entries and search was the highest-rated request theme in the corpus (22 reviews, mean 4.68★) and the reason a lifetime buyer switched to a competitor.")
add("C206","undecided","Swappable day templates / routine modes for irregular schedules","Report 18: shift-work / variable-day routine profiles were a meaningful request (31, 4.03★) from 2022; 'routine modes' shipped Dec 2025 as Pro and won back a churned subscriber ('神✨'; a nurse: 'rain in a drought') but shipped buggy — switching a mode rewrote past days, modes applied forward-only, edits did not persist, and the feature was buried in Settings.")
add("C207","must-have","Let users hide surfaces they don't use — tabs, social, recommendations, streaks","Report 18: 'UI complexity / can't find things' was the largest negative theme by count (149, 7.28%) and high-priority in all three eligible storefronts (KR 6.75%, JP 10.76%, US 8.33%), rising as features accumulated; an ADHD reviewer asked to hide social, recommendations, to-do, diary and streaks; another asked the developer explicitly not to add more.")
add("C208","research","Photo / media / URL attached to a habit, memo or diary entry","Report 18: ~25 reviews across KR and JP asked to attach a photo, media or link to a habit, memo or diary entry.")
add("C209","dont","No sign-up wall before first use","Report 18: 'sign-up / login required or broken' was a very strong signal (70, 3.42%, mean 3.13★); a sign-up wall before any trial was a ranked purchase barrier, and Japan's form demanded e-mail, phone and real name before the product was visible. Distinct from having an account system: the account should be offered when there is something to protect.")

ext("C001", " Report 18: five years of moving existing capability behind Pro — highlighter (May 2023), to-do list (Nov 2023), trackers and statistics (2024–25), free routines 15→8 and short memos →5/week (Dec 2023–Jan 2024), earned friend-invite routines revoked — each produced a rating trough, and dozens of reviewers in three languages stated the rule themselves: 'take back what you gave and people resent it… it may work short-term but long-term I doubt it.'")
ext("C002", " Report 18: the KR listing showed 4.8★ from ~25,000 ratings against a written mean of 3.824 (gap 0.98); praise for the product and condemnation of the paywall were frequently the same reviews, and more than a third of 1★ reviews (122/332) were about money rather than features.")
ext("C003", " Report 18: 34 lifetime buyers averaged 4.12★ against 3.53 for all payers; nine reviewers rejected the subscription outright and asked for a one-time purchase; the report's recommendation is to keep the lifetime tier and protect its entitlement absolutely.")
ext("C020", " Report 18: export was asked for from the app's fifth month to its last, named as a purchase condition twice ('add export and I'll subscribe for life'), and is the honest answer to five years of unresolved data-loss reports — it lets users protect themselves.")
ext("C023", " Report 18: 'let me check off without launching the app' was the single most-repeated widget request across five years and every language; some builds fixed it (Jul 2025) and then it regressed.")
ext("C033", " Report 18: 25 entitlement failures (mean 2.44★; 9.94% of confirmed payers; every Japanese instance 1★) — lifetime buyers denied Pro, a PayPay lifetime never applied, a subscription active in iOS settings with premium unusable, and a lifetime holder whose entitlement was deleted when they cancelled an accidental annual plan. The worst case: a power cut reset a lifetime buyer to onboarding, wiped every routine, then demanded a subscription.")
ext("C036", " Report 18: support silence (32, mean 2.72★) landed hardest on payers — a week of silence on a lifetime account with purchase screenshots; the Japanese in-app feedback form rejected every valid e-mail and its text was invisible in dark mode, so Japanese users could only file bugs through the App Store; KakaoTalk was the only Korean channel and closed at weekends; a Canadian found the in-app support link resolved to an ad.")
ext("C034", " Report 18: data loss sat between 6% and 8% in every era after the first, five years running — the single most durable defect in a 2,048-review corpus — and hit 12.42% of confirmed payers; 'if I'd known records could all disappear I wouldn't have paid.'")
ext("C040", " Report 18: the widget went from the top request (31 reviews at 4.77★ before launch) to the top defect surface (214 mentions, 10.45%) — blank, missing from the picker, wrong weekday, false 'all done', check-off opening the app, routine widget rendering to-dos.")
ext("C042", " Report 18: ADHD/ASD/depression/burnout reviewers were the highest-rated audience (36 at 4.53★; 5.95% of US reviews) and the developer put 'ADHD' in the Korean store title — but the same population is most damaged by streak mechanics and excluded by a 9-to-5 onboarding; the positioning ran ahead of the product.")
ext("C059", " Report 18: the developer shipped what users asked for — widget, Watch, dark mode, bundles, timer, routine modes — roughly 18–36 months after the request, often breaking something else in the same release; six reviewers raised their rating after a developer reply, and one returning churned subscriber wrote '神✨'.")
ext("C065", " Report 18: 161 confirmed payers rated 0.30 below the corpus with 21.7% at 1★; their rates of entitlement failure (9.94% vs 1.22%), data loss (12.42% vs 6.01%) and billing dispute (14.29% vs 7.03%) were roughly double the global rates, and by the last era 4.36% of all reviews came from someone who had paid and could not use what they bought.")
ext("C075", " Report 18: a five-year vocabulary muddle (습관 vs 루틴 vs 모드) and an onboarding that re-ran on existing and paying accounts with no skip button — a restore-purchase loop returned users to the questionnaire.")
ext("C093", " Report 18: a persistent bottom promo bar and a Dynamic Island discount countdown in 2025–26 were experienced as worse than the 2022 interstitial ads ('Absolutely the worst choice'); upgrade-nag was among the lowest-rated themes (40, mean 2.40★).")
ext("C109", " Report 18: trials that converted immediately ('in my case there was no free period'; asked for monthly, charged annual; frozen since minute 10, charged a full year) in KR, JP, TW, ID, BR and DE; trial length shrank from 3 weeks to 7 days to 2–3-day variants.")
ext("C113", " Report 18: four to five concurrently live annual prices per storefront produced 'I paid, then it showed me a cheaper price' — charged ₩33,000 and ₩25,000 both, '40% off' banners not honoured, ¥2,900 checkout billed ¥4,150 — and fraud accusations in six languages; Taiwan (2.60★) was almost entirely this; a Dutch user watched the displayed price move 'from over 200 to 68 to 19.90'.")
ext("C120", " Report 18: a per-bundle routine timer (46 reviews, 4.37★) converted — one user set every routine to one minute purely to defeat activation energy 'and then I actually started???'; Japan and the US rated it high-priority and asked for it on the Watch and in the widget, and Japanese users uniquely asked for auto-advancing timers.")
ext("C127", " Report 18: 'A pro member should be a pro member regardless of whether they are paying monthly or yearly' — monthly subscribers nagged daily to go annual, and a 'buy the next term' screen that blocked the app entirely.")
ext("C133", " Report 18: users who paid said the paid tier 'adds nothing, it only removes limits' — 'not so much an amazing paid service as being forced to pay because the basics were cut'; the corpus's own purchase-condition backlog (export, trend statistics, routine modes, timer with time tracking, Watch parity, themes, web/Mac) is entirely additive capability.")
ext("C147", " Report 18: the reviews that converted best came from people who used the app free for a week or a month first; the reviews that generated refund demands came from people charged before they could evaluate.")
ext("C155", " Report 18: the Sept 2024 split of the interleaved routine + to-do list into two tabs drew 32 protests at mean 4.25★ — the paying base — including subscribers who had bought a year because of the merged view days earlier; the weekly view and the Challenge feature were removed in the same release; nobody had asked for the split. Recommendation: restore it as a toggle, since a minority came to prefer the split.")
ext("C157", " Report 18: an automatic streak 'shield' made the streak number feel fake ('I get complacent since the number won't disappear'), while an ADHD reviewer said a broken streak is the feature that makes them quit and asked to hide the UI; another sat in red all day because the routine could only be finished at night. Conclusion: streak, shield, light and cheer messages are per-user toggles, default shield off.")
ext("C170", " Report 18: a configurable day-end time was requested ~15 times across KR, JP and US, and the timezone stayed on Korean time for diaspora users from 2021 to 2024 (US daylight saving unhandled).")
ext("C175", " Report 18: a July 2026 update told a mid-term subscriber to buy a new plan; lag, solved by 2025, regressed sharply (1.83% → 5.38%) as routine modes, intensity levels and note/tracker features were added.")
ext("C027", " Report 18: Japanese Instagram ads led to an app that opened in Korean with a KakaoTalk login; Korean push notifications persisted a year after the UI was fixed, the terms page stayed English-only (one reviewer refused to trial for that reason), Traditional Chinese was largely Simplified wording, and a Dutch translation was unintelligible.")
ext("C050", " Report 18: routines and one-off to-dos interleaved in one time-ordered list was a named purchase trigger and 'MyRoutine's one advantage' over to-do apps; to-do parity (carry-over, subtasks, tags, priority, undated, recurring) was requested ~30 times.")
ext("C082", " Report 18: an interstitial ad on every check-off (Oct 2022) drew 17+ protests in weeks and was softened by December; the surviving minimal ads were tolerated.")

M = {
 "R18-003":["C002"], "R18-004":["C200","C008","C147"], "R18-005":["C200","C007"], "R18-006":["C113","C029","C180"], "R18-007":["C109","C029"],
 "R18-008":["C033","C065"], "R18-009":["C033","C034","C036"], "R18-010":["C001","C155","C104"], "R18-011":["C141","C155"], "R18-012":["C082","C093"],
 "R18-013":["C044","C155"], "R18-014":["C001"], "R18-015":["C001"], "R18-016":["C001","C007","C089"], "R18-017":["C001","C104"], "R18-018":["C001","C133"],
 "R18-019":["C155","C050"], "R18-020":["C050","C155"], "R18-021":["C012","C155"], "R18-022":["C155","C101"], "R18-023":["C203","C075","C111"],
 "R18-024":["C203","C170"], "R18-025":["C203"], "R18-026":["C201","C134"], "R18-027":["C201","C095"], "R18-028":["C201","C016","C095"], "R18-029":["C120"],
 "R18-030":["C202"], "R18-031":["C042","C183"], "R18-032":["C157","C024"], "R18-033":["C157","C042"], "R18-034":["C201","C024"], "R18-035":["C157"],
 "R18-036":["C065","C034","C033","C030"], "R18-039":["C076"], "R18-041":["C002"], "R18-043":["C044"], "R18-044":["C022"], "R18-045":["C023","C110"],
 "R18-046":["C206"], "R18-047":["C120","C173"], "R18-048":["C109","C003"], "R18-049":["C007","C200"], "R18-050":["C064"], "R18-051":["C093","C180","C082"],
 "R18-052":["C110","C204"], "R18-054":["C207","C006","C142"], "R18-055":["C073","C010"], "R18-056":["C034"], "R18-057":["C031"], "R18-058":["C083"],
 "R18-059":["C209","C035"], "R18-060":["C064"], "R18-061":["C030","C013"], "R18-062":["C093","C082"], "R18-063":["C036"], "R18-064":["C039"], "R18-065":["C027","C038"],
 "R18-067":["C006"], "R18-068":["C201"], "R18-069":["C022"], "R18-070":["C201"], "R18-072":["C002"], "R18-074":["C011"], "R18-075":["C080"], "R18-076":["C206","C170"],
 "R18-077":["C205","C172"], "R18-078":["C020"], "R18-079":["C208"], "R18-080":["C050","C173"], "R18-081":["C170","C038"], "R18-082":["C023","C040","C107"],
 "R18-083":["C044"], "R18-084":["C207"], "R18-085":["C005"], "R18-086":["C002","C094"], "R18-087":["C073","C011"], "R18-088":["C065","C133"], "R18-089":["C002"],
 "R18-090":["C002","C147"], "R18-091":["C040","C065"], "R18-092":["C065"], "R18-093":["C003"], "R18-094":["C137","C007"], "R18-095":["C155","C120","C206"],
 "R18-096":["C147","C061"], "R18-097":["C058"], "R18-098":["C061"], "R18-099":["C147","C064","C003"], "R18-100":["C003"], "R18-101":["C065","C078"],
 "R18-102":["C025","C037","C103"], "R18-103":["C209"], "R18-104":["C034","C059"], "R18-105":["C155","C186"], "R18-106":["C133"], "R18-107":["C127","C093"],
 "R18-108":["C036","C027"], "R18-109":["C133","C020","C011","C022"], "R18-110":["C199"], "R18-111":["C038"], "R18-112":["C201","C095","C120","C202"],
 "R18-113":["C042"], "R18-115":["C026","C036"], "R18-116":["C027","C033","C036","C132"], "R18-117":["C120"], "R18-118":["C042","C038","C031"], "R18-119":["C038"],
 "R18-120":["C062"], "R18-121":["C113","C112","C027"], "R18-122":["C200"], "R18-124":["C203","C209","C113"], "R18-125":["C113"], "R18-126":["C036"], "R18-127":["C042"],
 "R18-129":["C001","C065","C033"], "R18-130":["C034","C083","C031"], "R18-131":["C040","C023"], "R18-132":["C042"], "R18-133":["C034","C020","C038","C073"],
 "R18-134":["C075"], "R18-135":["C071"], "R18-136":["C059","C175"], "R18-137":["C206","C059"], "R18-138":["C200","C008"], "R18-139":["C113","C112"],
 "R18-140":["C033","C139"], "R18-141":["C075","C203"], "R18-142":["C036","C112","C027"], "R18-143":["C204","C110"], "R18-144":["C133","C001"], "R18-145":["C147","C181","C192"],
 "R18-146":["C037","C025"], "R18-147":["C127","C093"], "R18-148":["C003","C033"], "R18-149":["C050","C155"], "R18-150":["C073","C010"], "R18-151":["C011"],
 "R18-152":["C020","C176"], "R18-153":["C205"], "R18-154":["C157"], "R18-155":["C206","C078"], "R18-156":["C022","C023","C120"], "R18-157":["C207","C006"],
 "R18-158":["C203"], "R18-159":["C203","C206","C170"], "R18-160":["C042","C157","C207"],
}
# unattached (nuance register): 001-002 header/method, 037-038 method, 040 composition, 042 inventory, 053 theme table, 066 positive table,
# 071 request table, 073 request table, 114 storefront table, 123 volume note, 128 era table, 161 research questions
cards = [json.loads(l) for l in open("Tools/prd_ledger/18/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/18/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
from collections import Counter
print("points by report count:", sorted(Counter(len(x["reports"]) for x in C.values() if not x.get("merged_into")).items()))
