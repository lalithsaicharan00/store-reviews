# -*- coding: utf-8 -*-
"""Stage 3 merge for report 70 (Habit: Daily routine tracker / 継続する技術, bondavi Inc.)."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C289", "must-have", "An app with a personality voice needs one 'quiet mode' switch — encouragement lines, jokes and badges to plain neutral text — while the voice stays the default",
    "Report 70 (Habit / 継続する技術, 2,290 reviews): the daily stick-figure encouragement line is the second most-praised thing in the app (PR_COMMENTS 428, 18.69%, mean 4.93; many continue 'in order to see tomorrow's line'; 'For someone starved of praise like me, this feature is truly the best'), and the same voice produces the harshest reviews — tone and notification complaints 14 (0.61%, mean 2.50), 11 of them from 2023: 「これじゃ893と変わらないんですけど。」 ('no different from the yakuza', 18 votes); 'The jokey tone is way too cringey'; 'The cheerleading energy and jokiness give me goosebumps'; a flippant 'only when you reeeeally need to' warning; 'the badge makes me feel blamed all day and weighs on me' (5★); a long-term user: 'please let me switch the encouragement comments fully off'; the audience includes depression, ADHD and binge-eating recovery (USE_WELLBEING 25, mean 4.92) — 'a pushy tone that motivates one user can shame another'; §8.3: one setting that switches the encouragement line, the 'are you sure' jokes and the badge to neutral text, keeping the voice as default. Related: [[C095]] (neutral tone on failure), [[C123]] (notifications finely controllable), [[C157]] (guilt mechanics optional), [[C117]] (mascot / companion).")
add("C290", "do", "Guide every new goal down to something doable on a bad day — a setup that asks 'can you really do that in 5 minutes?' is a feature users thank",
    "Report 70 (Habit / 継続する技術): the setup flow pushes goals to five minutes or less and reviewers praise the question itself — 'I was really grateful that the app itself asked me, can you really do that in 5 minutes?'; 'just sit at the desk' (that reviewer now studies about two hours a day — the small goal overflows); PR_SIMPLE 448 (19.56%, 4.90), PR_CONCEPT 262 (11.44%, 4.87: a goal small enough for a bad day, one focus, a visible 30-day end, a one-tap record); outcomes 992 (43.32%, 4.92) including 299 self-described chronic quitters ('三日坊主') who finally continued; the most-voted review (354 votes): 「信じてください。続きます。」 ('Believe me. It sticks.'); §8.9 keep the guided setup that shrinks goals. Related: [[C006]] (stay minimal), [[C203]] (user authors the routine), [[C222]].")

ext("C222", " Report 70 (Habit / 継続する技術): the purest defended cap — one goal at a time, free, by design (US listing: 'the app only allows you to set one goal at a time'); praised by 148 (6.46%, mean 4.87) and 28 (ONE_GOAL_CONVERT) say they resented it and came to agree ('At first I was saying let me add another goal!, but as I kept going I came to think this is how it should be'); the request for more (REQ_MULTI 44, mean 4.39) is growing (4.7% of 2025–26) and is narrower than 'many habits' — keep a completed habit while starting the next; reviewers volunteer the valve themselves: unlock a second goal only after a first 30-day cycle.")
ext("C227", " Report 70 (Habit / 継続する技術): 'Once you complete 30 days and start a new habit, the old habit is no longer notified' (3★) — §8.5: after a cycle offer 'keep tracking this quietly' beside 'set the next goal', graduated habits kept as a low-key streak while one goal stays active; measure 60- and 90-day continuation, not goals created.")
ext("C007", " Report 70 (Habit / 継続する技術): here the habit cap is one and free — a design, not a monetization lever — and it is defended by the reviewers it limits (148 praise vs 44 asking for more).")
ext("C006", " Report 70 (Habit / 継続する技術): 'The product works by subtraction: one small goal, one tap, thirty days' — PR_SIMPLE 448 (19.56%) in every era; 'At first I thought it was hard to use, with too many restrictions, but I realised they are firmly based on the maker's philosophy of how to keep going'.")
ext("C117", " Report 70 (Habit / 継続する技術): a stick-figure character shows a different encouragement line after each tap and a reminder says 「やったれ！」 — PR_COMMENTS 428 (18.69%, 4.93), PR_HUMOR 106 — the retention mechanic people name after simplicity; the free lines repeat every 30-day cycle and reviewers notice (REQ_MORE_COMMENTS 21).")
ext("C095", " Report 70 (Habit / 継続する技術): the jokey voice reads as shaming to some — 'the badge makes me feel blamed all day and weighs on me'; 'The cheerleading energy and jokiness give me goosebumps' — on an audience that includes depression and ADHD recovery.")
ext("C123", " Report 70 (Habit / 継続する技術): notifications that continue after being switched off ('I definitely turned notifications off, yet they keep coming', 1★), remain for deleted goals and duplicate on a new cycle (BUG_NOTIF 38, 1.66%, mean 3.42); §8.2 honour notifications-off, allow weekday / weekend reminder times and later edits (REQ_NOTIF_EDIT 10).")
ext("C039", " Report 70 (Habit / 継続する技術): missing, duplicated and phantom reminders across 2017 → 2026 (BUG_NOTIF 38) against 203 reviews crediting the reminder (PR_NOTIF, 4.84) — 'The second notification arrived at a moment as if it had seen through my laziness'.")
ext("C230", " Report 70 (Habit / 継続する技術): the recording tap is lost — tapping the ring shows the undo hint instead of recording ('A pop-up saying cancel with the top-right button appears; when I reluctantly delete it I'm back to day one'; BUG_INPUT 20, 2017 → 2026), counts stick at 7 or 4, and 'fairly often, wipes out the previous day's record' (BUG_COUNT 12, BUG_RESET 7); defects are in 48% of 1★ — 'For a product whose whole promise is an unbroken record, a lost day is the worst possible failure'; §8.1: log every tap so a lost day can be restored.")
ext("C034", " Report 70 (Habit / 継続する技術): 'my five minutes of effort couldn't be recorded and went to waste' (1★) — a lost check-in is lost data in a streak product.")
ext("C038", " Report 70 (Habit / 継続する技術): no date is shown on the ring — 'because no dates are shown, from about day 3 I lost track of whether I'd recorded or not, got confused and uninstalled'; 'unrecorded' flags on unscheduled weekdays; §8.1: show the date being recorded on the ring.")
ext("C170", " Report 70 (Habit / 継続する技術): the previous day is recordable until 3 a.m. — praised as grace (PR_GRACE 41) and by a night-shift worker ('choosing yesterday or today after midnight is welcome for night workers'), yet late studiers and shift workers get caught ('if I record at 15:00 one day, I can't record at 10:00 the next'; NEG_DAYBOUNDARY 11, REQ_DAYBOUNDARY_SET 6) — Japan's specific rule friction.")
ext("C016", " Report 70 (Habit / 継続する技術): a two-day-miss reset with no pause — 'sometimes you can't do it when you're unwell' (1★); 「生理が来ると、2日くらいお休みしたい人も中にはいるのです。」 (period); a school trip; REQ_PAUSE 10; §8.6: a limited honest rest day (e.g. two per cycle) plus an optional strict mode — 'Both camps have existed since 2018, so a single rule will keep losing one of them'.")
ext("C157", " Report 70 (Habit / 継続する技術): the reset divides users — PR_RESET_TENSION 40 value the discipline; a March 2018 update removed the automatic reset (6 welcomed it, 13 asked for it back as late as 2024: 'For some people motivation drops sharply without the reset'); the answer is an option in both directions, not one rule.")
ext("C216", " Report 70 (Habit / 継続する技術): finishers want to keep counting past the fixed 30-day cycle ('I want to see how far I can extend the record beyond 30 days!'; REQ_PERIOD 13); the same 2018 update removed a 90-day option (NEG_90_REMOVED 3).")
ext("C043", " Report 70 (Habit / 継続する技術): strength-training users — rest days are part of training, so a daily rule does not fit (REQ_FREQ 8).")
ext("C023", " Report 70 (Habit / 継続する技術): some users keep the habit and lose the app — 'I couldn't even keep up opening this app every day' (12 votes); 'This is no different from a game's daily login bonus'; widget requests (17, 0.3% → 2.4% of eras) ask for the goal to be visible without opening the app (§8.8).")
ext("C252", " Report 70 (Habit / 継続する技術): record from the notification (REQ_NOTIF_ACTION 1) as part of §8.8 — users 'are lost at the open app step'.")
ext("C097", " Report 70 (Habit / 継続する技術): a patronage model — 'completely free; in-app purchase is only for people who want to support us' — with 39 framing payment as support and explicit asks for a repeatable small tip ('Please add a way to donate ¥100 at a time, as often as I like'; named thresholds ¥100–300, ¥500), a 'watch an ad' button as non-monetary support, and two buying the developer's book instead; a donation link named in 23 reviews was intermittent (not accepted in 2020); §8.7: a repeatable ¥100–300 tip or one-time pack beside the monthly plan.")
ext("C061", " Report 70 (Habit / 継続する技術): the only paid item is an optional message pack named 「無駄機能」 ('useless feature') — 44 reviews name it; 54 bought (mean 4.76), support-the-developer lift 15.22×, developer-bond among 35.19% of buyers; 90 more say they will ('after 30 days', 'when I have money'); 'I felt guilty about using it for free'; 'This app doesn't smell of money at all'.")
ext("C137", " Report 70 (Habit / 継続する技術): the purchase moment users choose is a completed 30-day cycle — 22 of 54 purchasers report a streak ('I kept it up for 30 days, so I bought the useless feature'; 'I'll buy the useless feature if I last a month'); §8.7: offer the support prompt there.")
ext("C003", " Report 70 (Habit / 継続する技術): the add-on moved from a one-off ¥960–980 (2017–2021) to monthly (first described 2022-05-15) — 'it seems it used to be a one-off purchase and has changed to monthly, which is a shame'; 'a one-time purchase option would be nice too'; explicit purchases fell from 3.7% to 1.6% of reviews across that change (directional).")
ext("C064", " Report 70 (Habit / 継続する技術): '¥980 is far too much. I'd happily pay around ¥300'; 'It's ¥980 a month as of April 2023, which feels a bit expensive'; MON_PRICE_HIGH 20 and MON_NO_PAY 17 (students, minors: 'my family says no in-app purchases').")
ext("C285", " Report 70 (Habit / 継続する技術): 「しかも誤課金しやすい画面。970円も誤課金した。」 ('the screen makes mis-purchases easy. I mistakenly paid ¥970'); 'I couldn't work out how to turn the useless feature off' then charged ¥960; 'a sudden demand for money' — 'close to fraud'; §8.4: explicit confirmation on the add-on and a clear way to turn a pack off.")
ext("C127", " Report 70 (Habit / 継続する技術): the add-on kept being advertised after it was bought (NEG_UPSELL_NAG 5, mean 1.40); 'I can't tell the difference between the comments before and after paying'.")
ext("C059", " Report 70 (Habit / 継続する技術): 'It's also the first app I've seen that replies to every review one by one' — U_DEV_BOND 364 (15.90%, 4.92), release notes written as essays read as content (PR_RELNOTES 28); the bond is what purchases run on, and it is fading (PR_DEV 18.5% → 5.2% of eras); unanswered support mail in 5.")
ext("C060", " Report 70 (Habit / 継続する技術): 78 reviews (3.41%, 4.90) use or found the developer's other apps — from 2018-06 the sister app 「集中」 ('Focus'); cross-use peaked at 6.7% of 2020–22 reviews; one multi-app user warns 'after a few months, all of them start producing an absurd run of bugs'.")
ext("C246", " Report 70 (Habit / 継続する技術): 「広告なし。（そのため、清々しいほど儲かりません）」 ('No ads. That is why we make refreshingly little money') — PR_FREE 149 (6.51%, 4.87) rising 1.4% → 11.2% of eras as reviewers contrast ad-supported and subscription-first apps (60 comparisons).")
ext("C085", " Report 70 (Habit / 継続する技術): 'collects no personal data' named as a reason to trust (PR_PRIVACY 4); §8.9 keep no data collection.")
ext("C103", " Report 70 (Habit / 継続する技術): depression, ADHD, anxiety, autonomic disorders and binge eating named with recovery stories (USE_WELLBEING 25, 4.92: 'My depression has eased and I've been able to return to work'; 'day 15 since the stress-driven late-night binge eating I'd suffered for about eight years stopped') — the reason a quiet mode matters.")
ext("C094", " Report 70 (Habit / 継続する技術): an in-app 'rate this app' menu item and milestone-day reviews — the corpus agrees with the public rating (4.73 vs 4.78 on 53,106) and over-represents people for whom it worked.")
ext("C058", " Report 70 (Habit / 継続する技術): new acquisition routes in 2025–26 — a YouTube appearance and an AI assistant's recommendation ('I asked an AI to recommend apps like this and picked from those'); the developer's book appears alongside the app.")
ext("C062", " Report 70 (Habit / 継続する技術): a single-market app — Japan 2,259 of 2,290 reviews and 53,106 public ratings — with localised Chinese and English listings rated 4.88–4.96 on under 100 ratings each.")
ext("C231", " Report 70 (Habit / 継続する技術): a corpus that agrees with its public rating (4.73 vs 4.78) because reviewers are mostly those who succeeded; 17 contradictions are all 1–3★ with wholly positive text.")
ext("C141", " Report 70 (Habit / 継続する技術): iPad layout / landscape requested by 13 (mean 3.92).")
ext("C022", " Report 70 (Habit / 継続する技術): 'will make it 5★ if Apple Watch is supported' (REQ_WATCH 5).")
ext("C012", " Report 70 (Habit / 継続する技術): a History of completed cycles is praised (PR_HISTORY 31) while others want a calendar view (9) and a done list / time log (7).")
ext("C172", " Report 70 (Habit / 継続する技術): a note per check-in requested (REQ_MEMO 7, mean 4.43).")
ext("C017", " Report 70 (Habit / 継続する技術): a passcode lock exists and is valued (PR_PRIVACY 4).")
ext("C101", " Report 70 (Habit / 継続する技術): reviews are written to mark milestones — streaks of 500 days, 1,000 days, a year or more; OUT_STREAK 617 (26.94%).")
ext("C071", " Report 70 (Habit / 継続する技術): 2023 is the lowest year since launch (4.56 on 108 reviews), the year tone / notification complaints reached 7 and after the add-on went monthly; 2024 recovered to 4.75.")

M = {
 "R70-001":["C062","C246","C006"], "R70-002":["C231"], "R70-003":["C094","C231"], "R70-004":["C006","C290","C222"], "R70-005":["C290","C101"],
 "R70-006":["C117","C039"], "R70-007":["C289","C095","C123","C103"], "R70-008":["C222","C227"], "R70-009":["C016","C157","C043"], "R70-010":["C157","C216","C104"],
 "R70-011":["C170","C038","C216"], "R70-012":["C230","C034","C038","C031"], "R70-013":["C123","C039"], "R70-014":["C097","C061","C137"], "R70-015":["C061","C127"],
 "R70-016":["C064","C003","C097"], "R70-017":["C285","C127","C212"], "R70-018":["C059","C060","C036"], "R70-019":["C246","C085","C061"], "R70-020":["C103","C042"],
 "R70-021":["C023","C252"], "R70-022":["C006"], "R70-023":["C222","C141","C022","C013","C012","C172"], "R70-024":["C231"], "R70-025":["C231","C230"],
 "R70-026":["C062","C027"], "R70-027":["C062","C027"], "R70-028":["C003","C059","C058","C104"], "R70-029":["C071","C059"], "R70-030":["C003"],
 "R70-031":["C222","C289","C007"], "R70-032":["C289","C123","C095"], "R70-033":["C230","C123","C289","C285","C227","C016","C097","C023"], "R70-034":["C170","C012","C172","C017"],
 "R70-035":["C061","C097"], "R70-036":["C071","C289","C003"],
}
cards = [json.loads(l) for l in open("Tools/prd_ledger/70/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/70/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; {len(null)} unattached: {null}")
print("unbacked:", [x["id"] for x in C.values() if "Report 70" in x["statement"] and not any(k.startswith("R70-") for k in x["cards"])])
