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

c(1, "header line 3-6", "positioning",
  "Routinery is a Korean-built sequential routine timer (speaks the next task aloud, recalculates finish time) with a 4.72 US store rating on 17,825 ratings, 6,710 KR ratings at 4.74, English-only listing, 17+ age rating, and marketing claims of '2026 App of the Day', 'Best ADHD App by Forbes Health 2025', '5 million users'",
  "developer Routinery Corp., bundle com.alt.goodmorning; KR listing 갓생 루틴 루티너리; voice/TTS-guided timers, plant-badge streaks, widgets, watch; v3.29.36 (5 Sep 2026)", "praise",
  "3,342 reviews, 86 storefronts, Apr 2019 → Sep 2026; JP 3,342 ratings at 4.62, GB 2,111 at 4.64", "none", "corpus-level fact", "app-specific", [],
  cond="a routine-timer app, not a checklist — the timer is the product")
c(2, "How to read this", "data-caveat",
  "Method: bands against all 3,342 and separately against each of 9 storefronts with ≥50 reviews (2,840, 85.0%); 77 storefronts hold 502 (15.0%, mean 4.06, 17.3% 1–2★); one review = 0.030%; non-exclusive themes",
  "n/a", "none", "9 eligible storefronts", "none", "method", "yes", [])

# ---- PART 0 ----
c(3, "Part 0 summary line", "insight",
  "The product thesis — a sequential timer that speaks the next task aloud and continuously recalculates your finish time — is the strongest and most defensible in the category; 12.90% of reviewers identify as ADHD/neurodivergent and rate it 4.47; what drags the rating is engineering reliability (50.3% of every 2★), not price or the paywall",
  "sequential spoken timer with live ETA", "praise", "ADHD 12.90% at 4.47; reliability in 50.3% of 2★", "product-rule", "high-priority", "yes", [])
c(4, "Part 0 §1 + table", "data-caveat",
  "The written corpus is NOT much angrier than the tap rating (4.16 vs 4.72, a 0.56 gap — small for this category): negative reviews are specific defect reports from people who still want the app to work, not refugees from a predatory funnel — so fixing defects converts directly into rating",
  "n/a", "mixed", table(35, 43), "none", "high-priority", "yes", [],
  side="the tap-vs-written gap is a diagnostic: large gap = funnel anger, small gap = defect reports")
c(5, "Part 0 §2 + table", "insight",
  "Reliability, not money, produces 2★ and 3★: any-reliability theme in 9.4% of 5★ → 50.3% of 2★ (peaks at 2★, not 1★ — the signature of users who like the product and are frustrated); 609 reviews (18.22%) report a defect at mean 3.36; monetization 585 (17.50%) at 3.50 peaks at 1★ (37.9%) — money produces the loudest 1★s, engineering produces the volume of 2–3★s",
  "reliable enough to love, unreliable enough to lose stars", "complaint", "reliability 609 (18.22%), mean 3.36, 30.9% 1–2★; monetization 585 (17.50%), mean 3.50; " + table(51, 57), "must-never-break", "high-priority", "yes", [],
  side="2★ is the most recoverable unhappiness in the corpus")
c(6, "Part 0 §3", "feature",
  "The single feature that makes the app work is the live finish-time estimate: 277 reviews (8.29%, mean 4.16) praise the timer/countdown/'all ends by' ETA — it removes the need to hold a schedule in working memory and tells you continuously whether you are still on time; 'an ETA that gets pushed back whenever I take longer on a task is just revolutionary for my severe lack of time concept'",
  "sequential timer + live ETA, free", "praise", "277 (8.29%), mean 4.16, high-priority", "must-have", "high-priority", "yes",
  ["8204342733","9183771774","9017685503","10925188822","14115048883","11130087506","8382971100","6883027790","7510768204","8016986126","9228861293","9499393403","10746011966"],
  side="'Cure for Time Blindness' — the same description across seven years and every language")
c(7, "Part 0 §3 outcome", "insight", "162 reviews (4.85%, very strong, mean 4.46) independently report the commercially important outcome: they stopped being late — 'I would barely make it out the door at 6:30. Now I am ready to leave at 6:00'",
  "n/a", "praise", "162 (4.85%), mean 4.46", "do", "very strong", "yes",
  ["8305228306","7719936293","11628572335","11994505654","12283999607","13442882939","14083519489"],
  side="a concrete life outcome (punctuality) is the marketing claim the reviews themselves supply")
c(8, "Part 0 §4", "audience",
  "ADHD is the actual user base, not a marketing angle: 431 reviews (12.90%) mention ADHD/ADD/AuDHD/autism+ADHD/executive dysfunction/time blindness at mean 4.47 vs 4.11 for everyone else, 6.0% 1–2★, 70.5% 5★; autism 14 (0.42%) at 4.64 with zero 1–2★; depression/anxiety/bipolar/OCD/PTSD/burnout 95 (2.84%) at 4.52; ADHD share grew 6.8% (2020) → 18.0% (2022) → 15.4% (2026); therapists recommend it; 'as important as medication for my ADHD'",
  "designed around time blindness", "praise", "431 (12.90%) at 4.47; most-voted review (42 votes) is a neurodivergent recommendation", "do", "high-priority", "yes",
  ["9655374699","13224248600","12876052388","13503431066","12384933589","13632583017","12769141712"],
  side="'Life changing Assistive tech… no mental load at all' — positioning as assistive technology, not productivity",
  cond="the 17+ age rating on a product full of 10–15-year-olds and parents is flagged (§9)")
c(9, "Part 0 §5 + table", "monetization",
  "The 2-routine free cap is the most-named limitation (168 reviews, 5.03%) but a CONVERSION problem, not a rating problem: 70 of the 168 are 5★, mean 3.92, only 12.5% 1–2★ — 'praise, then I just wish I could make more than two'; 'that's enough for your morning & night routine'; 42 more (1.26%, mean 4.10) ask for 3–5 free routines",
  "free tier = 2 routines", "mixed", "168 (5.03%), mean 3.92, 12.5% 1–2★; " + table(88, 95) + " ; 42 (1.26%) ask for 3–5 free", "undecided", "high-priority", "yes",
  ["11641543092","13503431066","8605738567","12342952953","13333169396","12641178359","12658956308","11308909258","13348548274","13863035457","12283384934","8081966389","6423136829","9059742505","11420765116","13666386966","7235894863","12613639721"],
  side="inference: the cap is a wall people notice but it does not convert, because two routines (morning + night) already deliver the core value — the cap gates the wrong axis",
  cond="a quantity cap that lands above the point of core value produces polite wishes, not 1★; below it (report 1's 3-habit cap) it produces anger")
c(10, "Part 0 §6 + table", "timeline",
  "Three dated engineering incidents: a launch-failure crisis in 2023 Q2 (17.0% of that quarter's reviews, quarter mean 3.25 — worst in corpus); a screen-flicker outage on 2–3 Jul 2025 (13 reviews in ~48 hours, identical symptom across five languages — 7 of 13 still rated 5★ while reporting a total outage); a notification-loop regression 2–30 May 2026 (12 of 33 lifetime notification-spam reviews in four weeks, 8.4% of 2026 Q2) — 'sending notifications every two seconds for a routine I have finished… I deleted the routine and it kept sending them'",
  "three shipped regressions, one still open", "1★-burst", table(108, 112), "must-never-break", "high-priority", "yes",
  ["12845169896","12845170672","12845182717","12845201048","12845212130","12845278815","12845293413","12845331141","12845383837","12845433586","12845443933","12845461318","12845938596","14026780569","14025543075","14027904982","14020050534","14026381495","14031389102","14039388760","14039999029","14040436929","14061240049","14073080620","14124723476","14028544588"],
  side="the goodwill in this user base is extraordinary (5★ during an outage) and should not be spent casually; a notification loop punishes exactly the trait the app sells to",
  cond="release-day review clusters are clean forensic evidence of a regression")
c(11, "Part 0 §7 + table", "timeline",
  "Apple Watch is a FIXED problem — the proof this team can fix things: Watch defect reports fell from 8.8% of 2021 reviews and 7.7% of 2022 to 0.2% in 2026; for two years it was the single most-cited defect, now 'seamlessly functional between phone and watch'",
  "fixed the Watch app over 2023–2025", "praise", table(122, 131), "must-never-break", "high-priority", "yes",
  ["7040840149","7088596981","8728078244","9272132912","9439258779","9886812490","10179113941","11760598486","13259002296","14408847759"],
  side="the same discipline applied to notifications and launch reliability would move the rating")

with open("Tools/prd_ledger/5/cards.jsonl", "w") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards written")
