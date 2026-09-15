import json, re
R = 16
rep = open("App Store Reports/16. Atoms - from Atomic Habits - The official Atomic Habits app (REPORT).md").read().split("\n")
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
    return " ; ".join(re.sub(r"\s*\|\s*", " | ", l.strip("|")).replace("**","").strip() for l in rows)
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))

# ---- PART 7 ----
c(59, "§7.1 Method — four cohorts; §7.2 Trend 1 — The launch bought a rating and then spent it in six weeks; table (verbatim)", "timeline",
  "The launch bought a rating and spent it in six weeks: the mean fell 0.88 stars from the launch window to the following nine months and never returned; the floor since April 2024 (mean 3.22, 22.0% one-star) is the app's written steady state; within the launch window 24 Feb 4.49 → 27 Feb 3.84 as the price became widely known",
  "$120/yr revealed after launch buzz", "1★-burst", table("## 7.2 Trend 1") + " ; P1 678 / P2 217 / P3 190 / P4 83", "product-rule", "trend", "yes",
  ["10976398063","10979802836"])
c(60, "§7.3 Trend 2 — Worsening and unresolved: reliability; table (verbatim)", "timeline",
  "Reliability is worsening and unresolved — more than doubled; the launch bugs were fixed, the 2025 bugs were not; the freeze-on-habit-creation cluster is documented at ten dates between Apr 2025 and Feb 2026 and still producing 1★ eight weeks before the corpus ends — the only story unambiguously getting worse",
  "onboarding freeze unfixed since Apr 2025", "1★-burst", table("## 7.3 Trend 2"), "must-never-break", "trend", "yes", [])
c(61, "§7.4 Trend 3 — Worsening: brand damage and the paywall framing; table (verbatim)", "timeline",
  "Brand damage and bait-and-switch framing are worsening: bait-and-switch tripled from launch to 2026 — as the launch cohort's memory fades, a new cohort discovers the wall for the first time; rigid-habit-model complaints also nearly tripled",
  "trial cliff unchanged", "1★-burst", table("## 7.4 Trend 3"), "dont", "trend", "yes",
  ["14302077000","13613868361"])
c(62, "§7.5 Trend 4 — Improving, but only relatively: price and cap complaints; table (verbatim); P2 is the trough", "timeline",
  "Price and cap complaints improved only relatively: P2 (Apr–Dec 2024) is the trough — half of everything written was a price objection, in the period containing the June 2024 cut; price objection is still 30.12% in 2026, essentially the launch rate, at roughly one-third of the launch price; the Pro-cap complaint has not moved in 30 months",
  "price cut ~67%; caps unchanged", "complaint", table("## 7.5 Trend 4"), "product-rule", "trend", "yes", [])
c(63, "§7.6 Trend 5 — Decaying: everything that made the launch reviews good; table (verbatim); people cannot praise what they cannot see; nobody has defended the constraint since 2025", "timeline",
  "Every positive theme is falling and the two most specific — Mindset content and the haptic loop — fell by three-quarters: Mindset praise fell as the content moved behind the paywall (people cannot praise what they cannot see), haptic praise fell after the mid-2024 list redesign; nobody has defended the habit constraint since 2025 — the app's most distinctive idea has stopped being described as a virtue by anyone",
  "content paywalled; circles replaced by list", "complaint", table("## 7.6 Trend 5"), "product-rule", "trend", "yes",
  ["11343906321","11814577640","11390526677","11368755180"])
c(64, "§7.7 Trend 6 — Emerging: dark mode", "timeline",
  "Dark mode is the emerging request: 16 of 21 requests are dated after Nov 2024, from happy users — the highest-goodwill unmet need in the corpus",
  "no dark mode", "complaint", "0.29% → 2.76% → 5.26% → 3.61%; 21 total mean 3.76, 9.5% 1–2★", "build-free", "trend", "yes", [])
c(65, "§7.8 What persisted unchanged across the whole 31 months table (verbatim)", "timeline",
  "Seven themes reported in the first 72 hours of general availability and still producing reviews in 2026: free tier = 1 habit, Pro cap, no back-logging, English only, no dark mode, rigid time-locked model, requires internet to log",
  "n/a", "complaint", table("## 7.8 What persisted unchanged"), "product-rule", "persistent", "yes",
  ["10975917055","14064134860","10975518449","14287877372","10976218757","13717258566","10983171894","14276815734","10983131171","14163695377","10975577608","10977084069","13792185404"])

# ---- PART 8 ----
c(66, "§8.1 #1 Raise the free tier from 1 habit to 3", "product-rule",
  "Raise the free tier from 1 habit to 3 — the number reviewers repeatedly propose; the constraint's defenders defend a limit of 3–6, not 1, so raising the free tier keeps the philosophy and removes the objection; the single highest-leverage change and a configuration value",
  "free = 1", "blocked-conversion", "76 reviews mean 2.22, 61.8% 1–2★; defenders 20 mean 4.60", "product-rule", "recommendation (immediate)", "yes",
  ["10975505569","10988610880","11749997696","13838905269","10986199056"])
c(67, "§8.1 #2 Remove the 6-habit cap from the paid tier, or raise it to 12–15 — a cap on the tier someone has already paid for has no monetisation function", "product-rule",
  "Remove the 6-habit cap from the paid tier or raise it to 12–15 — a cap on the tier someone has already paid for has no monetisation function (there is no higher tier to drive to); it only produces angry reviews, and two of three payers who bought to escape a cap rated 3★ after hitting the next one",
  "Pro = 6", "churn", "75 reviews mean 2.57, 29 months unchanged", "product-rule", "recommendation (immediate)", "yes",
  ["14287877372","13573785597","13222746779"])
c(68, "§8.1 #3 Fix the freeze-on-first-habit-creation bug — kills users at the moment of first value", "must-never-break",
  "Fix the freeze-on-first-habit-creation bug — ten dated instances describe the identical screen; it kills users at the moment of first value, before they have anything to lose, which is why it produces no partial credit",
  "onboarding freeze", "1★-burst", "31 mean 1.90, 74.2% 1–2★, zero 5★", "must-never-break", "recommendation (immediate)", "yes", [])
c(69, "§8.1 #4 Give the free tier back to cancelled subscribers, and stop deleting their history", "must-never-break",
  "Give the free tier back to cancelled subscribers and stop deleting their history — a cancelled subscriber who keeps a read-only history is a candidate for resubscription; one whose data is hostage is a 2★ review and a permanent loss",
  "lapsed payers locked out", "churn", "n=1 (whole case)", "must-never-break", "recommendation (immediate)", "yes",
  ["13573892543"])
c(70, "§8.1 #5 Answer the support-failure and billing reviewers, and publish a support address in the app; refunds refused on unused auto-renewals are cheap to reverse", "must-have",
  "Answer the seven support-failure and five billing reviewers and publish a support address in the app — two reviewers could not find any contact route and wrote the review instead; refunds refused on auto-renewals the customer did not use are producing the angriest writing and are cheap to reverse",
  "no in-app support address; refunds refused", "1★-burst", "support 7 mean 2.14; billing 7 mean 1.43 (lowest theme)", "must-have", "recommendation (immediate)", "yes",
  ["10977940087","10992497041","11011057187","12988241997","11990095414","12165173158"])
c(71, "§8.2 #6 Ship a one-time / lifetime SKU — the problem is the shape, not the number", "monetization",
  "Ship a one-time / lifetime SKU — the price has already fallen ~67% with no measurable effect on the objection rate, the strongest available evidence that the problem is the shape not the number; reviewer-stated reservation prices cluster at $10–$30 one-time, a band testable immediately",
  "subscription only", "blocked-conversion", "37 (3.17%) mean 2.16; Streaks named 8×; objection 30.97% → 30.12%", "build-paid", "recommendation", "yes", [])
c(72, "§8.2 #7 Stop paywalling the Mindset content, or unbundle it — content free, habit slots paid, the exact inverse of today", "product-rule",
  "Stop paywalling the Mindset content or unbundle it — paywalling the ideas from a book the user already bought is the packaging decision reviewers find hardest to forgive, and Mindset praise fell 6.78% → 1.20% once it went behind the wall; the content is a differentiator generating more resentment than revenue — consider content free, habit slots paid, the exact inverse of today",
  "content paywalled, slots gated", "complaint", "Mindset praise 6.78% → 1.20%", "product-rule", "recommendation", "yes",
  ["11010361389","11097642923","12819752757"])
c(73, "§8.2 #8 Recognise book buyers — a code, a barcode scan, a discount or free month", "tactic",
  "Recognise book buyers with a code, a barcode scan, a discount or a free month — reviewers propose the mechanism themselves; no reviewer bought the book and felt the app respected that, eighteen felt the opposite",
  "no book-buyer recognition", "blocked-conversion", "18 (1.54%) mean 2.61", "do", "recommendation", "app-specific",
  ["11097642923","12513582477","10983993222"])
c(74, "§8.2 #9 Introduce regional pricing and a student tier", "do",
  "Introduce regional pricing (a Peruvian reviewer does the PPP arithmetic) and a student tier — rest-of-world reviewers ask 6.7× more often than high-spend-market reviewers",
  "single global price", "blocked-conversion", "11 regional; student asks 4 IDs", "do", "recommendation", "yes",
  ["11001435276","13456206729","10983993222","10984142146","11105451365"])
c(75, "§8.2 #10 Redesign the trial's ending, not its length — taper, warn earlier in-app, preserve the streak read-only", "product-rule",
  "Redesign the trial's ending, not its length — the trial itself is well-liked (no auto-charge); what breaks is the cliff; options the corpus supports: taper (keep 3 habits free forever), warn earlier and in-app rather than by email (two reviewers never saw it coming), or preserve the streak read-only after expiry",
  "hard cliff at day 28, email-only warning", "1★-burst", "bait-and-switch tripled to 7.23%", "product-rule", "recommendation", "yes",
  ["13616010098","14046766451"])
c(76, "§8.3 #11 Ship back-logging and streak import", "feature",
  "Ship back-logging — a request from people who mostly still like the app, in the two bands where ratings are cheapest to move; reviewers also want to import an existing streak",
  "log today/yesterday only", "complaint", "33 mean 3.39, 21.2% 1–2★; 9.8% of 4★, 7.4% of 3★", "build-free", "recommendation", "yes",
  ["12014435210","12259757598","11128803895"])
c(77, "§8.3 #12 Ship dark mode — one setting", "feature",
  "Ship dark mode — the fastest-growing feature request, framed as accessibility by two reviewers; one setting",
  "no dark mode", "complaint", "21 mean 3.76", "build-free", "recommendation", "yes", [])
c(78, "§8.3 #13 Make logging work offline — a habit tracker that cannot tick a box on a plane is failing at its only job", "must-never-break",
  "Make logging work offline — a habit tracker that cannot tick a box on a plane, on a hike, or on patchy service is failing at its only job",
  "internet required to log", "complaint", "9 mean 2.56, zero 5★", "must-never-break", "recommendation", "yes",
  ["10977084069","11339178421","13090001429"])
c(79, "§8.3 #14 Loosen the habit model — X times a week any day, no fixed time, multiple logs per day, habit stacking, editable identity phrasing", "feature",
  "Loosen the habit model — the third-fastest-growing negative: allow 'X times a week, any day', habits with no fixed time, multiple logs per day, habit STACKING (which the book is famous for and the app does not implement), and editable identity phrasing",
  "time-locked daily template; no stacking", "complaint", "39 (3.34%); 2.51% → 7.23%", "must-have", "recommendation", "yes",
  ["11569901162","14201996700","11018442332","11007001740","14237890130","11015467978","11087707385","11383246654","13517748845","11490817427","11402101270","11764648914","12228073166"])
c(80, "§8.3 #15 Restore the satisfying completion loop — offer the circle view as an option", "do",
  "Restore the satisfying completion loop — the most-praised piece of craft should not be a casualty of density; offer the circle view as an option",
  "circles replaced by compact list", "complaint", "haptic praise 4.87% → 1.20%; 4 reviewers name the change", "do", "recommendation", "yes",
  ["11343906321","11814577640","11390526677","11368755180"])
c(81, "§8.4 #16 Localise, starting with Spanish — the cheapest new market available", "market",
  "Localise, starting with Spanish — 14 of 36 requests; the book exists in ~60 languages; the widest brand-reach-to-product-reach gap and the cheapest new market available",
  "English only", "blocked-conversion", "36 (3.08%), Spanish 14, 7.76% of tail storefronts", "build-free", "recommendation", "yes", [])
c(82, "§8.4 #17 Say what the free tier is, in the listing, before download — converts a 1★ ambush into a 3★ informed decision", "do",
  "Say what the free tier is in the listing before download — eight reviewers had no idea the app was paid; a clear '1 free habit, Pro for more' line converts a 1★ ambush into a 3★ informed decision, and converts far better paired with a 3-habit free tier",
  "listing does not state the free tier", "1★-burst", "8 reviewers", "do", "recommendation", "yes",
  ["11562525291","12250461429","12482534390","12591641304","12959086974","13616010098","13807288552","14046766451"])
c(83, "§8.5 Research questions this corpus cannot answer", "data-caveat",
  "Research questions: actual conversion rate and whether the two price cuts moved it; do 1★ price reviewers ever become buyers at a lower price (one observed); how much of the 4.81 tap-rating is trial-period sentiment (an in-app prompt fired before vs after day 28 would answer it); is the freeze bug device-, OS- or storefront-specific; would a 3-habit free tier cannibalise Pro; is the review-solicitation campaign still running",
  "n/a", "none", "6 questions", "research", "research questions", "yes",
  ["11980741663","10977084069"])

with open("Tools/prd_ledger/16/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
