"""Stage 3 merge for report 43."""
import json
C = {x["id"]: x for x in json.load(open("Tools/prd_ledger/canonical.json"))}
def ext(cid, text):
    if text not in C[cid]["statement"]: C[cid]["statement"] += text
def add(cid, section, title, statement):
    if cid in C: return
    C[cid] = dict(id=cid, title=title, statement=statement, section=section, cards=[], reports=[], merged_from=[])

add("C258", "free", "A 'nag until done' repeating reminder — the one reminder shape reviewers say no other app offers",
    "Report 43: 'nag me until I'm done' repeating reminders are praised by name in 22 reviews (3.45%, mean 4.86) and reminders generally in 54 (8.46%, 4.76) — 'Best feature by far is the nag me until Im done option, which is something no other app has offered thus far'; 'HabitHub relies on good old-fashioned nagging. It's simple and effective'; 'The first time in my life I gave money to something to NAG me 😐'; 'you can set it to nag you as often as you want and don't have to stop what you are doing to turn off an alarm'. Praised in every era 2016–2025 and found excessive by one review in 638. The report calls it the product's moat and warns it is the mechanism most exposed to notification regressions on iOS updates; do not soften it into a single daily reminder.")
add("C259", "must-have", "An in-app help screen — first-run tour, searchable FAQ, per-setting explanations — for any product whose setup is richer than its daily use",
    "Report 43: no guide / tutorial / FAQ / help (9, mean 2.78) plus a learning curve (14, 3.36) — 20 reviews (3.13%) requested continuously from Feb 2017 ('There must be some tips or suggestions in start') to Aug 2026 ('I don't understand nothing') and never addressed: 'There is no help option in settings which makes at least one action I want to take impossible… I can't find instructions for this in the app, on YouTube, or through a Google search'; 'I have had to contact support twice on things that could have explained up front'; 'it took me an hour or so to figure out how to make it work… I'd pay for this if it had some adjustments in usability'. Roughly a tenth of the 29 scheduling-gap reviews ask for capabilities the app already has (custom days, timers, untimed tasks) and land as 1★ / 2★. The same product draws 123 'simple' reviews — daily use is simple, setup is not — so a help screen targets a different surface from the praised simplicity.")

ext("C001", " Report 43 (the positive case): the free tier was loosened around 2021–22 and the cap complaint went 14.1% (2021) → 0.0% (2024, 2026) while 'deceptive free' stopped entirely after Oct 2021 — the reference case for what lifting a gate does.")
ext("C002", " Report 43: a ten-year corpus where the two negatives crossed over — monetisation friction 23.1% of 2020 reviews → 0.0% of 2024 and 2026, reliability 0.0% (2016) → 23.9% (2021) → 26.1% (2026); 'the product traded one problem for another; the monetisation fix was real and complete, the engineering debt that replaced it is not being paid down'; the mean moved 4.34 → 3.90 → 3.88 by era.")
ext("C003", " Report 43: a single one-time unlock ($2.99 → $4.99) with no subscription in 638 reviews over ten years — monetisation praise (89, 13.95%, mean 4.70) outnumbers all monetisation friction (87) and is rated 2.25 stars higher, the only corpus in the series with that shape; the one-time model is the dominant purchase trigger ('If it was going to be a subscription app I was not going to bother'; 'one wanted 13 dollars a year, while another wanted 7 dollars upfront. I only paid a small $4'); a payer volunteered to pay annually to fund maintenance — the report's shape for recurring revenue is an optional supporter tier, not a gate.")
ext("C004", " Report 43: price / value praised by 57 (8.93%, mean 4.89) — 'I've tried 3 other apps that ranged from $25 to $60 per year'; 'Others… will charge double the one time payment for this as a monthly subscription!'; 'accessible to super low income people like myself'; value praise rose 3.98% → 11.04% → 10.39% by era even as the price rose $2.99 → $4.99, because the alternatives moved to subscription.")
ext("C005", " Report 43: 50 comparison winners (7.84%, mean 4.88 — 'I have checked 22 habit tracker apps'; 'I tested 5… It won for its simplicity… also the cheapest') and 22 naming alternatives — Streaks, Strides, Apple Reminders ×4, the phone calendar ×2, MyFitnessPal, paper; the only 'I left for' destinations are Apple Reminders and the built-in calendar; no reviewer in 638 leaves for a named paid competitor.")
ext("C006", " Report 43: simplicity 123 (19.28%, mean 4.86), the top theme every year for ten years and in ten languages — 'you don't have to read a bunch of flowery, condescending you can do it! messages'; 'not all illustrated with pink & blue kittens and ribbons… nor is it incessantly asking me to note my feelings' — with the distinction that daily use is simple while setup is configurable ('after a couple days you will appreciate the robust settings over the bare minimum other apps give').")
ext("C007", " Report 43 (natural experiment): a 3-item cap held 2016–~2022 produced 66 complaints (10.34%, mean 2.36), 25 of 76 one-star reviews and 16 'bait and switch' accusations ('how can anyone set up a productive day with only 3 available habits?'; 'at least 8 - 10 habits for free'); loosening it removed the theme within two years and replaced it with free-tier praise at 4.63; the cap appeared at 5★ eight times from users who found three focusing; the report: do not re-tighten.")
ext("C009", " Report 43: the widget is what makes the app work for the ADHD / accessibility segment — 'if I have to seek it out a lot of the time it's not happening. I can miss notifications, but not if it's on my Home Screen' — and is named a protected surface.")
ext("C010", " Report 43: backfilling a day after it has passed requested by 4 (mean 3.75).")
ext("C011", " Report 43: percentages, grades, streaks and the green / red calendar praised by 55 (8.62%, mean 4.82) — 'Thank you for %'s and grades. This is how my brain works… I'm actually completing it so I can stay at a 90% grade' — free.")
ext("C019", " Report 43: negative / 'avoid' habit tracking requested by 3.")
ext("C020", " Report 43: CSV / PDF export requested by 2; no export exists in a local-storage app that lost four-year histories.")
ext("C021", " Report 43: Apple Health integration requested once.")
ext("C022", " Report 43: Apple Watch requested by 12 over five years (May 2019 'Not using your app due to lack of iwatch' → Jan 2024), the listing now ships Watch, and no request appears after Jan 2024.")
ext("C027", " Report 43: all 10 language requests are non-US (4.37% of non-US reviews) — Arabic three times in fourteen months from Saudi Arabia and Oman, each capping the rating at exactly 3★ ('Nice app but it lacks Arabic support, so it deserves ⭐️⭐️⭐️'); Portuguese and Spanish requests appear answered by the listing's five languages; one 'full of spelling mistakes' (GB, 1★).")
ext("C030", " Report 43: iCloud is simultaneously the advertised backup, an undismissable error banner ('iCloud Sign in Error - I can't turn off this message'; 'Constant iCloud Error… Sloppy code') and a backup that did not restore for a payer ('lost everything even though it was backed up to iCloud') — 5 reviews, mean 1.40, none after Aug 2022.")
ext("C031", " Report 43: crash / won't open is the largest single defect (20, 3.13%, mean 2.15; 18 of 20 US) with a persistent won't-open cluster Dec 2021 → Feb 2023 recurring Dec 2025 → Apr 2026; 'after purchasing, the app crashed every single time I opened it'; 'Crashes if you have less than 500MB free'.")
ext("C034", " Report 43: data loss is the most severe and accelerating defect — 12 (1.88%, mean 2.08), 0 in 2016–18 → 7 in 2022–26 (4.55%); in July 2026 two German users four days apart lost four years of locally stored history when the UI changed ('I used HabitHub for four years and after an update my locally stored data was gone'), got immediate support replies, and had already migrated — 'If I could change anything, I would sync my data to the iCloud to be sure'.")
ext("C035", " Report 43 (counter-evidence): no account required is listed among reasons to buy ('No subscription · Very reasonable one-time purchase price · Great data privacy (no data collected) · No ads').")
ext("C036", " Report 43: support is bimodal because the intake is broken — praised by 24 (mean 4.67; a 2★ raised to 5★ after the exact fix shipped; 'requested a small new feature… added a few days later') vs 7 with no response (mean 1.29, the lowest theme) and 4 reporting the in-app feedback form itself fails ('Feedback email can not send'; 'They have a report bug feature, but that also doesn't work'); 'no response' rose 0.57% → 2.60% by era while praise stayed flat.")
ext("C039", " Report 43: an iOS 15 notification regression ran five public weeks (13 Oct – 10 Nov 2021: firing after completion, double notifications, 'I don't think the solution is to have us individually email tech support. It's clearly a bug'; a payer 'over a month and a half… no bug fix'); ghost habits — deleted habits still firing at midnight after reinstall and a new phone (2); notification bugs 15 (2.35%, mean 2.60) on the app's signature feature.")
ext("C042", " Report 43: ADHD (18, mean 4.61) and other accessibility accounts (12, 4.75; autism, depression, chronic illness, head injury, ASD, anxiety) are the fastest-growing theme (0.00% → 4.22% → 7.79% by era) and almost entirely US (24 of 25) — 'severe ADHD… complete tasks that would otherwise take hours on end — cooking, cleaning, and even applying makeup'; 'motivated me to shower for the first time in a week'; 'when I don't have the brain power to think it just tells me what to do next'; the mechanics are the multi-step timer and the widget; the listing's 'ADHD-friendly interface' claim is earned without targeting.")
ext("C043", " Report 43: scheduling flexibility is the longest-running unaddressed request (29, 4.55%, mean 3.38; Jan 2017 → Jan 2025) — intervals beyond one month ('Wish I'd known that before I paid for it'), Nth weekday ('1st Tuesday of each month'), 'X times per week' without fixed days, every other week, a due date rolling from last completion; a redesign regression made 'every 2/3 weeks' habits show every week.")
ext("C044", " Report 43: a macOS / desktop app requested by 3 (mean 4.67); the listing claims Mac (M1+) — possibly discoverability.")
ext("C046", " Report 43: Siri / Shortcuts praised by 5 (all US); one asks for Shortcuts integration.")
ext("C048", " Report 43: multiple completions per day with 0/2, 0/4 counters (water, reps) exist free and are a purchase trigger ('the 0/2, 0/4 etc feature that visually shows you how far behind you are… it made me buy it'); praised by 14 (mean 4.71).")
ext("C059", " Report 43: at least four verified cases of shipping what reviewers asked — Apple Watch (12 requests, none after it shipped), drag-to-reorder (7 asks, shipped Nov 2025), the timer music fix that turned a 2★ into 5★, and a feature 'added a few days later' (Jan 2026); three of the top four feature gaps have since closed.")
ext("C061", " Report 43: 'I purchased the premium version because I want to support the excellent privacy and pricing policies!'; 'you wouldn't do your job for free. Don't expect programmers to work for free either'; 'I wanna donate the developer'.")
ext("C062", " Report 43: a 64% US corpus where the high-spend group (79.15%) is indistinguishable from the rest (4.006 vs 4.045) and every language request comes from outside it; non-US reviewers self-report paying more (10.04% vs 6.11%, weak) and criticise the dated design more (4.37% vs 1.47%).")
ext("C063", " Report 43 (counter-case): only 4 of 638 asked for a time-limited trial because a full-featured 3-habit free tier served as one ('The free version has all the features but limits the amount of habits… try it out and if it works for you, you can upgrade as I did') — vs 14 in report 42's 3-habit-plus-paid-basics corpus.")
ext("C064", " Report 43: at $2.99 the price objection (36, 5.64%, mean 2.31) was almost entirely an objection to being stopped, not to money ('you can easily set timers on your phone for free'; 'I'm a college student so I'm ~broke~'), and it vanished with the cap.")
ext("C065", " Report 43: payers (48, 7.52%) rate 3.58 vs 4.05 and are 1.9× as likely to give 1★; 11 of 48 (22.9%) hit a defect after paying and 10 of 76 one-star reviews are payers — every one a delivery failure (re-buy after reinstall, restore failed, 'Had it for two minutes after I paid for it and it's glitching', won't open with data gone despite iCloud, a lifetime payer with no support reply, the 2025 popup regression).")
ext("C066", " Report 43: multi-step timed routines (morning routines, workouts, kids, ADHD) with background-music fade and voice prompts are a core differentiator and the mechanic the ADHD segment names most.")
ext("C069", " Report 43: 'paid for the full version because i really like the happy sound when completing tasks'.")
ext("C073", " Report 43: drag-to-reorder within time windows requested by 7 and shipped Nov 2025 ('The ability to program your day windows and reorder items in time windows is fantastic'); bulk edit across a group 1.")
ext("C075", " Report 43: 20 reviews over nine years say there is no tutorial, FAQ or help (see C259).")
ext("C078", " Report 43: 'purchase not delivered' is the most damaging pattern for a one-time product — 4 buyers got nothing ('I paid to upgrade to get the edit function, but no changes happened… Something broken in the backend??'; 'Purchase premium but still getting free trial capabilities'; 'just took my money'), one could not buy, one could not restore.")
ext("C080", " Report 43: per-habit colours / icons requested by 4 (mean 4.50); dark mode praised.")
ext("C085", " Report 43: 'Great data privacy (no data collected)' is enumerated among purchase reasons; 'I want to support the excellent privacy and pricing policies!'")
ext("C089", " Report 43: a promo-free, ad-free one-time model produced zero unexpected charges, trial traps or chargebacks in 638 reviews.")
ext("C093", " Report 43 (counter-case): the in-app upsell is never complained about; the nag is the review prompt.")
ext("C094", " Report 43: the review prompt fires 'every time I open this app', 'every 2 minutes', and to people who already paid ('Paid $3, still kept asking for review. Annoying!') — 4 reviews, mean 2.75, plus a prompt whose Submit stays greyed out; 'a rating-acquisition mechanism actively lowering the rating'.")
ext("C104", " Report 43: 'pause a habit' vanished in the 2026 update (2★) and 'every 2/3 weeks' schedules silently became weekly after the redesign (4★).")
ext("C107", " Report 43: per-habit notification sounds are 'too few' — 'hearing the same sound for every habit… mentally makes me mush all my tasks together'; 'you can't use the notification or ringtone sounds from your iPhone'; a snooze wanted (16, mean 3.94).")
ext("C112", " Report 43 (counter-case): a one-time purchase produced zero cancellation complaints; the only refund refusal was inside the EU 14-day withdrawal window.")
ext("C119", " Report 43: the Oct 2025 redesign split reviewers 4 positive / 7 negative — the negatives are a blocking journal-on-skip modal with no opt-out ('should have option to TURN OFF… the pop up is obscured by my keyboard'), a calendar header 'that takes up too much space', a removed pause button, a scheduling regression and three data losses at the moment the UI changed; the positives are reordering and the restructured routine screen; the report proposes an opt-in theme switch and a one-time 'what changed' screen instead of forced change.")
ext("C133", " Report 43: the report's experiment E3 is to surface the unlimited-habits unlock at a moment of demonstrated value (e.g. a 14-day streak) rather than at a count limit — the historic cap failed because it blocked before value was shown.")
ext("C141", " Report 43: the listing claims iPad, Mac (M1+), Vision, Watch and TV.")
ext("C142", " Report 43: roughly a tenth of scheduling complaints ask for shapes the app already has (custom days 'Monday and Wednesday's', timed tasks, untimed tasks) and land as 1★ / 2★; a Mac app is requested although the listing claims Mac.")
ext("C143", " Report 43: 0/2 and 0/4 per-day counters with hourly nagging exist and sell the app.")
ext("C147", " Report 43: 'Why not give 2 weeks fully functional, then handicap it to 3?'; 'Would have more stars if I cd test out >3 goals — Prior to paying!'")
ext("C150", " Report 43: rating prompts 'every time I open this app' and 'every 2 minutes'.")
ext("C153", " Report 43: local-only storage with optional iCloud lost users four years of history in July 2026; the report's #1 fix is iCloud backup on by default with a visible restore path and a 'last backed up' time.")
ext("C155", " Report 43: 'pause a habit' removed by the 2026 update.")
ext("C171", " Report 43: 'this app works with voiceover since I am a voiceover user' (the only screen-reader confirmation); 'The text is small, I can not see to read it!'")
ext("C172", " Report 43: journal / per-day notes praised by 9 (mean 4.44) — but a journal prompt forced on every skip in the 2025 redesign drew a 1★ from a long-time payer.")
ext("C175", " Report 43: regression after update 16 (2.51%) — 3 → 4 → 9 by era, eight of the nine recent inside Oct 2025 – Jul 2026; three updates in two days then 'I can no longer access the app… All the I spent created things are lost'.")
ext("C177", " Report 43: the purchase sheet does not say 'one time' — 5 reviewers (mean 4.20) could not tell whether $2.99 was monthly or once, three of them 5★ users trying to buy ('can't seem to figure out if the $2.99 is per month or a one time purchase.?') and one who wrote a 2★ believing it was monthly; the thing the sheet fails to state is the product's most-praised attribute.")
ext("C178", " Report 43: 'not all illustrated with pink & blue kittens and ribbons, have a psychologist's daily thought for the day baked in, nor is it incessantly asking me to note my feelings for the day'; 'you don't have to read a bunch of flowery, condescending you can do it! messages'.")
ext("C181", " Report 43: 'If it's a paid app then say so. You can only add 3 items before you have to upgrade' (1★); 16 'deceptive free' reviews (mean 1.25), zero after Oct 2021.")
ext("C183", " Report 43: a red / yellow / green time-window timeline and multi-step timers are what ADHD users name — 'when I don't have the brain power to think it just tells me what to do next'; an adult child with autism's morning routine on timers.")
ext("C186", " Report 43: a Chinese payer had to re-buy after a system reinstall (1★); 'How do I restore purchase' (1★).")
ext("C207", " Report 43: the report's #2 fix is a settings toggle for the skip-journal popup and calendar header introduced in the redesign — 'should have option to TURN OFF'.")
ext("C212", " Report 43: a refund refused inside the EU 14-day withdrawal period (DE, 1★).")
ext("C218", " Report 43: 'Not a free app. The whole app is an in app purchase'; 'Bait and switch. After 3 they make you pay' — 14 of 16 such reviews US, none after Oct 2021.")
ext("C223", " Report 43: the Done and Info buttons sat adjacent for four years and swipes were mis-read ('I was constantly marking things as done when I really wanted to mark them as skipped… so I deleted it'; 'Tap targets for your most common actions… are tiny'); undo an accidental Done requested.")
ext("C226", " Report 43: 20 reminders per day named as a cap.")
ext("C231", " Report 43: 18 of 20 crash reports are US (4.40% vs 0.87%) — more likely a reporting-behaviour artefact than a device fact, unresolvable from reviews.")
ext("C240", " Report 43: the Oct 2025 redesign put a journal prompt on every skip — 'Bad design to have to do skip every time' (long-time payer, 1★).")
ext("C246", " Report 43: no ads ever; praised by 5 (mean 4.80).")
ext("C253", " Report 43 (counter-case): the nag loop is the differentiator — user-controlled frequency ('as often as you want') is what makes heavy notification acceptable; one review in 638 finds it excessive.")
ext("C254", " Report 43: groups / profiles that can be toggled on and off (e.g. weekday vs weekend sets) requested by 4 (mean 4.25).")
ext("C255", " Report 43: 'The app is a mess, full of spelling mistakes' (GB, 1★) — localisation quality.")
ext("C256", " Report 43: a skipped vs missed distinction is part of the swipe confusion ('I was constantly marking things as done when I really wanted to mark them as skipped').")
ext("C257", " Report 43 (counter-case): reminders, including the nag, are free and the app's reason to exist; only the habit count was ever gated.")
ext("C076", " Report 43: 13 US 5★ reviews within 24 minutes on 10 Oct 2016 ('Use!!', 'Best!!', 'Helful'), three days after the first review — lifted 2016's mean 4.45 → 4.58 and the ten-year mean by 0.02; detected by timestamp clustering, not votes.")
ext("C054", " Report 43: a launch-week burst of 13 seeded 5★ reviews inside 24 minutes moved a ten-year corpus by 0.02.")

M = {
 "R43-001":["C003"], "R43-004":["C076","C054"], "R43-007":["C001","C007","C002"], "R43-008":["C002","C175"], "R43-009":["C065","C078"], "R43-010":["C003","C004"],
 "R43-011":["C258","C008"], "R43-012":["C034","C153"], "R43-013":["C039","C258"], "R43-014":["C119","C207","C240"], "R43-015":["C043","C142"], "R43-016":["C259","C075"],
 "R43-017":["C036"], "R43-018":["C042","C183"], "R43-019":["C027"], "R43-020":["C022","C059","C044"],
 "R43-021":["C153","C207","C259","C036","C039","C043","C027","C003"], "R43-022":["C002"],
 "R43-024":["C048","C143","C226"], "R43-025":["C066","C183","C069"], "R43-026":["C011","C172","C045","C009","C030","C046","C080","C050","C107","C073","C155"],
 "R43-027":["C155","C104"], "R43-028":["C085","C246","C035"], "R43-029":["C043","C020","C044","C021","C037","C019","C017","C010","C080"],
 "R43-030":["C003","C177","C007"], "R43-031":["C177"], "R43-032":["C063","C147","C007"],
 "R43-035":["C080","C073"], "R43-036":["C057"], "R43-039":["C043"], "R43-040":["C107","C074"], "R43-041":["C048","C143"], "R43-042":["C175"], "R43-044":["C175"],
 "R43-045":["C075","C119"], "R43-046":["C172","C009"], "R43-047":["C246","C085"], "R43-048":["C177"], "R43-049":["C046"], "R43-050":["C078","C033","C186"],
 "R43-051":["C036","C189"], "R43-053":["C059"],
 "R43-055":["C002","C003"], "R43-056":["C006","C259","C178"], "R43-057":["C002"], "R43-058":["C011"], "R43-059":["C005"], "R43-060":["C059","C036"],
 "R43-061":["C007","C001"], "R43-062":["C181","C218"], "R43-063":["C007","C001"], "R43-064":["C064","C007"], "R43-065":["C181"],
 "R43-066":["C175","C031"], "R43-067":["C031","C065"], "R43-068":["C030","C153"], "R43-069":["C175","C119"], "R43-070":["C057","C119"], "R43-071":["C223","C256"],
 "R43-072":["C094","C150"], "R43-073":["C059","C043","C022","C027","C073","C107"], "R43-074":["C223","C254"],
 "R43-076":["C003","C006"], "R43-077":["C059"], "R43-078":["C027"], "R43-079":["C007"], "R43-080":["C002","C031","C034"], "R43-081":["C065","C078","C186"], "R43-082":["C007","C065"],
 "R43-084":["C003"], "R43-085":["C063","C007"], "R43-086":["C048","C066","C069"], "R43-087":["C061","C085"], "R43-088":["C003"], "R43-089":["C065"], "R43-090":["C078","C033"],
 "R43-091":["C003","C089","C112"], "R43-092":["C212"], "R43-093":["C177","C147"], "R43-094":["C005"],
 "R43-096":["C062","C231"], "R43-097":["C062","C057"], "R43-098":["C027"], "R43-100":["C042","C183","C066","C009","C171"], "R43-101":["C062","C027"], "R43-103":["C034","C212"],
 "R43-105":["C001","C007"], "R43-106":["C175","C034","C031","C039"], "R43-107":["C002"], "R43-108":["C003","C004"], "R43-109":["C042"], "R43-110":["C027"], "R43-111":["C036"],
 "R43-112":["C119","C175"], "R43-113":["C104","C043"], "R43-114":["C006","C258","C043","C259","C003"],
 "R43-115":["C153","C034"], "R43-116":["C207","C119"], "R43-117":["C036"], "R43-118":["C104"], "R43-119":["C155"], "R43-120":["C094"], "R43-121":["C177"], "R43-122":["C259"],
 "R43-123":["C043"], "R43-124":["C039"], "R43-125":["C039"], "R43-126":["C027"], "R43-127":["C042","C066","C009"], "R43-128":["C107"],
 "R43-129":["C003"], "R43-130":["C007","C001"], "R43-131":["C006"], "R43-132":["C258"], "R43-133":["C057","C119"], "R43-134":["C119"], "R43-135":["C133"], "R43-136":["C044"],
 "R43-140":["C034"], "R43-141":["C042"], "R43-143":["C007","C181"],
}
# unattached (nuance register): 002 method, 003 top-heavy, 005 eligibility, 006 misrates, 023 inventory table, 033 master table, 034 generic, 037 churn, 038 requests,
# 043 too limited, 052 intent, 054 weak rows, 075 distribution, 083 payer table, 095 storefronts, 099 english-primary, 102 volume group, 104 method, 137–139/142 research questions
cards = [json.loads(l) for l in open("Tools/prd_ledger/43/cards.jsonl") if l.strip()]
ids = {c["id"] for c in cards}
for k, v in M.items():
    assert k in ids, k
    for cid in v: assert cid in C and not C[cid].get("merged_into"), (k, cid)
for c in cards:
    c["canonical"] = M.get(c["id"], [])
    for cid in c["canonical"]:
        if c["id"] not in C[cid]["cards"]: C[cid]["cards"].append(c["id"])
        if c["report"] not in C[cid]["reports"]: C[cid]["reports"].append(c["report"])
with open("Tools/prd_ledger/43/cards.jsonl", "w") as f:
    for c in cards: f.write(json.dumps(c, ensure_ascii=False) + "\n")
json.dump(list(C.values()), open("Tools/prd_ledger/canonical.json", "w"), indent=1, ensure_ascii=False)
null = [c["id"] for c in cards if not c["canonical"]]
print(f"{len(C)} canonical; {len(cards)-len(null)} attached; unattached {null}")
