# -*- coding: utf-8 -*-
"""Stage 3 merge for report 74 (Habit Check Calendar / 習慣チェックカレンダー, Naoki Otsu)."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text

ext("C193", " Report 74 (Habit Check Calendar, 151 reviews): the clearest cost of the cliff — at the end of an undisclosed ~1-week free window the app stops entirely ('after a week you can't even tap'; TRL_SUDDEN_LOCKOUT 20, mean 1.30) and read access to existing records is locked (TRL_DATA_HOSTAGE 6, mean 1.17 — 'the angriest theme'; 人質 'hostage' in two reviews and a title: 'holds the records you've built up hostage and presses you to pay'); the app is used for medication adherence and a locked-out user wrote 'I never thought it would go paid — I wish I'd written down what I'd been taking'; §8.1 #3 'Never lock read access to existing records. Let expired users read, scroll and export their history forever; gate only new entry and premium features' — the report's single highest-leverage change; #4 unconditional CSV export at trial end — 'A user who leaves with their data does not write scam'.")
ext("C176", " Report 74 (Habit Check Calendar): 'Going paid is unavoidable, but suddenly not being able to see my past history either — isn't that unkind?' — locking history converts a pricing decision into hostage-taking in the users' own words; 'the difference between I decided not to pay and they took my medication log'.")
ext("C204", " Report 74 (Habit Check Calendar): months of check-ins and memos made unreadable at the paywall; setup effort framed as deliberate sunk cost (TRL_WASTED_SETUP 4, all 1★).")
ext("C181", " Report 74 (Habit Check Calendar): a free-download listing on every storefront that enumerates notifications, backup, CSV export and unlimited tabs 'with no statement of a trial, a time limit, or any feature being paid-only' — TRL_NO_DISCLOSURE 23 (15.23%, mean 1.52), 27 of 30 1★ are trial grievances; 14 reviewers write the fix: 'This is a paid app. After the free period ends you need a paid plan to keep using the service'; 'free for one week only, paid after that'; 14 propose selling it as a paid app outright; the most-voted review: 'The listing says in-app purchase, not paid app. It isn't a lie, but I can't see it as anything other than deliberate misleading to grow the user base'; §8.1 #1 state the model — free for N days, then a one-time purchase, price named — in the description and first screen.")
ext("C218", " Report 74 (Habit Check Calendar): a listing that lists every feature and never the time limit — 'This is the gap the corpus is complaining about, and it is verifiable from outside the corpus'; the listing also claims cross-device and cross-OS restore while 7 say sync does not work and 2 paying users could not move the purchase.")
ext("C104", " Report 74 (Habit Check Calendar): an ad-supported free app converted to a ~1-week trial with no notice around 2025-01-04 — zero grievances in 51 reviews over the prior 2.5 years, then 22 of 37 (59.46%); mean 4.43 → 2.78; 1★ from 1 to 17 in six months; still 22.22% of reviews twenty months later — 'an ongoing tax', not a one-off migration cost.")
ext("C236", " Report 74 (Habit Check Calendar): §8.1 #2 show the trial state in-app from first launch — a persistent 'N days left in your free trial' — so day 8 is never a surprise; the lockout is a hard stop, not a degraded tier (one reviewer alone reports rows being cut back first).")
ext("C152", " Report 74 (Habit Check Calendar): no in-app notice before the free window closed — 'why, with no notice at all?'; one reviewer reports three months instead of one week (unexplained).")
ext("C191", " Report 74 (Habit Check Calendar): users of a year or more hit the sudden paywall — one bought at once and asked the app not be shut down; others 'had been thinking I might as well pay' and lost the desire to — 'Amazing how much one attitude from the developer changes how you feel' (4/6 helpful).")
ext("C003", " Report 74 (Habit Check Calendar): the paid tier is a single buy-once SKU ($4.99 / ¥780 today; reported ¥600 → ¥800 → ¥1,000) and the 20 self-stated buyers average 4.15 and name the one-time model — PAY_ONETIME_PRAISE 14 (4.71): 'I hate apps that require a subscription… Best 3.99 I've ever spent'; 「Så skönt att det går att köpa appen för en engångssumma!!!」; 1 of 151 objects to the amount against 23 objecting to how it was revealed; no refund, cancellation or regret exists — 'Keep the one-time price; stop hiding it'.")
ext("C147", " Report 74 (Habit Check Calendar): the trial is survivable when disclosed and the product lands — five 5★ met it and converted or shrugged ('I was using it without realising you have to pay after a week — but it was so good I paid'); several bought immediately (「即購入」) — 'the buyers were never the ones who needed persuading over a week'.")
ext("C094", " Report 74 (Habit Check Calendar): a 3★ whose entire content is that the app asked for a rating again the day after they rated — 'the review-prompt logic is directly manufacturing mediocre ratings'; §8.1 #5 never re-prompt a user who has rated.")
ext("C059", " Report 74 (Habit Check Calendar): 'The undeletable tab was the drawback that had me hesitating on buying. I sent a request through feedback… an update made them deletable, so I bought it immediately!' — 'a specific defect, fixed, converts a hesitant user at full price'; one bought purely to thank the developer.")
ext("C254", " Report 74 (Habit Check Calendar): glanceability 21 (13.91%, 4.95; UX_OVERVIEW 9, all 5★) — a week × every habit on one screen with no scrolling: 'There are lots of apps that fill in coloured blocks, but those take space per item so you can't see everything without scrolling. This app doesn't have that problem' — the product's differentiator.")
ext("C012", " Report 74 (Habit Check Calendar): the weekly grid is the unit people praise (5), and a monthly view is the third request (6) — 「月ごとの表示機能」 named as an immediate-purchase condition.")
ext("C172", " Report 74 (Habit Check Calendar): the memo written on the check cell itself (9, 4.67) — 'The memo isn't tucked away, it's on the check itself, so when you scan back you don't have to open them one by one… the memo usability really is one of a kind'.")
ext("C178", " Report 74 (Habit Check Calendar): 'It doesn't reward you for streaks, or show you stats, or remind you to do anything. You don't even enter goals into the app. Everything else I tried failed at one of these points… but for what I need it's perfect' — UX_NO_PRESSURE 3 (5.00); simplicity 65 (43.05%) — do not add streaks, goals, nagging or complexity.")
ext("C006", " Report 74 (Habit Check Calendar): 「シンプルで使いやすい」 as a review title five times; UX_SIMPLE 36 with no 1★; competitive wins are all against apps described as 'overly complicated'.")
ext("C103", " Report 74 (Habit Check Calendar): medication adherence (5) — a dose titrated every two weeks tracked as 20 / 40 / 100 mg rows ('I've safely reached and held the final dose') — makes the tracker 'a clinical-adjacent record'; locking it behind a paywall is 'a materially different act from locking a feature'.")
ext("C042", " Report 74 (Habit Check Calendar): health uses 9 (medication 5, diet 4, ADHD / rehab 2), all Japanese.")
ext("C033", " Report 74 (Habit Check Calendar): both restore failures had paid — a tablet upgrade that did not appear on the phone (no support contact found) and 'Doesn't let you transfer purchases from one OS to another. Waste of money' (1★) — 'the most costly review type there is'.")
ext("C271", " Report 74 (Habit Check Calendar): a one-time purchase that will not move between iOS devices or from Android to iOS while the listing promises cross-device and cross-OS backup.")
ext("C030", " Report 74 (Habit Check Calendar): 7 say sync does not work, one Korean reviewer says iCloud sync links her devices, the listing claims cross-device restore — 'Determine which is true, then fix the capability or the discoverability'.")
ext("C261", " Report 74 (Habit Check Calendar): colour control is the largest request (10, 6.62%) and is semantic — colour-coding weight thresholds and exercises; more than the current 8 checkmark colours.")
ext("C256", " Report 74 (Habit Check Calendar): a blank cell is ambiguous — ○ / ✕ / △ marks would separate 'didn't do' from 'forgot to log' (mark types 5).")
ext("C075", " Report 74 (Habit Check Calendar): three could not find how to start (the '+'); onboarding complaints are about absent guidance, never complexity.")
ext("C034", " Report 74 (Habit Check Calendar): three data-loss reports inside 48 hours after an October 2022 update, never recurring — yet in January 2024 a buyer withheld a star purely because of them: 'Old data-loss reviews keep costing stars long after the bug is gone'.")
ext("C231", " Report 74 (Habit Check Calendar): Japan's 103 text reviews are 3.27% of its 3,151 ratings and carry a 24.27% 1★ share against 3.11% public; JP written 3.49 vs rest of world 4.31 is 'engagement depth, not national sentiment' (27.08% of non-JP reviews are sentiment-only; every churn, defect and friction report is Japanese); Brazil holds 100 public ratings but 4 short reviews.")
ext("C062", " Report 74 (Habit Check Calendar): Japan is the home market — 68.21% of reviews and a public base 25× the next storefront — and its risk concentration (grievance 31.07% vs 8.33%); the non-Japanese trial grievances show the disclosure problem 'travels across language and storefront'.")
ext("C027", " Report 74 (Habit Check Calendar): emoji-search keywords stay English under a Japanese locale, raised by a paying customer — 「有料なのですから、対応お願いします」; a shorter home-screen app name requested.")
ext("C077", " Report 74 (Habit Check Calendar): a 5★ Russian user cannot find how to pay — 「Кааак оплатить???????」 — 'Full intent, zero friction tolerance, no sale'.")
ext("C214", " Report 74 (Habit Check Calendar): 'Excel would do this' — PAY_FEATURES_THIN 4 (1.75), three of four written while angry about the trial.")
ext("C085", " Report 74 (Habit Check Calendar): a user objects that cloud backup contradicts the listing's on-device privacy claim.")
ext("C023", " Report 74 (Habit Check Calendar): a widget requested 2023 → 2026 while the listing now claims widgets — possibly discoverability.")
ext("C008", " Report 74 (Habit Check Calendar): notifications were absent and requested in 2023–24 ('有料でもいいので' — 'even if paid'), then praised as present in 2026.")
ext("C073", " Report 74 (Habit Check Calendar): row reordering (4) named as the thing blocking one purchase — possibly already available via long-press.")
ext("C048", " Report 74 (Habit Check Calendar): enter numbers, counts or durations instead of a check (2) and more than one check a day (2).")

M = {
 "R74-001":["C254","C178","C003"], "R74-002":["C231"], "R74-003":["C231"], "R74-004":["C181","C218","C104"], "R74-005":["C193","C176","C204","C020","C103"],
 "R74-006":["C104","C181","C002"], "R74-007":["C191","C181"], "R74-008":["C003","C004","C182"], "R74-009":["C113","C003"], "R74-010":["C181","C147"],
 "R74-011":["C236","C152","C193"], "R74-012":["C006","C254","C172"], "R74-013":["C178","C157","C007"], "R74-014":["C103","C042"], "R74-015":["C059","C005"],
 "R74-016":["C003","C031","C209"], "R74-017":["C033","C271","C030"], "R74-018":["C231"], "R74-019":["C231","C094"], "R74-020":["C214","C085","C077","C036"],
 "R74-021":["C075","C094","C256","C223"], "R74-022":["C261","C030","C012","C023","C256","C073","C008","C048"], "R74-023":["C034","C031"], "R74-024":["C147","C002"], "R74-025":["C077","C003","C033"],
 "R74-026":["C231","C062"], "R74-027":["C231","C062"], "R74-028":["C027"], "R74-029":["C062","C027"], "R74-030":["C002","C008"],
 "R74-031":["C193","C181","C236","C094","C003","C178"], "R74-032":["C231","C147"], "R74-033":["C181","C218"], "R74-034":["C104","C191","C193"],
}
cards = [json.loads(l) for l in open("Tools/prd_ledger/74/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/74/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; {len(null)} unattached: {null}")
print("unbacked:", [x["id"] for x in C.values() if "Report 74" in x["statement"] and not any(k.startswith("R74-") for k in x["cards"])])
