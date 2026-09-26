"""Stage 3 merge for report 20."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C216","must-have","A forgiving habit-strength score that decays instead of resetting","Report 20: a non-streak percentage that drops when a day is missed rather than zeroing — 'missing one day and breaking my streak tends to send me into a spiral where I give up'; described as logarithmic and 'much closer to psychological reality'. The product's one genuine differentiator (38 explicit, the highest-affection language in a 4,048-review corpus; unclaimed by any competitor), broken by a 2021 rewrite when the score stopped decaying and never restored — 'Please bring that algorithm back!' Users who asked for a streak counter asked for it alongside, never instead of, the strength score. Distinct from C201 (a day-level partial-completion threshold): this is the long-run measure.")
add("C217","must-have","An unexplained metric reads as broken — explain the score on-screen","Report 20: a weekly habit completed once showed 4%, not 100%, and users could not work out why; the developer's answer (~91 repetitions to reach 100%) read as arbitrary. A documentation failure, not a maths failure — one explainer screen and an optional 'this period' toggle was the cheapest satisfaction win in the corpus (20 classified, undercounted).")
add("C218","product-rule","Keep the store listing true — never advertise a feature you removed","Report 20: the listing said 'Unlimited amount of habits. You don't need to pay a penny' for at least two years after the free tier was capped at 3; 24 reviews (mean 1.21 — the lowest of any theme) called it false advertising by name. Zero engineering cost, unmade for over two years. Report 18's screenshots advertised a timer a buyer could not find.")
add("C219","must-never-break","A free cap must be concurrent, never lifetime — deleting a habit frees a slot","Report 20: the 3-habit free cap behaved as a lifetime cap — users who deleted a habit to make room could not add a replacement and the add button routed to the paywall; this turned a pricing decision into a functional dead end and was the mechanic that converted annoyance into uninstalls.")
add("C220","product-rule","Never take a paying user's reason to buy away — the widget sold the upgrade and never worked","Report 20: the widget was by a wide margin the most-named purchase trigger and the feature that most often didn't work — 182 reviews (mean 1.94), 113 from confirmed payers (12.4% of all payers), reported broken for five years with an in-app FAQ offering 'restart your phone'; even when present it was a Today-view widget while screenshots implied Home Screen. Ship it properly or remove it from the paywall copy and refund on request.")

ext("C186", " Report 20: the cleanest natural experiment in the set — on 27 Jan 2021 a pay-what-you-want one-time purchase became a $39.99/year subscription, every prior buyer's entitlement was revoked and the free tier capped at 3; daily review volume went 2 → 61 → 135 at means of 1.15–1.36, 615 reviews (15.19%) describe losing a purchase, and the mean never recovered in five years (4.56 before, 1.62 after). The Feb 2021 patch was three weeks late, offered one free year instead of permanent restoration, was never announced and did not hold — revocation reports recur to Jan 2026. 'I bought your app precisely because it wasn't a subscription.'")
ext("C003", " Report 20: 35 reviews praised a pay-what-you-want one-time model at mean 4.83 ('£4.99 to say thank you, £6.98 for liking the app and £14.99 for loving it'); after the subscription switch 26 reviewers walked to Streaks explicitly because it is a one-time purchase ('even though I like this app better'); stated willingness clustered at $5–15 one-time, and the report's recommendation is a $15–25 lifetime unlock with legacy buyers grandfathered free.")
ext("C007", " Report 20: 'unlimited habits, free' was the highest-mean theme in a 4,048-review corpus (54 explicit, mean 4.94) and the product's entire market position; capping it at 3 deleted the reason to exist — 63 reviews say exactly this, 99 complain about the cap, and 3 is below the threshold of usefulness (the report's defensible line is 7–10 free with paid depth elsewhere).")
ext("C006", " Report 20: minimalism was the most-praised attribute by a wide margin (1,111 reviews, 27.45%; 42.8% of the pre-conversion era, mean 4.25), framed against 5–20 cluttered or gamified competitors; 'no ads' ran at mean 4.86; 131 one-star reviews still praised the simplicity in the same breath as condemning the company.")
ext("C002", " Report 20: the trust family (revoked purchase, restore failure, cancel/refund, billing mismatch, false advertising, silent support) was 810 reviews at mean 1.39 against every feature-gap theme combined at 513 reviews at mean 3.57 — trust complaints outnumbered feature complaints 1.58× and carried 2.2 stars less; the five lowest-mean themes were all integrity failures needing no new product surface.")
ext("C036", " Report 20: support went from answering reviews and fixing bugs same-day in 2019–2020 to a dead 'Contact Us' e-mail with an autoresponder and a dormant Instagram account (0.05% → 13.0% of reviews by era); among 148 support-silence reviews the mean was 1.33 versus 3.63 for the 30 who were restored or fixed — the same defect produced either rating depending only on whether anyone answered, worth ~+2.3 stars per recoverable incident.")
ext("C034", " Report 20: update 1.41.0 (13 Mar 2025) erased habit histories globally — 126 of 161 reviews in the following seven weeks (78.3%) reported losing 2–5 years; the advertised fix did not work, a second bug wiped prior progress on the next check-off, iCloud backup was itself a paid, manual feature ('Why should a premium subscriber even have to think about whether a backup was created?'), and there was no communication. The same migration-bug class had fired in Jan 2021.")
ext("C153", " Report 20: recovery from a developer-caused wipe was paywalled behind a manual premium iCloud backup; the recommendation is automatic daily local + iCloud snapshots with restore available to free users, and regression tests on the migration path.")
ext("C093", " Report 20: a 'limited time offer' countdown that reset to 60 hours on expiry ran for over four years (Jan 2021 → Mar 2025) beside a full-screen launch interstitial with a low-contrast dismiss — 225 reviews (5.56%, mean 1.80); 'Dark patterns make bad UX!'; 'first the consumer must see the value of the product. And what do you have? Every 2 seconds a subscribe banner.'")
ext("C113", " Report 20: the app advertised $5.99 / 499₽ / 85%-off and charged $39.99 / 3,150₽ — 28 reports across eight storefronts, Dec 2021 → Apr 2025; below threshold on volume, a consumer-protection exposure by nature.")
ext("C094", " Report 20: a review prompt whose decline button read 'let the developers be sad' — 26 reviewers say it is why they wrote (inflating 2019's 5★ count) and two docked stars for the manipulation.")
ext("C033", " Report 20: legacy lifetime entitlements often did not survive a device change; restore-purchase failures (91, mean 1.59) recurred for years after the 2021 revocation, and 75.8% of them came from confirmed payers.")
ext("C065", " Report 20: 908 reviewers with payment evidence averaged 1.55 against 3.61 for everyone else — 2.06 stars lower; 76.8% of revocation complaints, 62.1% of widget complaints and 65.5% of support complaints came from the ~22% who paid; the damage was also concentrated in the high-spend storefronts (revocation 19.3% vs 8.1% in ru/ua, broken widget 7×).")
ext("C071", " Report 20: across 92 months no significant new capability shipped — the only material changes were the paywall, a widget that never worked and two data-destroying updates; 'ZERO updates, content, features… NOTHING that justifies a yearly subscription fee.'")
ext("C196", " Report 20: an annual subscription was charged for seven years against a product that shipped nothing new; the 4★ band told the developer exactly what would make it a 5 and almost none of it was built.")
ext("C005", " Report 20: 145 reviews (3.58%) named an alternative — Streaks 26 times, and one churning customer wrote the complete gap analysis: 'it adds things to apple health and has custom icons and you can set multiple reminders. apple watch support and an updated ios14 widget.'")
ext("C112", " Report 20: refund requests ignored in Feb 2021 (Apple refunded where the developer would not), 'cannot cancel' reports 2022–2025 with one alleging an FTC-transparency breach, and accidental Touch-ID purchases during onboarding; 125 reviews at mean 1.28.")
ext("C074", " Report 20: one reminder per habit with user-written message text — 'small feature, outsized affection' (25 reviews, mean 4.60).")
ext("C143", " Report 20: multiple check-ins per day (water, medication, teeth) was requested 54 times (mean 3.87) and named as table stakes against Streaks and Productive; never shipped.")
ext("C043", " Report 20: frequency was 'N times in M days' only — specific weekdays ('Gym Mon/Wed/Fri') were never expressible in seven years (22 requests) and drove a share of the notification complaints.")
ext("C172", " Report 20: notes per day was the single most-requested feature in the corpus (79, mean 3.66) and never shipped.")
ext("C022", " Report 20: an Apple Watch app was the highest-mean capability gap (62 requests, mean 4.15), asked for by the happiest users and named in churn-to-Streaks reviews; never shipped.")
ext("C141", " Report 20: an iPad-native app never shipped (43 complaints, mean 3.33).")
ext("C020", " Report 20: export never shipped (9 requests, mean 4.44).")
ext("C045", " Report 20: categories/folders (58) and a compact row option (26) co-occur — both are what happens when a power user exceeds ~8 habits.")
ext("C024", " Report 20: a streak counter was requested 71 times (mean 3.72) — always alongside, never instead of, the decaying strength score.")
ext("C080", " Report 20: dark mode moved from free-ish to paid in the 2021 conversion (89 reviews, mean 2.69) and was a named purchase trigger.")
ext("C061", " Report 20: a large share of pre-2021 purchases were donations — 'I'll definitely choose the highest one because this developer deserves the best'; 'I bought the paid function not because I needed it, but as a thank you.'")
ext("C040", " Report 20: the widget was the top defect surface for five years and the 2★ band's peak theme (13.0%).")
ext("C027", " Report 20: Russian-first UI leaked to Chinese, French and Swiss users, Chinese localisation existed and was later removed ('there was Chinese a few years ago'), and Ukrainian was requested and never added.")
ext("C035", " Report 20: 'no account, no signup' was praised — and was the root cause of the 2025 data loss; the account/backup layer must exist even if signup stays optional.")
ext("C059", " Report 20: users restored in Feb 2021 came back and raised their ratings (23 five-star reviews carry the revocation theme as amended reviews); a 20 Oct 2020 launch failure fixed next day drew praise for the speed.")
ext("C062", " Report 20: revocation and delivery grievances were concentrated in the high-spend storefronts (us, gb, de, ca, au, fr: revocation 19.3% vs 8.1% in ru/ua; widget 7×) — the damage landed on the revenue-generating cohort; Russia's higher mean reflected when its users arrived and what they bought, not a better product.")
ext("C064", " Report 20: $39.99/year for a checkbox app was rejected in every market and language for seven years; Spain, which arrived after the conversion and lost nothing, objected to price (16.9%) but not revocation (2.8%) — the grievance follows arrival date, not nationality.")
ext("C104", " Report 20: the Feb 2021 restoration was never announced — '4 stars after premium was restored, but not 5 because the devs ignored us for so long and have not acknowledged the issue' — and the March 2025 wipe drew 'no communication whatever about this disaster.'")
ext("C133", " Report 20: after the conversion the paid layer was colours, dark mode, extended notifications, manual backup and a non-functional widget above a 3-habit cap — the cap sat below the threshold of usefulness and the paid depth did not deliver.")

M = {
 "R20-003":["C094"], "R20-004":["C186","C001","C002"], "R20-005":["C007","C133"], "R20-006":["C218","C104"], "R20-007":["C220","C040","C065"],
 "R20-008":["C036"], "R20-009":["C034","C153","C175"], "R20-010":["C113","C029"], "R20-011":["C006","C216","C007"], "R20-012":["C002"], "R20-013":["C186"],
 "R20-015":["C071","C196"], "R20-016":["C012"], "R20-017":["C043"], "R20-018":["C074","C008"], "R20-019":["C035","C153"], "R20-020":["C003","C061"],
 "R20-021":["C186","C064","C003"], "R20-022":["C133","C007"], "R20-023":["C033"], "R20-024":["C093","C180"], "R20-025":["C093","C137"], "R20-026":["C219","C137"],
 "R20-027":["C094"], "R20-029":["C003","C064"], "R20-030":["C186"], "R20-031":["C080","C001"], "R20-032":["C085"], "R20-033":["C002"], "R20-034":["C002","C065"],
 "R20-035":["C006"], "R20-036":["C006","C012"], "R20-037":["C007"], "R20-038":["C006","C082"], "R20-039":["C216","C157"], "R20-040":["C042"], "R20-042":["C172"],
 "R20-043":["C024","C216"], "R20-044":["C022"], "R20-045":["C045","C143","C019","C016"], "R20-046":["C141"], "R20-047":["C020"], "R20-048":["C220","C034","C033","C039","C031"],
 "R20-049":["C217"], "R20-050":["C064","C003"], "R20-051":["C005","C003"],
 "R20-053":["C059","C094"], "R20-054":["C024","C172","C143","C045","C141","C022","C013"], "R20-055":["C002"], "R20-056":["C220","C002"], "R20-057":["C186","C006"],
 "R20-058":["C036","C059"], "R20-059":["C065"], "R20-060":["C220"], "R20-061":["C061"], "R20-062":["C080","C153","C007"], "R20-063":["C003","C186"], "R20-064":["C065","C220"],
 "R20-065":["C003","C137","C005"], "R20-066":["C002"], "R20-067":["C112","C109","C029"], "R20-068":["C186","C104","C059"],
 "R20-072":["C062","C065"], "R20-073":["C062","C094"], "R20-074":["C064","C186"], "R20-075":["C064","C186"], "R20-077":["C027"], "R20-078":["C186"],
 "R20-080":["C186"], "R20-081":["C219","C007"], "R20-082":["C093","C180"], "R20-083":["C220","C040"], "R20-084":["C036","C071"], "R20-085":["C034","C153","C104"],
 "R20-086":["C034","C041"], "R20-088":["C059"], "R20-090":["C186","C033"], "R20-091":["C218"], "R20-092":["C093","C180"], "R20-093":["C113"], "R20-094":["C036"],
 "R20-095":["C153","C034"], "R20-096":["C219","C007"], "R20-097":["C220","C023"], "R20-098":["C024","C216"], "R20-099":["C217"], "R20-100":["C143"], "R20-101":["C043"],
 "R20-102":["C172"], "R20-103":["C045"], "R20-104":["C022"], "R20-105":["C216"], "R20-106":["C003","C064","C186"], "R20-107":["C003","C216","C002"], "R20-109":["C216","C042","C157"],
 "R20-110":["C014"], "R20-111":["C009"], "R20-112":["C073"], "R20-113":["C013","C030"], "R20-114":["C031"], "R20-115":["C041"],
}
# unattached (nuance register): 001-002 header/method, 014 inventory, 028 theme table, 041 gap table, 052 distribution, 069-071 eligibility/tables,
# 076 uniform requests, 079 method, 087 non-claims, 089 ownership question, 108 research questions
cards = [json.loads(l) for l in open("Tools/prd_ledger/20/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/20/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
