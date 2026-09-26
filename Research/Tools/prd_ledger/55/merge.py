"""Stage 3 merge for report 55."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C274", "dont", "A close or dismiss control must never start a purchase — no fake X, no dismissal that lands on the payment sheet",
    "Report 55 (Habit-Bull): a full-screen premium pop-up shown on every launch from 5 July 2020 had a close control that started a purchase — 'I clicked on the x at the top, but instead of giving me the data screen, it acted like I'd tried to make a purchase' (us, 4★); 'The pop up has a fake X in the top corner to close the message, which if you press, causes your account to agree to the premium subscription' (gb, 1★); 'after mistakenly upgrading' (2024). PAY_FORCED 20 (0.99%, mean 1.25, 18 at 1★, all 10 Jul 2020 → 3 Jan 2021) plus PAY_NAG 44 (2.02); in July 2020 35 of 68 reviews (51.5%) carried one or both, the month's mean was 2.09 with 39 one-stars and 11 reviews on 12 July alone; the German-speaking storefronts took it hardest (PAY_NAG 10.7%). The report's F2: make close controls unambiguous so no dismissal can start a purchase — 'the cheapest change with the clearest rating effect in the data'. Related: [[C093]] (no upsell nagging), [[C145]] (every modal dismissible), [[C180]] (no exit discounts or countdowns), [[C269]] (hijacking ad mechanics).")

ext("C001", " Report 55: 'The makers take the free user seriously too' (2018) described the product the July 2020 every-launch pop-up replaced.")
ext("C002", " Report 55: praised for a decade as a simple, flexible tracker while the written mean fell 4.71 (2015–16) → 3.25 (2020) on crash waves, a paid sync that failed, a 2018 subscription switch and a 2020 pop-up — the complaints are not about the core.")
ext("C003", " Report 55: 'Premium worth it' was said while premium was one-time (22 of 27 PAY_WORTH predate June 2018) and vanished after; reviewers repeatedly name $5–$10 one-time as what they would pay ('Would I pay a one-time fee of $5, absolutely, but a yearly fee, nope!'); M1: a lifetime option beside the subscription.")
ext("C004", " Report 55: a $3.99–$4.99 one-time premium ('I got Premium, was worth $4') became ~$19.99/yr in June 2018 — 'about 400% increase in price'; 40 of 42 price complaints date from the switch.")
ext("C005", " Report 55: switchers from Strides, Way of Life, Productive, coach.me, Streaks, Todoist, Habit List and paper (USER_SWITCH 194, 4.68) accept its dated looks for its function ('I'll take function over form any day').")
ext("C006", " Report 55: DES_CLEAN 475 (23.47%, 4.89) is the largest theme in every era and every eligible storefront.")
ext("C007", " Report 55: a five-habit free tier praised more often than resented (PAY_FREE_OK 96 at 4.86 vs PAY_CAP 87 at 3.98, 44 of them 5★) and contrasted favourably with 3-habit competitors ('some apps make the free version so debilitating you have no choice but to delete or buy. But this app has a great free version'); more than five habits is the leading reason among satisfied payers; M2: keep it, never shrink it.")
ext("C010", " Report 55: log earlier days including before install — part of the praised tracking model.")
ext("C013", " Report 55: cross-device sync was the headline paid feature and the most often named purchase reason (19 of 165 payers), mostly in 1–2★ because it failed ('If you are about to buy it for the sync option. I suggest you keep your money'; 'Paid £17.49 to sync phone/iPad/watch and it doesn't work'); SYNC_BUG 62 (1.90) with a 7.12× payer lift and 'servers are dead' by 2019.")
ext("C014", " Report 55: early iOS builds allowed one reminder per day while Android allowed several.")
ext("C016", " Report 55: a sick / skip day that keeps the streak (CORE_SKIP 5).")
ext("C017", " Report 55: passcode lock exists; Touch ID requested (LOCK 6), including in Germany.")
ext("C019", " Report 55: quit-habit use for smoking, alcohol, nail-biting and NoFap (USE_QUIT 46, 4.83) via 'not more than' goals — 'a nail biter for 26 years but getting to tap yes! everyday is exactly what I needed to finally stop'.")
ext("C020", " Report 55: CSV / Excel export is paid and bought for; 5 of 15 export reviews report failures.")
ext("C022", " Report 55: no Watch app (PLATFORM_WANT 24).")
ext("C023", " Report 55: widget or notification check-off requested (WIDGET_WANT 16).")
ext("C024", " Report 55: 'I completed a task because I didn't want to break my streak'; 'over 10K pushups… because I don't want to disappoint the app' — motivation layer 362 (17.89%, 4.86).")
ext("C027", " Report 55: Brazil — several give 4★ 'only because' there is no Portuguese (DES_LOC 8 of 21, 7.7% of br); a Spanish localisation that was available and then removed ('Antes estaba en español y ahora no'); R6: pt-BR first, then Russian.")
ext("C029", " Report 55: 'BEEN TRYING FOR MONTHS TO CANCEL MY SUBSCRIPTION'; auto-renewal on an account the user can't log in to; charged after a trial (PAY_CHARGE 7).")
ext("C030", " Report 55: partial, silent or 'only half' sync, a buried manual sync button; multi-device users pay for sync, open the iPad and see partial or no data — 'habitbull is a one device app only. And i have paid for pro. Unacceptable'.")
ext("C031", " Report 55: four crash waves each tied to an update and concentrated in one storefront — Jul 2017 (all 12 UK), Jan 2018 purchase and registration (US), Nov 2018 iOS 12 (23 of 24 Brazil), Oct 2020 – Feb 2021 (26 of 30 UK) — BUG_CRASH 197 (9.73%, 2.04, 107 at 1★); the written-vs-public gap tracks incident exposure (gb 1.07★, br 1.18★ vs ca 0.30★, au 0.14★).")
ext("C033", " Report 55: premium gone after a new phone or reinstall (PAY_RESTORE 18, 1.11, lift 10.22) because premium was tied to an e-mail account; F1: restore-purchase tied to Apple ID.")
ext("C034", " Report 55: 'now I lost my account including years worth of data' (BUG_DATA 35, mean 1.31); 'I'm a premium user and have already lost all my data twice' (br); reinstalling to escape a crash often wiped data.")
ext("C035", " Report 55: an optional account (e-mail, Facebook; later Apple, Google) whose January 2018 registration spinner, 'email invalid' and reset e-mails that never arrive (ACCT_BUG 57, 1.68; US 34 of 57) broke premium; F6: registration optional and robust, never block first use.")
ext("C036", " Report 55: support silence from Jan 2016 to Apr 2026 (SUP_BAD 83, 1.45, 66 at 1★; payer lift 6.21) — a developer site returning errors, a contact form that won't send, ticket numbers with no reply, canned answers; 'will update my review based upon their response'.")
ext("C038", " Report 55: 'not more than' goals saved as 'at least' — inverting success for quit-smoking and drinking goals ('Smoke not more than 10 cigarettes… they actually show as requiring you to do the task at least that many times'); streaks reset at the year change in 2018 and 2020; editing a frequency rewrites history; a traveller's completions shift days; a July 2020 update marked taps on the wrong day.")
ext("C039", " Report 55: medication reminders that fail; push instead of sound-only in silent mode.")
ext("C043", " Report 55: 'You set your own standards (every day, certain days a week, or a number of days in a week/month)… it doesn't disqualify you if you don't do each habit every single day' (CORE_FLEX 148, 4.82 — the named differentiator); gaps: weekly totals, monthly periods, custom week start, optional end dates.")
ext("C044", " Report 55: no Mac or web app (PLATFORM_WANT 24).")
ext("C048", " Report 55: numeric habits with 'at least', 'exactly' or 'not more than' success rules alongside yes/no — 'counting habits like 8 glasses of water a day'.")
ext("C058", " Report 55: a Reddit launch post with the developer answering in the thread produced 21 reviews on day two (4.71 for 2015), and BuzzFeed plus a TV review produced 105 in January 2016 (4.77); a Korean rapper's recommendation in 2019–20; therapists and a clinical psychologist recommend it to clients.")
ext("C059", " Report 55: a reviewer raised their rating when version 1.4.11 fixed the crash, after 'nearly nine months of complaints'.")
ext("C064", " Report 55: reviewers name $5–$10 one-time or a $2.99 download as acceptable against ~$19.99/yr (text sub-cut).")
ext("C065", " Report 55: payers are the unhappiest group — PAY_BOUGHT 165 at 2.56, 96 (58.2%) at 1–2★, paid mean 4.24 → 2.78 → 1.91 → 1.41 across eras; 41.8% of payers report a data & account continuity failure, 25.5% support silence, 21.8% sync failure; the continuity chain — crash or new phone → reinstall → login fails → data and premium gone → e-mail support → no reply → refund request and 1★; 'Two online reviews that premium customers had posted convinced me not to'.")
ext("C071", " Report 55: 'No updates have been issued in over half a year and the developers are no longer answering emails' (2016); no iPhone X layout from Nov 2017 to Dec 2020 (BUG_COMPAT 53); 'The last update was 9 months ago, this is unacceptable for a subscription based product' (2025).")
ext("C073", " Report 55: in 2026 habits cannot be deleted or deactivated.")
ext("C077", " Report 55: the purchase button crashed in January 2018 — 'I want to give you money! I want more habits! But you're app crashes whenever I try to upgrade' (PAY_IAP_FAIL 14, 10 that month).")
ext("C080", " Report 55: dark mode shipped mid-2020 with 'black writing on the black background' (BUG_DARK 10, 1.90).")
ext("C085", " Report 55: premium required an e-mail account or the purchase was lost; cloud storage of goal data questioned; 'no login needed' praised.")
ext("C093", " Report 55: a full-screen premium pop-up on every launch from July 2020 (PAY_NAG 44, 2.02; still reported Dec 2024) — 'Just ask once and don't make it pop up every time I launch the free app and it gets 5'; M5: one upsell, frequency-capped. See [[C274]].")
ext("C094", " Report 55: 'You have asked me 4 time within 1 minute to rate your app'; a lock screen and rating dialog that trapped a user (META_PROMPT 9, 2.44); R8: throttle the prompt.")
ext("C095", " Report 55: quirky reminder messages liked by most ('I loved being called a tiger') but pet names drove churn ('Deleted when the reminder called me cutie'); R5: offer a neutral message tone.")
ext("C104", " Report 55: the June 2018 switch from a $4.99 one-time unlock to $19/yr shipped with a release note that said only 'Changes'.")
ext("C109", " Report 55: charged after a trial; a trial that can't be cancelled (PAY_TRIAL 8, 2.12).")
ext("C112", " Report 55: M4 — disclose cap, trial length, annual price and how to cancel inside the app.")
ext("C123", " Report 55: reminders only for undone habits, several per habit (R4).")
ext("C131", " Report 55: a per-habit forum is a support network for most (COMM_GOOD 31, 4.90) but clutter, a one-topic feed and anonymous shaming for some (COMM_NEG 8); R7: topic filters and blocking of shaming replies.")
ext("C137", " Report 55: M2 — show the upsell at the moment a sixth habit is added, not on every launch.")
ext("C141", " Report 55: iPad runs the stretched phone app (IPAD 30).")
ext("C143", " Report 55: the same habit several times a day (CORE_MULTI 5).")
ext("C145", " Report 55: see [[C274]] — a pop-up whose X started a purchase.")
ext("C156", " Report 55: F4 — test every build against current and previous iOS versions and screen sizes; staged rollout; halt on a crash spike (no month with >10 crash reviews).")
ext("C175", " Report 55: crash waves after the July 2017, 2018 and 2020 updates; fixes reported twice, the second after nine months.")
ext("C184", " Report 55: a launch-screen photo of a woman hiker (DES_SPLASH 20, 2016–2022) — 'I purchased premium. I am uninstalling due to lack of dev response to the main photo of the girl'; an issue in a NoFap context; some ask only to turn it off.")
ext("C186", " Report 55: 'I specifically paid for the app because it was a one-off rather than subscription, so I actually feel I should now get my money back'; 'they offered life time… the people who bought the lifetime pass are no more able to use it' (PAY_REGRESS 9, 1.33, lift 12.27).")
ext("C196", " Report 55: 'It's not like a yoga or meditation app, which is constantly adding new videos/content, so why a yearly fee?!?' — an annual fee reads as a promise of ongoing development, and reviewers measured the app by its update log; M3: price the subscription only on features that work.")
ext("C209", " Report 55: a registration screen first; F6 — never block first use.")
ext("C212", " Report 55: refund requests 19 (1.11), 17 from payers, 9 from the UK.")
ext("C226", " Report 55: a badge countdown of outstanding habits motivates some and can't be removed for others.")
ext("C251", " Report 55: the Android version is described as more capable and reliable (reminders with sound control, one-tap sync, fewer crashes) — 'I recently switched my Android for an iPhone and unfortunately it doesn't work well' (USER_ANDROID 16, 2.81).")
ext("C078", " Report 55: sync and export — the server-dependent parts of the premium bundle — are the two paid features reviewers most often report broken, while 'more habits' costs nothing to deliver.")

M = {
 "R55-005":["C058"], "R55-006":["C094"], "R55-008":["C065","C033","C036","C030"], "R55-009":["C013","C078","C030"], "R55-011":["C186","C004","C003"],
 "R55-012":["C186"], "R55-013":["C274","C093","C145"], "R55-014":["C031","C175"], "R55-015":["C036","C071"], "R55-016":["C006","C043","C048","C002"], "R55-017":["C007","C001"],
 "R55-018":["C141","C022","C044","C023"], "R55-019":["C184","C095"], "R55-020":["C065","C274","C093","C186","C003","C007","C031","C036"],
 "R55-022":["C048","C019"], "R55-023":["C043"], "R55-024":["C131","C202"], "R55-027":["C082","C127"], "R55-028":["C020"], "R55-029":["C196","C078"],
 "R55-030":["C005"], "R55-031":["C058","C042"], "R55-035":["C029","C033"], "R55-036":["C031","C034"], "R55-037":["C030","C035","C034","C033"],
 "R55-038":["C036"], "R55-040":["C071"], "R55-041":["C077"], "R55-042":["C038","C073"], "R55-043":["C119"], "R55-044":["C080"], "R55-045":["C085","C035"],
 "R55-046":["C006"], "R55-047":["C024","C095"], "R55-048":["C043","C048","C010"], "R55-049":["C019"], "R55-050":["C007"], "R55-051":["C226"], "R55-052":["C003"],
 "R55-054":["C131"], "R55-055":["C226"], "R55-057":["C023","C252"], "R55-058":["C016"], "R55-059":["C052","C101"], "R55-060":["C017","C171"], "R55-061":["C027"],
 "R55-063":["C014","C123","C039"], "R55-064":["C030","C141"], "R55-065":["C251"], "R55-066":["C019","C042","C038"], "R55-067":["C184"], "R55-068":["C038"],
 "R55-077":["C065"], "R55-083":["C007","C013"], "R55-084":["C007"], "R55-085":["C078","C013"], "R55-086":["C274"], "R55-088":["C064","C003"], "R55-089":["C065"],
 "R55-090":["C065","C033"], "R55-091":["C186"], "R55-092":["C212","C029","C109","C112"], "R55-093":["C059","C093","C186"],
 "R55-097":["C031","C212"], "R55-099":["C031","C027"], "R55-100":["C027"], "R55-101":["C274","C093"], "R55-103":["C031"], "R55-104":["C027","C155"],
 "R55-111":["C031","C175","C274","C104"], "R55-112":["C104"], "R55-113":["C038"], "R55-115":["C003","C036","C071"],
 "R55-116":["C030","C033","C035"], "R55-117":["C274","C093"], "R55-118":["C038"], "R55-119":["C156","C175"], "R55-120":["C036","C104"], "R55-121":["C035","C209"],
 "R55-122":["C080","C175"], "R55-124":["C003","C186"], "R55-125":["C137"], "R55-126":["C078","C196"], "R55-127":["C112","C177"], "R55-129":["C043","C016","C143"],
 "R55-130":["C023","C022","C141","C044"], "R55-131":["C184","C095"], "R55-132":["C131"], "R55-135":["C007"],
}
cards = [json.loads(l) for l in open("Tools/prd_ledger/55/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/55/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; {len(null)} unattached")
print("unbacked:", [x["id"] for x in C.values() if "Report 55" in x["statement"] and not any(k.startswith("R55-") for k in x["cards"])])
