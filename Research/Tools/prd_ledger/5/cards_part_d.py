import json, re
R = 5
rep = open("App Store Reports/5. Routine Planner, Habit Tracker - Daily Time Management for ADHD (REPORT).md").read().split("\n")
def table(start, end):
    rows = [l for l in rep[start-1:end] if l.startswith("|") and not re.match(r"^\|[\s\-:|]+\|$", l)]
    return " ; ".join(re.sub(r"\s*\|\s*", " | ", l.strip("|")).replace("**","").strip() for l in rows)
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))

# ---- PART 4 table ----
c(46, "Part 4 table (verbatim)", "feature", "Top complaints and unmet needs, 30 rows — full table",
  "n/a", "complaint", table(341, 372), "none", "high-priority", "yes", [])
c(47, "Part 4 row 5", "must-never-break", "Crash / won't open / infinite loading — 135 (4.04%), mean 2.91, 43.7% 1–2★", "n/a", "1★-burst", "135 (4.04%)", "must-never-break", "very strong", "yes", [])
c(48, "Part 4 row 6", "monetization", "'Must pay to use' perception — 130 (3.89%), mean 3.52", "2-routine cap read as paywall", "complaint", "130 (3.89%)", "research", "very strong", "yes", [])
c(49, "Part 4 row 9", "must-never-break", "Cross-device sync failure — 107 (3.20%), mean 3.83; 3.1× over-represented among payers", "sync unreliable", "complaint", "107 (3.20%)", "must-never-break", "very strong", "yes", [])
c(50, "Part 4 row 14", "feature", "Widget missing / broken / limited — 92 (2.75%), mean 4.02, only 10.9% 1–2★ — fans asking; Lock Screen, Live Activity and watch complication requested to 'run the routine without opening the app'",
  "widgets weak", "complaint", "92 (2.75%), mean 4.02", "build-free", "meaningful", "yes", [])
c(51, "Part 4 row 16", "must-never-break", "Lag / freeze / unresponsive — 69 (2.06%), mean 3.03, 39.1% 1–2★", "n/a", "complaint", "69 (2.06%)", "must-never-break", "meaningful", "yes", [])
c(52, "Part 4 row 23", "feature", "Shortcuts / auto-start / URL triggers — 37 (1.11%), mean 4.08 — 'remove the last manual step (opening the app)'",
  "no automation hooks", "complaint", "37 (1.11%), mean 4.08", "undecided", "meaningful", "yes", [])
c(53, "Part 4 rows 26–27", "feature", "The TTS voice: 25 (0.75%) say it can't be disabled or is too loud; 30 (0.90%) say it sounds robotic/creepy",
  "voice guidance always on", "complaint", "25 + 30", "must-have", "emerging", "yes", [],
  cond="a signature feature still needs an off switch and a better voice")
c(54, "Part 4 row 29", "market", "China: the app will not open at all at the storefront level — 23 reviews (0.69%), mean 2.52, 56.5% 1–2★",
  "broken in CN", "1★-burst", "23 (0.69%)", "must-never-break", "emerging", "app-specific", [],
  cond="see §7.5")

# ---- 4.1 ----
c(55, "§4.1", "must-never-break", "Battery drain and overheating — 62 reviews (1.86%), mean 2.94, 43.5% 1–2★ — the highest-severity engineering complaint by rating impact: 30–90% of daily battery, device heating, because the timer runs in the background; '5× Instagram? no way'; a brand-new iPhone losing 15% in one hour of morning tasks — and that reviewer will not renew; partially fixed once, then regressed",
  "background timer drains battery", "1★-burst", "62 (1.86%), mean 2.94; peaks 2023 (22) and 2025 (17), live in 2026 (5)", "must-never-break", "meaningful", "yes",
  ["11515721909","10098317714","13376641175","13249089782","14491246957","14493761177","9502486128","9764474844","10239716747","9958518584","10135282986","9759386345","11125731785","13091482216","13195777384","13520796132"],
  side="a timer app that is 'currently unusable' because of battery is losing subscribers who otherwise love it")

# ---- 4.2 ----
c(56, "§4.2 not firing", "must-never-break", "Notifications not firing — 99 (2.96%), mean 3.53 — a total-loss failure for an app whose core loop is 'the app tells you to start': 'as someone with adhd the notifications are the main purpose of it'; 'this app won't work for me if the onus is on me to remember to launch it'",
  "notifications silent", "1★-burst", "99 (2.96%), mean 3.53", "must-never-break", "meaningful", "yes",
  ["13318004023","10337926884","12327812271","13446802332","13830916795","13982523131","9219301950","11903518291"])
c(57, "§4.2 design note", "insight", "The persistent, un-dismissable notification is a deliberate feature several users LOVE ('it doesn't let me ignore it! Hella annoying — but effective'), and when the app removed the buzzing alarm in 2026 it broke wake-ups for loyal subscribers ('They ruined it… I'm canceling after being a loyal customer for years') — the escalation ladder IS the product; it needs to be user-configurable, not silently retuned",
  "retuned the alarm escalation silently", "1★-burst", "2 loving IDs; 3 2026 1–2★ from removal", "must-never-break", "weak count, clear mechanism", "yes",
  ["13667837214","13166666978","14371016110","14447685280","14499455292"],
  side="a behaviour some users depend on cannot be changed without a setting; another instance of removing something users had",
  cond="pairs with the notification loop (R05-010): both extremes of the same ladder")

# ---- 4.3 ----
c(58, "§4.3", "must-have", "Data loss — 91 (2.72%), mean 3.42 — routines vanishing, usually after an update: 'all my routines disappeared… ~40 items in one routine' (restored after dev contact); 'third time everything vanished'; turning on Sync deleted all routines; 'make sure you create an account — I did not, and lost my account + my 135 days streak' — local-first with no default account = data loss by design",
  "local-first, account optional, sync can wipe data", "1★-burst", "91 (2.72%), mean 3.42", "must-have", "meaningful", "yes",
  ["12925478996","13049897248","13365456673","11500955921","8120137325","13760050939"],
  side="several discovered only after the fact that nothing was backed up",
  cond="the account must be default-on or backup must be automatic; 'Sync' must never be destructive")

# ---- 4.4 ----
c(59, "§4.4", "must-have", "'No way to contact support' — 97 (2.90%), mean 3.70 — the review page is being used as a helpdesk; a vicious loop: the only support channel is inside an app that won't open; the support link is 'hidden behind a lone cryptic icon'; three unanswered emails while developers reply to public reviews same-day",
  "support email only reachable in-app; emails unanswered while reviews get replies", "complaint", "97 (2.90%), mean 3.70", "must-have", "meaningful", "yes",
  ["8229765673","8512899266","9654996405","13469367908","13769267096"],
  side="prioritising public review replies over private email is noticed and reads badly",
  cond="a support path must exist outside the app (web page, listing) and be answered")

# ---- 4.5 ----
c(60, "§4.5", "market", "Localisation: 26 translation-QUALITY complaints (0.78%, mean 2.73, 50% 1–2★) — unusually harsh: 'idiot-German produced by some algorithm'; 'my eyes are bleeding'; 'a good app ruined'; even the ENGLISH copy is broken ('routines reduce your energy about what to do when'; 'give any English speaker $20 and they could finish the job in 20 minutes') — plus 16 missing-language requests (BR-PT 7, Chinese 3+, Russian 2, Arabic, TW, IT, TR); the listing says English-only while the app ships machine-translated DE/FR/PT/JA/KO, push notifications arrive in Chinese, and a German user sees German, Dutch and English mixed — the worst of both worlds",
  "machine-translated UI in several languages; English copy itself poor", "1★-burst", "26 (0.78%), mean 2.73; 16 (0.48%) missing-language", "do", "emerging, harsh tone", "yes",
  ["9814965554","12869846755","10515742946","9070949448","7566936697","13898345640","11659281945","10865092345"],
  side="bad translation rates a full star lower than missing translation; a non-native English base copy compounds it",
  cond="ship a language properly or not at all; get the source-language copy right first")

# ---- 4.6 ----
c(61, "§4.6", "feature", "The timer is mandatory and a real minority needs it not to be: 69 (2.06%, mean 4.26) ask for an untimed/checklist mode and 15 (0.45%) say the timer causes anxiety — 'you cannot simply mark a habit as done; you are forced to start a timer… turn off the timer and you'll earn 5 stars'; 'I need a dumb mode'; an AuDHD user: 'the time component brings me severe anxiety… I just want the reminder to do the thing. Not the count down' — a checklist shipped ~late 2025 but as a SEPARATE object, not a per-routine mode, which is not what was asked",
  "timer-only routines; separate checklist added late 2025", "complaint", "69 (2.06%), mean 4.26; 15 (0.45%) anxiety", "must-have", "meaningful", "yes",
  ["10507135013","10746011966","13073278557","12700460272","11972917376","9952706862","9677875961","13657298374","13442141220","8848686558","10004061679","13329626963","13520796132","13648621463"],
  side="the signature feature is also an anxiety source for part of the target audience; the fix is an option, not a new object",
  cond="fans asking for an option — high mean; shipping the wrong shape of the feature does not close the request")

# ---- 4.7 ----
c(62, "§4.7", "must-never-break", "The undo gap — 42 (1.26%): tapping 'done' by accident is unrecoverable and the buttons sit close together; first reported Jan 2020 ('pause and done should be further apart'), still described in 2026 — six and a half years",
  "no undo; adjacent pause/done buttons", "complaint", "42 (1.26%), mean 3.52", "must-never-break", "meaningful", "yes",
  ["12069182383","5432864399","13702441710","11580842783","11217088616","12629348274","9980992196"],
  side="the same shape as report 3's accidental widget reset: an irreversible tap on a high-frequency surface")

# ---- 4.8 ----
c(63, "§4.8", "must-never-break", "The midnight boundary breaks night routines — 14 (0.42%): a routine started 23:30 and finished 00:30 is logged to the next day and the starting day recorded blank, destroying streaks for late-night users; a 'day ends at 5am' setting was not honoured — fixed within three weeks after a developer reply (a documented win)",
  "day boundary at midnight; custom day-end setting buggy then fixed", "complaint", "14 (0.42%)", "must-never-break", "weak", "yes",
  ["13490673673","13283851839","13317314197","13057963564","12949429540","13175278334","14367123124","13715558049","13203062194"],
  cond="a configurable day-end (e.g. 5am) is required for night routines and shift workers")

# ---- 4.9 ----
c(64, "§4.9", "audience", "Safety: two reviews report the social tab surfaced identifiable minors (a 17-year-old girl, a 16-year-old boy) to an adult account — 'Parents please tell your children to avoid this app' — and the corpus contains many self-identified children aged 9–13 on a product rated 17+ with an opt-out-by-default public feed; 12 (0.36%) ask for the social tab to be removable ('We don't need another dumb social platform shoved down our throats')",
  "public social feed on by default, mixing minors and adults; 17+ rating not enforced", "1★-burst", "2 safety reports; ≥9 self-identified minors; 12 remove-social requests", "dont", "below threshold, child-safety", "yes",
  ["13030062439","13866789200","12171510092","10184385950","12619331115","12922302831","9337913065","13860429738","12740246107","12476018972","14079774351","11717198512","13364876886","13373809432","12811011494"],
  side="a social feed in a routine app is unwanted by a vocal minority and a child-safety liability; one subscriber just wants a hide option",
  cond="if there is a feed it must be opt-in and age-gated; the team shipped another share option instead of fixing a known widget bug — noticed")

# ---- 4.10 ----
c(65, "§4.10", "do", "Icon representation — 'the ones showing people shouldn't all be white. Representation matters' (2020) — raised four times over six years, never fixed; by 2026 a 1★: 'Pale skin is default for emojis… My review will remain 1 star until I see some sort of remedy'",
  "pale-skin default for people icons", "complaint", "4 reviews 2020–2026", "do", "weak, zero-ambiguity", "yes",
  ["6063452130","9323411983","13658574051","14221471353"],
  side="a zero-ambiguity, low-cost fix ignored for the life of the app; cf. report 1's missing Islamic icons")

# ---- PART 5 ----
c(66, "Part 5 table (verbatim)", "audience", "Audiences: ADHD 431 (12.90%, 4.47, 70.5% 5★); students 226 (6.76%, 4.43, heavy KR + US teens); mental-health 95 (2.84%, 4.52 — highest); parents 30 (0.90%, 4.40); autism 14 (0.42%, 4.64, zero 1–2★)",
  "n/a", "praise", table(441, 448), "do", "high-priority", "yes", [])
c(67, "Part 5 parents", "audience", "Parents are the clearest unserved commercial segment: they ask for FAMILY SHARING (5 reviews, 0.15%) and every one is an explicitly blocked purchase — 'my kids could benefit but I can't afford the full price for all of us'; 'no family sharing, so I gave up on paying'; parent outcomes are strong: 'As a mom with ADHD trying to get kids with ADHD out the door… a life saver'; 'It was not uncommon for me to leave the house in tears'",
  "no family plan", "blocked-conversion", "5 (0.15%), mean 4.20 — 'the highest intent quality in the corpus'; parent outcomes 6 IDs", "research", "weak count, highest intent", "yes",
  ["11745385532","9400943406","9830120067","9907503193","7985033621","13624963931","11628572335","12598922221","14087664268","12915068929","13121738980"],
  side="a family plan is money left on the table from the happiest cohort")

# ---- PART 6 ----
c(68, "Part 6 table (verbatim)", "feature", "Feature requests ranked with the underlying job — full table (widgets 92; untimed mode 69; ≥3 free routines 42; undo 42; Shortcuts 37; per-task day scheduling 36; more icons/search 27; dark mode 16 — shipped ~Jan 2025; anytime routines 15; Mac/web 15; sub-routines 12 at 4.42; calendar integration 9 at 4.44; family sharing 5; Android 6)",
  "n/a", "complaint", table(459, 475), "none", "high-priority", "yes", ["12243693467"])
c(69, "Part 6 sub-routines + task-level days", "feature", "Two requests deserve outsized attention: sub-routines (12, mean 4.42 — 'shower routine' reused inside 'morning routine') and per-task day/interval scheduling (36 — 'trash to the curb only on trash day', biweekly meds, showering every other day); both address the same problem — the app forces you to duplicate an entire routine to vary one step — which is also what drives users into the 2-routine cap; fixing task-level variability would reduce cap pressure and increase value simultaneously",
  "routines are monolithic; no per-step schedule; no nesting", "complaint", "12 at 4.42; 36 at 3.72; 4.6× over-represented among payers", "must-have", "meaningful, highest-rating askers", "yes",
  ["9017685503","13624660676","13942902589","14182637597","12613639721","9392564396","8795874884","10093805316","9262998416","12911127629","7734088825","13257733003","12116433368"],
  side="a structural feature that relieves the monetisation wall at the same time")
c(70, "Part 6 rows: anytime routines, more icons, calendar", "feature", "Smaller asks with clear jobs: anytime/unscheduled routines for shift workers, nurses, flight attendants (15, 4.27); more icons / icon search because icon-hunting blocks routine creation (27, 4.41); calendar integration to merge fixed appointments with flexible routines (9, 4.44); Mac/web to build on a big screen (15); Android for cross-platform households (6)",
  "n/a", "complaint", "15 / 27 / 9 / 15 / 6", "undecided", "weak", "yes", [])
c(71, "Part 6 row dark mode", "timeline", "Dark mode requested by 16 (0.48%) for night routines — shipped ~Jan 2025", "shipped dark mode Jan 2025", "praise", "16 (0.48%)", "build-free", "weak", "yes", ["12243693467"])

with open("Tools/prd_ledger/5/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
