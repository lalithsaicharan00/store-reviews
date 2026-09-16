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

# ---- PART 6 ----
c(50, "§6.1 The payer cohort — 64 of 105 (60.95%); group table (verbatim)", "monetization",
  "Confirmed payers 64 (60.95%), inferred 3, not established 38; 63 of 64 confirmed payers left 1★ (the 64th is the 3★); not one of the eight 5★ reviewers indicates being a customer in any commercial sense — a majority-payer corpus, not the voice of people who bounced off a paywall",
  "majority of reviewers paid", "1★-burst", table("## 6.1 The payer cohort"), "must-never-break", "high-priority", "yes", ["13398540937"])
c(51, "§6.2 What made people pay — named purchase triggers (verbatim table)", "insight",
  "Purchase triggers among 64 payers: a paid social ad promising ADHD help 6 (9.4%); the promise of a personalised plan from a quiz 5 (7.8%); a 'free trial' framing 8 (12.5%; 10 globally); a money-back guarantee used as risk reversal 3 (4.7%); impulse explicitly attributed to ADHD 1 ('I signed up on an impulse because I have ADHD… hence the interest in Wisey'); never read these as conversion rates",
  "ads + quiz + trial + guarantee funnel", "1★-burst", table("## 6.2 What made people pay"), "dont", "named triggers", "yes",
  ["12998276106","13671148757","13710711149","13880194933","14087411464","14107869084","12748055966","12763706876","12836726941","12985541561","13131008150","13280826420","13311158289","13366105778","13926895274","12778540152","13675718331","13772597437","13003020356"])
c(52, "§6.2 The most commercially important line: a money-back guarantee is why they bought, and it was not honoured", "product-rule",
  "Three reviewers state the money-back guarantee is why they bought and all three say it was not honoured — a guarantee is the cheapest conversion lever in subscription commerce and the most expensive one to break: it converts a refund request into a fraud allegation; 'I signed up with 30 days money back warranty… told that it is not refundable… I am going to report this scammers to my credit card company'",
  "guarantee as conversion lever, then refused", "1★-burst", "3 of 64 payers (4.7%); 3 of 105 (2.86%)", "product-rule", "meaningful — most commercially important", "yes",
  ["12778540152","13675718331","13772597437"])
c(53, "§6.3 What paid users complain about — segment rates (verbatim table)", "monetization",
  "Among 64 payers: scam label 67.2%, refund refused 32.8%, cancel hard 31.2%, billed post-cancel 28.1%, off-store 23.4%, double billed 23.4%, not as advertised 21.9%, price high 20.3%, unauthorised 18.8%, support fail 18.8%, content thin 17.2%, e-book upsell 15.6%, low value vs free 15.6%, ADHD targeting 14.1% — one third of everyone who paid says they could not get their money back and just under one third says they could not stop paying; for a subscription business those two numbers in a public corpus are the business",
  "n/a", "1★-burst", table("## 6.3 What paid users complain about"), "must-never-break", "payer cohort", "yes", [])
c(54, "§6.4 Upgrade barriers — the non-payer evidence; people are not bouncing off this paywall", "insight",
  "Only four non-payers, all giving the same reason — no way to evaluate first; the absence of a larger price-objection population is itself informative: people are not bouncing off this paywall, they are going through it and then trying to reverse the transaction — the problem is not acquisition, it is what happens after",
  "funnel converts, then reverses", "blocked-conversion", "4 of 105 (3.81%, Very strong)", "product-rule", "very strong", "yes",
  ["12819961338","12915335177","13405220625","14289131320"])
c(55, "§6.5 Refund, churn and escalation path (verbatim table); no full refund reported by anyone", "timeline",
  "A consistent four-stage escalation: attempts to cancel (24 obstructed, 22.86%) → requests a refund (25 refused, 23.81%) → offered retention instead (5, 4.76%) → escalates outside the store (6, 5.71%); exactly one partial refund (50% offered after three emails, not yet received) and no full refund reported by anyone; terminal state: 'Reported to FTC… Edit: Confirmed scam. :)'",
  "cancel → refuse → retain → escalate", "1★-burst", table("## 6.5 Refund, churn and escalation path"), "dont", "high-priority", "yes",
  ["12819961338","13772597437","13803171356","13921976046","13926895274","13099305086","13259029152","13636589290","13675718331","13754537415"])

# ---- PART 7 ----
c(56, "§7.1 Support failure — 17 of 105 (16.19%); four failure modes", "must-have",
  "Support failure in four modes: no reply at all ('ZERO response'; 'Support never responds to emails'); circular replies ('keeps looping you around'; 'inconsistently suggest we go to Apple support directly'); slow enough to defeat the deadline — 'They said cancel within 24 hours before and they take more than 48 hrs to get back to you!' — when cancellation runs through support email and support replies in 48 hours against a 24-hour deadline the deadline cannot be met, a process defect not a service-quality complaint; hostile or scripted ('a rude lecture via email about how I signed up on purpose'; 'less like support and more like a scripted sales funnel')",
  "email-only support: silent, circular, slow, hostile", "1★-burst", "17 of 105 (16.19%, High-priority)", "must-have", "high-priority", "yes",
  ["12705617097","12742285860","12761607224","12874978864","12998276106","13003020356","13142094640","13202910675","13241632109","13259029152","13280826420","13417665753","13597970945","13675718331","13716802092","13921976046","14397733811"])
c(57, "§7.1 Support reply time must be shorter than the cancellation deadline", "product-rule",
  "A 24-hour pre-renewal cancellation cut-off cannot coexist with a 48-hour support reply time when cancellation runs through support — the deadline is structurally unmeetable", "24h deadline vs 48h reply", "1★-burst", "n=1 stating it explicitly", "product-rule", "process defect", "yes", ["13597970945"])
c(58, "§7.2 Entitlement failures — 5 of 105 (4.76%); the most under-weighted finding", "must-never-break",
  "Paid and could not use what they paid for — 'I can log in on my laptop but no apps'; 'App doesn't work, was not able to use the service and was still charged $49.99'; login error 300 on iPhone (iPad fine) with no error message; 'once you've started the cancellation process, you can no longer log onto the app' — buried inside billing complaints; the error-300 review is the only pure bug report in the corpus and the cheapest actionable item",
  "paid, no access; device-specific login failure", "1★-burst", "5 of 105 (4.76%, Very strong)", "must-never-break", "very strong", "yes",
  ["12742285860","13142094640","13357149144","13258914566","14160038721"])
c(59, "§7.3 Records and receipts — 4 of 105 (3.81%); no subscription entry, no receipt, no working link", "must-have",
  "Reviewers cannot find any record of what they bought — 'no confirmation email anywhere'; 'Customer support emailed and said we sent you an EMAIL notification. Seriously an email'; 'when you get your thank-you email BE SURE to click the link at the bottom. THAT is where the fine print is'; combined with off-store billing this produces a customer who has been charged and possesses no subscription entry, no receipt they can find and no working link to the product — every downstream support cost starts here",
  "no receipt / no record / fine print in a footer link", "1★-burst", "4 of 105 (3.81%, Very strong)", "must-have", "very strong", "yes",
  ["13150104593","13366105778","13417665753","14087411464"])
c(60, "§7.4 Software defects — the complete list, 10 of 105 (verbatim table)", "must-never-break",
  "The complete defect list: cannot back-date a completed habit; login fails on iPhone with error 300 and no message (iPad unaffected); app freezes (mx); settings/account section inaccessible for weeks (de); cancel form does not work (two independent reports); paid but no access (4) — ten reports in sixteen months, none corroborated more than twice, a small and unremarkable defect surface; the software is not what is generating this corpus",
  "small defect surface", "complaint", table("## 7.4 Software defects"), "none", "high-priority by count, small in substance", "app-specific",
  ["12915336789","13258914566","13816735964","13876370915","13689727356","13772597437","12742285860","13142094640","13357149144","14160038721"])

# ---- PART 8 ----
c(61, "§8.1 Storefront table (all 14) (verbatim)", "market",
  "Storefronts: us 72 (68.57%, 1.444, 64 1★, 8 5★); ca 11 (1.182); de 4, gb 4, au 3, mx 2, nz 2, ch/cl/fr/it/ph/se/tr 1 each — all at exactly 1.000; only the US clears 50; thirteen of fourteen storefronts have a mean of exactly 1.000 and the US is higher only because it holds all eight 5★ — excluding the December burst the US mean is 1.000, identical to every other storefront",
  "n/a", "1★-burst", table("## 8.1 Storefront table"), "none", "storefront table", "app-specific", [])
c(62, "§8.2 United States — n = 72 (verbatim table); the US profile is the global profile", "market",
  "US (n=72) theme rates: scam 58.3%, confirmed payer 59.7%, cancel hard 25.0%, refund refused 22.2%, billed post-cancel 19.4%, double billed 18.1%, support fail 18.1%, off-store 16.7%, unauthorised 15.3%, price high 15.3%, not as advertised 15.3%, ADHD targeting 13.9%, content thin 13.9%, e-book upsell 9.7%, low value 8.3%, legal escalation 6.9%, no custom plan 0.0%; the US profile is the global profile; the US carries all but one escalation and both competitor recommendations — where FTC and chargeback paths are named, the commercial risk concentrates",
  "n/a", "1★-burst", table("## 8.2 United States"), "none", "≥50 storefront", "app-specific", [])
c(63, "§8.3 Canada — n = 11, limited evidence", "market",
  "Canada (n=11): 3 of the 5 'promised a personalised plan' reviews are Canadian, and Canada contributes the only 3★ and the most constructive review; with n=11 three reviews is not a market difference — flagged for follow-up not action",
  "n/a", "1★-burst", "n=11, mean 1.182", "research", "limited evidence", "app-specific",
  ["12748055966","12778540152","13194035072","13398540937"])
c(64, "§8.4 The one real geographic split — 'no personalised plan' (verbatim table)", "market",
  "'No personalised plan' is 0 of 72 in the US and 5 of 33 (15.2%) non-US (ca ×3, mx, gb); either the ad creative differs by market (the Chilean reviewer confirms ad language differs from app language) or a 5-review theme against 33 is noise — do not act without a larger non-US sample; other fragile US/non-US differences: non-US higher on low-value-vs-free (21.2 vs 8.3%), not-as-advertised (24.2 vs 15.3%), trial-mislead (15.2 vs 6.9%), unauthorised (24.2 vs 15.3%); US higher on content-thin, double billing, scam label (58.3 vs 45.5%)",
  "possible market-specific ad creative", "1★-burst", table("## 8.4 The one real geographic split"), "research", "fragile (n=33)", "app-specific",
  ["13710711149","12748055966","12778540152","13194035072","13785381809","14107869084"])
c(65, "§8.5 High-spend markets (verbatim table) — every high-spend market behaves identically; JP/CN/KR never queried", "market",
  "High-spend markets present (us, ca, gb, de, fr, au) 95 (90.48%, mean 1.358) vs all others 10 (mean 1.000); Japan, China and South Korea contribute zero reviews because they were never queried — a distribution and extraction fact; the 1.358 is entirely a US artefact of the December burst; strip it and the high-spend group runs at 1.000 — there is no market in this corpus where this product is working",
  "n/a", "1★-burst", table("## 8.5 High-spend markets"), "none", "market table", "app-specific", [])
c(66, "§8.6 High-review-volume markets (verbatim table)", "market",
  "Storefronts ≥5% of corpus: us 72 (68.57%), ca 11 (10.48%) — a US corpus with a Canadian minority and eleven single-digit tails; review volume measures nothing except review volume", "n/a", "none", table("## 8.6 High-review-volume markets"), "none", "method", "app-specific", [])
c(67, "§8.7 Localisation — the Instagram ad ran in Spanish; the product is English-only", "market",
  "'On Instagram it appears in Spanish and in this app everything is in English… tell me if there's a Spanish version and if not, refund the money' — a clean instance of the general pattern: the funnel promises something the product does not contain; two of the three non-English reviews (it, de) additionally complain the product is paywalled before it can be seen",
  "ads localised, product not", "1★-burst", "1 of 105 (0.95%, Emerging) + 2 paywall complaints", "dont", "emerging", "yes",
  ["13710711149","14289131320","13650570635"])

with open("Tools/prd_ledger/19/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
