import json, re
R = 19
rep = open("App Store Reports/19. Wisey - Habit Builder - Form habits, change your life (REPORT).md").read().split("\n")
def table(after, k=0):
    i = next(n for n, l in enumerate(rep) if after in l)
    blocks, cur = [], []
    for l in rep[i+1:]:
        if l.startswith("|"): cur.append(l)
        elif cur:
            blocks.append(cur); cur = []
            if len(blocks) > k: break
    if cur: blocks.append(cur)
    rows = [l for l in blocks[k] if not re.match(r"^\|[\s\-:|]+\|$", l)]
    return " ; ".join(re.sub(r"\s*\|\s*", " | ", l.strip("|")).replace("**","").replace("`","").strip() for l in rows)
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))

# ---- PART 3 ----
c(32, "§3.1 The corpus splits into two subjects, and one dwarfs the other (verbatim table)", "insight",
  "75 of 105 (71.43%) raise any money theme, 51 (48.57%) any product theme, 35 both, 40 money only, 16 product only, 14 neither, and only 10 (9.52%) report a functional software defect — a habit tracker generating 7.5× more billing complaints than bug reports; in every other folder in the collection the ratio runs the other way; the engineering surface is not what is failing, the commercial surface is",
  "commercial failure, not engineering failure", "1★-burst", table("## 3.1 The corpus splits"), "product-rule", "high-priority", "yes", [])
c(33, "§3.2 Prioritised negative themes (verbatim table, 38 rows)", "data-caveat",
  "Negative themes (n/105): SCAM_LABEL 57 (54.29%) — the corpus's default vocabulary; REFUND_REFUSED 25; CANCEL_HARD 24; NOT_AS_ADVERTISED 19; BILL_POST_CANCEL 19; BILL_UNAUTH 19; OFF_STORE 18; SUPPORT_FAIL 17; BILL_DOUBLE 16 (15.24%); PRICE_HIGH 15 (14.29%) — nobody defends the price; ADHD_TARGETING 13; LOW_VALUE_VS_FREE 13; CONTENT_THIN 12 (11.43%); EBOOK_UPSELL 11; TRIAL_MISLEAD 10 (9.52%); UX_POOR 7; APP_THIN 7; REFUND_14DAY 6; SOCIAL_AD 6; LEGAL_ESCALATION 6; ENTITLEMENT_FAIL 5; NO_CUSTOM_PLAN 5; SUPPORT_RETENTION_LOOP 5; FINE_PRINT 5; DARK_PATTERN 5; TRUST_LOW 4; RECEIPT_MISSING 4; PRICE_MISMATCH 3; MONEYBACK_BROKEN 3; PAYWALL_UPFRONT 3; PRICE_OPACITY 3; RENEWAL_SURPRISE 3; DISCOUNT_LADDER 3; NO_TRIAL 3; ONBOARDING_GAP 2; BUG_CANCEL_FORM 2; ENGAGEMENT_LOW 2; ALT_APP_NAMED 2; plus 14 emerging singletons",
  "n/a", "1★-burst", table("## 3.2 Prioritised negative themes"), "none", "theme table", "app-specific", [])
c(34, "§3.2 SCAM_LABEL — 57 of 105 use the word scam / fraud / crooks / stealing", "insight",
  "57 of 105 (54.29%) use the word scam, fraud, crooks or stealing — the corpus's default vocabulary, not a fringe reaction; 59.4% of the 1★ band", "n/a", "1★-burst", "57 (54.29%, High-priority)", "none", "high-priority", "app-specific", ["12692126207","12896636688"])
c(35, "§3.2 NOT_AS_ADVERTISED — gap between the ad and the app; PRICE_HIGH — nobody defends the price; CONTENT_THIN", "insight",
  "Not-as-advertised (19, 18.10%), price too high (15, 14.29% — nobody defends the price) and thin content — courses/videos/PDFs judged worthless, one calling them AI-generated (12, 11.43%) are all high-priority", "advertised programme ≠ delivered checklist", "1★-burst", "19 + 15 + 12", "dont", "high-priority", "yes",
  ["13675718331","12760145236","14107869084"])
c(36, "§3.2 TRIAL_MISLEAD — 'free trial' that charged; FINE_PRINT; RENEWAL_SURPRISE; PRICE_OPACITY; PRICE_MISMATCH; RECEIPT_MISSING", "must-never-break",
  "A 'free trial' that charged (10, 9.52%); terms found only after charging (5); no renewal warning (3); price not visible at decision time (3 — 'They hide price on the main page'); charged ≠ agreed (3 — $29.99 annual agreed, $59.99/month billed); no confirmation or record (4, 3.81%)",
  "trial/price/renewal disclosure failures", "1★-burst", "10 + 5 + 3 + 3 + 3 + 4", "must-never-break", "high-priority / very strong / meaningful", "yes",
  ["12985541561","13311158289","13742636617","13716802092","13803171356","13921976046","12742285860","13248498967"])
c(37, "§3.2 Emerging-signal singletons retained because each names a specific fixable thing", "data-caveat",
  "Fourteen singletons retained: feature backlog (back-dating), login bug (error 300), freeze, account-access bug, immediate termination on cancel, AI content, upsell bombardment, localisation (Spanish ads, English app), discovery gap (web portal), ineffective, partial refund, severe harm, jurisdiction note, funnel critique",
  "n/a", "complaint", "14 × 0.95%", "none", "emerging", "app-specific",
  ["12915336789","13258914566","13816735964","13876370915","12933789910","13675718331","13381915569","13710711149","13398540937","13117882072","13921976046","13636589290","13689727356","13975889341"])
c(38, "§3.2 IMMEDIATE_TERMINATION — access cut the moment you cancel", "dont",
  "One reviewer reports access terminated immediately on cancellation rather than at period end", "cancel = instant lockout", "complaint", "n=1", "dont", "emerging", "yes", ["12933789910"])
c(39, "§3.3 Positive themes — the complete list (verbatim table)", "insight",
  "Positive themes: generic praise 7 (all 5★ burst); tone 'feels human / calm' 2; reminders 1; widget 1; web courses genuinely useful 1; 'technically easy to use' inside a 1★; support bot pleasant inside a 1★ — excluding the December burst the corpus contains three positive statements in sixteen months, two inside one-star reviews",
  "n/a", "praise", table("## 3.3 Positive themes"), "none", "theme table", "app-specific",
  ["13549237052","13552347079","13568090356","13571866718","13398540937","13117882072","13251215774"])
c(40, "§3.4 Unmet needs — every request in the corpus (verbatim table); scarcity is itself a finding", "feature",
  "Only six requests — people fighting a charge do not file feature requests: surface the web portal from inside the app ('a few seconds to say look here for more help… and have a hyperlink'); allow back-dating a completed habit ('I did the habit so why can't I go back and track it?'); Spanish localisation (ads run in Spanish, app English-only); in-app guidance ('I don't see instructions!!!'); a way to evaluate before paying; cancel from inside the app",
  "requests", "complaint", table("## 3.4 Unmet needs"), "none", "request table", "app-specific",
  ["13398540937","12915336789","13710711149","13150371570","13405220625","14289131320","12819961338","12731738911","13099305086","13280826420"])
c(41, "§3.4 Spanish localisation — ads run in Spanish, the app is English-only", "market",
  "Ads run in Spanish but the app is English-only (cl reviewer)", "localised ads, unlocalised app", "complaint", "n=1", "dont", "emerging", "yes", ["13710711149"])
c(42, "§3.4 In-app guidance / instructions", "feature",
  "'I'm finding little in the way of guidance. I don't see instructions!!!' — no onboarding guidance", "no instructions", "complaint", "2 (ONBOARDING_GAP 1.90%)", "must-have", "meaningful", "yes", ["13150371570","14087411464"])
c(43, "§3.4 Cancel from inside the app — a cancel button that is not an email", "must-have",
  "Three ask for a cancel button inside the app instead of an email", "email-only cancellation", "complaint", "3 named; CANCEL_HARD 24", "must-have", "high-priority", "yes", ["12731738911","13099305086","13280826420"])
c(44, "§3.5 Competitors named — Fabulous and Triimo; trust is a feature people comparison-shop on", "positioning",
  "Only two competitors, both named by departing payers as the better alternative: Fabulous ('much better'; folder 24 in this collection) and Triimo ('it actually works and customer service aren't trying to rob you') — in this category at this price point, trust is a feature people comparison-shop on",
  "compared against Fabulous, Triimo", "churn", "2 of 105 (1.90%)", "do", "meaningful", "yes", ["12760145236","12863798573"])

# ---- PART 4 ----
c(45, "§4.1 The distribution has no middle (verbatim table)", "data-caveat",
  "5★ 8 (7.62%, 57 chars) · 4★ 0 · 3★ 1 (372 chars) · 2★ 0 · 1★ 96 (91.43%, 284 chars); a healthy product produces a 4★ band of people who like it with reservations and a 2★ band of disappointed-not-betrayed — both are entirely empty; the shape you get when the review population is (a) people in a billing dispute and (b) something else",
  "n/a", "1★-burst", table("## 4.1 The distribution has no middle"), "none", "rating band", "app-specific", [])
c(46, "§4.2 What drives 1★ — n = 96 (verbatim table); four causes; star rating is a verdict on the transaction", "insight",
  "Within the 1★ band: scam label 57 (59.4%), confirmed payer 63 (65.6%), refund refused 25 (26.0%), cancel hard 24 (25.0%), billed post-cancel 19, unauthorised 19, not-as-advertised 19; four causes in order: a money dispute (75 of 96, 78.1% — the modal 1★ is a person who paid, tried to stop paying, and could not); a value verdict without a dispute (16 — 'paper or an excel sheet is just as useful'); a pure verdict with no mechanism ('Just go talk to your doctor'); a functional complaint (only four: back-dating, login error 300, freezing, no instructions); two 1★ reviews contain praise — star rating in this corpus is not a feature preference, it is a verdict on the transaction",
  "n/a", "1★-burst", table("## 4.2 What drives 1★"), "product-rule", "rating band", "yes",
  ["13094667829","13828678467","14107869084","12896636688","13016003589","13296391777","13003499428","12915336789","13258914566","13816735964","13150371570","13117882072","13251215774"])
c(47, "§4.3 The single 3★ — the only reviewer still trying to use the product", "insight",
  "The only mixed review, by a confirmed payer still trying to use the product: the web portal 'has tons of helpful info… a few episodes in their courses very useful'; 'The apps are too rudimentary to be helpful'; request: advertise the website from inside the app on open with a link — found real value by accident, on a surface the app never pointed them to",
  "value hidden on an unlinked surface", "mixed", "n=1 (3★, ca, 14 Nov 2025)", "do", "single", "yes", ["13398540937"])
c(48, "§4.4 What drives 5★ — n = 8 (verbatim table)", "data-caveat",
  "All eight 5★ in full: 'Didn't expect much at first, but it's grown on me'; 'feels more human'; 'Simple; calm, and consistent'; 'Helps me stay consistent with my daily habits and reminders'; 'really helped me form good routines'; 'Widgets on the home screen make logging habits so quick'; 'Simple and effective habit builder—highly recọmmend'; 'Perfect tool for building positive habits' — only two name a capability (reminders, widget); none mentions price, subscription, cancellation, courses, e-books, the web portal or a personalised plan",
  "n/a", "5★-burst", table("## 4.4 What drives 5★"), "none", "rating band", "app-specific",
  ["13545315131","13549237052","13552347079","13568090356","13568431568","13571866718","13572140998","13576146958"])

# ---- PART 5 ----
c(49, "Part 5 §5.1 What is observable (verbatim table); §5.2 The two explanations, and what would settle it", "data-caveat",
  "The 5★ band: all 8 in 23–31 Dec 2025 (9 days of 441), the only 5★ in 16 months, all US, 44–74 chars vs 1★ mean 284, all posted 07:01–13:00 UTC, generic register with 5 of 8 lacking terminal punctuation, Firstname-Lastname handles with no repeats, and one homoglyph ('recọmmend', U+1ECD — the only non-Latin-1 character in any English review; a documented duplicate-detection evasion technique); two 1★ fall in the same window so the store was accepting negatives; organic vs inorganic — the pattern fits inorganic substantially better but the report does not assert inauthenticity; what would settle it: Apple's integrity signals, same handles on other Koflimin apps, dated clusters on the sister apps; every positive finding is stated with and without the burst — excluding it the corpus is 97 reviews at mean 1.021 with three positive statements",
  "possible purchased review burst", "5★-burst", table("## 5.1 What is observable") + " ; excluding burst: 97 reviews, mean 1.021", "dont", "unresolved provenance", "yes",
  ["13572140998","13546645984","13564772884"])

with open("Tools/prd_ledger/19/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
