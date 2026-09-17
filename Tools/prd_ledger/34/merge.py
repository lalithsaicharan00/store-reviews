"""Stage 3 merge for report 34."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C252", "free", "Complete a habit from the notification — an actionable reminder is part of the one-tap loop",
    "Report 34: two reviewers ask to mark a habit done straight from the reminder notification (10052127570, 10100128513), and 'actionable notifications' recur among US 4★ requests — the missing piece between a reminder and a check-off in an app praised for one-tap logging.")

ext("C001", " Report 34: in E5 the objection moved from the habit count to everyday features behind the wall — 'other gated feature' rose to 3.2% of E5 while cap complaints fell 9.7% → 7.1%; widgets, notes, colours and backup behind the paywall average 1.55★ (72.7% 1★), worse than the cap itself (2.44).")
ext("C002", " Report 34: a 4.58★ app whose 1★ band is the paywall almost alone — 28 of 37 1★ (75.7%) are monetisation friction and only 3 are reliability; 'reviewers love what the app is and push back on what it withholds'; era means drifted 4.71 → 4.40 as friction rose 8.4% → 16.4% / 14.3% with no reliability rise.")
ext("C003", " Report 34: a $5–9 one-off (2018–19) gave the highest payer share of any era (18.9% of E1 reviews vs 3.9–8.4% later); lifetime (~$40) beside ~$20/yr and ~$9/mo is praised by 15 (mean 4.87) — 'I hate subscriptions so I paid for lifetime … as an investment'; 'you only pay once which is refreshing in the current year' — and is a US differentiator (3.02% vs 1.46%).")
ext("C004", " Report 34: price fair / worth it 34 (4.58%, mean 4.91; US 6.79% vs 3.35%) — 'I never buy apps. This is worth it … Take it from a penny pincher'; the price objection (25, mean 3.16) anchors against an indie game ($5–25) and Netflix.")
ext("C005", " Report 34: 98 competitor mentions (13.19%, mean 4.85, only one 1★) — arrivals from Streaks, Ladder, HabitKit, ADHD-specific apps and paper; departures only to an app with more free habits or one with iPad and Mac apps; the US names rivals twice as often (19.62% vs 9.62%).")
ext("C006", " Report 34: simplicity praised by 275 (37.01%, zero 1★) — 'no busy visuals, no hokey games'; 'Forget cutesy interfaces, overuse of emojis'; 'too many bells and whistles and I get decision fatigue' — named as the reason people left rivals.")
ext("C007", " Report 34: a 2-habit cap (2018–2025) is 39 complaints (5.25%, mean 2.44) and 15 of 37 1★ (40.5%), rising to 9.7% of E4; reviewers benchmark 5 as the norm ('Other apps usually have 5 free habits'; 'with three I'd have kept it for decency; with five I'd have … got hooked, and then bought'); the same cap is the most common purchase trigger for users whose two habits worked; the 2026 reports of a 4-habit tier are too few to read.")
ext("C009", " Report 34: widgets requested for 3.5 years (11.1% of E3) became the top new praise on launch (11.2% of E4), then were paywalled for some users ('Cant use widgets without subscription', 1★) — the report's advice is to keep at least one widget and basic colours free.")
ext("C010", " Report 34: back-filling and long-press to mark yesterday praised by 10 (mean 4.90); editing days from the month calendar requested by 6, and one US reviewer left over it.")
ext("C011", " Report 34: statistics requests 14 (1.88%) — month %, all habits in one grid, counts rather than streaks; the free stats screen is 'a bit too simple'.")
ext("C012", " Report 34: the per-habit year grid / 'year in pixels' / GitHub-style heatmap is the differentiator — 105 reviews (14.13%, zero 1★), 'the only habit tracker I could find with a whole year view'; 'Don't Break The Chain only makes sense if you can actually see your chain!'")
ext("C016", " Report 34: skip / pause / sick day requested by 5 ('i am sick and cannot swim … i dont want to loose my results').")
ext("C019", " Report 34: bad-habit / quit tracking 6 — 'I'd rather not see TO DO next to bad habits'.")
ext("C020", " Report 34: CSV export disabled in Feb 2026 ('Out of nowhere … years of data are stuck in this app'; 'Vendor Lock', 1★) and a paid backup required before deleting (1★) — both data-lock-in reviews are 1★ (mean 1.00) in a no-account app where export is the only exit.")
ext("C023", " Report 34: 7 interactive-widget requests, all after static widgets shipped (Mar 2024) — 'The widgets still aren't interactive' (Feb 2026).")
ext("C025", " Report 34: a 50% annual offer converted ('I paid £9.99 for a whole year - bargain!'), affordability complaints come from students, Vietnam and ADHD users; the report proposes a student / regional price and New-Year sales.")
ext("C027", " Report 34: 19 polite localisation requests (none 1★) — Chinese 9, Russian 4, Spanish 2, French 2, Ukrainian 1 — 11 of them arriving in E3, starting the day a free-lifetime promotion reached br, vn, cn and co: promote into a market only once the app speaks its language.")
ext("C031", " Report 34: the 10–11 Apr 2024 update crashed on launch and was fixed a day later (E4 reliability 6.7% → E5 2.6%); in Feb 2026 a reviewer needed 20–30 launches to load.")
ext("C034", " Report 34: local-only storage lost data on reinstall, factory reset or 'for no reason' (4; 'thought this app supports iCloud sync and re-installed app … lost all data as this app needs backup file').")
ext("C036", " Report 34: a single 'Support doesn't respond to emails' in an app whose main asset is a named, responsive solo developer.")
ext("C039", " Report 34: the reminder time picker broke for a paying user ('I payed for this app … I might just cancel my membership', Dec 2025) and again Mar 2026; a 2019 buyer got no notifications and returned the purchase.")
ext("C040", " Report 34: widget rendering broke with the iOS 18 tinted home screen (white), two of six widgets didn't show days, 'keeps getting disabled' — 5 reviews, 3.0% of E4, one payer 'waste money'.")
ext("C042", " Report 34: ADHD users (5) prefer the simple general tracker — 'apps designed specifically for ADHD … too detailed … This app is simple with just the right amount of detail'; 'MUST. FILL. BOXES.'")
ext("C043", " Report 34: x-days-per-week added on request (Apr 2019), flexible frequency praised by 13 (mean 4.92); every-other-day and monthly targets still requested (7).")
ext("C044", " Report 34: no iPad / Mac / web app (8) — 'The only reason i'm going with a competitor … is because I don't always want to use my phone'; 'I'd even pay for separate versions as long as they synced'.")
ext("C048", " Report 34: quantity / partial completion requested by 11 — 'I Drank 80oz … I wanna be able to track that'; '8 of 10 glasses counts as progress'.")
ext("C054", " Report 34: a free-lifetime giveaway (~29 Jun 2023) produced 27 short, mostly 5★ reviews in three days (55.6% ≤ 25 characters) and moved the mean by ~0.01.")
ext("C056", " Report 34: across 743 reviews over eight years, no review mentions AI, ChatGPT or an AI feature.")
ext("C058", " Report 34: launched via Reddit (Jul 2018); 6 reviewers (mean 5.00) say they found it via Reddit, social or reviews; early Reddit adopters wrote long, personal reviews to the developer by name.")
ext("C059", " Report 34: 52 developer-praise reviews (mean 4.96), 31 naming 'Kevin'; replies turned ratings up ('Updated to 4 stars - thank you devs for the response!'); weekly habits and a reviewer's suggestion built on request; an in-app 'in progress' roadmap list ('this informing and communicative attitude was a huge plus'); the share fell 13.2% (E1) → 5.2% (E5).")
ext("C061", " Report 34: supporting a solo developer is a named purchase motive ('I paid the app to support solo developer'); 13 of 51 payers praise the developer.")
ext("C062", " Report 34: the US (265) is the comparison-shopping market — competitors named 2×, payers 9.06% vs 5.65%, price praise 2× — with less wall friction but 9 of the 14 explicit churn reviews; non-US users hit the cap (6.07% vs 3.77%) and the English-only UI more.")
ext("C063", " Report 34: no trial (2022, 2024, 2026) vs a 3-day trial (2025) — 7 complaints (mean 3.00): 'I refuse to pay the min. $9 just to find out if I like it'; a 2018 reviewer proposes '21 days of all bells and whistles … Once you hook them on, charge them'.")
ext("C064", " Report 34: ~$9/mo, ~$20/yr, ~$40 lifetime — price objection 25 (mean 3.16), many 'great app, too expensive' at 4–5★; €9.99/month called 'completely of the charts'.")
ext("C065", " Report 34: payers are satisfied (51, mean 4.63) and E5 is their weakest era (4.23) because every low-rating E5 payer reports a broken paid thing — widget, reminders, lifetime entitlement — not price.")
ext("C085", " Report 34: on-device data with no account praised as privacy (7): 'my data isn't stored on a server!'; 'hasn't been larded with privacy-invading trackers'.")
ext("C089", " Report 34: the ~29 Jun 2023 free-lifetime giveaway left one reviewer calling it a 'Scam of free life time subscription' (1★) and another asking when the next limited-time free offer comes.")
ext("C093", " Report 34: upgrade nagging 4 (mean 2.00) — 'constantly being nagged to upgrade to premium. I only track one thing'.")
ext("C094", " Report 34: a rating prompt during setup ('you want me to rate it before I even finish setting it up'; 'App asks for 5 stars review'); the report recommends prompting after setup and after a 7-day streak.")
ext("C110", " Report 34: the wall arrives at habit #3 during setup — 'I added 2, tried to add the third and was prompted to pay'.")
ext("C141", " Report 34: 'purchased Premium version for my iPad as well' refers to the iPhone app on iPad; iPad / Mac / web requested by 8.")
ext("C142", " Report 34: 'No widgets!!' two months after widgets shipped, and a request for an easier way to mark yesterday answered by the existing long-press ('That solves 90% of the struggle').")
ext("C147", " Report 34: 'two habits is too few to judge the app' is the plurality of 78 monetisation-friction reviews; a 2-habit tier converts believers and repels evaluators.")
ext("C153", " Report 34: a local-first no-account app praised for privacy loses data on reinstall and factory reset; optional iCloud sync would keep data off the developer's servers while fixing loss, multi-device use and exit.")
ext("C155", " Report 34: CSV export, present for years, was disabled in 2026; the one-time purchase option vanished 'after updating the app'.")
ext("C170", " Report 34: 'My day always ends after midnight' — a configurable day start, citing Habitica's setting.")
ext("C172", " Report 34: notes per completed day are Premium (praised 11, mean 4.91); notes on missed days and opening a note from the calendar requested by 9 (a 'No Spend' habit).")
ext("C176", " Report 34: 'forced to keep paying … if you don't want to lose all your history' — export disabled and a paid backup before delete, both 1★.")
ext("C178", " Report 34: 'Feels like it was made by Apple'; 'Native iOS gem'; 'The whole app just feels calm and clear' — calm native design praised by 156 at 4–5★, gamification requests (5) outnumbered by praise for its absence.")
ext("C186", " Report 34: lifetime holders' only negatives are continuity — the one-time option gone after an update (Nov 2025) and a lifetime licence that 'wont be working anymore' (Jun 2026, 'False claim', 2★); 'a lifetime model obliges the developer to honour and migrate, not withdraw'.")
ext("C218", " Report 34: users who searched for free apps met a 2-habit wall — 'only to find out AFTER downloading the app that there is a fee'; 'I just wish it was said earlier (for example, here)'.")
ext("C225", " Report 34 (counter-case): a ~29 Jun 2023 free-lifetime giveaway brought 27 short 5★ reviews in three days and a wave of non-English users asking for a language the app did not have; no durable-retention evidence.")
ext("C246", " Report 34: no ads; 'no ads / no nagging' praised by 6 (mean 4.83).")

M = {
 "R34-001":["C005"], "R34-004":["C054","C225"], "R34-005":["C225","C089","C027","C054"], "R34-006":["C150","C094"], "R34-007":[],
 "R34-009":["C006","C012"], "R34-010":["C012"], "R34-011":["C005"], "R34-012":["C007","C002"], "R34-013":["C007","C147"],
 "R34-014":["C001","C009","C133"], "R34-015":["C007","C002"], "R34-016":["C147","C218","C063"], "R34-017":["C218","C110","C236"],
 "R34-018":["C063","C109"], "R34-019":["C064"], "R34-020":["C002"], "R34-021":["C009","C107"], "R34-022":["C009","C059"],
 "R34-023":["C023"], "R34-024":["C009","C001"], "R34-025":["C020","C155","C176"], "R34-026":["C176","C020"], "R34-027":["C186","C003"],
 "R34-028":["C039","C065"], "R34-029":["C065"], "R34-030":["C007","C147"], "R34-031":["C003"], "R34-032":["C061"], "R34-033":["C059"],
 "R34-034":["C062","C005"], "R34-035":["C218","C094","C147","C020","C186","C039","C040","C023","C048"],
 "R34-039":["C002"], "R34-040":["C032"],
 "R34-043":["C006","C069"], "R34-044":["C012"], "R34-045":["C011","C234"], "R34-046":["C043"], "R34-047":["C010"], "R34-048":["C008","C014"],
 "R34-049":["C172"], "R34-050":["C080","C009","C018"], "R34-051":["C118","C073"], "R34-052":["C202"], "R34-053":["C085","C020","C153"],
 "R34-054":["C059"], "R34-055":["C022","C141","C044","C013"], "R34-056":["C153","C030"], "R34-057":["C048","C143"], "R34-058":["C172"],
 "R34-059":["C019","C016"], "R34-060":["C021"], "R34-061":["C027"], "R34-062":["C252"],
 "R34-064":["C058"], "R34-065":["C031"], "R34-066":["C040"], "R34-067":["C175","C018"], "R34-068":["C039","C175"], "R34-069":["C031"],
 "R34-071":["C007","C001"], "R34-072":["C064","C003"], "R34-073":["C003"], "R34-074":["C186","C177"], "R34-075":["C063","C109"], "R34-076":["C025"],
 "R34-077":["C059"], "R34-078":["C159","C145"], "R34-079":["C093"], "R34-080":["C036"],
 "R34-082":["C002"], "R34-083":[], "R34-085":["C004","C003"], "R34-086":["C024"], "R34-087":[], "R34-088":["C004"], "R34-089":["C024","C012"],
 "R34-090":["C002"], "R34-092":["C061"], "R34-093":[], "R34-094":["C011"], "R34-095":["C007"], "R34-097":["C063","C064"], "R34-098":["C186","C034","C020"],
 "R34-099":["C178"], "R34-100":["C043"], "R34-101":["C175"], "R34-102":["C142","C145"], "R34-103":["C170","C010"], "R34-105":["C101"],
 "R34-106":["C003"], "R34-107":["C025","C092"], "R34-108":["C034"],
 "R34-112":["C176","C186","C020"], "R34-114":["C176","C020"], "R34-115":["C001","C009","C133"], "R34-116":["C214"], "R34-117":["C171"],
 "R34-118":["C002"], "R34-119":["C147","C218","C063","C064","C001","C003"], "R34-120":["C063"], "R34-121":["C218","C134"], "R34-122":["C007","C222"],
 "R34-123":["C147","C218","C001"], "R34-125":["C006","C178"], "R34-126":["C178"], "R34-127":["C012"], "R34-128":["C042","C183"],
 "R34-130":["C175","C040","C039"], "R34-131":["C142","C223"], "R34-132":["C024","C157","C178"], "R34-133":["C005"], "R34-134":["C070"],
 "R34-135":[], "R34-136":["C110","C137"], "R34-137":["C007"], "R34-138":["C007"], "R34-139":["C001","C133"], "R34-140":["C007","C002"],
 "R34-141":["C007","C147"], "R34-142":["C009","C059"], "R34-143":["C009"], "R34-144":["C040","C065"], "R34-145":["C085"], "R34-146":["C034","C153"],
 "R34-147":["C044","C141"], "R34-148":["C153","C013","C085"], "R34-149":["C186","C020","C039","C031","C150"], "R34-150":["C186","C176"],
 "R34-151":["C027"], "R34-152":["C027","C225"],
 "R34-154":["C002"], "R34-155":["C007"], "R34-156":[], "R34-157":["C002","C001"], "R34-159":["C002"],
 "R34-162":["C003","C004"], "R34-163":["C065","C078"], "R34-165":["C007","C147"], "R34-166":["C003"], "R34-167":["C061"], "R34-168":["C167","C080"],
 "R34-169":["C025"], "R34-170":[], "R34-171":["C004"], "R34-172":["C065","C039"], "R34-173":["C177","C029"], "R34-174":["C063","C044","C064"],
 "R34-175":["C186"],
 "R34-179":["C005","C062"], "R34-180":["C012"], "R34-181":["C062"], "R34-182":["C062","C007"], "R34-183":["C218","C063"], "R34-185":["C089"],
 "R34-186":["C062"], "R34-187":["C027","C007"],
 "R34-189":["C002"], "R34-190":["C001","C007"], "R34-191":["C001","C133"], "R34-192":["C009","C059"], "R34-193":[], "R34-194":["C031","C040"],
 "R34-195":["C186"], "R34-196":["C027"], "R34-198":["C056"],
 "R34-199":["C012"], "R34-200":["C006"], "R34-201":["C007","C147"], "R34-202":["C218"], "R34-203":["C186","C003"], "R34-204":["C153","C085"], "R34-205":["C059"],
 "R34-206":["C218","C110"], "R34-207":["C150","C094","C159"], "R34-208":["C093"], "R34-209":["C020","C176"], "R34-210":["C186"], "R34-211":["C039"],
 "R34-212":["C040","C031"], "R34-213":["C007","C063"], "R34-214":["C009","C133"], "R34-215":["C109","C152"], "R34-216":["C025","C092"], "R34-217":["C003"],
 "R34-218":["C023"], "R34-219":["C048","C143"], "R34-220":["C172"], "R34-221":["C153","C044","C022","C141"], "R34-222":["C010","C170"], "R34-223":["C011"],
 "R34-224":["C019","C016"], "R34-225":["C027"], "R34-226":["C024","C157"], "R34-227":["C007","C009"], "R34-228":["C186"], "R34-229":["C020"],
 "R34-230":["C089"], "R34-231":["C007"], "R34-232":["C007","C063"], "R34-233":["C218"], "R34-234":["C009"], "R34-235":["C094"],
}
# unattached (nuance register): 002 method, 003 small-corpus caveat, 007 misrate, 008 storefront/contradiction caveat, 036–038 tables, 041 storefronts,
# 042 inventory, 063 timeline table, 070 renames, 081 master table, 083 utility series, 084 generic, 087 life outcomes, 091 long-term, 093 churn,
# 096 update improved, 104 promo mention, 109 gibberish, 110 weak rows, 111 4–5★ restriction, 113 worst-rating table, 124 strengths table,
# 129 unmet table, 135 wall table, 153 5★ band, 156 2★ band, 158 cross-band table, 160–161 payer framing, 164 triggers table, 170 renewal,
# 176–178 US scope/tables, 184 US bands, 188 method, 193 praise-mix trend, 197 non-claims
cards = [json.loads(l) for l in open("Tools/prd_ledger/34/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/34/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
