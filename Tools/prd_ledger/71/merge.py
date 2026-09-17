# -*- coding: utf-8 -*-
"""Stage 3 merge for report 71 (MyStreaks — Streak Tracker, formerly Streaking; Streaking LLC)."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C291", "research", "A way past the free cap that is not a payment (referral, invite, earned unlock) only works if it is shown at the wall — audit whether capped users can see it",
    "Report 71 (MyStreaks, 32 reviews): v2.58 (2024-02-28) shipped 'Unlock unlimited streaks when 10 friends join through your invite link' — a free route past the exact barrier behind every 1★ in the corpus — and no reviewer mentions it, including a 4★ still calling the cap 'the worst part' nine months later, while 7 reviewers already recommend the app unprompted; three readings (not discoverable at the paywall; ten referrals too high a bar; removed) cannot be separated from reviews; §8.1 #5: audit the referral unlock — 'a referral unlock that the most motivated advocates do not appear to know about is worth an audit regardless of which reading is true'; the cap itself was 'answered with a referral mechanic rather than a product change'. Related: [[C270]] (earned free capacity reads as generosity), [[C236]] (a limit must announce itself), [[C238]] (rewarded-ad unlock path).")

ext("C133", " Report 71 (MyStreaks): the clearest case of charging for the commodity — the paywall gates the number of streaks, 'the private, single-player counter' every free competitor gives away ('there are so many alternatives that don't make you pay when you've hit a max of 2 goals'), while the surfaces reviewers praise and competitors cannot copy — community (8, 4.88), sharing, accountability, outcomes (21, 4.95), the book and podcast (8, all 5★) — sit ungated or unclear; §8.4: 'charge for the part that is hard to copy… and stop charging for the part every free competitor already gives away'; §8.1 #1 re-cut the paywall to gate a feature, not the streak count.")
ext("C007", " Report 71 (MyStreaks): a free streak cap reported at 3 active (Jan 2023, a 5★ user 'for over 2 years'), then 2 (Nov 2023, Feb 2024), then 1 (Nov 2024) — reported by one reviewer each, so the direction is reported, not established; the cap is the whole 1★ population (3 reviews, mean 2.00 vs 4.90 for the other 29): 'For an app all about self betterment i thought it wouldn't require me to pay to have MORE THAN 2 GOALS'; the only counter-offer: 'they could make the max like 5 or 10' (4★).")
ext("C191", " Report 71 (MyStreaks): the reported free allowance shrank from 2 to 1 streak between Feb and Nov 2024 while the release notes show 'improved subscriptions' and 'Fix subscription bug'; a 4★ on the 1-streak tier pre-announces churn: 'I like this app but if I find a better one I'll definitely switch'.")
ext("C236", " Report 71 (MyStreaks): both 1★ reviewers met the cap after investing setup effort — 'i was going to make my 3rd streak and i was met with an unavoidable monthly subscription'; 'I was really excited about this app… But a paywall for more than 2 streaks?' — §8.1 #3: disclose the cap at onboarding, 'honesty about the limit before the third streak, not a change to the limit'.")
ext("C189", " Report 71 (MyStreaks): a public developer reply defending the cap as good for users drew 'Comment from creator that it encourages people to keep it simple? 🙄' in a 1★; §8.1 #4: retire that defence — 'asymmetric downside, and it is free to stop'.")
ext("C169", " Report 71 (MyStreaks): 'I feel like people cheat and just put a random number so they're on the discover feature… people still acknowledge those who have a large number of streaks' — editable streak counts ranking on a social Discover feed make the community's currency forgeable, a flaw 'independent of how many people mentioned it' that grows with the community; §8.2 #6: non-editable counts or a visible 'edited' mark on Discover.")
ext("C041", " Report 71 (MyStreaks): a streak's cadence (daily / weekly / monthly) cannot be changed after creation — the reviewer had to retire a 6-day streak and start over, and retired streaks cannot be viewed; 'Forcing a user to destroy the exact thing the product tells them never to break is a design contradiction' (open after 25 releases).")
ext("C202", " Report 71 (MyStreaks): the social layer is the most-praised surface of a streak tracker — community 8 (25.0%, 4.88), positive social union 11 (34.4%, 4.91): 'I love connecting with other Streakers on the community page'; 'it's fun to see other family member streaks and their progress (and we even have competitions sometimes too)'; 'The future of social media' — and thin to two 4★ ('the social feature needs some love'; 'a small community but still great'); community praise went quiet after mid-2023 (8 in E1, 1 in E2), so whether it retains or only delights is untested.")
ext("C015", " Report 71 (MyStreaks): sharing streaks with a spouse, family and students (SOC-SHARE 3) — 'share with friends, students and people I want to be accountable to or vice versa' (a teacher / coach use case); comment replies and posting into Groups requested or buggy (2023).")
ext("C058", " Report 71 (MyStreaks): a founder-led content channel — a book, a podcast and the founders (Jeff & Jami) — appears in 8 reviews (25.0%), every one 5★, from the first review (Feb 2021) to the last era: 'This concept, the book, and the app have done a 180 in how I see habits'; 'it wasn't until I found this App + Podcast…' — users 'already bought into the method before they open the app'; 'a durable acquisition advantage no habit-tracker competitor can replicate by shipping features'.")
ext("C239", " Report 71 (MyStreaks): 'Thank you to Jeff & Jami and their team for the great book & app!' — founder presence is praised in 4 reviews, all 5★.")
ext("C184", " Report 71 (MyStreaks): 'Great habit tracker, really unfortunate name' (4★, seven words, Jan 2024) — v2.61 (Apr 2024) 'Updated Name and Bug Fixes' renamed Streaking → MyStreaks; reviewers switch names exactly at the change — the one complaint demonstrably closed.")
ext("C094", " Report 71 (MyStreaks): no 3★ and no 2★ review exists (81.2% 5★), two US 5★ posted 38 seconds apart, an author handle 'Streaking User', a campaign-register review ending '#streakingforthewin' — consistent with in-app prompting after success moments and a founder community asking members to review; removing the 7 flagged reviews changes no headline band.")
ext("C231", " Report 71 (MyStreaks): the written corpus stops 648 days before extraction while the app shipped 9 more releases (Challenges, Persona Notifications, Journal) — 'this report describes the app as it was up to late 2024'; the silent public raters are harsher (a 2★ and two 1★ with no text); zero paying reviewers, so every monetization data point is a refusal; GB, CA, AU and VN hold ratings but no text.")
ext("C097", " Report 71 (MyStreaks): a listed tip ladder — Friend $0.99, Ally $1.99, Advocate $2.99, Endorser $4.99 — beside Premium; no reviewer mentions any of it.")
ext("C023", " Report 71 (MyStreaks): 'Home Screen widget for quick check-off… that is literally my only feedback' (5★, Apr 2023) — still absent after 25 releases, 'the cheapest item… open the longest', aligned with the most-praised mechanic, the 3-click check-off.")
ext("C264", " Report 71 (MyStreaks): the core loop reviewers praise is the tap count — 'it's a simple tap to say that you've done it, but it's so satisfying!'; '3 clicks is all it takes to update a daily streak'; 'I get a little thrill every time I check off my streaks'.")
ext("C034", " Report 71 (MyStreaks): the streak record is the asset users protect — 'I depend on it to keep track of my Streaks…that record is extremely important to me!'; streaks of 823 and 900+ days; zero data-loss, crash or login complaints in six years (thin but genuine).")
ext("C005", " Report 71 (MyStreaks): habit tracking is a commodity and reviewers say so — 'there are so many alternatives'; 'if I find a better one I'll definitely switch'; no competitor is named.")
ext("C119", " Report 71 (MyStreaks): 'the user interface can be clunky and unpolished at times. The menu can be slightly inconvenient to navigate' (ZA, 4★) beside 7 praising ease — the check-off and the navigation / social surfaces are different parts of the app; usability-test them separately.")
ext("C059", " Report 71 (MyStreaks): the rename followed a one-line 4★ complaint within 3½ months, while five of six feature requests (widget, cadence edit, retired history, Discover integrity, a larger free cap) stayed open across 25 releases.")

M = {
 "R71-001":["C202","C264","C058"], "R71-002":["C231"], "R71-003":["C231","C071"], "R71-004":["C094","C231"], "R71-005":["C007","C133","C236","C005"],
 "R71-006":["C007","C191","C291"], "R71-007":["C202","C133","C015"], "R71-008":["C169","C202"], "R71-009":["C023","C041","C015","C169"], "R71-010":["C189"],
 "R71-011":["C236","C110","C003"], "R71-012":["C291"], "R71-013":["C184","C059"], "R71-014":["C058","C239","C070"], "R71-015":["C034","C101"],
 "R71-016":["C264","C119","C034"], "R71-017":["C202"], "R71-018":["C002","C007"], "R71-019":["C231","C034"], "R71-020":["C231","C065"],
 "R71-021":["C231"], "R71-022":["C231","C023"], "R71-023":["C031","C083"], "R71-024":["C231","C015","C027"], "R71-025":["C133","C236","C189","C169","C023","C041"],
 "R71-026":["C133","C005"], "R71-027":["C058","C101"], "R71-028":["C097","C133"], "R71-029":["C041","C034"], "R71-030":["C231"],
}
cards = [json.loads(l) for l in open("Tools/prd_ledger/71/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/71/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; {len(null)} unattached: {null}")
print("unbacked:", [x["id"] for x in C.values() if "Report 71" in x["statement"] and not any(k.startswith("R71-") for k in x["cards"])])
