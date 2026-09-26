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

c(1, "header lines 1-10; §12.4 External sources", "positioning",
  "Wisey: Habit Builder (App Store ID 6742659386) — 'Form habits, change your life' — a habit tracker sold as part of a subscription 'programme' for adults who self-identify as having ADHD; the decision it informs is what a habit-tracking product can and cannot charge for, and what happens to a habit app when the acquisition funnel, not the tracker, is the business",
  "developer KOFLIMIN LIMITED (artist 1621709984); bundle com.koflimin.limited.wisey.habitbuilder; sister apps Your Productive Self (4.08★, 877), Deep Focus (4.07★, 136), Simple Budget (3.03★, 29); US listing 3.45★ from 259 ratings; v1.1.1 released 1 Jul 2026, first released 5 May 2025; store rank 19", "1★-burst",
  "105 written reviews, 14 storefronts, 24 May 2025 → 7 Aug 2026 (16 months); written mean 1.324", "none", "corpus-level fact", "app-specific", [])
c(2, "How to read this; Five things to know; §1.1 Files used; §1.2 Schema; §1.3 Coverage and reconciliation; §1.4 Processing method; §1.5 Limitations and judgement calls; §12.1 counting rules; §12.3 method audit trail", "data-caveat",
  "Method: 105 records, every one hand-coded from a full read in original language — no sampling, classifier or clustering; the corpus is 91.43% one-star (96 1★, 8 5★, 1 3★, zero 2★ and 4★) — a distribution with no middle, so it is a dispute record not a satisfaction survey; the public rating is 2.13 stars above what people write (3.45★ from 259 vs 1.324 written; 105 of 259 carry text); the dominant subject is not the app — 75 of 105 (71.43%) raise billing/pricing/cancellation/refund and only 10 (9.52%) report a functional defect; all eight 5★ were posted in one nine-day window 23–31 Dec 2025, all US, 44–74 chars — evidence of uncertain provenance; signal bands <0.1 ignore … >5% high-priority",
  "n/a", "none", "105/105 read; denominator 105 non-exclusive; 14 storefronts; 16 months", "none", "method", "yes", [])
c(3, "Executive summary — nine findings", "insight",
  "Executive summary: Wisey is not, in its reviews, a habit-tracking product — it is a payment funnel with a habit tracker attached, and the reviews are a dispute record; nine findings: billing outside the App Store (18, 17.14%); a second e-book subscription (11, 10.48%); charged after cancelling (19) and charged with no recognised subscription (19); refunds refused (25, 23.81%) with three mechanics turning refusal into fraud allegations; a save-flow that destroys price credibility ($98.50/mo → $5 or $49 lifetime); cancellation obstructed by five named mechanics (24, 22.86%); a product ceiling — a checklist cannot carry $45–$99 (13, 12.38%); ADHD-targeting accusations (13, 12.38%) with 6 escalations to banks/FTC; the December 5★ burst of unresolved provenance",
  "web-funnel subscription with thin app", "1★-burst", "see individual cards", "product-rule", "summary", "yes", [])

# ---- PART 0 ----
c(4, "§0.1 The product being reviewed is a payment funnel, and the App Store app is its front door", "anti-pattern",
  "Billing happens outside the App Store and that single architectural choice generates most of the corpus: the listing shows Premium $6.99 and $29.99 IAPs, but reviewers report $15, $17, $17.99, $19.99, $30, $34.99, $37, $45, $49.99, $50, $59.99, $60, $70, $85, $98.50, $99, $99.99 and cumulative $100, $136, 'hundreds' — almost none an App Store IAP; the developer's terms confirm two purchase pathways and that website purchases are non-refundable; 'The app is just a front, this is a web based program so your terms are hidden from you. It will not show in your subscriptions either'; 'intentionally funnel you outside appstore to their website so that you cant request refund'; everything downstream follows from billing happening somewhere Apple cannot see it",
  "web checkout outside App Store; app is the front door", "1★-burst", "18 of 105 (17.14%, High-priority) say the subscription does not appear in Apple subscriptions", "dont", "high-priority", "yes",
  ["13417665753","13150104593","13366105778","13770028994","13926895274","13131008150","13716802092","12692126207","12731738911","12811553385","12821851615","12998276106","13099305086","13202910675","13435933779","13772597437","14087411464","14397733811"])
c(5, "§0.2 The second subscription: 11 reviewers describe being enrolled in an e-book plan they did not knowingly buy; table (verbatim)", "anti-pattern",
  "A second, separate subscription for e-books/workbooks/PDFs charged on top of the programme subscription with its own cancellation path — pays $15, clicks the e-book link, charged $17 'because they already have your info'; '$59.99/month for the app and another $45.00/month for some ebooks'; billed $45 then $17.99 minutes later; 'provides a link to PDFs that a third grader could create'; two reviewers on two continents five months apart describe the same asymmetry — cancelling the main plan succeeds, cancelling the e-book plan does not; corroborated by public Trustpilot complaints (pattern existence only)",
  "hidden add-on e-book subscription at $45/mo", "1★-burst", "11 of 105 (10.48%, High-priority), five storefronts, 8 months apart; " + table("## 0.2 The second subscription"), "dont", "high-priority", "yes",
  ["12692126207","12705617097","12821851615","12836726941","12910430870","13251215774","13280826420","13311158289","13546645984","13636589290","13772597437"])
c(6, "§0.3 (a) Charged after cancelling — 19 of 105", "must-never-break",
  "Charged after cancelling: 'I followed the cancellation instructions exactly well before the time required and was charged several days later'; 'trying since the first month to cancel… 6 months later they are still taking my money'; 'It breaks cancellations into two innocuous components, so even if the user thinks they've cancelled (and receives a cancellation email) they will continue charging'; cancelled after a $34.99 trial charge, then charged $99.99 three months later",
  "charges continue after cancellation", "1★-burst", "19 of 105 (18.10%, High-priority)", "must-never-break", "high-priority", "yes",
  ["12763706876","12821851615","12836726941","12910430870","13099305086","13131008150","13142094640","13259029152","13280826420","13282459076","13366105778","13369386593","13435933779","13636589290","13679453387","13752060221","13880194933","13917677839","14160038721"])
c(7, "§0.3 (b) Charged with no subscription the reviewer recognises — 19 of 105", "must-never-break",
  "Charged with no subscription the reviewer recognises — 'Unauthorized transaction… Never signed up for this'; 'Have never used this app. Now it is continually trying to charge my credit card' (nz); 'one dollar charges will come out constantly'; 'stolen over $100 now and the app keeps on trying to get $59.99 again and again every week'",
  "unrecognised recurring charges", "1★-burst", "19 of 105 (18.10%, High-priority)", "must-never-break", "high-priority", "yes",
  ["12811553385","12924114693","12985541561","13101150060","13131239346","13150104593","13248498967","13251215774","13280092455","13369386593","13490397655","13597970945","13636589290","13644957048","13759087115","13770028994","13810899948","14160038721","14208322175"])
c(8, "§0.3 One case is materially more serious than the rest — surfaced under the safety exception", "data-caveat",
  "One reviewer states that after blocking the card, charges appeared on other payment methods carrying their name, including an account belonging to a six-year-old child with a genetic disorder for whom they are guardian, totalling 'HUNDREDS OF DOLLARS' — a single review (0.95%), uncorroborated within the corpus, surfaced under the safety exception, not as a quantified pattern",
  "alleged charges to other payment methods", "1★-burst", "n=1 (0.95%), safety exception", "none", "single uncorroborated", "app-specific", ["13636589290"])
c(9, "§0.4 The refund policy is the churn engine — 25 of 105 refused a refund", "must-never-break",
  "Refunds refused for 25 of 105 (23.81%, High-priority); the refusal is not what makes people write 'scam' — three specific mechanics are (proof-of-use requirement, unhonoured guarantee, retention offers instead of an answer)",
  "refunds refused; website purchases non-refundable", "1★-burst", "25 of 105 (23.81%, High-priority)", "must-never-break", "high-priority", "yes",
  ["12763706876","12778540152","12811553385","12819961338","12868620709","12874978864","12985541561","12998276106","13003020356","13007286102","13009681827","13259029152","13280826420","13311158289","13357149144","13417665753","13675718331","13716802092","13742636617","13770028994","13772597437","13785381809","13880194933","13926895274","14087411464"])
c(10, "§0.4 (a) A refund requires proving you used the product — 6 of 105", "dont",
  "A refund requires proving 14 days of consecutive use — 'you are NOT ALLOWED TO ASK FOR A REFUND until 14 days of activity on the app'; 'I used it for 2 days, and didnt like it'; the condition is impossible to satisfy when 'there is no plan' to follow",
  "proof-of-use refund condition", "1★-burst", "6 of 105 (5.71%, High-priority)", "dont", "high-priority", "yes",
  ["12692126207","12760145236","12778540152","12998276106","13117882072","13772597437"])
c(11, "§0.4 (b) A 'money-back guarantee' that was advertised and then not honoured — 3 of 105", "dont",
  "A 30-day money-back guarantee was advertised and not honoured — 'Shortly they dont have money back guarantee'; no published guarantee page could be located (two candidate URLs 404), so the 14-day/30-day conditions rest on review evidence only",
  "advertised guarantee not honoured", "1★-burst", "3 of 105 (2.86%, Meaningful); 6 + 3 reviewers across four storefronts", "dont", "meaningful", "yes",
  ["12778540152","13675718331","13772597437"])
c(12, "§0.4 (c) Refund requests answered with retention offers instead — 5 of 105", "dont",
  "Refund requests answered with retention offers instead of an answer — 'Their bot tried to convince me to stay on… Never did they address my refund until I continued to ask directly, in three different emails. Finally, a 50% refund was offered'; 'attempted to upsell me on a $5 lifetime subscription—which makes absolutely no sense given the $99 charge they're refusing to reverse'",
  "retention bot in place of refund handling", "1★-burst", "5 of 105 (4.76%, Very strong)", "dont", "very strong", "yes",
  ["12819961338","13772597437","13803171356","13921976046","13926895274"])
c(13, "§0.5 The discount ladder tells buyers the real price — 3 reviews; table (verbatim)", "anti-pattern",
  "When a customer tries to leave they are offered a dramatically lower price — charged $98.50/month, offered lifetime for $49; charged $99 non-refundable, offered a $5 lifetime; subscription + $45/mo e-books, offered '$5 for lifetime, $1 per month' — and each reviewer draws the same conclusion: 'That is probably the real value of the service. I passed on that. I'm too mad to give them another dime'; a save-offer at 5% of the charged price converts a pricing objection into a fraud belief and costs the lifetime-value sale it was trying to protect; all three left 1★",
  "save-offer at ~5% of charged price", "1★-burst", "3 of 105 (2.86%, Meaningful); " + table("## 0.5 The discount ladder"), "dont", "meaningful — most commercially instructive", "yes",
  ["13772597437","13803171356","13926895274"])
c(14, "§0.6 Cancellation is described as obstructed, with named dark patterns — 24 of 105", "anti-pattern",
  "Cancellation obstructed by five named, reproducible mechanics: (1) cancellation requires email, not a button ('several emails from the right email account 30 days in advance'); (2) visual weighting — 'the big bold items were to stay subscribed and the smaller was to cancel'; (3) confirmation-step attrition — 'about 10 are-you-sure items'; (4) split cancellation across two objects; (5) losing account access mid-cancellation — 'once you've started the cancellation process, you can no longer log onto the app to continue it'; 'Could not access the settings or account section for weeks' (de); two report the cancel control simply not working — a bug report inside a billing complaint and the cheapest thing to verify",
  "email-only cancel, bold/small asymmetry, ~10 confirms, split cancel, lockout mid-flow", "1★-burst", "24 of 105 (22.86%, High-priority)", "dont", "high-priority", "yes",
  ["12692126207","12731738911","12811553385","12821851615","12910430870","12924114693","13099305086","13150104593","13241632109","13280826420","13282459076","13435933779","13546645984","13564772884","13597970945","13636589290","13679453387","13689727356","13716802092","13752060221","13772597437","13876370915","13926895274","14160038721"])
c(15, "§0.7 'It's a to-do list I could have written myself' — the value problem underneath the billing problem", "insight",
  "Strip out the billing and a quieter finding remains: the product does nothing existing free tools don't — the phone's alarm, the Notes app, the calendar, paper or Excel; 'If you can set an alarm on your phone you don't need this app'; 'might as well asked my kids to draw up a habit builder — no input or suggestions, videos, nothing, just a calendar' (gb); 'a very basic checklist hidden behind a terrible UI and clunky UX' (au); this is the finding that generalises — a habit tracker whose entire surface is a checklist has a commodity substitute pre-installed on every phone, and that ceiling is what makes $45–$99 read as theft rather than as expensive",
  "bare checklist at $45–$99", "1★-burst", "13 of 105 (12.38%, High-priority)", "product-rule", "high-priority", "yes",
  ["12692126207","12731738911","12748055966","12933789910","13094667829","13117882072","13131008150","13194035072","13251215774","13636589290","13810899948","13828678467","14107869084"])
c(16, "§0.8 The promise that is not delivered: a personalised plan", "anti-pattern",
  "Five paid specifically for a customised programme and received a blank habit tracker — 'They promised a customized plan to help. I received no such plan… expecting you to setup your own habits'; 'They promise a full program to help you and instead you pay for some useless little apps' (mx) — literally accurate: the subscription grants access to four separate thin Wisey apps rather than a programme; all five are non-US (3 ca, 1 mx, 1 gb) — 0 of 72 US reviews",
  "sells a personalised plan, delivers a blank tracker + thin app bundle", "1★-burst", "5 of 105 (4.76%, Very strong); 0 of 72 US", "dont", "very strong", "yes",
  ["12748055966","12778540152","13194035072","13785381809","14107869084"])
c(17, "§0.9 The ADHD accusation is a reputational and regulatory risk, not just an insult", "audience",
  "Thirteen accuse the product of deliberately targeting people with ADHD because they are less likely to complete a cancellation — 'preying on ADHDers they know may not remember to cancel'; 'Most ADHD apps understand the basics of ADHD and impulse control and will refund your money… They should change the name to UNWisey'; 'the ONE SINGLE EMAIL they sent confirming my purchase with no actual link… If you have actual ADHD, you understand why one singular email with no working links is a complete and total waste'; 'designed for people with ADHD to spend money but not to help them' (de); when your positioning is 'we help people who struggle to follow through', a friction-heavy cancellation flow is read as exploiting the exact deficit you claim to treat, and it is the accusation that gets regulators involved",
  "ADHD-positioned funnel with cancellation friction", "1★-burst", "13 of 105 (12.38%, High-priority)", "product-rule", "high-priority", "yes",
  ["12692126207","12868620709","13003020356","13007286102","13111156410","13194035072","13280826420","13546645984","13754537415","13828678467","14087411464","14160038721","13671148757"])
c(18, "§0.9 Six name the acquisition channel — paid social ad → web quiz → web checkout → checklist", "tactic",
  "The acquisition channel is named by six: Instagram (3), YouTube (1), unspecified social media (2); the pattern is consistent — paid social ad → web quiz → web checkout → an app that turns out to be a checklist",
  "paid social → web quiz → web checkout", "1★-burst", "6 of 105 (5.71%, High-priority)", "dont", "high-priority", "yes",
  ["12998276106","13671148757","13710711149","14107869084","14087411464","13880194933"])
c(19, "§0.9 Six escalated outside the store — banks, card networks, FTC, Apple", "timeline",
  "Six escalated outside the store: credit-card dispute, bank fraud department + Apple, reporting to card issuer, 'Reported to FTC - Koflimin', bank dispute; one asks Apple directly: 'I recommend suspension from the App Store until they fix their subscription issues'",
  "disputes and regulator reports", "1★-burst", "6 of 105 (5.71%, High-priority)", "dont", "high-priority", "yes",
  ["13099305086","13259029152","13636589290","13675718331","13754537415","13926895274","14160038721"])
c(20, "§0.10 What the corpus says works — a very short section, honestly labelled", "insight",
  "Only 11 of 105 (10.48%) contain anything positive and 8 are the December 5★ burst; setting it aside leaves three statements in sixteen months: the only 3★ — 'the online portal/website has tons of helpful info… a few episodes in their courses very useful. The apps are too rudimentary to be helpful but the website is good'; 'It's technically easy to use' (immediately followed by 'none of this actually helps build habits'); 'AI Bot Rachel was nice though. Haha.'",
  "web course library is the only praised asset", "mixed", "11 of 105 (10.48%) positive; 3 excluding the burst", "research", "honest minimum", "app-specific",
  ["13398540937","13117882072","13251215774"])

with open("Tools/prd_ledger/19/cards.jsonl", "w") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards written")
