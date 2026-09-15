import json, re
R = 9
rep = open("App Store Reports/9. Dear Me - Daily Routine Tracker - Self Care & ADHD Habit Planner (REPORT).md").read().split("\n")
def table(after, k=0):
    """k-th markdown table after the first line containing `after`, flattened."""
    i = next(n for n, l in enumerate(rep) if after in l)
    blocks, cur = [], []
    for l in rep[i+1:]:
        if l.startswith("|"): cur.append(l)
        elif cur:
            blocks.append(cur); cur = []
            if len(blocks) > k: break
        elif l.startswith("#") and blocks == [] and k == 0 and False: pass
    if cur: blocks.append(cur)
    rows = [l for l in blocks[k] if not re.match(r"^\|[\s\-:|]+\|$", l)]
    return " ; ".join(re.sub(r"\s*\|\s*", " | ", l.strip("|")).replace("**","").strip() for l in rows)
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))


# ---- PART 1 — PRODUCT AND MONETIZATION MODEL ----
c(34, "§1.1 What the product is, reconstructed from the corpus table (verbatim)", "data-caveat",
  "Capability map with free/paid status as reviewers experience it: today checklist, custom habits, Discover templates, quiz, breathing demo, tests, journal, reminders, stickers, widgets, calendar, statistics, cycle tracking, AI coach Mimi, affirmations, beaver mascot",
  "n/a", "mixed", table("## 1.1 What the product"), "none", "verbatim", "app-specific",
  ["12468334420","12533297284","13326456954","11525075222","12174607035","11682091018","13002982148","12497412052","13021325704","12451223326","13276823733","12847151988","11823311515","12523888830","13810246956","14302044695","14507626498","13860369435","11526412509"])
c(35, "§1.1 'Keşfet' / Discover — pre-made routine templates Paid; §1.3; §5.1-FR M-gated", "feature",
  "Pre-made routine templates (Discover) are the paid layer and the single most-cited gated feature — 'the proposed routines are all paid' — and the most-voted free-tier guide describes browsing the paid routines and re-typing the ideas manually as free custom habits",
  "Discover templates Plus-only", "mixed", "M-gated 31 (2.42%, MEANINGFUL), mean 2.90; FR 5 (10.0%); 86 helpful votes on the workaround review", "build-paid", "meaningful", "yes",
  ["11525075222","12174607035","12620617170"])
c(36, "§1.1 Journal / mood + emotion logging; §4.4 journal + trackers row; §2.2 G-notes", "feature",
  "Mood selection is free but writing journal text is paid — buyers expected 'all the tools (journal and other trackers)' — and engaged users ask for real free-text daily entries and a photo of the day",
  "mood picker free, text entry Plus", "complaint", "G-notes 9 (0.70%, EMERGING), mean 3.11", "research", "emerging", "yes",
  ["13021325704","12209118679"])
c(37, "§1.1 Home-screen widgets row; §2.2 G-widget; Part 7 §7.3 #9", "feature",
  "Widgets are paid in some storefronts (SA, ID) and reported free in the US — inconsistent — and a Saudi 1★ argues charging for widgets specifically is unfair",
  "widgets paid by storefront", "complaint", "G-widget 11 (0.86%, EMERGING), mean 3.18; 4★ band 4", "build-free", "emerging", "yes",
  ["12451223326","13276823733","13021325704"])
c(38, "§1.1 Daily affirmations and Beaver mascot rows; Part 7 §7.4", "feature",
  "Daily affirmations and the beaver mascot are free and do real emotional work, but affirmations cannot be turned off and the mascot appeared in an update and cannot be dismissed — make them optional, do not remove them",
  "non-removable affirmations; undismissable mascot", "mixed", "report gives none beyond named reviews", "do", "qualitative", "yes",
  ["13860369435","13624114897","11526412509","12284703983"])
c(39, "§1.1 Not present, and repeatedly requested; §2.2 G-sync, G-calendar", "feature",
  "Not present and requested: an Apple Watch app, a usable iPad build, Apple Calendar sync, dark mode, and habit sharing with friends",
  "absent", "complaint", "G-sync (iPad / Watch / multi-device) 7 (0.55%), 3.00; G-calendar 5 (0.39%), 3.20; dark mode 4; G-social 3 (0.23%), 3.33", "research", "emerging to weak", "yes",
  ["11966810600","12343427636","11713261203","11713566182","12020346318","13038158254","12464161947","12458138764"])
c(40, "§1.1 CSV export (0 reviews — nobody asks); §5.5 Nobody asks for data export", "contradiction",
  "Nobody asks for data export — zero reviews across 62 storefronts — against reports 1 and 3 where export was a repeated request from happy users",
  "no export", "none", "0 of 1,281", "none", "absence", "unknown", [],
  cond="a template-driven daily routine app with little accumulated personal data, versus long-history trackers")
c(41, "§1.2 The pricing model [external + corpus]", "monetization",
  "Plan structure as users meet it: weekly ≈ $7.99 / €7.99, with Turkish users repeatedly describing a weekly charge presented as if it were monthly; annual $39.99, ~$60, ₺199.99–₺699.99, ₪200, €20, ₹649, 129 DKK at 50% off",
  "weekly + annual Plus; five IAP price points", "complaint", "5 TR reviews describe weekly-shown-as-monthly; price points $6.99 / $16.99 / $27.99 / $39.99 / $79.99", "must-never-break", "observed", "yes",
  ["12221358308","11436403992","11587765683","11642792565","11722946564","12652692645","13966657008","12209118679","13316643309","11539871453","12257289655","11690398268","12479597871","12190059793","12301387923","12919237808","12966178467"])
c(42, "§1.2 Free-trial availability is inconsistent by storefront, and reviewers noticed; Part 7 §7.2 Part A", "market",
  "Free-trial availability depends on the storefront and reviewers compare notes in public: 'for anyone asking about a trial: it depends on account type — an American account gets a trial, a Saudi account does not'; the terms say 'We make no representation or warranties that you will be offered any Trials' — a trial in one country and none in another is worse than no trial anywhere",
  "trial in US, none in SA and most others", "blocked-conversion", "52 reviewers across TR, RU, DE, FR, SA, BE, NL, AU, PK, IN say there is no trial", "must-never-break", "meaningful", "yes",
  ["11836191831","13021325704"])
c(43, "§1.2 US trial trap; §0.2 M-trialtrap; §5.1-US", "must-never-break",
  "Charged despite cancelling inside the trial — one US reviewer kept screenshots and reports $86.53 still being attempted",
  "trial converts after cancellation", "1★-burst", "M-trialtrap 10 (0.78%, EMERGING), mean 1.80; 10 of 10 paid; 1.51% → 0.47% → 0.00%", "must-never-break", "emerging, resolved by 2026", "yes",
  ["13245012766","11552283550"])
c(44, "§1.2 A 'Newcomer discount' / '-50%' screen fires on nearly every open; §4.3 trigger 3", "dont",
  "A '−50% Newcomer discount' timer fires on nearly every open for non-subscribers, drives impulse purchases, and in one case completed an Apple Pay annual purchase while the user was trying to dismiss it for the nth time — users ask for 'Do Not Show Again'",
  "recurring discount interstitial", "1★-burst", "59 M-nag reviews; 3 named discount-timer purchases", "dont", "very strong", "yes",
  ["12360368631","12755295856","12966178467","12650182347","11777093103"])
c(45, "§1.3 Free/paid/unclear classification table (verbatim); Part 7 §7.2 Part C", "data-caveat",
  "Users cannot tell what Plus adds — currency, plan length and the paid feature list are unclear; a self-identified PM notes the premium page is one vague slogan and the profile membership page is blank; 'there is no info on what is actually included in the pro subscription'",
  "no single free/paid comparison screen", "complaint", "M-unclear 19 (1.48%, MEANINGFUL), mean 2.84; " + table("## 1.3 Free/paid"), "must-have", "meaningful", "yes",
  ["12399224524","11878902945","13021325704"])
c(46, "§1.4 The free tier is better than its reputation, and 28 reviewers say so; Part 7 §7.4", "positioning",
  "The free tier is better than its reputation — a positioning failure, not a product failure: users correct each other in public ('you don't lose much'; 'the subscription just gives a little bit more but not much of a difference'), while 75 others say you cannot do anything without paying — the pop-up density is what teaches users the app is locked; market the free tier",
  "usable free tier hidden by upsell density", "mixed", "P-free 28 (2.19%, MEANINGFUL), mean 4.39 vs M-wall 75 (5.85%), 1.69", "do", "meaningful", "yes",
  ["12174607035","13326456954","12294500887","11525075222","11372377257","11487094036","12044126085","12548474349","13611780246","13839168780","13951718803","14103224443"])
c(47, "§1.1 Custom habit creation — unclear cap; Part 7 §7.6 research question on the free-tier habit cap", "data-caveat",
  "Whether a free-tier habit cap exists is unclear: some report adding 10+ habits free with no cap, others report immediate blocking",
  "unclear cap", "mixed", "report gives none", "research", "open", "yes", ["12468334420"])

# ---- PART 2 — GLOBAL FINDINGS ----
c(48, "§2.1 Negative themes, ranked table (verbatim)", "data-caveat",
  "Eighteen negative themes ranked by volume",
  "n/a", "1★-burst", table("## 2.1 Negative"), "none", "verbatim", "app-specific", [])
c(49, "§2.2 Unmet-need themes (requests, not defects) table (verbatim)", "data-caveat",
  "Twenty-four unmet-need themes with what is asked for",
  "n/a", "complaint", table("## 2.2 Unmet"), "none", "verbatim", "app-specific", [])
c(50, "§2.2 The frequency model is the most-misunderstood part of the product; Part 7 §7.3 #3", "feature",
  "Richer scheduling from engaged users: sub-daily repetition (5× daily for prayers, water), 'any N days of the week' without fixing which days, explicit weekday selection, skip/vacation — two subscribers have written the spec",
  "daily / weekly / monthly only; no weekday pick", "complaint", "G-freq 22 (1.72%, MEANINGFUL), mean 3.14; 3★ band 7; 4★ band 4; FR 3", "must-have", "meaningful", "yes",
  ["11686508200","11668735422","12183108635","12695260948","12017205465"])
c(51, "§2.2 G-noedit and G-nodelete; Part 7 §7.3 #4", "feature",
  "Preset habits cannot be renamed or edited and habits/routines cannot be deleted — and the store listing claims you can",
  "presets locked; no delete", "complaint", "G-noedit 20 (1.56%, MEANINGFUL), mean 2.55; G-nodelete 15 (1.17%), mean 3.13; DE 4", "must-have", "meaningful", "yes",
  ["14400137816"])
c(52, "§2.2 G-content; Part 7 §7.3 #2", "feature",
  "More and deeper routine content is wanted (cleaning, study, sport, weekend, pets), and every preset habit needs a 'how to do this' body — a reminder that just says 'forehead lines' leaves the user asking 'what do I do?'; only the heading is shown",
  "preset habits are bare titles", "complaint", "G-content 30 (2.34%, MEANINGFUL), mean 3.40; 4★ band 6; TR 16 (3.4%)", "build-paid", "meaningful", "yes",
  ["12357846588","12710666495"])
c(53, "§2.2 G-group, G-order, G-dup; Part 7 §7.3 #5", "feature",
  "Routines interleave into one list: users want to group the day (cleaning / self-care / study), drag to reorder, and stop the same habit appearing 2–3 times",
  "single interleaved list; duplicates", "complaint", "G-group 13 (1.01%), 2.69; G-order 8 (0.62%), 2.38; G-dup 8 (0.62%), 2.25", "must-have", "meaningful", "yes",
  ["13099009549","12464161947","11491997138","12272862926"])
c(54, "§2.2 G-icons; Part 7 §7.3 #6", "feature",
  "More icons, emoji and colours — 'only 6 colours', 'only 60 emoji' — cheap and asked by engaged users",
  "6 colours, 60 emoji", "complaint", "G-icons 14 (1.09%, MEANINGFUL), mean 3.57; 4★ band 5", "undecided", "meaningful", "yes",
  ["11607493158","11703804318"])
c(55, "§2.2 G-time and G-sub; Part 3 4★ premium user list", "feature",
  "Time ranges and durations (start/end, not just a point), sub-tasks, quantity targets ('8 of 10 glasses of water') and a stopwatch — asked by a premium user who calls the app 'only a surface-level app'",
  "point-in-time binary tasks", "complaint", "G-time 10 (0.78%), 2.50; G-sub 7 (0.55%), 3.29", "undecided", "emerging", "yes",
  ["11646116789"])
c(56, "§2.2 G-sound; §5.4 SA; Part 7 §7.1 #7", "feature",
  "An audible completion sound / alarm tone instead of a silent push — Saudi Arabia is the notification/alarm market, where one reviewer gives a five-point audit of the alarm system",
  "silent push only", "complaint", "G-sound 9 (0.70%), 2.33; + B-notif 12; SA B-notif 4, G-sound 3", "build-free", "emerging", "yes",
  ["11836191831"])
c(57, "§2.2 G-backfill and G-future; Part 7 §7.3 #7", "feature",
  "Tick off a day you missed, and plan further ahead than 3–4 days — one German user cancelled over the planning horizon",
  "no backfill; 3–4-day horizon", "churn", "G-backfill 6 (0.47%), 2.83; G-future 6 (0.47%), 3.50", "must-have", "weak", "yes",
  ["12847151988","14066249834"])
c(58, "§2.2 G-stats; §1.1 Statistics row", "feature",
  "Statistics are free but thin — 'just numbers with no detail' — users want per-habit streaks and counts",
  "basic numbers", "complaint", "G-stats 6 (0.47%), 2.33", "undecided", "weak", "yes", ["11823311515"])
c(59, "§2.2 G-todo, G-kids, G-cal-start", "feature",
  "Small requests: one-off to-dos alongside habits, a version for children, and a Monday week start (FR, FI)",
  "absent", "complaint", "G-todo 5 (0.39%), 3.00; G-kids 4 (0.31%), 2.75; G-cal-start 2 (0.16%), 3.50", "research", "weak", "yes", [])
c(60, "§2.2 G-a11y — rapid animation is a seizure/vertigo risk (promoted despite volume as a safety concern)", "must-never-break",
  "Rapid animation is reported as a seizure/vertigo risk — promoted despite a single review as a safety concern",
  "fast animations, no reduce-motion", "1★-burst", "G-a11y 1 (0.08%), 1★, AU", "must-never-break", "safety carve-out", "yes", ["13467908248"])
c(61, "§2.3 Mixed themes — Notifications", "must-never-break",
  "Notifications are praised and attacked at once: some say reminders land at the exact time, others that they never arrive, and others that they all fire at once at the wrong time — 'It sends all the notifications at the same time'; '20 notifications to my Apple Watch all at once while I'm at work'",
  "reminder scheduling unreliable", "mixed", "P-remind 14 (1.09%), 4.86 vs B-notif 12 (0.94%), 1.75 (SA 4, TR 4) vs B-notifspam 8 (0.62%), 2.50", "must-never-break", "emerging", "yes",
  ["13745822425","12019986162","12343427636"])
c(62, "§2.3 X-anxiety; §5.1-US", "audience",
  "The notification behaviour increases anxiety in the exact audience the app targets: a 'take a deep breath' notification at midnight and an 'overdue task' alert that 'immediately stressed me out'",
  "overdue alerts, late-night nudges", "1★-burst", "X-anxiety 6 (0.47%); US 2, CA 2", "dont", "weak", "yes",
  ["12184046988","11764762613","12298944709","11603369138"])
c(63, "§2.3 Mixed themes — Design", "insight",
  "Design is praised but cannot carry a broken product — 'Stars only for the design'; 'Inconvenient, useless, but beautiful' — and some find the palette too loud or childish",
  "bright illustrated palette", "mixed", "P-design 33 (2.58%), mean 4.45; RU 10 (8.8%)", "undecided", "meaningful", "yes",
  ["12875174028","13600520150","12998493686","13585793108"])
c(64, "§2.3 Mixed themes — The mascot", "feature",
  "The beaver mascot splits users: 4 love it, 2 reject it ('I couldn't with the beaver. Why a beaver?'; 'I'm not a dog'), and one reports it appeared in an update and cannot be dismissed",
  "beaver mascot", "mixed", "4 positive, 2 negative, 1 undismissable", "undecided", "weak", "yes",
  ["11526412509","12284703983","12308282270","13367660347","12148653483","12623899009","13860369435"])
c(65, "§2.3 Mixed themes — Advertising (O-ads)", "data-caveat",
  "Heavy social-ad acquisition cuts both ways: 'the advertising helped me download it' vs 'fooled by their ads… I bought a one-year membership'",
  "social/video ad-driven acquisition", "mixed", "O-ads 18 (1.41%, MEANINGFUL), mean 2.78", "none", "meaningful", "yes",
  ["11442054312","12633273226"])
c(66, "§2.4 The 'I could do this in Notes' argument is the churn thesis, stated 20+ times", "positioning",
  "The churn thesis is a comparison to a free tool the reviewer already owns — iPhone Notes / Reminders, paper, a whiteboard, a spreadsheet, Trello, Google Calendar, ChatGPT: 'I would get a better personalized routine using ChatGPT for free. Just a pretty app with basic content' (bought on an ad promising MBTI-personalised routines that do not exist)",
  "checklist positioned as coach", "churn", "20+ reviews across every major market", "do", "meaningful", "yes",
  ["11356752221","12345630714","12304025485","12177449575","12373899765","12919946354","11629249062","11832344919","11488999833","12294753083","12663050322","12755295856","12680748423"])
c(67, "§2.5 Localization quality is a paid-user problem in four languages; Part 7 §7.3 #8", "market",
  "Machine translation is a paid-user problem: Japanese phrasing is odd, Hebrew 'beneath criticism' and rendered reversed, Russian 'translated by a translator with no human involvement — headings shifted, long words don't fit', a Saudi subscribed for a full year before finding the Arabic 'very bad', and Brazilian support content is in English",
  "machine-translated JA, HE, RU, AR; English support in PT", "1★-burst", "G-l10n 14 (1.09%, MEANINGFUL), mean 1.79; JP G-l10n 3 + B-ime 7", "do", "meaningful", "yes",
  ["11614598675","11624500796","11890679534","12513379051","13038071101","12562609306","11895224084"])
c(68, "§2.5 P-l10n — what good localization buys; §5.1-TR", "positioning",
  "Good localization is a named reason to choose the app: 'I tried another app, it didn't have Turkish' — all five localization-praise reviews are Turkish (one Turkish 1★ says better-localised Turkish alternatives exist)",
  "native Turkish", "praise", "P-l10n 5, all TR", "do", "weak", "yes",
  ["11647652906","12024330293","12207555969","12253673918","13167235553"])
c(69, "⚠️ 2. The public star rating is ~1.35 stars higher; §2.6 The rating gap table (verbatim)", "data-caveat",
  "The public rating averages 4.86 on ~40,555 ratings across eight storefronts while written reviews average 3.51 — a +1.35 weighted gap, largest in RU (+2.27), FR (+2.19) and DE (+2.03)",
  "n/a", "mixed", table("## 2.6 The rating gap"), "none", "verbatim", "app-specific", [])
c(70, "§2.6 13 reviews report being asked to rate the app before using it; §5.6; Part 7 §7.1 #2", "dont",
  "Asked to rate the app before using it, as a step inside sign-up — 'I'm having to write a review before actually using app??'; 'first they ask you for 5 stars, then for money, and only then do you get to see the app'; 'mid-onboarding the devs beg for a review of an app I haven't even seen. Incidentally Apple forbids this' — an App Store guideline exposure that inflates the public rating",
  "rating prompt inside onboarding", "mixed", "O-forcedrate 13 (1.01%, MEANINGFUL), mean 2.54; public/written gap +1.35", "dont", "meaningful", "yes",
  ["11894722198","12278140415","12137044359","13021325704","13441600880","14276958495","11549287863","11936103176","12009795310","12018437724","12783290291","13175470414","13604430494"])
c(71, "§2.6 9 reviews (0.70%) are outright MISMATCH; Decision implication", "data-caveat",
  "Five-star ratings attached to entirely negative text — titled 'Not worth it', 'I was defrauded' ('I'm giving five stars so my review appears at the top'), 'Doesn't open' — so the public rating cannot be used as a satisfaction metric; treat the written mean and the 1★ share as the signal",
  "n/a", "none", "MISMATCH 9 (0.70%)", "none", "observed", "yes",
  ["11466703747","13025036138","13681845921","11509007666","11718643683","11788006113","11900899478","13815975384","13928105308"])

with open("Tools/prd_ledger/9/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
