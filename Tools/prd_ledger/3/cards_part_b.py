import json, re
R = 3
rep = open("App Store Reports/3. Days Since - Quit Habit Tracker - Sober Streak Day Counter (REPORT).md").read().split("\n")
def table(start, end):
    rows = [l for l in rep[start-1:end] if l.startswith("|") and not re.match(r"^\|[\s\-:|]+\|$", l)]
    return " ; ".join(re.sub(r"\s*\|\s*", " | ", l.strip("|")).replace("**","").strip() for l in rows)
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))

# ---- 1.1 ----
c(12, "§1.1 bullet 1", "monetization", "Free download with no ads anywhere — 206 reviews (1.94%) explicitly praise the absence of ads at mean 4.94, and zero of them are 1–2★",
  "no ads", "praise", "206 (1.94%), mean 4.94, 0 1–2★", "product-rule", "meaningful", "yes", [])
c(13, "§1.1 bullet 2", "monetization", "Subscription-first, branded 'Count Up Club' (earlier 'Premium'): yearly $17.99, monthly $5.99 / $2.99, lifetime $49.99, discounted $11.99; legacy Premium $29.99/yr, $9.99/mo",
  "subscription with a lifetime option at ~2.8× the yearly", "mixed", "IAP list from the store page (2026-09-09)", "research", "external source", "yes", [],
  cond="a rebrand of the paid tier left two SKU families visible on the store page")
c(14, "§1.1 bullet 3", "monetization", "Reviewers name a wide spread of prices — $17.99–18/yr, $50 lifetime, $30/yr, $22/yr, €7/mo, £6/mo, €60 lifetime, ₹5,000/yr, $12/yr legacy — so the pricing surface is inconsistent; one buyer 'can't find the count up club' they paid for",
  "inconsistent prices across periods and SKUs", "complaint", "≥9 distinct price points reported", "must-never-break", "meaningful", "yes",
  ["9642317256","12870203346","13478631404","13571382100","12872057253","13723431455","13223954026","12942245612","11602241705","13471712113","13490897194","9468239921","10584415042","13409969245","11367914478","14107888082","10103510351","13189265606","10468707953","14364118481","9912775984"],
  side="two SKU families + a rebrand = buyers who cannot find what they bought (R03-024)")

# ---- 1.2 ----
c(15, "§1.2 table (verbatim)", "monetization", "Features named as paywalled with count, %, mean and 1–2★ — full table",
  "n/a", "mixed", table(109, 117), "none", "high-priority", "yes", [])
c(16, "§1.2 table row 1 + bold", "feature", "Widget / Lock Screen / Home Screen behind the paywall: 120 reviews (1.13%), mean 2.53, 59.2% 1–2★ — everything else paywalled is tolerated (4.0+ means); this is 'the cleanest pricing signal in the dataset'",
  "widget paid (since Jul 2025)", "1★-burst", "120 (1.13%), mean 2.53, 59.2% 1–2★", "build-free", "high-priority", "yes", [],
  cond="a feature that has been free for years, and that is the primary surface, cannot be paywalled")
c(17, "§1.2 table row 2", "feature", "Goals behind the paywall is tolerated (mean 4.05, 14.3% 1–2★) and is the #2 purchase trigger",
  "goals paid", "purchase-driver", "21 (0.20%), mean 4.05; 4 buyers name it — 'The goals are 100% worth upgrading for'", "build-paid", "weak", "yes", ["13144761902"])
c(18, "§1.2 table row 3", "feature", "Reminders / notifications behind the paywall draw 19 reviews at mean 3.63 (31.6% 1–2★) — tolerated but less so than goals or colours",
  "reminders paid", "mixed", "19 (0.18%), mean 3.63, 31.6% 1–2★; 2 buyers name it", "undecided", "weak", "yes", [],
  cond="report 1 made the first reminder free and only extras paid; here all reminders are paid and it costs a third of a star more than goals")
c(19, "§1.2 table row 4", "feature", "Colours / app icons behind the paywall are tolerated (mean 4.00, 15.4% 1–2★) and 2 buyers name colours as their reason",
  "colours and icons paid", "purchase-driver", "13 (0.12%), mean 4.00", "build-paid", "weak", "yes", ["13602265269","13395203249"],
  cond="report 1 gave colours away free and they drove 5★ — both work; cosmetics are safe to gate, not safe to un-gate")
c(20, "§1.2 table row 5", "feature", "Backup / export / import / iCloud behind the paywall draws 12 reviews at mean 3.42 (33.3% 1–2★)",
  "backup/export/sync paid", "complaint", "12 (0.11%), mean 3.42", "build-free", "weak", "yes", [])
c(21, "§1.2 table row 6", "feature", "Siri Shortcuts behind the paywall: 4 reviews, mean 2.25, 75% 1–2★",
  "Shortcuts paid", "complaint", "4 (0.04%), mean 2.25", "undecided", "ignore-band", "yes", [])
c(22, "§1.2 table row 7", "feature", "Apple Watch behind the paywall: 1 review, 1★", "Watch paid", "complaint", "1 (0.01%)", "undecided", "ignore-band", "yes", [])
c(23, "§1.2 free-tier list", "feature", "Free tier confirmed working: unlimited counters, custom titles and emojis, colour coding, reset with note, full reset history, longest/average streak stats, calendar streak view, time-unit switching (seconds → years), Face ID / passcode lock, alternate app icons, social share images, dark mode",
  "all of these free", "praise", "no cap found in any review; one claim of a 20-counter limit contradicted by a user tracking '100+ things'", "build-free", "stated", "yes", ["12098476442","13602265269"],
  cond="passcode lock is free here (paid in reports 1 and 2)")

# ---- 1.3 ----
c(24, "§1.3 opening", "insight", "45 reviews (0.42%) confirm a first-hand purchase — hand-curated list",
  "n/a", "purchase-driver", "45 (0.42%)", "none", "weak", "yes",
  ["9466347369","9483674873","9659762298","9912775984","10120217443","10246644188","10263513150","10570659048","10618771296","10764707061","11108689966","11148249366","11291342307","11336770737","11366641851","11602241705","11618250403","11729131712","11787136840","12130917231","12308505754","12585734229","12708219985","12795625876","12868861275","12879539920","12936970266","13115850782","13144761902","13246151828","13257489481","13308257943","13395203249","13571741107","13602265269","13704550155","13843033653","13964501187","14007541207","14060380344","14144614865","14324807045","14364118481","14392573700","14461407652"])
c(25, "§1.3 trigger table", "insight", "Stated reasons to pay: widget customisation / reset-from-Home-Screen 5, goals 4, support the indie devs 4, colours 2, reminders 2, Apple Watch 1, accidental / forgot to cancel trial 2",
  "n/a", "purchase-driver", table(129, 138), "none", "weak counts", "yes",
  ["12936970266","14324807045","13308257943","13395203249","11291342307","13144761902","14392573700","12622562349","12308505754","11366641851","14364118481","14461407652","10081706180","13602265269","10246644188","11602241705","11618250403","12144029927"],
  side="the #1 purchase trigger is widget customisation — the widget sells when the base widget is free")
c(26, "§1.3 trigger row 'Accidental'", "monetization", "Two purchases were accidental / forgot-to-cancel-trial — one left 3★",
  "trial converts to paid automatically", "complaint", "2 of 45 buyers", "must-never-break", "weak", "yes", ["11618250403","12144029927"])
c(27, "§1.3 buyers' words", "insight", "Buyers who are happy anchor on price-per-month ('$12 a year. That's $1 a month… Get a grip'), on motivation ('spending $20 on this app for a year is a super motivating way to keep track of my goals') and on responsiveness ('The developers even added my suggestion into the app')",
  "n/a", "purchase-driver", "4 quoted 5★ buyers", "do", "qualitative", "yes", ["14364118481","12130917231","11602241705","12795625876"],
  side="paying can itself be a commitment device for a recovery tool")

# ---- 1.4 ----
c(28, "§1.4 table + bold", "insight", "Paying costs the app roughly nine-tenths of a star and multiplies the 1–2★ rate by eight: payers 3.91 vs 4.77, 24.4% 1–2★ vs 3.11%",
  "n/a", "churn", "payers n=45: 3.91, 24.4% 1–2★, 64.4% 5★; corpus 4.77, 3.11%, 87.1%", "must-never-break", "high-priority", "yes", [])
c(29, "§1.4 'did not move'", "insight", "Payer sentiment did not move across the July 2025 boundary (pre 3.92, post 3.90) — the paywall damage lands on FREE users; the buyer problem is different: delivery and billing",
  "n/a", "churn", "pre n=24 mean 3.92; post n=21 mean 3.90", "must-never-break", "high-priority", "yes", [],
  side="two distinct failure modes: re-paywalling hurts free users, entitlement/billing failures hurt payers")
c(30, "§1.4 1–2★ payer table (verbatim)", "timeline", "The eleven 1–2★ payers, in full — what each paid for and what happened",
  "cannot find the tier they paid for; charged $17.99 twice a week for a month after cancelling; subscription not recognised on Mac, no iCloud sync; premium buyer still upsold every launch for months; cannot set future dates, support silent two weeks; paid for Lock Screen widget but cannot choose the counter; charged for a monthly sub never agreed to and data gone; counter 2 days off at 2 years; cannot find how to cancel; Lifetime buyer still told to subscribe for widgets; reset broken and no iPad↔iPhone sync", "1★-burst",
  table(159, 171), "must-never-break", "high-priority", "yes",
  ["9912775984","10263513150","10570659048","10764707061","11148249366","13115850782","13704550155","13843033653","13964501187","14060380344","14144614865"],
  side="six of eleven are billing or entitlement failures, not product complaints")
c(31, "§1.4 closing", "must-never-break", "The worst case in the corpus: a Lifetime purchaser who did not receive the feature the purchase exists to unlock — still told to subscribe for widgets",
  "entitlement not honoured", "1★-burst", "1 review, but the archetype of the entitlement failure", "must-never-break", "single review, severe", "yes", ["14060380344"])

# ---- 1.5 ----
c(32, "§1.5 bullet 1", "monetization", "21 reviews (0.20%) say they would pay but haven't — several explicitly ask for a donate or tip button because the app has no way to give money",
  "no tip/donate option", "blocked-conversion", "21 (0.20%); ~12 unsolicited offers to donate", "do", "weak", "yes",
  ["8659150662","7190023036","7259554838","7981181148","7596500499","7934568657","6826653115","7409351582","8811617621","8410535615","8581180685","7942101292"],
  side="'The only thing I miss is a donate button' — goodwill with nowhere to go")
c(33, "§1.5 bullet 2", "monetization", "18 reviews (0.17%) explicitly demand a one-time purchase instead of a subscription",
  "subscription-first; lifetime exists at $49.99 but is not what they mean", "blocked-conversion", "18 (0.17%)", "product-rule", "weak", "yes",
  ["9642317256","10149619417","11400900906","11594710921","11726683344","12173342801","12318988707","11624049028","10584415042","12456220146","14151250043","13656090865","12721975270","9385157078","13434276029","11420159085","9536310663","14060380344"],
  cond="a $50 lifetime on a free counter app does not read as 'one-time purchase' to these users — price level matters, not just the SKU type")
c(34, "§1.5 bullet 3", "market", "Regional pricing is asked for by name in UA, TR, IN, SA — 'I would buy yearly if it was at least 60–70% cheaper. I don't think you are making any profits from Turkiye'; 'Localized pricing for digital goods is a well-researched topic'",
  "single global price", "blocked-conversion", "6 IDs across 4 markets", "do", "weak", "yes",
  ["10584415042","11570961952","10134372371","10848084400","10468707953","13656090865"],
  side="the review text says price is the only blocker in these markets")

# ---- 1.6 ----
c(35, "§1.6 opening + quotes", "anti-pattern", "Subscription nagging is chronic: 176 reviews (1.66%, mean 4.35) complain about upgrade pop-ups, present in every era and peaking 2024 — 73% of them are 5★ users who like the app enough to keep it and still complain; there is no 'no, never' option; a permanent banner hides the third row of counters",
  "full-screen upsell interstitials, permanent banner, settings reminder; no opt-out", "complaint", "176 (1.66%), mean 4.35; 129 of 176 (73%) are 5★", "dont", "meaningful", "yes",
  ["12456220146","9347710178","12041109291","13413526077","13223954026","10507973491","11447347782","11764640342","12781765544","11631487359","11053407529","9532159519","10801499811","11851863331","12091997037","14185154968","14341258724"],
  side="'Leave me alone and let me actually experience the app as a first time user before telling me the extra features'",
  cond="upsell before first value is the specific complaint; a 'never ask again' control is the specific fix")
c(36, "§1.6 review-prompt paragraph", "anti-pattern", "11 reviews complain about review-prompt nagging — three from paying customers — including one whose iOS opt-out of review prompts is ignored 'even on the lifetime paid plan'; 'comes across as scammy'",
  "in-app review prompts that ignore the iOS opt-out and hit payers", "complaint", "11 reviews, 3 from payers", "dont", "weak", "yes",
  ["12282678957","10818110589","11519112210","13083333768","10094842714","12520439155","12029565290","11640646593","13352415665","14339177491","14248121134"])
c(37, "§1.6 counterpoint", "tactic", "The review prompt is also one of the app's most effective acquisition assets: at least 40 reviews say they wrote the review only because the request was charming — the prompt is not the problem; its frequency and its ignoring of the iOS opt-out are",
  "a charming, well-written review request", "5★-burst", "≥40 reviews written because of the prompt", "do", "qualitative, clear mechanism", "yes",
  ["8285762745","8034718546","12229362617","8862823851","8731237614","14347631180","9421444201","12732351894","8993759816","13067292411","10570326748","8250508459","9489905182"],
  side="tone of the ask converts; cadence and disrespecting opt-out backfire")

# ---- 1.7 ----
c(38, "§1.7 #1", "product-rule", "Paywalling the widget was the single most expensive product decision visible in this dataset — 128 reviews, mean 2.48, and a full-quarter rating collapse",
  "paywalled the widget", "1★-burst", "128 (1.21%), mean 2.48", "product-rule", "high-priority", "yes", [], cond="evidence: R03-003, R03-006, R03-008, R03-016")
c(39, "§1.7 #2", "must-never-break", "Not honouring entitlements: Lifetime buyers told to subscribe, paid subscribers who can't find what they bought, premium members still shown upsells",
  "entitlement failures", "1★-burst", "≥4 IDs", "must-never-break", "meaningful", "yes", ["14060380344","9912775984","10764707061","12282678957"])
c(40, "§1.7 #3", "must-never-break", "Billing hygiene: double charges, unclear cancellation, charges after trial cancellation",
  "billing errors", "1★-burst", "≥7 IDs", "must-never-break", "meaningful", "yes",
  ["10263513150","11203632971","13964501187","10999894947","11248201618","11722683268"])
c(41, "§1.7 #4", "dont", "Nagging users who already said no — 176 reviews and no 'never ask again' control",
  "no opt-out on upsell", "complaint", "176 (1.66%)", "dont", "meaningful", "yes", [], cond="evidence: R03-035")
c(42, "§1.7 #5", "monetization", "No one-time / tip option at a sane price — 18 explicit requests plus ~12 unsolicited offers to donate; the corpus contains people literally asking to give money in a way the app doesn't accept",
  "subscription or $50 lifetime only", "blocked-conversion", "18 + ~12", "product-rule", "weak", "yes", [], cond="evidence: R03-032, R03-033")
c(43, "§1.7 #6", "market", "No regional pricing in IN, TR, UA, SA — markets where the review text says the price is the only blocker",
  "single global price", "blocked-conversion", "6 IDs", "do", "weak", "yes", [], cond="evidence: R03-034")

with open("Tools/prd_ledger/3/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
