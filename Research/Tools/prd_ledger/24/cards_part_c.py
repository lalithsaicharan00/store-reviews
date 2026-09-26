"""Cards for report 24 — Part 4 (design bets) and Part 5 (ratings analysis)."""
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

c(104, "§4.1 The bet: constrain the user, and constrain them gently — validation: previous failure with self-directed trackers, success attributed to the constraint", "insight",
  "The design bet — the app decides what you work on, refuses to let you add more, and wraps the refusal in narrative and audio — is validated at the top of the distribution: reviewers describe previous failure with self-directed trackers and attribute success to the constraint ('I stacked up everything I wanted to change… and I failed—MISERABLY'; 'it warns you when trying to add too much')",
  "app-directed programme, refuses over-commitment", "praise", "1,817 (4.18%), mean 4.692, 2.0% 1★", "product-rule", "very strong", "yes",
  ["11058749172","11300682685","8316569117"])
c(105, "§4.1 Rejection — four complaint shapes table (verbatim): 'I already do this' 124; 'it ignored my answers' 175; 'too slow / shallow' 168; 'doesn't fit my week' 31", "anti-pattern",
  "The same constraint produces four complaint shapes: 'I already do this' (forced water/breakfast, 124, mean 2.452); 'it ignored my answers' (no customisation, 175, 2.097); 'too slow / too shallow' (168, 2.393); 'it doesn't fit my week' (no per-day schedule, 31, 3.484) — a long onboarding questionnaire produces an identical plan for everyone ('You will answer a ton of questions… and then the app will not take any of your answers into account'; 'I told it I drink water all day. The first habit I'm to build is drinking three glasses of water')",
  "detailed questionnaire, identical plan", "complaint", table("**Rejection.** The same constraint produces four distinct complaint shapes:"), "product-rule", "weak individually, consistent", "yes",
  ["11727320977","11787845786","14173187184"])
c(106, "§4.1 Interpretation — the corpus asks for one branch: declare an existing habit as already-held and start at habit two", "product-rule",
  "The corpus does not ask for the constraint to be removed; it asks for one branch — a way to declare an existing habit as already held and start at habit two; small cost, and it addresses the concrete example inside several much larger personalisation complaints",
  "no 'already do this' branch", "complaint", "124 (0.29%) direct; feeds 175 + 168", "product-rule", "interpretation", "yes", [])
c(107, "§4.2 The second bet: make the interface an experience — for (design 4.089, music 4.387) vs against (cluttered 3.068, pop-ups 2.082, childish 2.701)", "contradiction",
  "The app is an animated, narrated, colour-saturated world rather than a checklist, and the corpus splits measurably: for — design 2,969 (mean 4.089), music/audio 282 (4.387); against — cluttered/overwhelming 1,324 (3.068), pop-ups 182 (2.082), childish/condescending 304 (2.701)",
  "experiential, animated UI", "mixed", "for 2,969 + 282 vs against 1,324 + 182 + 304", "undecided", "very strong", "yes", [])
c(108, "§4.2 An app marketed as an ADHD and focus aid is described as itself overstimulating — a stock sentence ('This app literally GIVES me adhd')", "anti-pattern",
  "The against-case has a specific, repeated, damaging form: an app marketed as an ADHD and focus aid is described as itself overstimulating — close to a stock sentence ('This app literally GIVES me adhd'; 'an ADHD nightmare to set up'; 'For someone with severe ADHD this app is completely useless')",
  "overstimulating UI sold as a focus aid", "churn", "4 named reviews; cluttered 1,324 (3.05%)", "product-rule", "very strong", "yes",
  ["11778963777","11436147013","13600052281","13656613592"])
c(109, "§4.2 Clutter grows independently of billing: 1.90% → 2.72% → 2.96% → 4.26%; sister-app ads 0.11% → 0.21% → 0.50% → 2.03% — what got added was commercial, not functional", "timeline",
  "Clutter complaints rose steadily across all four eras including the two good ones (1.90% → 2.72% → 2.96% → 4.26%) and sister-app advertising rose 0.11% → 0.21% → 0.50% → 2.03% — the interface got busier over time and a material part of what got added was commercial rather than functional",
  "interface accreted commercial surfaces", "churn", "1.90 → 2.72 → 2.96 → 4.26%; 0.11 → 0.21 → 0.50 → 2.03%", "dont", "very strong", "yes", [])
c(110, "§4.3 The third bet: an ecosystem of separate apps — experienced as advertising inside a paid product (14.6% 4–5★, lowest of any UX theme) and as a billing trap", "anti-pattern",
  "From ~2022 the product became a family of apps (Clarify, Shape, Elixir, Lumière, Lune, Ambiance, Sphere, Mind) and reviewers experience it two ways, both negative: as advertising inside a product they already pay for ('I'm on the purchased version… I don't want to see adds'; 'please consider removing ads and upsells for paying members!!') and as a billing trap — near-identical offer screens during onboarding each enrolling a separate subscription that must later be cancelled separately",
  "app-family cross-sell with separate subscriptions", "1★-burst", "ads 308 (0.71%, mean 1.932, 14.6% 4–5★); bundle 324 (0.75%, mean 1.398); both E4: 0.30 → 0.06 → 0.17 → 2.62%; 0.11 → 0.21 → 0.50 → 2.03%", "dont", "emerging", "yes",
  ["11143130693","11960208395"])
c(111, "§4.4 The fourth bet: sell direct, not through Apple — the largest and lowest-rated theme is a consequence of a commercial architecture decision, not a feature", "insight",
  "Selling direct rather than through Apple is a design bet: the corpus's largest and lowest-rated theme is a consequence of a commercial architecture decision, not of a feature", "off-Apple billing", "1★-burst", "bill_core 13.32%, mean 1.110", "product-rule", "high-priority", "yes", [])

# ---- Part 5
c(112, "Part 5 intro — median review length rises 5★ → 2★ (105 → 150 → 227 → 286 chars) then falls at 1★ (243); the 2★ band holds the most considered reviews", "data-caveat",
  "Median review length rises monotonically from 5★ to 2★ (105 → 150 → 227 → 286 characters) and falls slightly at 1★ (243) — the 2★ band contains the most considered reviews and the 1★ band many one-word verdicts", "n/a", "mixed", "105 → 150 → 227 → 286 → 243 chars", "none", "corpus-level fact", "yes", [])
c(113, "§5.1 5★ themes table (verbatim); 424 five-star reviewers still say the interface is too busy; much of the band is written in the first three days at the app's prompting", "data-caveat",
  "5★ (n=25,163, mean length 105, bill_core 59 = 0.2%): coaching 18.19%, life-changing 15.75%, routine built 10.57%, design 7.23%, small steps 5.85%, depression/anxiety 3.23%, science 1.77%, cluttered 1.69%, ADHD 1.32%; 424 five-star reviewers still say the interface is too busy — a feature request from retained customers; a substantial share is written in the first three days at the app's prompting, so treat the band as first-impression satisfaction",
  "n/a", "praise", table("Mean review length 105 characters — the shortest band."), "must-have", "corpus-level fact", "yes",
  ["13061180549","14003379751","13802373157","12134714782"])
c(114, "§5.2 4★ — 'I like it, but': praises coaching then asks for a simpler home screen", "insight",
  "4★ (n=4,601, bill_core 32 = 0.7%) is where product criticism first appears at scale — confusing navigation 6.32%, cluttered 4.04%, crash 2.93%; the modal 4★ review praises the coaching and then asks for a simpler home screen", "n/a", "mixed", "291 (6.32%); 186 (4.04%); 135 (2.93%)", "must-have", "corpus-level fact", "yes",
  ["11039550189","11189202374","12832796136","14435637931","14110502597"])
c(115, "§5.3 3★ — the most balanced band and most useful for product work", "insight",
  "3★ (n=1,828, bill_core 62 = 3.4%) is the most balanced band: confusing navigation 10.01%, cluttered 8.37%, crash 7.22%, notifications 5.47%, price 4.65%, sister-app ads 2.35% alongside coaching 12.69% and design 10.56%", "n/a", "mixed", "as listed", "none", "corpus-level fact", "yes",
  ["10992459471","11065672263","11583598458","13047138158","14221145502"])
c(116, "§5.4 2★ — the longest band (286 chars): a long, careful account of an app the writer wanted to like; highest design-praise share of any negative band", "insight",
  "2★ (n=1,464, bill_core 180 = 12.3%) is the longest band (286 characters), led by confusing navigation 12.98% and cluttered 12.16% with design praise at 12.02% — the highest design-praise share of any negative band; the characteristic 2★ review is a long, careful account of an app the writer wanted to like", "n/a", "churn", "12.98% / 12.16% / 12.02%", "must-have", "corpus-level fact", "yes",
  ["11059128795","11258492217","12206139825","13093968640","14494360866"])
c(117, "§5.5 1★ themes table (verbatim) — bill_core in 52.4% of the band; era distribution E4 53.7% of all 1★; within E4 1★ is 52.5% of everything written", "data-caveat",
  "1★ (n=10,413): bill_core present in 5,458 (52.4% of the band); scam 32.18%, refund 15.41%, charged after cancelling 14.91%, cannot cancel 10.16%, refund refused 8.95%, support 7.28%, confusing navigation 6.68%, duplicate charges 5.25%, trial not free 4.51%, ADHD 4.27%; era distribution E1 1,552 (14.9%) · E2 2,031 (19.5%) · E3 1,242 (11.9%) · E4 5,588 (53.7%); within E4, 1★ is 52.5% of everything written",
  "n/a", "1★-burst", table("`bill_core` present in **5,458 reviews — 52.4% of the entire band**."), "product-rule", "corpus-level fact", "yes", [])
c(118, "§5.6 Themes that cut across the rating line (verbatim table) — clutter, ADHD, design, science framing", "data-caveat",
  "Cross-band themes: cluttered (424 in 5★ = 1.69%; 1,324 total, mean 3.068) — retained users want it calmer, new users bounce; ADHD (331 in 5★ = 1.32%; 445 in 1★ = 4.27%) — the segment is both best- and worst-served; design (1,820 in 5★; mean 4.089) — praised even by detractors, not the problem; science framing (446 in 5★; mean 3.865) — credibility cuts both ways once trust is lost",
  "n/a", "mixed", table("## 5.6 Themes that cut across the rating line"), "none", "corpus-level fact", "yes", [])
c(119, "§5.6 Design is praised even by detractors — it is not the problem", "insight",
  "Art/design is praised even by detractors — design is not the problem; the money and the clutter are", "strong art direction", "praise", "2,969 (6.83%), mean 4.089; 12.02% of 2★", "do", "corpus-level fact", "yes", [])

with open("Tools/prd_ledger/24/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
