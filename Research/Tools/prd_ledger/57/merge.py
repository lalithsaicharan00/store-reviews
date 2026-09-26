"""Stage 3 merge for report 57."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C275", "dont", "Never gate the core create action behind an ad — an interstitial at setup is the churn engine, and an ad that fails to load must never block creation",
    "Report 57 (DayStamp): a free tier that requires watching a full-screen interstitial to create a habit (from Jan 2021; 5 seconds in 2021, 29–30 seconds from Sep 2023) is the single most destructive mechanic — ads 47 of 779 (6.03%, mean 2.234, half of them 1★), 26 naming the creation gate (2.154), and 20 of the 25 reviewers who state they deleted the app (80%) name ads, against zero stated deletions for crashes or data loss: 'A full screen ad after just creating one habit? Wow, immediately uninstalled'; 'The developer is losing a lot of app sales because the full screen ads are so horrible that you will stop using the app before finding out if you like the functionality'; an ADHD user 'as soon as I made a single activity scheduled it gave me an add. Literally distracted me before I could get familiarized with the app'. From 2024 the gate started failing — 8 reviewers (7 since 2024, latest 24 Aug 2026) could not create a habit at all because no ad loaded ('Can't add a task - no ads to show'; 'seven ads to add three goals… I got angry trying to build good habits and deleted it') — 'a monetization mechanic that can hard-block the product's core action is a reliability bug, not a pricing decision'. Six reviewers who tolerate ads all gave 5★ and all describe them as short and confined to creation ('survivable at 5 seconds and not at 30'); ads run 9.20% of non-Korean reviews vs 2.48% Korean and 15.15% of US reviews, where 8 of 10 uninstalls blame ads. Options the report supports: back to ~5 seconds, move to a session boundary, or gate after the nth habit rather than the 3rd–4th. Related: [[C269]] (hijacking ad mechanics), [[C246]] (no ads), [[C240]] (never on the completion moment), [[C147]] (use before pay).")

ext("C001", " Report 57: the free tier was tightened silently and repeatedly — 'At first unlimited habits were free but now only three are for free?'; multiple daily check-ins became Premium ('did daily check-in suddenly become a paid feature? There was no announcement'); a daily-goal interval removed for a years-long user; free data retention cut to 30 days — monetization_model_change_complaint 10 (mean 1.700, the lowest with n ≥ 5), 8× over-indexed in 2★ reviews from the oldest users; monetisation friction rose 5.18% → 10.56% → 23.47% of reviews across eras as the mean fell 4.38 (2022) → 3.30 (2026).")
ext("C002", " Report 57: the three lowest-rated families are all monetisation mechanics — churn 1.593, ads 2.234, paid-user trouble 2.528 — while UX praise sits at 4.753; outside Korea people complain about what the app costs, inside Korea about what it broke.")
ext("C003", " Report 57: a one-time lifetime Premium (₩9,900 → ₩29,000; ¥1,600 → ¥4,500; $13 → $30–35) was the purchase reason for 8 (4.875, 6 non-Korean, 4 US — 'Better than the apps that charge hundreds of dollars a year'; 'charging monthly for a simple calendar or diary seems abusive'), then a subscription appeared in 2025–26 and a lifetime buyer was asked to subscribe ('DO NOT BUY IT').")
ext("C004", " Report 57: price_too_high 20 — 14 non-Korean (8.05%) vs 6 Korean (0.99%); Japan 7 of 26 (26.92%) after ¥1,600 → ¥4,500 ('I was going to buy at around ¥300'); reviewers name ¥2,000 and 'under ₩20,000'.")
ext("C005", " Report 57: 69 (8.86%, 4.884) settled here after trying the category ('I'm a habit-tracker nomad, tried over ten and settled here') — collapsing from 10.36% of 2019–21 reviews to 4.23% of 2024–26.")
ext("C006", " Report 57: UX praise 198 (25.42%, 4.753) in the same words for seven years (깔끔, 심플, 직관적) — 'Please don't add complexity — keep this leanness'; 'Other apps tried to do way too much'; §8.5: read the 267 requests as settings, not surface.")
ext("C009", " Report 57: dark mode Premium-gated ('shell out $13 for premium just for dark mode') against a photosensitive user; a colour picker praised by 22.")
ext("C010", " Report 57: past-date check-in went from top complaint (13, 2019–20: 'if you forget to track something you're just out of luck') to differentiator (4 praise at 5.000: 'ridiculously easy to add data for previous dates') — the one confirmed fix-to-differentiator in the corpus.")
ext("C011", " Report 57: weekly / monthly / yearly reports praised by 24 (the yearly report called unique); history of past reports requested by 11.")
ext("C013", " Report 57: cross-device is the largest unmet need in the product's history — 72 (9.24%): sync 44, iPad 21, Mac 8, backup 17 — flat across eras (29 / 28 / 27) and 84% Korean; one JP report of iCloud working (2024) against six later Korean 'it doesn't'; a Premium user in 2026 'I bought Premium and iPad doesn't seem to sync'.")
ext("C016", " Report 57: a skip / rest day shipped mid-2024 ('which I've been eagerly waiting for') but only reachable from the calendar step and still requested after.")
ext("C020", " Report 57: backup is manual Dropbox (Jan 2020) and Premium-gated — 'so you can't back up at all unless you buy — this is practically blackmail'.")
ext("C022", " Report 57: a Watch app shipped ~Mar 2020 ('moved to see it on the Watch') and hung on 'Loading…' for 26 (19 in 2020–21), then was largely fixed (0.94% of 2024–26).")
ext("C023", " Report 57: the widget tap launched the app instead of checking in from the iOS 14 rewrite (Nov 2020) until Dec 2023 — 16 reviews ('if it's a widget the check should happen right there — why is the app launching?'; 'give us back checking from the widget'), zero after.")
ext("C025", " Report 57: 'how about a two-week trial then a discount — I'd just pay under ₩20,000'; a Mexican reviewer 'please put a discount on it'.")
ext("C027", " Report 57: Japan is the most price-sensitive and least-localised storefront — 'settings has English and Korean mixed in'; 'I can't understand explanations written in English… the screen is so minimal that [features] aren't self-evident' (1★); incomplete Simplified Chinese (CN).")
ext("C029", " Report 57: listed ₩29,000 but the card was charged ₩44,000; ₩3,994 charged after a redeem code.")
ext("C033", " Report 57: 8 restore failures, all from 2024 ('I changed phones and my Premium purchase is gone'; 'after reinstalling I get ads again'); 3 whose entitlement never applied; a July 2026 release (3.1.0) broke Premium activation and restore — 8 reviews in 5 days, six 1★, one still broken on 3.1.1, externally corroborated by the release notes.")
ext("C034", " Report 57: 12 data-loss reports (8 since 2024, 6 at 1★) — 'today's update wiped all my previous data. If recovery is impossible, shouldn't you warn people before the update?'; 'I adjusted the count on one habit, saved, and every other habit's check-ins collapsed to one'.")
ext("C036", " Report 57: Korean users write support tickets in the review box — 50 direct questions to the developer (49 Korean, 8.10% vs 0.57%), mostly 5★ about existing features; support praised 2019–24 for fast KakaoTalk replies ('got a reply the moment 9am hit') then silent ('they just read it and never replied. What a waste of money'); 'the support link goes to some Asian industrial company'; the in-app bug-report form crashes on Submit; F6: a support link and FAQ where users are already asking.")
ext("C037", " Report 57: Family Sharing advertised on the listing and not working for a buyer ('I do not think it is right that they lie', MX).")
ext("C038", " Report 57: 'Display on' per-weekday filter shipped and silently ignores selections for 8 users over five years ('I set Tue/Thu/Sat and it shows every day').")
ext("C040", " Report 57: the widget is both the most-loved feature and the largest defect surface — 129 (16.56%) raise a problem: 50 won't appear or go blank (rising 3.89% → 6.67% → 10.80% by era), 25 don't reflect check-ins, 9 show a live group as 'deleted' (Apr 2024 – Dec 2025), 6 clip items; 58 of 90 defect reviews are 4–5★; 'every single update breaks the widget'; 'I have to reinstall five or six times a month'; 23 of 99 payers affected; a Premium payer considering switching over three widget layouts.")
ext("C042", " Report 57: two US ADHD reviewers disagree — one left over the ad at first setup, one calls colour coding and views 'amazingly functional for my ADHD'; a medication user asked for multiple stamps per day in 2019.")
ext("C043", " Report 57: every-N-days, monthly, yearly and month-end scheduling requested (7).")
ext("C044", " Report 57: Mac requested by 8 (all Korean).")
ext("C051", " Report 57: Android requested by 13 (all Korean) — 'please release this on Play Store so Galaxy users can use it too'.")
ext("C058", " Report 57: the only AI-discovery attribution in the corpus — 'I found it by asking GPT to recommend an app with the features I wanted' (KR, 2025); Korean word of mouth (24 advocacy).")
ext("C059", " Report 57: seven of the ten largest early complaints were fixed (streaks, backup, Watch, custom widget restored after complaints, widget tap, keyboard, past-date, accidental purchase) — 'Recent update is a godsend. They fixed an issue with the widgets and this app is back to being one of my top 3 apps'.")
ext("C061", " Report 57: 'you made a good app, so I bought Premium'; 'the purchase option is one-time rather than subscription, so I intend to pay soon as a gesture of thanks'.")
ext("C063", " Report 57: no trial — 'you only get the urge to go paid after actually trying it free'; 'the Premium features don't land for me — a time-limited trial would be fine'.")
ext("C064", " Report 57: lifetime roughly tripled between 2020–22 and 2024 (₩9,900 → ₩29,000; ¥1,600 → ¥4,500; $13 → $30–35) before a shift to subscription.")
ext("C065", " Report 57: 31 of 99 payers (31.31%) report a purchase-side failure, rising 12.9% (2019–21) → 27.3% → 45.7% (2024–26); payers are 12.71% of reviews but 20.8% of one-stars; in 2026 8 of 12 payers report a failure — the rising payer share may be measuring anger, not adoption; refunds rare (2 genuine) because unhappy payers write a 1★ and stay broken.")
ext("C069", " Report 57: the stamp check-in and its sound are the emotional core — stamp satisfaction 19 (4.947: 'there's hardly a reward system more intuitive and efficient than stamps filling up'), sound 5 ('a little thrill in the sound when you check a habit').")
ext("C071", " Report 57: 'people have been asking about iPad and Mac for years and you always say it's planned — is it ever actually happening?' — 6 told 'planned', never shipped.")
ext("C073", " Report 57: 27 could not find how to delete or edit a habit though the function exists ('How on earth can you make a habit app and not be able to delete the habits'; 'I got angry and deleted the app'; 'I almost threw my phone') — a user documented it publicly; 'it should be a clear option when viewing the habit detailed view'.")
ext("C075", " Report 57: onboarding_no_guidance 23 (18 KR, 4 JP) and 65 Korean reviewers (10.74%) asking for help rather than reviewing — an in-app FAQ answering the five most-asked review questions.")
ext("C080", " Report 57: dark mode Premium-gated (US) against a photosensitive user's accessibility need; white text on a white background with Premium themes.")
ext("C092", " Report 57: price objection 8.05% outside Korea vs 0.99% inside, Japan 26.92% — three reviewers on three continents independently propose a cheaper tier of ad removal + groups + backup (~¥2,000), one a monthly plan.")
ext("C101", " Report 57: a big confetti pop-up on check-off 'gives me ALL the dopamine' with no penalty for missing.")
ext("C104", " Report 57: none of the tier changes was announced — 'there wasn't even an announcement — what's going on?' — F7: an in-app changelog before the next tier change.")
ext("C141", " Report 57: iPad-native layout requested by 21 (18 Korean) — cheaper than full sync.")
ext("C142", " Report 57: an AI habit-suggestion feature shipped in 2025 and both reviewers who mention it cannot find it; a Shortcuts 'Check-in ID' exists undocumented.")
ext("C143", " Report 57: multiple check-ins per day requested from 2019 ('stamping three or four times a day, like for medication'), shipped as 'goal', capped at 5 ('I need 10'), then tier-gated — producing the three angriest change complaints (24 requests).")
ext("C147", " Report 57: new users who hit the creation ad 'stop using the app before finding out if you like the functionality'.")
ext("C171", " Report 57: dark mode paywalled against photosensitivity.")
ext("C172", " Report 57: notes allowed only on successful check-ins — 9 ask across six years and three languages to write why they failed ('I want to write down why I couldn't do it on the days I failed').")
ext("C175", " Report 57: 'an update broke it' is constant for seven years (update_regression 59, 7.57%) — a Sep 2020 release broke the note keyboard (21 reviews in three days, mostly still 5★) and a Jun 2020 release stopped launch (8); 'every update breaks something that worked. Please just leave it alone'.")
ext("C176", " Report 57: free-tier history cut to 30 days while backup is Premium — 'in the end I learned for the first time that without paid Premium, backup and recovery are impossible'.")
ext("C186", " Report 57: 'I paid for the premium and now it asks for subscription??! DO NOT BUY IT' (HK, 1★, Jul 2026) — §8.2: an explicit, published grandfathering policy; 'One public DO NOT BUY IT on the storefront costs more than the subscription it was protesting'.")
ext("C196", " Report 57: 2★ reviews concentrate the oldest users hit by silent tier changes (long_tenure_user 10.3% vs 2.95%).")
ext("C208", " Report 57: photo attachment shipped but capped at 3 even with Premium (9 request more).")
ext("C216", " Report 57: 'This is the only habit-building app that didn't make me feel like a failure for missing a day'; a detailed proposal asks for a skipped / failed distinction to keep it that way.")
ext("C218", " Report 57: 'I bought Premium and nothing differs from before — I can't use the features shown in the screenshots'; Family Sharing advertised but not delivered.")
ext("C228", " Report 57: a Sep 2020 update stopped the note keyboard appearing (21 of 22 reviews in three days).")
ext("C262", " Report 57: backup and restore gated behind Premium while 12 users lost data — §8.2: 'Gating recovery behind a purchase converts a bug into a grievance'; at minimum an automatic local export or a one-time free restore after detected loss.")
ext("C274", " Report 57: 'I tapped to see what Premium was, pressed OK to close the sheet, and it bought it' — 6 accidental purchases (2019–2023), all refund requests.")
ext("C231", " Report 57: the same product shows three market problems — Korea (tenured base worn down by regressions), the US (top-of-funnel lost to a 30-second ad; ads and uninstalls 15.15%), Japan (would convert at ¥2,000, converts at zero at ¥4,500).")

M = {
 "R57-004":["C002"], "R57-005":["C175","C228"], "R57-008":["C275","C147"], "R57-009":["C275"], "R57-010":["C040","C065"], "R57-011":["C065","C033","C218","C037"],
 "R57-012":["C033","C175","C186"], "R57-013":["C013","C141","C044","C020"], "R57-014":["C006"], "R57-015":["C005"], "R57-016":["C036","C075","C073"],
 "R57-017":["C001","C104","C186"], "R57-018":["C004","C092"], "R57-019":["C033","C275","C040","C013","C073","C036","C104","C092","C006"],
 "R57-021":["C142","C056"], "R57-022":["C036"], "R57-023":["C034"], "R57-024":["C022"], "R57-026":["C262","C020"], "R57-027":["C176","C001"], "R57-028":["C143","C001"],
 "R57-029":["C080","C009"], "R57-030":["C063"], "R57-031":["C064"], "R57-032":["C029"], "R57-033":["C218","C037"],
 "R57-036":["C275"], "R57-037":["C275"], "R57-038":["C275","C231"], "R57-039":["C040"], "R57-040":["C023"], "R57-041":["C175","C022"], "R57-042":["C034","C262"],
 "R57-043":["C038","C142"], "R57-044":["C075","C073"], "R57-045":["C073","C142"], "R57-046":["C010"], "R57-047":["C171","C080"], "R57-048":["C036"], "R57-049":["C071"],
 "R57-051":["C274"], "R57-052":["C013","C141"], "R57-053":["C143","C001"], "R57-054":["C172"], "R57-055":["C141","C044","C051"], "R57-056":["C043","C016","C050","C208"],
 "R57-057":["C006"], "R57-058":["C005","C021"], "R57-059":["C069","C011"], "R57-060":["C216","C101"], "R57-062":["C058"],
 "R57-063":["C040","C013"], "R57-064":["C065"], "R57-065":["C004","C092","C025"], "R57-066":["C001","C196"], "R57-067":["C275","C065"],
 "R57-070":["C147"], "R57-071":["C246","C040","C020"], "R57-072":["C061"], "R57-073":["C003"], "R57-074":["C004"], "R57-075":["C065","C033","C218"], "R57-076":["C065","C212"],
 "R57-077":["C033","C186","C175"], "R57-078":["C063","C092"], "R57-079":["C004","C092"], "R57-080":["C065","C040"], "R57-081":["C077"], "R57-082":["C274"], "R57-083":["C005","C040"],
 "R57-085":["C036","C013","C051","C044","C141"], "R57-086":["C275","C042"], "R57-087":["C004","C027","C075"], "R57-089":["C275","C062"], "R57-090":["C231"], "R57-091":["C231"],
 "R57-093":["C001","C002"], "R57-094":["C275"], "R57-095":["C040","C034"], "R57-096":["C005"], "R57-097":["C059"], "R57-098":["C013","C071"], "R57-099":["C065"], "R57-100":["C175"],
 "R57-101":["C033","C036"], "R57-102":["C033"], "R57-103":["C040","C038"], "R57-104":["C073","C036","C075"], "R57-105":["C104"], "R57-106":["C275"], "R57-107":["C186","C003"],
 "R57-108":["C013","C141"], "R57-109":["C092"], "R57-110":["C262"], "R57-111":["C275","C063","C092","C104"], "R57-113":["C006","C069","C216","C186"], "R57-114":["C059"],
}
cards = [json.loads(l) for l in open("Tools/prd_ledger/57/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/57/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; {len(null)} unattached")
print("unbacked:", [x["id"] for x in C.values() if "Report 57" in x["statement"] and not any(k.startswith("R57-") for k in x["cards"])])
