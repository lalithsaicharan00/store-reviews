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

# ---- PART 9 ----
c(68, "§9.1 Method — era table (verbatim); E2's mean is produced entirely by the December burst", "timeline",
  "Eras by date: E1 24 May–30 Sep 2025 n43 mean 1.000 (~10.2/month); E2 1 Oct 2025–31 Jan 2026 n37 mean 1.919 (~9.3/month); E3 1 Feb–7 Aug 2026 n25 mean 1.000 (~4.0/month); E2's 1.919 is produced entirely by the eight December 5★ — excluding them E2 is 29 reviews at 1.069; all era percentages are fragile (one E3 review = 4.0%)",
  "n/a", "1★-burst", table("## 9.1 Method"), "none", "era definition", "app-specific", [])
c(69, "§9.2 What persisted, unchanged, across all sixteen months (verbatim table) — nothing was fixed", "timeline",
  "Persistent across E1/E2/E3: refund refused 25.6 / 16.2 / 32.0%; cancel hard 18.6 / 27.0 / 24.0%; billed post-cancel 16.3 / 21.6 / 16.0%; unauthorised 14.0 / 21.6 / 20.0%; off-store 20.9 / 8.1 / 24.0%; scam label 69.8 / 45.9 / 40.0% (declining share); nothing was fixed — the first review (19 days after launch) describes the two-subscription mechanism, the 14-day refund condition and the ADHD-targeting accusation; the last (441 days later) describes unresponsive support and post-trial charges",
  "no change over 16 months", "1★-burst", table("## 9.2 What persisted"), "dont", "era series", "app-specific",
  ["12692126207","14397733811"])
c(70, "§9.3 Worsening — price shock (verbatim table)", "timeline",
  "Price-high rises 7.0% (3) → 18.9% (7) → 20.0% (5); reported amounts rise — E1 $15–$45, E2 introduces $59.99, $85, $99.99 and $100 cumulative, E3 has $98.50/month and $99 non-refundable; price increase or plan-mix shift cannot be determined, but the reviewer experience worsened either way",
  "prices reported rising to ~$99", "1★-burst", table("## 9.3 Worsening"), "none", "era series (fragile)", "app-specific",
  ["13803171356","13926895274"])
c(71, "§9.4 Emerging in E3 — the retention machine (verbatim table)", "timeline",
  "Two themes appear only in the final era: support retention loop 2.3% / 0 / 16.0% (4) and discount ladder 0 / 0 / 12.0% (3); from Feb 2026 reviewers stop describing a refund refusal and start describing a negotiation — a bot, then a human, then a $1/month or $5-lifetime counter-offer, then a refusal; three ladder reports name three price points from three storefronts (tr, us, us); interpretation: a save-flow was added or intensified around late 2025/early 2026 and it is not saving customers — all four left 1★; social-ad mentions also rise (2.3 → 2.7 → 16.0%), consistent with a 2026 paid-acquisition push or more explicit reviewers — the corpus cannot distinguish",
  "save-flow added ~early 2026", "1★-burst", table("## 9.4 Emerging in E3"), "dont", "era series (thin)", "yes",
  ["13772597437","13803171356","13921976046","13926895274"])
c(72, "§9.5 Improving — two themes genuinely fade (verbatim table)", "timeline",
  "E-book upsell 11.6% (5) → 13.5% (5) → 4.0% (1), last complaint 21 Feb 2026; content-thin 18.6% (8) → 5.4% (2) → 8.0% (2); the e-book decline is the only credible improvement signal and it is ambiguous — the mechanism may have been removed, or the buying population shrank to where nobody hits it",
  "e-book plan possibly removed", "mixed", table("## 9.5 Improving"), "none", "era series (ambiguous)", "app-specific", ["13772597437"])
c(73, "§9.6 The clearest trend of all: the corpus is drying up (verbatim table)", "timeline",
  "Jun–Dec 2025 (7 months) 70 reviews; Jan–Mar 2026 (3 months) 23; Apr–Aug 2026 (5 months) 10 — monthly volume falls from ~10 to 2, 2, 1, 1; three explanations: acquisition spend cut, funnel moved further off-store so complaints land on Trustpilot and card issuers, or the product was fixed — the third is least consistent with the evidence (2026 reviews at exactly 1.000 from February on)",
  "review flow collapsing", "none", table("## 9.6 The clearest trend"), "none", "era series", "app-specific", [])

# ---- PART 10 ----
c(74, "§10.1 Immediate — act without further research (verbatim table) — #1 Move subscription billing into the App Store", "product-rule",
  "Move subscription billing into the App Store for App Store-acquired users; if the web funnel stays, make the app show the active plan, price, next charge date and a working cancel button — the root cause: 60 distinct reviews once deduplicated flow from a customer who cannot see or stop their own subscription; nothing else matters as much",
  "off-store billing invisible in the app", "1★-burst", "§0.1 (18) · §0.3a (19) · §0.3b (19) · §7.3 (4); " + table("## 10.1 Immediate"), "product-rule", "recommendation (immediate)", "yes",
  ["13366105778","13417665753"])
c(75, "§10.1 #2 Collapse the e-book plan into the main subscription, or delete it", "dont",
  "Collapse the e-book plan into the main subscription or delete it — the corpus's most specific and most repeated mechanism", "second hidden subscription", "1★-burst", "§0.2 (11)", "dont", "recommendation (immediate)", "yes", ["12910430870","13280826420"])
c(76, "§10.1 #3 One-tap cancellation, symmetric buttons, one confirmation step", "must-have",
  "One-tap cancellation, symmetric buttons, one confirmation step — hours of work, and the direct source of the ADHD-exploitation accusation", "asymmetric buttons, ~10 confirms", "1★-burst", "§0.6 (24)", "must-have", "recommendation (immediate)", "yes", ["13636589290","13435933779"])
c(77, "§10.1 #4 Delete the 'prove 14 days of use' refund condition and honour the advertised money-back guarantee", "product-rule",
  "Delete the proof-of-use refund condition and honour the advertised guarantee — breaking it converts a refund request into a chargeback and an FTC report; the refund is cheaper than the dispute", "conditional refunds, unhonoured guarantee", "1★-burst", "§0.4a (6) · §0.4b (3) · §6.2", "product-rule", "recommendation (immediate)", "yes", ["12760145236","13675718331"])
c(78, "§10.1 #5 Send a renewal reminder email before every charge, and a receipt with a working product link after every charge", "must-have",
  "A renewal reminder before every charge and a receipt with a working product link after every charge — support's own answer 'we sent you an EMAIL notification' concedes the notification model is the whole safeguard", "single confirmation email with no link", "1★-burst", "§7.3 (4) · RENEWAL_SURPRISE (3)", "must-have", "recommendation (immediate)", "yes", ["14087411464","13417665753"])
c(79, "§10.1 #6 Fix the four named defects", "must-never-break",
  "Fix the four named defects: cancel form not submitting, settings/account inaccessible, iPhone login error 300 with no message, back-dating a completed habit — two of them block cancellation, which makes them billing defects with legal exposure, not UX polish", "small defect list, two block cancellation", "1★-burst", "§7.4 (10)", "must-never-break", "recommendation (immediate)", "yes",
  ["13689727356","13772597437","13876370915","13258914566","12915336789"])
c(80, "§10.1 #7 Reply to support email within the cancellation deadline, or move cancellation out of email entirely", "product-rule",
  "Reply within the cancellation deadline or move cancellation out of email entirely — a 24-hour deadline served by a 48-hour queue is unsatisfiable by construction", "email cancellation vs 24h deadline", "1★-burst", "§7.1 mode 3", "product-rule", "recommendation (immediate)", "yes", ["13597970945"])
c(81, "§10.1 #8 Retire the discount ladder", "dont",
  "Retire the discount ladder — replace a $5-lifetime save-offer against a $99 charge with a plain refund or a pause; the offer is teaching customers that the list price is a 20× markup, in public, in writing", "save-offer at 5% of list", "1★-burst", "§0.5 (3)", "dont", "recommendation (immediate)", "yes", ["13803171356"])
c(82, "§10.2 a. Trust is a purchasable feature, and this corpus prices it", "insight",
  "Trust is a purchasable feature: in a category where the software is commoditised, Apple-billed subscriptions, one-tap cancel, a visible price on the paywall and a renewal reminder are product differentiators that cost almost nothing to ship — say so in the store listing; a competitor was recommended because its 'customer service aren't trying to rob you'",
  "n/a", "churn", "transferable lesson", "do", "transferable", "yes", ["12863798573"])
c(83, "§10.2 b. Selling to people who struggle with follow-through raises the bar on cancellation, it does not lower it", "product-rule",
  "Friction a neurotypical user calls annoying this audience calls predatory, because the product's own marketing asserts they cannot be relied on to complete multi-step tasks; the ADHD positioning and the retention funnel are incompatible — pick one; if the positioning stays, the cancellation flow has to be the easiest flow in the product",
  "n/a", "1★-burst", "13 (12.38%)", "product-rule", "transferable", "yes", ["13546645984","13828678467"])
c(84, "§10.2 c. A checklist has a free substitute pre-installed on the device", "product-rule",
  "Any habit product charging above a few dollars must deliver something a checklist structurally cannot — genuine personalisation, real coaching content, accountability with another human, or data the user could not assemble themselves; Wisey charged $45–$99 for the substitute and got 96 one-star reviews",
  "n/a", "1★-burst", "13 name the substitute; 96 1★", "product-rule", "transferable", "yes", ["13828678467","13094667829"])
c(85, "§10.2 d. A guarantee is a conversion lever that only works once", "product-rule",
  "A guarantee's value is in the buying decision; its cost is in honouring it; a guarantee you will not honour is a fraud allegation you have pre-purchased", "n/a", "1★-burst", "3 bought because of it, 3 escalated", "product-rule", "transferable", "yes", ["12778540152","13675718331","13772597437"])
c(86, "§10.2 e. Do not let the funnel promise what the product does not contain", "dont",
  "Every gap between funnel and product — a personalised plan that was an empty tracker, a Spanish ad for an English-only app, a programme that was four thin apps — was created by marketing and paid for by the product's rating", "n/a", "1★-burst", "5 + 1 + several", "dont", "transferable", "yes", ["12748055966","13710711149","13785381809"])
c(87, "§10.3 The one product opportunity in the corpus — surface the course library from the app's first open", "do",
  "The tracker is a commodity, the course library is the differentiated asset, and the app never mentions the library exists — every reviewer who called the product 'just a checklist' may have been describing the 10% of the product they were shown; the action is a one-screen change: surface the course library on first open with a link, as the only constructive reviewer literally requests",
  "differentiated asset hidden from the app", "mixed", "n=1 constructive reviewer vs 13 'just a checklist'", "do", "single-source opportunity", "yes", ["13398540937"])
c(88, "§10.4 Experiments worth running (verbatim table)", "insight",
  "Experiments: in-app course-library entry point on first open (3★+ share among users who open it); genuine free tier (track 1–3 habits forever) vs paywall-on-open (paid conversion and 30-day retention); Apple-billed IAP vs web checkout at the same price (refund, chargeback, 1★ share per cohort); refund-on-request within 30 days, no conditions (chargeback rate, review mean, ticket volume)",
  "n/a", "none", table("## 10.4 Experiments worth running"), "research", "experiments", "yes", [])
c(89, "§10.5 Research questions this corpus cannot answer; part 10 #1; part 10 #2; part 10 #3; part 10 #4; part 10 #5; part 10 #6", "data-caveat",
  "Research questions: (1) are the eight December 5★ organic — every positive finding is contingent; (2) the actual refund rate; (3) do App Store IAP buyers ($6.99/$29.99) complain at all — not one of 105 clearly identifies as Apple-billed, and if the IAP cohort is quiet that alone settles recommendation 1; (4) did the price rise or the plan mix shift; (5) why review volume collapsed in 2026 H1; (6) does the ad creative differ by market",
  "n/a", "none", "6 questions", "research", "research questions", "yes", [])

with open("Tools/prd_ledger/19/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
