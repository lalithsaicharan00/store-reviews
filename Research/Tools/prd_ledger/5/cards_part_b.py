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

# ---- 1.1 ----
c(12, "§1.1 table (verbatim)", "monetization", "The model as reconstructed from reviews: free vs paywalled elements with evidence — full table",
  "n/a", "mixed", table(142, 153), "none", "high-priority", "yes", [])
c(13, "§1.1 row 1", "feature", "Creating routines with unlimited steps/tasks is free — 'you make routines with unlimited steps and checklists'",
  "unlimited steps free; routines capped at 2", "praise", "2 IDs", "build-free", "stated", "yes", ["12470101467","13361043130"],
  cond="the cap is on the number of ROUTINES, not tasks — quantity gating at a coarser grain than report 4's task cap")
c(14, "§1.1 row 3", "feature", "The sequential timer, voice/TTS announcements and live ETA are free — the core value is not gated",
  "core timer free", "praise", "3 IDs", "build-free", "stated", "yes", ["13503431066","12470101467","11640510418"])
c(15, "§1.1 row 4", "feature", "The full icon/emoji library is partly paywalled — 17 reviews (0.51%): 'one of them were freaking ICONS'",
  "icons partly paid", "complaint", "17 (0.51%)", "build-free", "emerging", "yes", ["11079201751","10203934956","9775758576","12257661729","13261964716"],
  cond="report 1 and 2 gave icons free and it drove 5★; gating icons draws a 1★ here")
c(16, "§1.1 row 5", "feature", "Analytics / statistics are paywalled — 'statistics being a paid service?' (KR, 1★)",
  "stats paid", "complaint", "3 IDs", "build-paid", "weak", "yes", ["9189599066","9264877129","11486140970"])
c(17, "§1.1 row 6", "feature", "Custom reminder sounds and satisfaction notes are paywalled", "paid", "complaint", "1 ID", "undecided", "single review", "yes", ["11486140970"])
c(18, "§1.1 row 7", "anti-pattern", "Routine duplication and archiving became paywalled ~2025 — 'Making duplicate routine premium and then archive routines is now inconvenient'",
  "re-paywalled duplicate/archive in 2025", "complaint", "2 IDs", "dont", "weak", "yes", ["13100664783","13502501341"],
  side="another instance of moving a free capability behind the paywall")
c(19, "§1.1 row 8", "anti-pattern", "Streak savers became ad-gated even for subscribers in 2025 — 'it won't let me use my accumulated streak savers without watching an ad? I'm a paid subscriber to the annual plan'",
  "ads gate a feature for payers", "1★-burst", "1 ID (2★)", "dont", "single review, severe", "yes", ["13099883499"])
c(20, "§1.1 row 9", "timeline", "A lifetime / one-time purchase appears to have launched ~2026 — '5 minutes in and I've already snagged the lifetime' (Apr 2026); 'I purchased it for life' (Aug 2026)",
  "shipped lifetime SKU in 2026", "purchase-driver", "4 IDs Apr–Aug 2026", "product-rule", "weak count, clear signal", "yes",
  ["13987336109","14216125689","14375560440","14365784546"],
  side="the corpus says lifetime was six years overdue (§1.5) and converted within five minutes of being seen")
c(21, "§1.1 prices line", "monetization", "Prices named: $2.99–$5/mo; $20–$36/yr US; ₩35,000/yr KR; £25–30/yr; €30–45/yr; ¥4,000–4,200/yr; 339 kr/yr SE; one nonsensical '$52/month' display (2021) — a likely price-display bug",
  "subscription ~$20–36/yr", "mixed", "prices as reported", "research", "indicative", "yes",
  ["11104661863","12319574416","9224882379","10800331235","8941948970","9465428819","13863035457","14239220013","12354215582","7390930425"])

# ---- 1.2 ----
c(22, "§1.2 opening + #1", "insight", "120 reviews (3.59%) contain self-reported purchase evidence; the dominant path by far: the free tier worked first and they upgraded to scale it — 'two routines for free… enough to be worthwhile but I paid for the subscription right away'; 'Bought it finally after a year of use'; 'used it well for years, so I bought the annual'; three and four years free then premium",
  "generous free tier converts over years", "purchase-driver", "120 (3.59%); path #1", "product-rule", "very strong", "yes",
  ["13093885049","8448464887","12444613825","13891754512","13595999311","12900411902"],
  side="conversion here is earned over years of free use, not forced at onboarding — the opposite of report 4",
  cond="do not read a conversion rate from this: 3.59% is reviewers who mention paying")
c(23, "§1.2 #2", "insight", "Purchase path #2: needing more than two routines — the cap converts when the user has genuinely outgrown morning+night: 'the subscription has no restrictions on the quantity of routines (I have tons now)'",
  "2-routine cap", "purchase-driver", "3 IDs", "undecided", "weak", "yes", ["11776189779","12899184203","14497138417"])
c(24, "§1.2 #3", "insight", "Purchase path #3: Apple Watch capability — several Korean reviewers bought a WATCH because of this app, then subscribed: '루티너리 쓰려고 워치 샀어요' (I bought a Watch to use Routinery)",
  "Watch app as a hardware-driving feature", "purchase-driver", "4 IDs", "build-paid", "weak, striking", "yes", ["6633721289","7046987901","9607295246","7621728149"],
  side="a Watch experience good enough to drive hardware purchases is a premium feature by definition")
c(25, "§1.2 #4", "insight", "Purchase path #4: price framed as trivially small — 'if I can build a habit for 100 won a day'; 'it's only $2/month to feel like a normal human'",
  "~$2–3/mo", "purchase-driver", "2 IDs", "product-rule", "weak", "yes", ["6669295549","11392402930"])
c(26, "§1.2 #5", "insight", "Purchase path #5: demonstrated outcome after a streak — a ~300-day-streak user: 'I'm paying real life human dollars for this app and it is worth every penny'",
  "n/a", "purchase-driver", "1 ID", "do", "single review", "yes", ["12625991801"])

# ---- 1.3 ----
c(27, "§1.3 tables", "insight", "Confirmed payers (n=120) rate 3.48 vs 4.16, 30.0% 1–2★ vs 14.4%; over-represented among payers: refund 4.8×, gift/promo dispute 9.2×, nagging 5.2×, ads 3.9×, sync failure 3.1×, Watch defect 2.1×, data loss 2.5×, task-level day scheduling 4.6× — paying users are the ones who hit sync, watch, data-loss and advanced-scheduling limits, AND the ones being shown ads and upsells",
  "payers hit the limits and see the ads", "churn", table(171, 175) + " ; " + table(179, 189), "must-never-break", "high-priority (directional, n=120)", "yes", [],
  side="the most commercially important finding in the report")
c(28, "§1.3 quotes", "anti-pattern", "A subscriber who is shown an ad churns loudly: 'multiple back-to-back, full-screen unskippable, LONG brainrot ads before you can proceed. Even as a paying subscriber'; 'even on the premium version I am bombarded with ads'; a lifetime buyer still got banner ads (later fixed); an annual subscriber gets a full-screen 'change plan' pop-up on every open because prices went up",
  "ads and upsells shown to payers", "1★-burst", "4 quoted IDs; ads 5.8% of payers", "dont", "meaningful", "yes",
  ["14021959851","13382239088","14049946488","13726548501"],
  cond="ads to payers is the most reliable way to turn an advocate into a 1★")

# ---- 1.4 ----
c(29, "§1.4 opening + table", "must-never-break", "Billing integrity: 91 reviews (2.72%, mean 2.31, 64.8% 1–2★) — refund demanded 52 (1.56%), 'free trial' charged immediately / annual instead 31 (0.93%, mean 1.55, 87.1% 1–2★), unexpected/auto-renewal charge 26, cannot cancel 12, 1+1 gift-code promo not honoured 12 — small globally, concentrated in Korea, severe where it lands; 'It said free trial but billed me instantly. I tried to get a refund 60 seconds later'; still occurring Sep 2026",
  "trial charges immediately for some; cancellation and refunds fail", "1★-burst", table(202, 210), "must-never-break", "meaningful", "yes",
  ["11422332321","11674221985","13666735555","12852521520","11919502264","12403701027","12379919405","13878515388","14509669820","12213361997","12448354189","12477311939","12394473219"],
  side="trial/billing reviews average 1.55 stars — the single most reliable generator of 1★ in the corpus; some describe cancelling and still being charged (defect), others misreading the plan screen",
  cond="same shape as report 4 at a fifth of the rate")
c(30, "§1.4 1+1 promo", "anti-pattern", "The 1+1 gift-code promo is a distinct self-inflicted wound: users bought 'buy one year, get one year', then found the second code could not be used by themselves and expired in 3 months — the restriction was in light-grey fine print on white (39-vote review); one received 1 month instead of 12; still unresolved Mar 2026",
  "promo whose terms contradict its name", "1★-burst", "12 (0.36%), mean 3.75; 9.2× over-represented among payers", "dont", "weak count, clear mechanism", "yes",
  ["8142666759","9512372663","12273106669","6913284885","8195028670","9530513755","9557023526","13901606439"],
  side="a promo that reads one way and works another is a billing-integrity complaint, not a marketing one")

# ---- 1.5 ----
c(31, "§1.5", "monetization", "The subscription-vs-one-time debate is real but stable and mostly polite: 255 reviews (7.63%, mean 3.47) discuss the model; 46 (1.38%, mean 3.76) explicitly ask for a one-time/lifetime purchase — 'I would gladly pay a one-time fee, but don't pay for subscriptions on apps like this'; 'LIFETIME access… I'd be willing to go up to maybe $60'; requests spread evenly 2020–2026 (the demand never went away) and the 2026 lifetime reviews suggest it was finally answered — six years overdue",
  "subscription until ~2026", "blocked-conversion", "255 (7.63%); 46 (1.38%) one-time asks at 3.76; by year 10/6/6/10/2/6/6", "product-rule", "high-priority", "yes",
  ["8984943439","6461798867","9197464713","12433331798","7590856614","13823849345","14239220013","11308909258","9465428819","10800331235","12432503704","13645079984","13987336109"],
  side="a stated preference from people who otherwise like the app, not a churn event; willingness to pay MORE for lifetime than the typical app price")
c(32, "§1.5 price objection", "market", "Price objection proper is small (19, 0.57%, mean 2.74), concentrated in KR, IN, GB, with one explicit purchasing-power argument: 'India is a poor country and you charge us more for a subscription than those in the USA'",
  "higher price in India than the US", "complaint", "19 (0.57%), mean 2.74", "do", "emerging", "yes", ["8911150255"])

# ---- 1.6 ----
c(33, "§1.6", "anti-pattern", "Ads were introduced ~2023 and escalated in 2025 (2→3→2→9→6→19→8 complaints by year; 49 total, 1.47%, mean 3.41): '45 seconds of ads… I even recommended this to people, now I have to go apologise'; 'the ad section is bigger than the routine section now'; and from a 5★ user: 'the addition of in app ads lately has been really annoying. I think limiting us to two routines is fine enough' — the cap is accepted; the ads are not",
  "added ads to a previously ad-free app, escalated them", "complaint", "49 (1.47%), mean 3.41, 32.7% 1–2★; 19 in 2025", "dont", "meaningful", "yes",
  ["12961330080","13032976287","13186195934","13502501341","13551456063","10598751597"],
  side="the whole trade-off in one sentence from a five-star user: users tolerate a quantity cap and reject ads",
  cond="adding ads to an established ad-free app is a form of re-paywalling")

# ---- 1.7 ----
c(34, "§1.7", "anti-pattern", "Review-prompt and upsell nagging — 27 reviews (0.81%, mean 3.52) — fires on routine completion, the app's highest-frequency event, so it feels like harassment: 'after every routine the app asks me to review it'; 'they continue even after I say no'; 'even on the paid subscription it opens the App Store without asking… I'm looking for another app'; several reviewers say they only reviewed to make it stop",
  "review prompt on every routine completion, even for payers", "complaint", "27 (0.81%), mean 3.52", "dont", "emerging", "yes",
  ["12140481975","12152542435","14390918053","12809291422","11693253776","13814479381","14037700755","12863665218"],
  side="prompting at the highest-frequency event inflates review volume and makes the corpus MORE representative of daily users — a selection-bias caveat",
  cond="fire the prompt on a milestone, not on every completion; never on payers who said no")

with open("Tools/prd_ledger/5/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
