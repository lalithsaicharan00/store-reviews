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

# ---- PART 5 ----
c(79, "Part 5 Audience 1 table (verbatim)", "audience", "Recovery and harm-reduction use cases with count, %, mean — full table (alcohol 7.09%, nicotine 3.82%, food/EDs 2.32%, self-harm 1.14%, hard drugs 1.03%, cannabis 0.96%, social media 0.69%, BFRBs 0.40%, porn/NoFap 0.38%, no-contact 0.31% at mean 4.97, shopping 0.24%, gambling 0.06%)",
  "n/a", "praise", table(334, 347), "do", "high-priority", "yes", [],
  cond="quit-habit audience; means are all 4.75–4.97 — every recovery use case is a happy one")
c(80, "Part 5 Audience 1 self-harm paragraph", "audience", "The self-harm / suicidality cohort (121 reviews, mean 4.77) matters disproportionately: multiple reviewers are minors (11, 12, 13 years old), and three complain that a 17+ age rating blocked them via family filters — the age rating is load-bearing for a real segment",
  "age rating moved 12+ → 17+ → 12+", "praise", "121 (1.14%); 5 self-identified minors; 3 age-rating complaints", "do", "meaningful", "yes",
  ["8235797720","11811900918","9168912965","13649780407","8444639701","9082663804","9142597312","12044926784"],
  side="content/age rating is a product decision with a user segment attached; monetisation moves land on this cohort as 'preying on the vulnerable' (R03-011)")
c(81, "Part 5 Audience 2", "audience", "The accidental second product: 443 reviews (4.17%) use the app for chores, ADHD time-blindness or household maintenance, and 77 (0.72%) for medical tracking (seizure logs, medication refills, cancer prognosis, pet symptoms) — a very strong signal the developer did not design for and reviewers apologise for",
  "designed for recovery; used for time-since-anything", "praise", "443 (4.17%) chores/ADHD; 77 (0.72%) medical", "do", "very strong", "yes",
  ["12276515904","13602265269","11802530951","12712883376","13152317845","11987481281","12109101100","13469744538","12095994550","13155067518","11792382769","12783836494","11572672661","12864038501","12708537989","13591837410","12818140107","14248093670","12885656663"],
  side="'saw this app recommended in an ADHD subreddit'; 'found it via a book on ADHD' — the ADHD audience arrives through community channels",
  cond="'time since I last did X' is a general-purpose primitive: ADHD time-blindness, medical logs, maintenance")
c(82, "Part 5 product implication", "contradiction", "The two audiences want opposite things: recovery users want the number to go UP and hate the reset button; chore users want it to stay LOW and reset constantly — 10 reviews ask for an 'invert' or 'good habit' mode; one counter type, two mental models",
  "one counter type", "mixed", "10 invert-mode requests", "research", "clear mechanism", "yes",
  ["12014211393","8197401481","9503479974","9917027140","11689561035","8690192526","9766598371","8168145206","8298887438","11810992187"],
  cond="a 'good habit / invert' mode reconciles them; the reset affordance must differ per mode")

# ---- PART 6 ----
c(83, "Part 6 country table (verbatim)", "market", "All 23 storefronts with ≥50 reviews: n, mean, 1–2★, widget-paywall, any-paywall, sub-nag, price, free-praise, simple-praise, widget-praise — full table",
  "n/a", "mixed", table(370, 394), "none", "high-priority", "yes", [])
c(84, "§6.1", "market", "The US (5,600 reviews, 52.7%) decides the rating and carries 84 of 128 widget-paywall complaints (65.6%) at 1.5% of US reviews vs 0.6% elsewhere; it is the only market where price/greed vocabulary reaches 1.2% — but not the angriest by rating (Poland 8.5% 1–2★, Italy 5.8%, Netherlands 5.5%)",
  "n/a", "complaint", "US n=5,600, mean 4.77, 3.3% 1–2★; 84/128 widget complaints", "do", "high-priority", "yes", [],
  side="the US is the most vocal about monetisation specifically")
c(85, "§6.2", "market", "The anglophone core (US+GB+CA+AU+NZ+IE) is 7,874 reviews (74.1%) at mean 4.77 — where the widget paywall did 81% of its damage, where free-tier praise is highest (AU 7.6%, CA 5.7%) and simplicity praise strongest (AU 42.3%, NZ 42.9%); positioning that works in one works in all",
  "English-only app", "mixed", "7,874 (74.1%), mean 4.77; 104 of 128 widget complaints", "do", "high-priority", "yes", [])
c(86, "§6.3 opening", "market", "High-spend markets (US, GB, CA, AU, DE, FR, IT, ES, NL, SE, DK, CH, IE, NZ, SA, AE) hold 8,388 reviews (79.0%) at mean 4.77, 3.1% 1–2★",
  "n/a", "mixed", "8,388 (79.0%), 4.77, 3.1%", "none", "high-priority", "yes", [])
c(87, "§6.3 Germany", "market", "Germany is the price-sensitive market: 2.4% of German reviews use price/greed language — double the US rate and the highest of any eligible market; '59,99€ is too much for me personally to pay for an app that basically tracks time'",
  "€59.99 lifetime shown in DE", "complaint", "DE n=294, price 2.4%", "research", "meaningful (in-market)", "yes",
  ["10931212725","12605773887","11589368716","14018922179","13413526077","12892307323","13879073912"])
c(88, "§6.3 Denmark & Poland", "market", "Denmark and Poland took the widget change hardest per capita (3.8% and 4.2% of their reviews) — 'Widgets suddenly premium only. No warning, no version update info about it'",
  "widget paywalled without release-note disclosure", "1★-burst", "DK 3.8%, PL 4.2% on small bases", "dont", "limited evidence", "yes",
  ["12882383970","12990450515","12853744436","12944067790","13631461492","11887508168"],
  side="an undisclosed change in release notes is itself a complaint")
c(89, "§6.4 opening", "market", "High-review-volume markets US, GB, CA, AU, IN, DE = 8,401 reviews (79.1%) — volume used strictly as a disclosed engagement proxy",
  "n/a", "mixed", "8,401 (79.1%)", "none", "method", "yes", [])
c(90, "§6.4 India", "market", "India is the anomaly: 346 reviews at 4.79 with 0.3% paywall and 0.3% nag complaints — five times lower than any other market; the only pricing feedback is a polite request for regional pricing ('I wish it were around ₹2000 than ₹5000') — a market that likes the product and has not yet been asked to pay a price it can accept",
  "single global price (₹5,000/yr)", "blocked-conversion", "IN n=346, mean 4.79, paywall 0.3%, nag 0.3%", "do", "meaningful (in-market)", "yes",
  ["8310546194","12352453901","9709310769","11511641881","13283082126","10134372371","10848084400","10468707953","9385157078"])
c(91, "§6.5", "market", "English-only yet shipped in 111 storefronts: only 9 reviews (0.08%) ask for translation, but the count is suppressed by selection — people who can't read the app don't write English reviews; only 67 reviews (0.63%) are in a non-Latin script, so non-English markets are systematically under-represented; one explicit lost sale ('PS : l'app n'est toujours pas traduite')",
  "English only", "blocked-conversion", "9 (0.08%); 67 non-Latin-script reviews (0.63%)", "do", "below threshold, selection effect", "yes",
  ["8670657354","9782695829","7912950885","6937466468","11396418684","8890864234","9471638249","10584415042","12323759307","13189265606"],
  side="a low localisation-request count in an English-only app is evidence of absence of non-English users, not absence of demand")
c(92, "§6.6", "data-caveat", "88 storefronts under 50 reviews hold 954 reviews (9.0%) at mean 4.78 — indistinguishable from the global mean; no standalone claims",
  "n/a", "none", "954 (9.0%), 4.78", "none", "method", "yes", ["12982439459","13722672404","8894412160"])

# ---- PART 7 ----
c(93, "§7.1", "timeline", "Reviews per year: 7 / 151 / 1,281 / 2,275 / 1,314 / 2,163 / 2,269 / 1,161 (2019–2026 partial) — a growing, actively developed app; v4.1.0 shipped six days before the last review",
  "active development", "praise", "2,275 peak (2022); 2,269 (2025)", "none", "high-priority", "app-specific", [])
c(94, "§7.2 lines", "timeline", "Mean by year 4.43 → 4.71 → 4.88 → 4.85 → 4.74 → 4.78 → 4.71 → 4.64 (2019–2026); 1–2★ 2.0% → 0.6% → 1.1% → 3.6% → 2.8% → 5.1% → 6.2%",
  "n/a", "mixed", "2026 mean 4.64, 1–2★ 6.2%", "none", "high-priority", "app-specific", [])
c(95, "§7.2 event 1", "timeline", "First monetization shock, late 2022: 1–2★ jumped 0.92% → 3.87% when the 'Count Up Club' subscription launched with upsell spam and the widget reset button removed from free — 'must pay $18 to begin using the app' — survivable: the app recovered to 4.82 by 2025 Q1",
  "launched subscription Q4 2022; removed widget reset from free", "1★-burst", "0.92% → 3.87% 1–2★ in 2022 Q4; recovered by 2025 Q1", "dont", "high-priority", "yes",
  ["9178559150","9211936118","9246079791","9438566929","9444704937","9027024142","9036334050"],
  side="a subscription launch with nagging costs ~3 points of 1–2★ for two years even when the product is untouched",
  cond="contrast event 2: taking away an existing free feature was not survivable in the same window")
c(96, "§7.2 event 2", "timeline", "Second shock, July 2025: 1–2★ 1.75% → 8.64% on the widget paywall; fourteen months later it has not returned to its 2025 Q2 baseline — the decline is two discrete events, not gradual erosion",
  "paywalled the widget", "1★-burst", "1.75% → 8.64%; not recovered after 14 months", "product-rule", "high-priority", "yes", [])
c(97, "§7.3", "timeline", "Worsening: paywall complaints 0.7% (era A) → 5.4% (era D), 8×; widget paywall 0.0% → 4.5%; price/greed language 6 reviews (2020–21) → 60 (2025–26)",
  "monetisation tightened over time", "complaint", "8× paywall complaints; 10× price/greed", "dont", "high-priority", "yes", [])
c(98, "§7.4", "timeline", "Stable: simplicity praise holds at 26–42% of every era — the core value has not degraded; free-tier praise actually ROSE in era D (4.6% → 6.1%) because free users who kept their widget wrote defensively positive reviews; milestone requests constant 2020→2026",
  "n/a", "praise", "simplicity 26–42% every era; free praise 6.1% in era D", "none", "high-priority", "yes",
  ["14456318136","14211548185","13053535012","12957382577","14364118481"],
  side="a paywall fight produces defensive 5★ reviews from the unaffected as well as 1★ from the affected")
c(99, "§7.5 backdate", "timeline", "Fixed: 'can't backdate / edit start date' was an early 1★ defect ('Can't set date — worthless app', Dec 2019) that largely disappears after 2022 and is now praised as a differentiator — evidence of a real fix",
  "fixed date editing by 2022", "praise", "7 early 1★ IDs → 5 later praise IDs", "must-have", "meaningful", "yes",
  ["5264212724","5492378192","6396319937","6431260025","5530635157","6614014666","5543491910","8568493851","7795420959","12377633896","13066783750","8913462962"],
  side="an editable start date is table stakes for a counter; when present it is praised")
c(100, "§7.5 widget breakage + crashes", "must-never-break", "Widget technical breakage clustered in 2021–24 (17 reviews) and is near-zero in 2025–26; crashes total 12 in 10,621 (0.11%) — by category standards the engineering is excellent",
  "stable, well-engineered", "praise", "17 widget-breakage reviews 2021–24; 12 crashes (0.11%)", "must-never-break", "high-priority", "yes", [],
  cond="proves the rating collapse was monetisation, not quality")

with open("Tools/prd_ledger/3/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
