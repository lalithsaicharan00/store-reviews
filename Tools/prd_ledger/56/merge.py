"""Stage 3 merge for report 56."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text

ext("C001", " Report 56: in a fully free app, 9 of 67 name a competitor's paywall as the reason they left it and 35 (52.24%) restate the free promise — 'paywalling existing free capability attacks the documented acquisition path'; the appeal is flat between high-spend and other markets (47.1% vs 43.8%), so it cannot be paywalled in rich storefronts either.")
ext("C002", " Report 56: a 4.91★ corpus with zero 1★ and zero 2★ in 199 days is selection bias, not proof of health — defect reporters average 4.50, two 5★ reviews report functional defects, and the users driven away wrote nothing.")
ext("C005", " Report 56: 15 of 67 (22.39%, all 5★) describe a search that ended here, rising 17.6% → 31.8% — 'i've uninstalled like 5 habit trackers this year lol… the one i actually kept'; the two named criteria are free and widgets ('I have not found others that have both').")
ext("C006", " Report 56: simplicity 39 of 67 (58.21%, 4.92), never below half in any period — 'knows what it wants to do and does exactly that and nothing more'; 'I lose interest in things if they're too complicated'; every request is a request to add something, so non-daily frequency must be one field defaulting to daily; do not add social, sharing or AI (zero requested).")
ext("C007", " Report 56: unlimited habits named by 4, always against competitors — 'without limiting me to preset habits or a specific number without paying first' (AR); 3 left competitors specifically over caps.")
ext("C009", " Report 56: widgets free where 'free apps often have chopped widgets, or widgets just gated behind a subscription'; cosmetic limits (icons, colours, descriptions) cost two of four 4★ — 'i would have a 5 star rating if a few small changes could be made'.")
ext("C010", " Report 56: back-dating existed but was hard to find — requested in June, 'a little hard' in July, 'super easy' in August.")
ext("C011", " Report 56: analytics / charts requested once in a fully free app.")
ext("C013", " Report 56: optional iCloud sync shipped free and headlines a positive review ('Simple, free, privacy friendly - optional icloud sync').")
ext("C022", " Report 56: an Apple Watch app requested once.")
ext("C023", " Report 56: per-habit home-screen widgets with one-tap completion are the differentiator (9 of 67 name them; 'the empty dots on my home screen guilt trip me into being productive and honestly? it works'); a multi-habit widget designed in detail (dates across, habits down), more than 4 widgets and transparency requested; a widget tap that opened the app instead of completing broke the most-praised interaction (fixed in v2.3.2).")
ext("C024", " Report 56: do not add streak pressure, scores or gamification to a product chosen for restraint — one streak request against 'no subscription, no guilt' and 39 restraint reviews.")
ext("C027", " Report 56: the listing claims Korean and Japanese yet 24 of 43 polled storefronts, Japan included, returned zero reviews; non-English reviewers rate 5.000 vs English 4.882.")
ext("C030", " Report 56: 'the recent update about sync made my habits disappear, is there anyway I can get them back??' — six days after a sync request; F1: a local pre-sync snapshot and a visible restore path.")
ext("C034", " Report 56: a sync update deleted a user's habits (4★, the only severe defect) — the history is the asset outcome reviewers keep the app for.")
ext("C036", " Report 56: four in-review support questions (data recovery, widget transparency in Korean, language reset, back-dating) left unanswered, each answerable in one sentence.")
ext("C038", " Report 56: 'the calendar is a day out so when you complete a dot on the Monday it highlights the Sunday before' (GB, rated 5★) — F2: verify week-start and timezone handling (Europe/London vs UTC feed); the UI switched to Chinese unprompted.")
ext("C040", " Report 56: a widget tap that opens the app instead of progressing the habit (BE, 4★).")
ext("C042", " Report 56: one ADHD reviewer — 'tried countless apps that claim to help neurodivergent people… They end up being made for quick cash grabs or having a wildly confusing interface… With Dots, you get exactly what you download' — the report advises earning the audience by staying simple, not claiming it (n=1).")
ext("C043", " Report 56: non-daily scheduling is the oldest request (day one) and the only one with a rating penalty — the corpus's only 3★: 'Great daily but no weekly… I love the daily tracking for free with no premium version, but I feel like we need a weekly/monthly/select days option!'; five of six forms reduce to 'this habit is not daily' (x per week, weekly, monthly, select days); a deadline request is a different product (D1).")
ext("C045", " Report 56: separate lists / habit groups requested once.")
ext("C059", " Report 56: 'It didn't have options for reminders & shuffling the order of your habits, but it does now! -Even more happy with it' — visible shipping raised a verdict; 13 of 67 thank the developer by name.")
ext("C061", " Report 56: a fully free app with no commercial surface — 0 of 67 mention paying — and exactly one unprompted request to donate ('Eager next for notification and donation options'), backed by 13 (19.40%) who thank the developer; the only monetisation path the corpus supports is voluntary (D3).")
ext("C073", " Report 56: reorder requests (4) stopped dead once reordering shipped, because it is visible in the list.")
ext("C080", " Report 56: a dark / OLED design praised ('Cool OLED and Minimal Design'); dark mode (Feb) and light mode (Jul) requested five months apart.")
ext("C083", " Report 56: the bottom menu bar blocks the habit list at 9+ habits — the scale 'unlimited habits' invites.")
ext("C085", " Report 56: no data collection named as the primary value by an ES reviewer ('No recopila datos') and corroborated by the listing; adding analytics to learn about churn would contradict it.")
ext("C096", " Report 56: no ads, no data collection, no account — 'Dots currently monetizes nothing', itself a differentiator and the credibility that makes a donation ask land.")
ext("C097", " Report 56: one unprompted donation request in 67 reviews of a fully free app; E1: an unobtrusive tip jar in Settings — no gating, no prompt, no nag — and watch for any negative review mentioning it.")
ext("C134", " Report 56: the listing leads with the category's language ('simplicity, clarity, and daily consistency') while users say 'actually free, no strings, nothing extra' — E5: rewrite it in the corpus's words; the US over-indexes on outcomes (25.0% vs 9.3%).")
ext("C142", " Report 56: 'a feature-discoverability problem, not a feature-absence problem' — reminders requested twice after shipping (buried in the habit editor; v2.3.2 added a bell icon on every row), back-dating hard to find, widget transparency in the store preview but not findable — 'Shipping a feature is not the same as retiring its request'.")
ext("C147", " Report 56: free-trial-then-charge patterns at competitors are explicitly rejected — 'No obnoxious free-trial trick. Actually free'; 'really free, no false promises'.")
ext("C172", " Report 56: per-habit description / notes requested by 3 — ship a short label first; journaling is a separate question.")
ext("C175", " Report 56: a sync update deleted habits; defects clustered in the Jun–Jul build cycle.")
ext("C178", " Report 56: users praise absence — 'no random pop ups—just put your habits in and track them'; 'track their habits without the faff'.")
ext("C209", " Report 56: 'I tried a couple of them on the App Store and hated them immediately. They usually ask 20 questions just to get started'; 'no sign-in wall' named as why it stuck.")
ext("C218", " Report 56: a store preview shows a widget-transparency setting the user cannot find in the app.")
ext("C246", " Report 56: 9 of 67 name ad-freeness; ads 'caused instant deletion' of competitors.")
ext("C255", " Report 56: the UI switched to Chinese unprompted and the user could not find how to change it back.")
ext("C099", " Report 56: a deadline (time-bounded goal) requested once — kept out of scheduling as a different product.")

M = {
 "R56-004":["C002"], "R56-006":["C001","C061","C006","C043","C142"], "R56-008":["C001","C009","C246","C097"], "R56-009":["C010","C142"],
 "R56-012":["C006","C178"], "R56-013":["C001","C147"], "R56-014":["C001","C005"], "R56-016":["C005"], "R56-017":["C023"], "R56-018":["C246","C178"],
 "R56-020":["C061","C059"], "R56-021":["C059","C061"], "R56-022":["C209"], "R56-023":["C085","C096"],
 "R56-025":["C043"], "R56-027":["C099"], "R56-028":["C009","C172"], "R56-029":["C023"], "R56-030":["C013","C022","C080","C024","C011","C010","C045"],
 "R56-031":["C034","C030","C038","C040","C083","C142"], "R56-032":["C083"], "R56-033":["C255"], "R56-034":["C218","C142"], "R56-037":["C009"],
 "R56-038":["C002"], "R56-040":["C001"], "R56-041":["C097","C061"], "R56-042":["C001","C007","C147","C246"], "R56-043":["C001"],
 "R56-044":["C065"], "R56-049":["C042"], "R56-050":["C001"], "R56-051":["C027"], "R56-052":["C027"],
 "R56-056":["C142","C073"], "R56-057":["C142"], "R56-058":["C059"], "R56-059":["C030","C034","C175"],
 "R56-062":["C030","C034"], "R56-063":["C038"], "R56-064":["C083","C040"], "R56-065":["C036"], "R56-066":["C001","C007","C009","C246"], "R56-067":["C097","C061","C096"],
 "R56-068":["C009","C172"], "R56-069":["C023"], "R56-070":["C134"], "R56-073":["C209","C246","C007","C024","C006"], "R56-074":["C024"], "R56-075":["C006","C056"], "R56-076":["C002"],
}
cards = [json.loads(l) for l in open("Tools/prd_ledger/56/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/56/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; {len(null)} unattached")
print("unbacked:", [x["id"] for x in C.values() if "Report 56" in x["statement"] and not any(k.startswith("R56-") for k in x["cards"])])
