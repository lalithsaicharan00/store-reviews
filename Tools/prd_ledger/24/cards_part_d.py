"""Cards for report 24 — Part 6 (billing architecture) and Part 7 (paid-user analysis)."""
import json, re
R = 24
rep = open("App Store Reports/24. Fabulous - Daily Habit Tracker - Morning Routines & ADHD Help (REPORT).md").read().split("\n")
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

c(120, "§6.1 Scale table (verbatim) — bill_core 13.32%; 52.4% of 1★; 38.00% of E4; no product theme reaches half this size and none has a lower mean", "must-never-break",
  "Billing scale: bill_core 5,791 (13.32%, mean 1.110, 94.2% 1★); bill_any 6,612 (15.21%); 5,458 of 10,413 1★ reviews (52.4%); 4,042 of 10,637 E4 reviews (38.00%) — high-priority on every denominator that matters; no product theme reaches half this size and no theme has a lower mean",
  "off-Apple billing", "1★-burst", table("## 6.1 Scale"), "product-rule", "high-priority", "yes", [])
c(121, "§6.2 (1) Acquisition happens off-store — social ad → web questionnaire → payment details before ever opening the app", "anti-pattern",
  "Acquisition happens off-store: a large share arrive from an Instagram / Facebook / X ad, take a questionnaire in a web browser, and enter payment details before ever opening the app", "paid social → web funnel → card before install", "1★-burst", "6 representative reviews", "dont", "high-priority (chain)", "yes",
  ["8427785341","11036419330","12195952808","13430547332","14496026279","13631053622"])
c(122, "§6.2 (2) The trial is charged — 'pay what you can' $1 / $10 / ~$16 set-up fee, non-refundable", "must-never-break",
  "The trial is charged via a 'pay what you can' set-up fee ($1 / $10 / ~$16) described as covering costs and classed in the terms as non-refundable", "paid non-refundable 'free trial'", "1★-burst", "506 (1.16%) trial charged; 100 name the fee, mean 1.110", "must-never-break", "meaningful", "yes",
  ["13983838985","10909330947","13278190010","13591196521","14453348484"])
c(123, "§6.2 (3) One or more subscriptions created that the user did not knowingly select — bundle 324; charge with no consent or warning 338", "must-never-break",
  "One or more subscriptions are created that the user did not knowingly select — the bundle (324) and charges with no consent or warning at all (338, mean 1.047, the lowest in the corpus)", "silent enrolment", "1★-burst", "324 (0.75%); 338 (0.78%, mean 1.047, 97.3% 1★)", "must-never-break", "emerging", "yes",
  ["13578287485","14420525318","13759495643","14406647146"])
c(124, "§6.2 (4) The subscription is invisible where iOS users look — not in Apple Subscriptions; cancelling in the App Store does nothing", "product-rule",
  "The subscription is invisible where iOS users look: 125 state explicitly it does not appear in Apple Subscriptions, 204 the broader off-Apple fact; because it was sold on the web, cancelling in the App Store does nothing", "web-sold subscription invisible in iOS", "1★-burst", "125 (0.29%, mean 1.136); 204 (0.47%, mean 1.118)", "product-rule", "emerging", "yes",
  ["12932307919","14396308469","13276324661","14085528402","13631053622"])
c(125, "§6.2 (5) Cancellation does not stop the charge — 227 hold a screenshot or e-mail confirming cancellation and were charged anyway", "must-never-break",
  "Cancellation does not stop the charge: 1,620 (3.73%, mean 1.085) were charged after cancelling and 227 state they hold a screenshot or e-mail confirming the cancellation", "confirmed cancellations still billed", "1★-burst", "1,620 (3.73%), mean 1.085; 227 with proof", "must-never-break", "very strong", "yes",
  ["7226767053","7717432145","12153410886","13029061238","14372809998","14457740924"])
c(126, "§6.2 (6) Retry behaviour looks like a payment loop — daily retries (117); bank flags or blocks the merchant as fraud (123)", "must-never-break",
  "Payment retry behaviour looks like a loop to the customer: 584 (1.34%) report duplicate or repeated charges, 117 describe daily or near-daily retry attempts, and 123 report their bank flagging or blocking the merchant as fraud", "aggressive dunning retries", "1★-burst", "584 (1.34%); 117 daily retries; 123 bank-flagged", "must-never-break", "meaningful", "yes",
  ["13884799619","11914953567","13853634156","7041235372","13116907572"])
c(127, "§6.2 (7) Support cannot resolve it — web form with a 250-character limit and no telephone; refunds refused citing a 24-hour clause or the non-refundable fee", "must-have",
  "Support cannot resolve it: 947 (2.18%, mean 1.528) describe unresponsive or automated-only support; 17 name the specific obstacle — a web contact form with a 250-character limit and no telephone number; 968 (2.23%, mean 1.070) report a refund refused citing a cancel-24-hours-before clause or the non-refundable set-up fee",
  "contact form with 250-char limit; automated refusals", "1★-burst", "947 (2.18%); 17 name the form; 968 (2.23%) refused", "must-have", "meaningful", "yes",
  ["12684356794","12961953095","13116907572","13473184526"])
c(128, "§6.2 (8) The user escalates outside the company — chargeback, bank block, new card, BBB, FTC, state attorney general, lawyer", "timeline",
  "Users escalate outside the company: chargebacks, bank blocks, new cards, complaints to the Better Business Bureau, the FTC, a state attorney general or a lawyer", "disputes leave the store ecosystem", "1★-burst", "212 (0.49%, mean 1.236)", "product-rule", "weak", "yes",
  ["11541415141","11945228372","12324443572","12955266205","13338375566","13617520821","13873014737","14112324759"])
c(129, "§6.2 Interpretation — the 5,791 reviews are one architecture observed from eight angles, not eight separate problems", "insight",
  "The corpus cannot establish intent; what it establishes is that a specific commercial architecture — web checkout outside Apple IAP, bundled trials created during onboarding, and a support channel that cannot process exceptions — mechanically produces all eight complaint shapes; the 5,791 reviews are one architecture observed from eight angles",
  "off-Apple billing architecture", "1★-burst", "5,791 (13.32%)", "product-rule", "interpretation", "yes", [])
c(130, "§6.3 Quarterly timeline table (verbatim) — two step changes: 2023Q3→Q4 (6.6% → 12.0%, mean 4.192 → 3.743) and 2024Q3→Q4 (17.7% → 33.1%, 3.613 → 2.988); plateau at ~half of everything written since 2025Q2; no recovery", "timeline",
  "Quarterly bill_core and mean 2023Q1–2026Q3: two step changes, neither gradual — 2023Q3 → Q4 (6.6% → 12.0%, mean 4.192 → 3.743) and 2024Q3 → Q4 (17.7% → 33.1%, 3.613 → 2.988); since 2025Q2 the rate plateaus at roughly half of everything written and the mean near 2.0 (2025Q2 1.919, 71.8% 1★); there is no recovery anywhere in the corpus",
  "billing model tightened twice", "1★-burst", table("## 6.3 The timeline: this is a dated failure, not a constant"), "product-rule", "very strong", "yes", [])
c(131, "§6.4 An earlier, smaller billing crisis in 2018–2019 that resolved — bill_core 20.2% (Nov 2018), mean 2.854 (May 2019), snaps back Dec 2019 to 2.6% / 4.206 and holds four years", "timeline",
  "A first billing crisis resolved: monthly bill_core rose from 0.0% (Jun–Jul 2018) to 20.2% (Nov 2018), ran 7–15% through 2019 with the mean bottoming at 2.854 (May) and 2.884 (Nov), then in Dec 2019 snapped back to 2.6% / mean 4.206 and stayed for four years; the discontinuity coincides with a volume step (268 → 606 → 893) — why is an open question (pricing/billing change vs start of in-app review solicitation); it establishes the failure mode has been recoverable before — the company solved this once",
  "billing crisis fixed once", "mixed", table("## 6.4 There was an earlier, smaller version of this in 2018–2019"), "do", "very strong (event) / open (cause)", "yes", [])
c(132, "§6.5 Who is hit and who is not (verbatim table) — Ireland, Finland, Poland, Ukraine, HK, Hungary, Romania, NZ, UK, AU, CA, NL, US vs Peru, Ecuador, Mexico, Brazil, Dominican Rep., Saudi Arabia; holds in E4", "market",
  "Billing concentrates by storefront (language-neutral ratings confirm it): Ireland 3.266 / 24.48%, Finland 2.361 / 26.39%, Poland 3.154 / 25.38%, Ukraine 2.823 / 25.00%, Hong Kong 2.900 / 23.33%, Hungary 3.118 / 23.53%, Romania 3.569 / 22.41%, New Zealand 3.573 / 20.77%, UK 3.368 / 19.85%, Australia 3.436 / 19.67%, Canada 3.575 / 18.01%, Netherlands 3.172 / 17.52%, US 3.753 / 15.31% — versus Peru 4.511 / 3.01%, Ecuador 4.593 / 2.47%, Mexico 4.381 / 2.98%, Brazil 4.266 / 3.00%, Dominican Rep. 4.558 / 3.85%, Saudi Arabia 4.192 / 2.35%; in E4 US 2.560 at 42.63% and UK 2.113 at 47.26% vs Brazil 4.002 at 7.49% and Mexico 4.274 at 5.71%",
  "web funnel deployed against English/European ad audiences", "mixed", table("## 6.5 Who is hit and who is not"), "research", "very strong", "yes", [])
c(133, "§6.5 Interpretation — two readings: the web-checkout funnel targets English-language and European ad audiences, or USD/GBP/EUR price sensitivity; 'classifier can't read Portuguese' is ruled out by ratings", "insight",
  "Two non-exclusive readings the corpus cannot settle: the aggressive web-checkout funnel is deployed primarily against English-language and European advertising audiences, or price sensitivity in USD/GBP/EUR markets makes the same charge more consequential; what is ruled out is a classifier artefact — Brazilian ratings are 0.5 stars above the corpus and 1.4 above the UK",
  "n/a", "none", "br 4.266 vs gb 3.368", "research", "interpretation", "unknown", [])
c(134, "§6.6 The credibility claims turn hostile — Duke / Dan Ariely / behavioural science cited approvingly then thrown back ('uses behavioural science to get you to subscribe')", "insight",
  "The science framing (736, mean 3.865) is the theme most often inverted by detractors: Duke University, Dan Ariely and behavioural science are cited approvingly by satisfied users and thrown back by dissatisfied ones — the Duke affiliation is challenged ('no longer related to Duke… their office is in Europe'), the founder is invoked against the app ('discredited for falsifying results… I no longer trust this app to be evidence based'), and the framing is read as the mechanism ('uses behavioural science to get you to subscribe'); a genuine acquisition asset (1.77% of 5★) that becomes a liability the moment trust breaks because it raises the expected standard of conduct",
  "science/university credibility framing", "mixed", "736 (1.69%); 12 name Dan Ariely, split by era", "dont", "meaningful", "yes",
  ["3498932930","9654134632","2081835457","3383670737","11960317431","11142144586","14506251739","11036419330"])

# ---- Part 7
c(135, "§7.1 Three populations table (verbatim) — transaction-aware 2.006 vs not 4.356 vs in dispute 1.110; the 2.35-star gap is the headline; caveat: it measures what happens when money enters the conversation", "data-caveat",
  "Three populations kept apart: transaction-aware 11,200 (25.77%, mean 2.006), not transaction-aware 32,269 (74.23%, mean 4.356), in active dispute 5,791 (13.32%, 1.110); the 2.35-star gap is the headline and not an artefact of complainers using more words — the non-transaction 74% is happy; caveat: the transaction-aware group self-selects toward money grievances and measures what happens when money enters the conversation, not how payers feel",
  "n/a", "mixed", table("## 7.1 Framing this correctly"), "none", "method", "yes", [])
c(136, "§7.2 #1 The trial produced a result in days — the modal conversion story", "insight",
  "The modal conversion story: the trial produced a result in days ('In three days my mindset really started to change… so I went ahead and kept my subscription')", "content-led trial", "purchase-driver", "2 named reviews", "build-paid", "meaningful", "yes", ["11480619063","10987632061"])
c(137, "§7.2 #2 The pacing removed a prior failure — converts because the app refused to let them over-commit", "insight",
  "Users who had failed with self-directed trackers convert specifically because the app refused to let them over-commit", "gated pacing", "purchase-driver", "3 named reviews", "product-rule", "meaningful", "yes", ["11058749172","11298347895","11535313577"])
c(138, "§7.2 #3 Credibility signals — Duke/Stanford/behavioural-science framing and Atomic Habits adjacency", "do",
  "Credibility signals convert: Duke/Stanford/behavioural-science framing and Atomic Habits adjacency", "university and science framing", "purchase-driver", "4 named reviews", "do", "meaningful", "yes",
  ["10985171233","11518618204","11545357324","12975776937"])
c(139, "§7.2 #4 Price anchoring during cancellation — the cancel flow offers $19.99 → $12.99 → $5 → $2/month → 30 days free; reviewers document it as a tactic they use deliberately", "anti-pattern",
  "The cancellation flow offers progressively lower prices — $19.99, $12.99, $5, $2/month, 30 days free — and reviewers document it as a tactic they use deliberately ('keep opting for cancel, you'll eventually get an offer for $5/month'); it converts some but publicly establishes that the list price is not the real price, corrosive to the 791 (1.82%) who already object to price",
  "escalating save-offers on cancel", "mixed", "5 named reviews; price objection 791 (1.82%)", "dont", "meaningful", "yes",
  ["14078552085","11068061944","11770837150","13135059492","14162136721"])
c(140, "§7.3 What buyers value once paid — three daily coaching pieces, deep-work ritual, meditations, art and audio, and that missing a day is not punished", "insight",
  "Among paying 4–5★ reviewers the value statements are, in order: the three daily coaching pieces; the deep-work ritual; the meditations; the art and audio; and the fact that missing a day is not punished", "content and forgiveness", "praise", "5 representative reviews", "build-paid", "meaningful", "yes",
  ["11842141822","8224377882","13523105037","14038035383","13490840884"])
c(141, "§7.3 A specific under-served request — long-tenure payers cannot save or re-listen to a coaching piece ('the main reason, every year, I seriously consider whether I will even renew'); cannot revisit journal entries; background music removed", "feature",
  "Long-tenure paying users ask to save or re-listen to a coaching piece and cannot — 'the main reason, every year, I seriously consider whether or not I will even renew'; related: cannot revisit journal entries; background music removed", "no library / replay of paid content", "churn", "3 named reviews", "must-have", "limited evidence, high value", "yes",
  ["13236083919","14280639299","14346117158"])
c(142, "§7.4 Price objection examined — magnitude vs category ($40/quarter or $80–100/month with bundles vs $5–20/yr rivals), opacity (different prices on different screens), targeting (priced as premium wellness for people with executive dysfunction and low income)", "monetization",
  "The price objection (791, 1.82%, mean 2.248, 53.0% 1★) is rarely to the existence of a price; it is to magnitude relative to category ($40 per quarter, or $80–$100 per month once bundles are counted, against $5–$20/year rivals), opacity (different prices quoted on different screens), and targeting (a product marketed to people with executive dysfunction and low income priced as a premium wellness subscription)",
  "~$40/quarter plus bundles; inconsistent price display", "complaint", "791 (1.82%), mean 2.248", "research", "meaningful", "yes",
  ["12185164799","13101231620","14135454399","13010833468","12308000770","12470218336","13182834152","13615857614","14350750065","11637887359","12663348260","13281553025","14110502597"])
c(143, "§7.4 Counter-evidence — the free tier is repeatedly described as genuinely usable and a distinct group says the price is fair ('only $20 a year and it is worth every penny')", "monetization",
  "Counter-evidence stated fairly: the free tier is repeatedly described as genuinely usable (77 reviews, mean 4.442) and a distinct group says the price is fair for what is included ('only $20 a year and it is worth every penny')", "usable free tier; some at $20/yr", "praise", "77 (0.18%); 3 fair-price reviews", "research", "weak", "yes",
  ["12877743366","13649333600","13885598213","14383996948","11062961456","11178556858","13523105037"])
c(144, "§7.5 Refunds and billing support — refusal language near-verbatim across years: 'set-up fee for the trial period is non-refundable'; 'unless cancelled at least 24 hours before the renewal date'", "dont",
  "Refund refusal language is near-verbatim across years and markets — 'in line with our T&Cs, the set-up fee for the trial period is non-refundable' and 'the renewal date was displayed at the time of signing up… unless cancelled at least 24 hours before the renewal date'", "templated refusals citing T&Cs", "1★-burst", "refund mentioned 1,737 (4.00%, 1.163); refused 968 (2.23%, 1.070); support 947 (2.18%, 1.528); escalated 212 (0.49%, 1.236)", "dont", "very strong", "yes",
  ["11270936086","12321421246","13653522994","13753645415","14350750065","14013765356"])
c(145, "§7.5 Partially offsetting — a visible minority report fast, effective refunds and upgrade their review in place (1★ → 4★); the refund path works when reached, the failure is reaching it", "insight",
  "A visible minority report fast, effective refunds, sometimes upgrading their review in place (1★ → 4★ after refund) — the refund path works when it is reached; the failure is reaching it", "refunds work when the request lands", "praise", "6 named among 1,412 edited", "must-have", "limited evidence", "yes",
  ["12610947103","13811397692","14482279671","14034408044","12254880059","14220122715"])

with open("Tools/prd_ledger/24/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
