"""Stage 3 merge for report 53."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C272", "must-never-break", "Built-in timers survive backgrounding, a call and screen lock, and always alert at the end — store the start time, compute elapsed",
    "Report 53 (HabitMinder): CORE_TIMER 52 (2.98%, meaningful, mean 3.54) — praised as unique, yet 13 of 52 describe progress lost when the app is backgrounded, paused or the screen locks and 9 more say the timer ends without an alert: 'after 90 mins you had a call and after the conference call you come back and found that the counter is no longer running and now you've only read 0 minutes' (my, 2★, 2019); a years-long user left because the screen now powers off during a 30-minute meditation (ca, 1★, Nov 2023); a meditation timer that 'runs for 11mn and then logs in 22mn46s'. Report's R4: store the start time and compute elapsed, and always alert at the end via a local notification and Watch haptic. Related: [[C066]] (focus timer), [[C120]] (routine timer), [[C072]] (timed habits written to Health).")

ext("C001", " Report 53: once over the 3-habit free limit, editing an existing habit's settings hits the paywall.")
ext("C002", " Report 53: a 4.6-public app whose written mean fell from 3.90 (2017–19) to 2.55–2.71 (2023–26) as monetisation friction rose 14.8% → 40.1% → 45.0% of reviews; billing & trust failures (133) average 1.81.")
ext("C003", " Report 53: 'because unlike many apps you don't need a subscription, you just pay once' (de, 19 votes); PAY_ONETIME lift 3.40 among payers and none after Jul 2023 once only an annual plan was offered; report's M2 — offer lifetime again beside the annual plan.")
ext("C004", " Report 53: payers who talk about price mostly call it fair (PAY_PRICE_OK 47 at 4.79, payer lift 3.95; 'RAISE YOUR PRICES… I would genuinely pay more'), then the praise vanished (2 reviews from 2023) when an annual $39.99 plan replaced a ~$8–20 one-time unlock.")
ext("C006", " Report 53: simplicity is the largest substantive theme (DES_CLEAN 181, 10.38%, 4.66 — 'FINALLY a habit app thats not overpriced or over complicated!', 24 votes); a 21-vote cn reviewer asks the developer not to add a calendar.")
ext("C007", " Report 53: a 3-habit free cap (PAY_CAP3 89, 5.11%, 3.04) splits reviewers — 35 at 4–5★ find three enough to try or live with, 33 at 1–2★ call it a trick; top theme in Canada (11.94%); the report's M3 asks for a retention test of 5 habits rather than assuming bigger is better.")
ext("C011", " Report 53: extended statistics are a named purchase reason ('bought premium with extended statistics', ru) and the paid feature that broke.")
ext("C016", " Report 53: the most-upvoted review in the corpus (274 votes) asks for archive / pause — 'to keep my page organized I have to delete some habits, which means losing all the records'; skips that don't count as failures (CORE_SKIP 20, 4.20).")
ext("C019", " Report 53: limits and zero goals — 'no more than 3 coffees', count-down counters (CORE_BAD 21, 3.76).")
ext("C021", " Report 53: Apple Health integration is what reviewers could not find elsewhere (HK_GOOD 40 — the Watch Breathe app 'automatically marks that as complete'; calories logged from the wrist) and they ask for more sources — sleep, running, calories, blood pressure, Fitbit, Garmin, Strava (HK_WANT 31).")
ext("C022", " Report 53: Watch complications configurable 'almost like watch faces themselves' are a purchase trigger (WATCH_GOOD 43, 4.70) while WATCH_BUG 62 (2.85) — duplicate water entries, sync, the Watch app crashing on launch in 2025–26; F6: re-certify the Watch app on every iOS release.")
ext("C023", " Report 53: check off from the widget, hide completed, more habits per widget (WIDGET_WANT 18).")
ext("C027", " Report 53: machine-translated or mixed-language UI in ru, br, it, se, kr and jp (DES_LOC 19 — 'you need to study more Japanese'; lock-screen reminders alternating Chinese and English).")
ext("C029", " Report 53: unexpected charges PAY_CHARGE 34 (mean 1.38, 85.3% 1★); a one-week trial billed for a year (kr); an accidental purchase on first open.")
ext("C031", " Report 53: crash waves at launch (Nov 2017, fixed within days), on iOS 11.3 and iOS 13, an app that quit on open for several days (Mar 2022), and the 2024–26 statistics-view crash (BUG_CRASH 133, 7.63%, 2.82).")
ext("C033", " Report 53: PAY_RESTORE carries the highest payer lift (6.32); a lifetime buyer about to post a bait-and-switch review tapped Restore Purchase and 'the app went back to normal and no more pop ups' — so part of the 2026 legacy cluster is a restore failure the app could fix by restoring on launch (F2).")
ext("C036", " Report 53: support went from praised to silent — SUP_GOOD 31 (4.71) all Nov 2017 → Mar 2022 (a proactive follow-up, an icon idea shipped in days, VoiceOver added on request) and SUP_BAD 64 (1.58), 41 in 2023–26; the in-app contact needed a configured Mail account and later 'the support email it opens does not send'; payers with silent support average 1.17; F4: a contact that works without Mail, an auto-acknowledgement and a known-issues note.")
ext("C037", " Report 53: the listing claimed Family Sharing that the in-app purchases did not support (PAY_FAMILY 8; refund requests in kr).")
ext("C039", " Report 53: in an app named HabitMinder reminders are tied to a time-of-day section, not a clock time — an evening habit reminds at 8 am ('the only reminder that can be set is for 8am'), a 30-reminder list hits iOS's scheduled-notification cap so some habits are never reminded, and reminders fire for habits already done (REM_CONTROL 56, 2.88; REM_ANNOY 28; REM_FAIL 13).")
ext("C040", " Report 53: widgets blank on tinted home screens and no longer interactive on iOS 18/26 (WIDGET_BUG 5.1% of 2025, 7.5% of 2026).")
ext("C042", " Report 53: medication, stroke, bariatric care, alcohol recovery and brain-injury users ('I haven't missed a dose since I started using this app') — a small set of older, disabled or recovering users most exposed to confusing billing.")
ext("C043", " Report 53: '3 times a week, any day', every other day, a day of the month (CORE_FREQ 54, 3.76); a 3×/week habit fails Monday and Tuesday and support's Skip 'skips that task for the week'; '2 times weekly' must be done twice in one day.")
ext("C045", " Report 53: 'so close to perfect… ability to group activities' (4★).")
ext("C047", " Report 53: totals and trends in units, not only completion % — 'a total of 1000 push ups'; a 7-hour sleep against an 8-hour goal shows 0% (R6).")
ext("C048", " Report 53: US units only for water, weight and distance ('Stuck with Dopey American units'; 'In Europe we have no idea what a US Fl Oz is!'; notifications in ounces with litres selected — DES_UNITS 47, 20 storefronts); log beyond the goal (CORE_OVER 10).")
ext("C059", " Report 53: VoiceOver unlabeled buttons reported Dec 2021 and a fix confirmed Mar 2022; an icon suggestion implemented within days.")
ext("C060", " Report 53: WaterMinder buyers arrive happy, but 2023–25 reviewers link the developer to the 'Done' app's degraded lifetime upgrades and call the whole portfolio a scam — 'I will be regretfully avoiding this developer because their pricing policies'.")
ext("C064", " Report 53: one-time $4.99 → $7.99 → $12–13 → $19.99 (2017–22), then annual only $39.99 / over €40 / AU$99.99; price is Germany's top theme (18.00%, 'why €14?').")
ext("C065", " Report 53: payers went from 143 at 3.44 (2017–22) to 54 at 2.15 (2023–26); paid and reliability failure 82 at 2.46, statistics broken 24 at 2.25, entitlement withdrawn 10 at 1.50.")
ext("C071", " Report 53: positives vanished before negatives peaked — SUP_GOOD none after Mar 2022, REM_GOOD none after May 2024, WATCH_GOOD 4.3% (2022) → 0% (2026) — while iOS releases broke widgets, Watch app and statistics for a year ('No update to fix issues on iOS 18 for about a year').")
ext("C072", " Report 53: reading, meditation and relaxation timers written to Apple Health as exercise minutes or active calories ('One hour of reading in HabitMinder gave me 60 active minutes'); stand counted while asleep; doubled Health statistics (HK_WRITE 8, HK_BUG 61); F7: stop, or make write-back explicit per habit.")
ext("C078", " Report 53: statistics — a main reason to pay — crashed for paying users from Sep 2024 (STAT_CRASH 28 of 33 since then, 21.7% of all E4 reviews; payer lift 2.95; the 7-day trend view named by 14); a reviewer reset two years of data trying to fix it; F3 'the feature people pay for'.")
ext("C083", " Report 53: slowdown with many habits (24-vote jp review); the statistics crash tested against long histories and 20 habits.")
ext("C085", " Report 53: reviewers who read the privacy policy object to Facebook pixel and Firebase SDKs in a health-adjacent app; unexplained Apple ID prompts on launch (PRIV 7, 1.86); R8: publish and minimise third-party analytics.")
ext("C089", " Report 53: a splash screen offering ~90% off the annual plan while the App Store sheet shows the full price, in more than ten currencies ($7.99 → $79.99; €6.99 → €69.99; ¥900 → ¥9,000; 199 → 1,999 TRY) — PAY_PROMO 35 (mean 1.83), Jan 2023 → Feb 2026, 13 with no support reply and 9 asking for refunds; some reviewers did get it, suggesting eligibility rules; the most concentrated trust-destroying pattern in the corpus; F1: show the exact first charge and renewal on the offer screen and never show an offer the viewer can't redeem.")
ext("C093", " Report 53: a 'new year, new me' premium pop-up with a countdown that 'never ends, it just starts over', shown every app open from 2023 (PAY_NAG 42, mean 1.93, 39 of 42 from 2023) — reviewers call the app's own offers 'ads'; M1: once a week at most, never to payers, no resetting countdown.")
ext("C094", " Report 53: one jp reviewer nagged to review every time they open the app to log.")
ext("C095", " Report 53: reminders phrased as questions — 'instead of stating what I'm supposed to do NOW, it asks questions — Have you walked today?' (REM_GOOD 67, 4.85).")
ext("C109", " Report 53: 7-day trials that several reviewers say billed a full year; M4: charge date and amount on the trial screen and a reminder 24 hours before conversion.")
ext("C113", " Report 53: a perpetual 'limited-time' discount offer (2023–26) reads as deception rather than a deal.")
ext("C123", " Report 53: suppress reminders once the habit or its Health goal is met ('it should know based on my steps being tracked that I've met the goal'), several clock times per habit, snooze from the notification (R1); a burst of 10–15 notifications at 8 am ('64 notifications in just a few days').")
ext("C143", " Report 53: brush teeth twice, meditate in two sessions (CORE_MULTI 12).")
ext("C147", " Report 53: 'I was asked to pay too soon, without really trying the app'; 'Let me try before upselling'.")
ext("C170", " Report 53: end the day at 1–5 am and handle time-zone travel (CORE_DAYSTART 9).")
ext("C171", " Report 53: VoiceOver compatibility shipped on request (2022) for blind users.")
ext("C175", " Report 53: re-certify Watch app and widgets on every iOS release — iOS 11.3, iOS 13 and iOS 18/26 each broke a surface.")
ext("C186", " Report 53: one-time buyers were pushed into a subscription — 'the VIP I bought outright has turned into a subscription? Charging twice is unreasonable' (cn, 2023); 'I had previously PAID to have full access… now they're forcing a yearly subscription' (ca, 2025); 10 in Feb–May 2026 under a new 'AppLife' plan ('all of a sudden I can't use the additional habits I created… without purchasing a $14.99 upgrade'); PAY_REGRESS 16, mean 1.50, payer lift 5.53.")
ext("C188", " Report 53: in mainland China the launch screen hangs for seconds to 10+ minutes from build 2.8.0 (Dec 2022) through Aug 2026 — BUG_LAUNCH 30 of cn's 273 (10.99%); 'with a network connection it won't open; it only works offline' points at a blocking network call (analytics, paywall or ad SDK slow or blocked in China); F5: test cold start with no network and with blocked endpoints.")
ext("C204", " Report 53: reviewers over the free limit hit the paywall when editing an existing habit.")
ext("C205", " Report 53: a list of all notes, and notes on the calendar (47-vote jp review).")
ext("C218", " Report 53: the listing claimed Family Sharing that in-app purchases don't support (M5: remove it).")
ext("C227", " Report 53: archive without losing history (274-vote review).")
ext("C231", " Report 53: Spanish- and Portuguese-language storefronts carry 34.1% monetisation friction against 21.3% globally; Germany's top theme is price (18.00%); Taiwan's is reliability (37.5%) with only 8.9% friction.")
ext("C252", " Report 53: 'It should be a single tap to complete one once the reminder pops up' (gb, 3★).")
ext("C264", " Report 53: swipe-to-complete and the completion sound are liked; editing habits 'are a nightmare - you have to tap in multiple times'; compared unfavourably with Productive's one-swipe check (DES_UX_NEG 38).")
ext("C077", " Report 53: an accidental purchase on first open (kr) and a crash right after paying ₩19,000.")

M = {
 "R53-010":["C094"], "R53-012":["C002","C186","C065"], "R53-013":["C093","C180"], "R53-014":["C186","C002"], "R53-015":["C089","C113","C029"],
 "R53-016":["C078","C011","C065"], "R53-017":["C036","C071"], "R53-018":["C188","C062"], "R53-019":["C021","C022"], "R53-020":["C072","C022"],
 "R53-021":["C040","C022","C175","C071"], "R53-022":["C006"], "R53-023":["C095","C039"], "R53-024":["C042"], "R53-025":["C003"], "R53-026":["C043","C039"],
 "R53-027":["C043"], "R53-028":["C039","C123"], "R53-029":["C016","C227"], "R53-030":["C272"], "R53-031":["C089","C186","C033","C078","C036","C188","C175"],
 "R53-033":["C060"], "R53-036":["C177"], "R53-037":["C218","C037"], "R53-039":["C064"], "R53-040":["C186","C033"], "R53-042":["C007"], "R53-043":["C011"],
 "R53-044":["C204","C001"], "R53-045":["C109"], "R53-046":["C093"], "R53-047":["C186","C002"], "R53-048":["C042","C103"],
 "R53-052":["C031"], "R53-054":["C064"], "R53-055":["C029"], "R53-056":["C031","C175"], "R53-057":["C078"], "R53-058":["C036"], "R53-059":["C022","C030","C072"],
 "R53-060":["C039","C123"], "R53-061":["C188"], "R53-062":["C272"], "R53-063":["C048","C027"], "R53-064":["C085"], "R53-067":["C004","C003"], "R53-068":["C059","C036"],
 "R53-069":["C009","C018"], "R53-071":["C007"], "R53-072":["C005"], "R53-073":["C065","C186"], "R53-074":["C060"], "R53-076":["C073","C223"], "R53-077":["C043"],
 "R53-078":["C047","C012","C011"], "R53-079":["C021"], "R53-080":["C030","C044","C141"], "R53-081":["C009"], "R53-082":["C019"], "R53-083":["C016","C227"],
 "R53-084":["C023"], "R53-085":["C048"], "R53-086":["C143"], "R53-087":["C205"], "R53-088":["C170"], "R53-089":["C099","C199","C066"], "R53-092":["C177"],
 "R53-093":["C264"], "R53-094":["C252"], "R53-095":["C039","C123"], "R53-096":["C039"], "R53-097":["C123"], "R53-098":["C072","C022"], "R53-099":["C072"],
 "R53-100":["C006","C131"], "R53-101":["C042","C171","C059"], "R53-109":["C045"], "R53-110":["C045"], "R53-113":["C029","C065","C036"], "R53-118":["C065"],
 "R53-119":["C007","C147"], "R53-120":["C003"], "R53-121":["C021","C022"], "R53-122":["C011"], "R53-123":["C061","C089"], "R53-125":["C147","C137"], "R53-126":["C060","C186"],
 "R53-128":["C186"], "R53-129":["C033"], "R53-130":["C212","C109","C037"], "R53-131":["C089","C186","C078","C036","C030","C043"], "R53-136":["C231"],
 "R53-138":["C036"], "R53-140":["C188","C064"], "R53-142":["C083","C205","C016"], "R53-143":["C083"], "R53-145":["C109","C037","C077"], "R53-146":["C077"],
 "R53-147":["C092","C003"], "R53-148":["C007","C089"], "R53-150":["C031"], "R53-151":["C064","C003"], "R53-153":["C048","C027"],
 "R53-160":["C031","C175","C089"], "R53-161":["C031"], "R53-164":["C071"], "R53-165":["C089"], "R53-166":["C186","C033"], "R53-167":["C078"], "R53-168":["C036"],
 "R53-169":["C188"], "R53-170":["C175","C040","C022"], "R53-171":["C072"], "R53-173":["C093"], "R53-174":["C003"], "R53-175":["C007"], "R53-176":["C152","C109"],
 "R53-177":["C218"], "R53-179":["C123","C039"], "R53-180":["C272"], "R53-181":["C048","C027"], "R53-182":["C085"], "R53-185":["C071"], "R53-186":["C007","C222"],
}
# unattached (nuance register): 001 identity, 002–009 method and caveats, 011 launch feature, 032/034/035/038/041 inventory and price tables, 049–051/053/065/066/070/075/090/091 theme tables,
# 102–108/111/112/114–117/124/127/132–135/137/139/141/144/149/152/154–159/162/163 rating, payer, country and trend tables and caveats, 172/178/183/184 recommendation tables and research questions
cards = [json.loads(l) for l in open("Tools/prd_ledger/53/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/53/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
unbacked = [x["id"] for x in C.values() if "Report 53" in x["statement"] and not any(k.startswith("R53-") for k in x["cards"])]
print("unbacked:", unbacked)
