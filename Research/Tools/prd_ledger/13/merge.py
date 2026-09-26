"""Stage 3 merge for report 13."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C186","product-rule","Never revoke what earlier buyers paid for when the model changes","Report 13: in Aug 2017 a $3.99 one-time purchase became a subscription, unannounced in the release notes, and prior buyers were downgraded to free ('my purchase was worthless'); the mean fell 1.79 stars in nine months and no month since has been above 4.0. Subscriptions later silently expired after updates. Grandfather, always.")
add("C187","dont","No paid acquisition into an auto-converting trial in frictionless-payment markets","Report 13: a Douyin campaign drove Chinese installs into a 7-day trial that opened a ¥208/yr subscription with password-free payment and no authentication step; China became 73% one-star and 51% of all involuntary-charge reviews. Where the payment rail has no friction, the app must add an explicit confirmation step.")
add("C188","must-never-break","The app must open offline — never block launch on a network call","Report 13: a blocking in-app 'update in progress' migration bricked the app on launch in three waves (Nov 2019, Oct 2020 at 5.9% of that month's reviews, Sep 2025 → Aug 2026), destroyed data on reinstall ('lost almost 3 years of habit tracking') and locked out paying subscribers; 'Will not launch without internet'.")
add("C189","dont","Never post canned public replies — answer the specific complaint or don't reply","Report 13: copy-paste replies restating Apple's cancellation instructions under reviews had a mean of 1.40 with zero 5★, and multiple reviewers edited their rating downward afterwards ('If you're just going to copy-paste an answer again, don't leave one at all').")
add("C190","dont","No weekly billing tier","Report 13: weekly billing introduced in 2024 ($3.99, €6, R$29.90, ₽499 per week) drew the corpus's most hostile pricing language — 'insane', 'immoral', 'Per week! I didn't even test it' — and price complaints rose to 26.7% of 2025 reviews.")

ext("C003", " Report 13: 239 reviews across every year 2017–2026, including 5★ ones ('It would be better to charge only once. It would attract more users, trust me'), asked for the one-time purchase back after it was withdrawn.")
ext("C109", " Report 13: a trial that cannot start without first authorising a subscription, defaulting to the most expensive annual tier, produced 1,102 auto-charge reviews at mean 1.20 (999 one-star) — the single most damaging mechanic in a 19,850-review corpus; involuntary-charge reviews equalled voluntary-purchase reviews 1:1.")
ext("C112", " Report 13: in Korea 24.7% of reviews say they cannot cancel and two reviewers published how-to-cancel guides for other users; an in-app 'Manage subscription' link would address a quarter of that storefront's reviews.")
ext("C007", " Report 13: the free cap was cut from 5 to 3 in 2018 (the worst year, mean 2.85) and restored in 2020 without recovering the rating; 'hitting the cap while already engaged' is the one purchase trigger buyers name.")
ext("C008", " Report 13: exact-clock reminder times behind the paywall was the single most resented gate in an eleven-year corpus (227 requests); free users got only Morning/Afternoon/Evening buckets.")
ext("C137", " Report 13: the paywall fired 3–15 times in the first three minutes while the real purchase trigger was hitting the cap after engagement; the report's experiment: delay the first interstitial until habits are completed on three separate days.")
ext("C030", " Report 13: iCloud sync complaints rose 10× from 2015 to 2021 and ran at 8.9% of 3★ reviews — the fastest-worsening dimension and the defect most likely costing renewals.")
ext("C027", " Report 13: Arabic is the largest unserved language (20.5% of Saudi reviews); users were also served the wrong language ('I am from Turkey but this app language is Korean', 41 votes) and shown store screenshots in languages the app does not have.")
ext("C116", " Report 13 (contested): Challenges/Explore content tabs added in 2020 drew 'please let me hide them… I will not pay for an app that is 50% useless content'; nobody in 19,850 reviews asked for content, coaching or AI.")
ext("C180", " Report 13: 'Here's one star for you. You can buy the rest at a 49% discount' — the exit-intent discount tells every full-price buyer they overpaid.")
ext("C085", " Report 13: a 2017 privacy-policy revision drew 11 reviews in a month; location prompts with no stated purpose ('No, you don't need it') and disclosure-to-law-enforcement language made long-time users delete.")

M = {
 "R13-004":["C186","C003","C104"], "R13-005":["C109","C152","C029"], "R13-006":["C064","C004","C190"], "R13-007":["C187","C112","C092"],
 "R13-008":["C188","C031","C139"], "R13-009":["C006","C166","C116"], "R13-010":["C013","C027","C043","C073","C181"],
 "R13-012":["C008","C133"], "R13-013":["C066"], "R13-014":["C053"], "R13-015":["C020"], "R13-016":["C114","C027"],
 "R13-017":["C064","C004","C003","C190"], "R13-018":["C007"], "R13-019":["C003","C109"], "R13-020":["C180","C113","C112","C109","C110"],
 "R13-021":["C029","C112"], "R13-023":["C003","C147"], "R13-024":["C093","C094","C114"], "R13-025":["C006","C011","C075"],
 "R13-026":["C016","C143","C017","C080","C050","C019"], "R13-027":["C141","C022","C040","C175","C083","C038"], "R13-028":["C002","C065"],
 "R13-029":["C109","C036","C029","C189"], "R13-030":["C006","C042","C134"], "R13-031":["C103","C042"],
 "R13-032":["C172","C008","C048","C027","C043","C009","C019","C050","C020","C021","C044","C045","C010"], "R13-033":["C048"], "R13-034":["C043"], "R13-035":["C172"],
 "R13-036":["C030","C031","C034","C039","C073","C188"], "R13-037":["C073"], "R13-039":["C008","C024"], "R13-040":["C003","C002"],
 "R13-041":["C172","C043","C030","C009","C073","C007"], "R13-042":["C030","C141"], "R13-043":["C007","C133"], "R13-044":["C109","C003","C064","C147","C002"],
 "R13-045":["C022","C116","C024"], "R13-046":["C189","C036"], "R13-048":["C065","C061","C004"], "R13-049":["C007","C137"],
 "R13-050":["C109","C112","C152","C029","C187"], "R13-051":["C147","C003","C064","C007","C093"], "R13-052":["C093","C137","C147"],
 "R13-053":["C065","C033","C030"], "R13-054":["C186","C033"], "R13-056":["C062"], "R13-057":["C187","C002"], "R13-058":["C187","C092","C114"],
 "R13-059":["C112","C152"], "R13-060":["C027"], "R13-061":["C027","C114"], "R13-062":["C027","C029"], "R13-063":["C027"],
 "R13-065":["C186","C003","C104","C002"], "R13-066":["C064","C190"], "R13-067":["C188","C034","C031"], "R13-068":["C030","C013"],
 "R13-069":["C116","C166","C006"], "R13-070":["C085","C096"], "R13-071":["C147","C007","C093","C030","C027","C044","C020","C039","C008"],
 "R13-073":["C109"], "R13-074":["C152"], "R13-075":["C112"], "R13-076":["C109","C113"], "R13-077":["C181","C110"], "R13-078":["C180"],
 "R13-079":["C189","C036"], "R13-080":["C187","C026"], "R13-081":["C188","C139","C034"],
 "R13-082":["C030","C043","C073","C172","C048","C027","C010","C020","C116"], "R13-083":["C030"], "R13-084":["C003"], "R13-085":["C137","C007"],
 "R13-086":["C190","C064"], "R13-087":["C092"], "R13-088":["C008"], "R13-089":["C003","C042","C027","C110"],
}
# unattached (nuance register): 001-003 header/method/composition, 011 inventory table, 022 theme table, 038 band tables, 047 evidence base,
# 055 storefront table, 064 eras, 072 not claimed, 090 research questions
cards = [json.loads(l) for l in open("Tools/prd_ledger/13/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/13/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
from collections import Counter
print("points by report count:", sorted(Counter(len(x["reports"]) for x in C.values() if not x.get("merged_into")).items()))
