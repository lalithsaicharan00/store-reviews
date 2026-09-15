import json, re
R = 7
rep = open("App Store Reports/7. Habit Tracker - HabitKit - Streaks & Accountability (REPORT).md").read().split("\n")
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


# ---- PART 4 — COMPLAINTS ----
c(73, "Part 4 COMPLAINTS AND UNMET NEEDS (full table) (verbatim)", "data-caveat",
  "Thirty-four complaint / unmet-need themes with n, %, mean, 1–2★% and signal",
  "n/a", "complaint", table("# PART 4"), "none", "verbatim", "app-specific", [])
c(74, "Part 4 #3 Paywall generally blocks use", "monetization",
  "The paywall generally blocks use for a very strong minority — distinct from the specific cap and widget themes — and runs highest in Canada",
  "4 habits free; widgets, charts, export Pro", "complaint", "31 (3.51%, VERY STRONG), mean 3.06, 38.7% 1–2★; CA 7.1% (HIGH), US 3.8%, DE 2.8%, GB 2.2%", "none", "very strong", "yes", [])
c(75, "§4.3 Platform gaps, ranked by rating damage table (verbatim)", "data-caveat",
  "Platform gaps ranked by rating damage: iPad 18 at 3.61, Mac/web 15 at 3.87, Apple Watch 20 at 4.15",
  "n/a", "complaint", table("## 4.3 Platform gaps"), "none", "verbatim", "app-specific",
  ["13336507038","13092058110","12403426948","12186579144","12162624396","13583765027"])
c(76, "§4.3 iPad; Part 4 #6; Part 6 #4; Part 9 #13", "feature",
  "Native iPad layout before Apple Watch: the iPad complaint hurts most and is cheapest to fix — a responsive layout, not a new app ('on iPad the UI feels stretched and awkward'; one churned over it)",
  "iPhone layout stretched on iPad", "churn", "No native iPad app 18 (2.04%, MEANINGFUL), mean 3.61 (worst of the three), 16.7% 1–2★; 8.4% of 4★, 11.4% of 3★", "must-have", "meaningful", "yes",
  ["13336507038","13092058110"])
c(77, "§4.3 Mac / web; Part 4 #11", "feature",
  "Mac / web app is wanted; several users found the iOS-app-on-Mac workaround themselves; Pro from phone not carrying to macOS is one of the entitlement failures",
  "no native Mac/web app", "complaint", "No Mac / web app 15 (1.70%), mean 3.87, 20.0% 1–2★", "undecided", "meaningful", "yes",
  ["12403426948","12186579144","13105035694"])
c(78, "§4.3 Apple Watch; Part 4 #5; Part 6 #5", "feature",
  "Apple Watch is asked for most and forgiven most — a want, not a blocker (tick a habit from the wrist; several say they would pay), except two 1★s",
  "no Watch app", "complaint", "No Apple Watch app 20 (2.27%, MEANINGFUL), mean 4.15, 15.0% 1–2★; 6.3% of 4★", "build-paid", "meaningful", "yes",
  ["12162624396","13583765027"])
c(79, "Part 4 #9 Bugs reported; §7.2 bugs", "must-never-break",
  "Bugs are reported rarely but at a steep rating cost, and payers are the ones who hit and report them; bug reports are 2.5× more common outside high-spend markets",
  "mostly stable", "1★-burst", "16 (1.81%, MEANINGFUL), mean 2.75, 50.0% 1–2★; 7 of 16 payers (43.8%); high-spend 1.1% vs rest 2.8%", "must-never-break", "meaningful", "yes", [])
c(80, "Part 4 #14 Setup / UI confusing; §4.2 gear icon opens Export", "must-have",
  "Setup / UI confusion is a sharp minority complaint — including a gear icon that opens the Export menu instead of Settings ('Zahnrad öffnet nicht die Einstellungen, sondern das Export-Menu')",
  "gear icon → Export", "1★-burst", "13 (1.47%, MEANINGFUL), mean 2.92, 46.2% 1–2★; 1★ confusing 3 (7.3%)", "must-have", "meaningful", "yes",
  ["13736974190","13213024086"])
c(81, "Part 4 #18 Stated churn to another app", "data-caveat",
  "Stated churn to another app is rare but the angriest group, concentrated in Canada",
  "n/a", "churn", "9 (1.02%, MEANINGFUL), mean 1.89, 77.8% 1–2★; CA 3.6% (VERY STRONG) vs US 0.9%, DE 0.9%, GB 1.1%", "none", "meaningful", "yes", ["13499288017"])
c(82, "Part 4 #24 Wants Health / Strava / Oura integration; Part 6 #12", "feature",
  "Health / Strava / Oura / Duolingo integration is a pure-upside request with stated willingness to pay — 'Would easily pay for the pro version if it had that'",
  "absent", "purchase-driver", "6 (0.68%, EMERGING), mean 4.83, 0% 1–2★", "build-paid", "emerging", "yes",
  ["12139974588","12183133631"])
c(83, "Part 4 #34 Wants friend / accountability sharing; Part 6 #18", "feature",
  "Friend visibility / accountability partner is a small request benchmarked against HabitShare",
  "absent", "complaint", "2 (0.23%, Weak), mean 4.50", "research", "weak", "yes", ["9901846846"])
c(84, "Part 4 #28 Localization gaps; Part 9 #19", "do",
  "Localise the store listing, starting with Chinese and German: the listing is English-only while the app itself supports 15+ languages (changelog 1.2, 1.14, 1.17.2) — DE is 12.1% of the corpus and CN cannot even buy",
  "EN-only listing, localised app", "blocked-conversion", "Localization gaps 4 (0.45%, Weak), mean 4.50; DE 107 reviews (12.1%); CN 4", "do", "recommendation", "yes",
  ["11183018670","11385868721"])
c(85, "Part 4 #30 Wants 'hide completed habits'; Part 6 #15", "feature",
  "Hide / reorder completed habits is asked by long-list users",
  "absent", "praise", "3 (0.34%, Weak), mean 4.33", "undecided", "weak", "yes", [])
c(86, "§4.1 The two request clusters that are pure upside — per-day notes; Part 4 #8; Part 6 #7; §8.2", "feature",
  "Per-day notes are pure upside — people want to record what they did, not only that they did it ('I'd like to add a note specifying which exercises'; 'on a day you missed your habit, write the reason why'; 'I'd be willing to subscribe to pro for that') — shipped in 1.16.0 and confirmed by the reviewer who proposed it; verify late requesters were on older builds before treating it as open",
  "shipped 1.16.0 after 3 years of requests", "purchase-driver", "16 (1.81%, MEANINGFUL), mean 4.81, not one below 4★; requests Nov 2023 → Aug 2026", "undecided", "meaningful", "yes",
  ["13824458972","13036578153","12607872016","14466920687"])
c(87, "§4.1 Sub-habits / folders / pages; Part 4 #17; Part 6 #9", "feature",
  "Sub-habits / folders / pages are the natural next product after categories and what heavy users (10+ habits, the paying segment) ask for: 'label the habit morning routine, click it to open, add a sub-habit like make bed, brush teeth, do skin care, and once you check off all three it will complete that habit'; pages to separate his tracking from his dog's; career vs health folders",
  "categories only", "praise", "11 (1.25%, MEANINGFUL), mean 4.82, zero 1–2★", "build-paid", "meaningful", "yes",
  ["11526306665","13692456434","13149743389","12727692876","11650437167","11081763094"],
  cond="ship opt-in, invisible by default (Part 9 #16)")
c(88, "§4.2 The frequency model is the most-misunderstood part of the product; Part 4 #7; Part 6 #6; §8.4; Part 9 #12", "must-have",
  "Make the existing weekly/monthly goal modes discoverable: the app HAS 'X per week / X per month' goals and rest days, but changelog 1.11 moved frequency behind 'Advanced Options' — so users rate it as missing: a 3★ offered to raise his rating if corrected ('If incorrect advise me how and will adjust review') and nobody took it; a payer 'didn't realize until subscribing to pro… that it is only set up for daily habits'; a FR 2★ says it puts the app behind competitors — the highest ratio of rating gain to engineering cost in the report",
  "feature exists, hidden in Advanced Options", "complaint",
  "Wants weekly / flexible / skip-day goals 17 (1.93%, MEANINGFUL), mean 4.12, 5.9% 1–2★; 8.4% of 4★; span 3y (10266075296 16 Aug 2023 → 14489689059 30 Aug 2026)", "must-have", "meaningful", "yes",
  ["10266075296","11800436326","13187090517","14489689059","13736974190"])
c(89, "§4.2 streak maths for non-daily goals is not trusted; Part 4 #27; Part 9 #4", "must-never-break",
  "Streak maths for non-daily goals is not trusted: 'I'm on a 12 week streak for a habit I started 8 weeks ago'; 'The numeric streak count for weekly goals is strange, so I don't use it'; 'The streak is not a true streak'; one resolved only because the developer explained it personally — a wrong number in a trust-based app is worse than no number; audit it",
  "weekly-goal streak count wrong / opaque", "complaint", "Streak maths confusing 4 (0.45%, Weak), mean 4.00", "must-never-break", "weak, trust-critical", "yes",
  ["13578452293","13856682531","12189061392","11317982485"])
c(90, "§4.2 Genuinely missing: skip / rest days and every-other-day intervals; Part 9 #15", "feature",
  "Genuinely missing: skip / rest days that don't break the chain (public holidays shouldn't break a work habit) and every-other-day intervals — 'leider keine Gewohnheiten, die alle zwei Tage anstehen… Sonst hätte ich es mit der App versucht', a stated non-adoption",
  "no interval / holiday skip", "blocked-conversion", "3 reviews, all 5★ or 4★; cheap", "must-have", "weak, cheap", "yes",
  ["13604363091","12962416172"])
c(91, "Part 4 #29 Wants custom day-boundary (not midnight); Part 6 #14; Part 9 #15", "feature",
  "A configurable day boundary (a 4am rollover, not midnight) for night-shift and late-night loggers — all requesters 5★, cheap fix",
  "midnight rollover", "praise", "3 (0.34%, Weak), mean 5.00", "must-have", "weak, cheap", "yes",
  ["12632001002","13776739735","11670099719"])
c(92, "§4.4 Notifications: a small, sharp, six-review problem; Part 4 #23", "must-never-break",
  "Notifications are a small, sharp problem with opposite failures: reminders silently went quiet ([external] changelog 1.16.1: 'reminders could go quiet for the rest of the week, depending on the day you last opened the app'), fired at the wrong time — and one 1★ says 'This app doesn't have notifications' when it does, a discovery failure inside onboarding",
  "reminders regressed then fixed in 1.16.1", "1★-burst", "6 (0.68%, EMERGING), mean 2.67, 50.0% 1–2★", "must-never-break", "emerging", "yes",
  ["12837659567","10334933288","14470755939"])
c(93, "§4.4 missing notification action; flashy / sticky reminders", "feature",
  "Notification interactions users want: mark 'complete' from a held notification without opening the app ('Not possible to hold notification and choose complete'), more attention-grabbing reminders, and a sticky reminder that can't be dismissed until the habit is done",
  "no actionable notification", "1★-burst", "3 of the 6 notification reviews (1★, 4★, 4★)", "undecided", "weak", "yes",
  ["13184092651","13631547170","12438365647"])
c(94, "§4.5 No AI backlash and almost no AI demand", "dont",
  "Adding AI to this app would be arguing with its own fanbase: users praise the absence — 'without adding AI bloatware'; 'not based around some opaque cloudy AI nonsense' — and only one proposes adaptive scheduling / natural-language logging",
  "no AI", "praise", "2 praise the absence, 1 request", "dont", "weak", "yes",
  ["13891792959","14450302981","13177753546"])
c(95, "§4.5 No billing-fraud or surprise-charge accusations", "contradiction",
  "Unlike apps 3, 5 and 6 in this set, nobody claims they were charged an amount they did not agree to — HabitKit's paid failures are the opposite problem: charged correctly, not delivered",
  "no trial-to-charge or quote/charge issues", "none", "0 billing-fraud accusations vs 8 entitlement failures", "none", "absence", "yes", [],
  cond="billing correctness and entitlement delivery are two separate must-never-break checks")
c(96, "§4.5 No ad complaints; What is *not* in this corpus", "insight",
  "Absences are informative: no ad complaints beyond premium-upsell interstitials (there are no ads), no privacy accusations, no billing-fraud claims, no AI demand, almost no crashes — the complaint load is packaging and missing platforms",
  "no ads, local-only", "praise", "0 ad / privacy / fraud complaints; 8 upsell interstitial complaints", "none", "absence", "yes", [])

# ---- PART 5 — AUDIENCE ----
c(97, "Part 5 WHO ACTUALLY USES THIS table (verbatim)", "data-caveat",
  "Self-described segments: developers/technical, ADHD, ex-bullet-journallers, multi-habit power users, quantified-self, sobriety, non-habit trackers, religious practice",
  "n/a", "praise", table("# PART 5"), "none", "verbatim", "app-specific",
  ["9336703919","9452538229","10422430745","12072650756","12104725882","13116845394","13196795496","10705970933","11674324275","12196979794","13621381288","14089093879","12958968819","13422297301","13244460118","11351318921","9466333479","13291634659","13647254621"])
c(98, "Part 5 Developers / technical users — the founding audience", "audience",
  "Developers and technical users are the founding audience — they recognise the GitHub contribution graph on sight ('If you're a developer, the whole thing feels very familiar from GitHub'; 'It is like GitHub of Habit'; one spots the Flutter build)",
  "GitHub-grid metaphor", "praise", "7 named reviews; 73 grid-metaphor mentions", "do", "founding audience", "app-specific",
  ["9452538229","12072650756","12104725882","13196795496"])
c(99, "Part 5 Ex-bullet-journallers", "audience",
  "Ex-bullet-journallers explain the year-grid attachment — one drew a pixel year-view by hand before",
  "year grid", "praise", "4 named reviews", "do", "small", "yes",
  ["10705970933","11674324275","12196979794","13177753546"])
c(100, "Part 5 Multi-habit power users (10+) — the paying segment", "audience",
  "Multi-habit power users (10+ habits) are the paying segment, and they drive the folders, colours and hide-completed requests — '21 colours not enough for 10+ habits'",
  "unlimited habits Pro", "purchase-driver", "4 named reviews", "build-paid", "segment", "yes",
  ["13621381288","14089093879","12958968819","13422297301"])
c(101, "Part 5 Sobriety / consumption reduction; Part 6 #11; §8.2 Quit-habit mode", "timeline",
  "Quit-habit mode: requested from 2024, rising to 2.53% of P4, shipped in 1.17.0 and immediately validated — 'The quit option work surprisingly well… I'm more motivated because I don't have to open the app to log a missed day'; sobriety users already used the app ('tried multiple apps to motivate me to have alcohol-free days, this is the only one that's worked')",
  "shipped quit-habit mode Aug 2026", "praise", "Wants bad-habit / quit mode 11 (1.25%, MEANINGFUL), mean 4.00, 27.3% 1–2★; 0.00% → 0.43% → 1.62% → 2.53%; paid cohort 4 of 11 (36.4%)", "build-free", "meaningful", "yes",
  ["11762071060","14470496356","11351318921","9466333479","10417971167"])
c(102, "Part 5 Religious practice [limited evidence, n=2]", "audience",
  "Religious practice is a use case — daily Bible reading, and a request for location-based Islamic prayer times ('potenziell 2 Milliarden Kunden')",
  "generic habits only", "praise", "2 [limited evidence]", "research", "limited evidence", "yes",
  ["13291634659","13647254621"])

with open("Tools/prd_ledger/7/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
