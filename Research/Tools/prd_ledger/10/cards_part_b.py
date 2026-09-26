import json, re
R = 10
rep = open("App Store Reports/10. Finch - Self-Care Pet - Daily Journal & Habit Tracker (REPORT).md").read().split("\n")
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

# ---- PART 2 ----
c(17, "§2.1 What the product is, reconstructed from what users describe", "positioning",
  "The product loop: hatch a bird, name it, choose its pronouns and colours, dress it; completing real-world goals generates energy that sends the bird on a multi-hour adventure, it returns with a discovery and item and asks a two-option question that shapes its personality; goals also earn rainbow stones spent in rotating shops on clothing and furniture",
  "virtual-pet self-care app; adventures, energy, rainbow stones, rotating shops", "praise", "report gives none on this paragraph", "research", "descriptive", "app-specific", [])
c(18, "§2.1 Feature vocabulary table (verbatim)", "feature",
  "Feature vocabulary by how many reviews mention it: adventures, Finch Plus, breathing, outfits, journaling, reflections, streaks, quests, Journeys (removed), mood tracking (auto check-in removed), micropets, gems/stones, furniture, quizzes, shop, widget (chronically broken), Guardian, first aid kit, travel, soundscapes, good vibes, Tree Town, insights, merch, Self-Care Areas, pause mode",
  "full feature set as described by reviewers", "mixed", table("## 2.1 What the product is"), "research", "verbatim", "app-specific", [])
c(19, "§2.1 Breathing exercises named more than any other therapeutic tool", "feature",
  "Breathing exercises are the therapeutic tool reviewers name most, ahead of journaling and reflections",
  "breathing exercises free, some (anxiety) gated", "praise", "breathing 1,606 (2.29%); journaling 1,302 (1.86%); reflections 1,194 (1.70%); quizzes 558 (0.80%); first aid kit 444 (0.63%); soundscapes 385 (0.55%)", "build-free", "meaningful", "yes", [])
c(20, "§2.1 Pause mode / snooze row; §4.6", "feature",
  "A pause mode / snooze exists and is mentioned by a small number of reviewers",
  "pause mode exists", "mixed", "54 mentions (0.08%)", "undecided", "ignore-band", "yes", [])
c(21, "§2.2 Free / paid / trial classification table (verbatim)", "monetization",
  "Corpus-derived free/paid map: goals, check-off, energy, adventures free; basic outfits/furniture free with limited rotation (6–8 slots vs 12–16 for Plus); some breathing exercises gated; soundscapes and longer timers paid (previously free); full shop / colour options / outfit saves paid; monthly event micropet paid or partially paid from ~2025 (previously free); goal icon customisation paid; Journeys organisation was paid (2022); cloud backup free but opt-in and manual; Guardian paid add-on; Family Sharing not supported",
  "generous free core with cosmetics and content paid", "mixed", table("## 2.2 Free / paid"), "research", "corpus-derived", "app-specific",
  ["14338788841","13057118678","13594995098","12383429614","14375332074","14378349434","14455889030","10529428569","12187968321","12241626633","9130759190"])
c(22, "§2.2 Free users report 6–8 shop slots vs 12–16 for Plus", "monetization",
  "Shop slot count is the free/paid boundary for cosmetics: free users see 6–8 daily shop slots vs 12–16 for Plus — gating on quantity of rotation, not on a capability",
  "shop rotation size gated", "mixed", "report gives none beyond the slot counts", "undecided", "corpus-derived", "yes", [])
c(23, "§2.2 Soundscapes and longer timers reported as previously free; monthly event micropet reported as previously free", "product-rule",
  "Several capabilities reviewers report as previously free are now paid — soundscapes (animal sounds), longer timers, the monthly event micropet — i.e. paywall creep on things people had already been using",
  "moved free features behind Finch Plus", "complaint", "reported by individual reviewers; M-paywall theme quantified in §4.2", "product-rule", "corpus-derived", "yes",
  ["13057118678","13594995098","14455889030","10529428569"])
c(24, "§2.2 Anxiety breathing exercise gated", "feature",
  "The anxiety breathing exercise is reported gated behind Plus in a mental-health app — a therapeutic tool behind a paywall",
  "anxiety breathing exercise paid", "complaint", "several reviewers", "build-free", "corpus-derived", "yes", ["14338788841"])
c(25, "§2.2 Trial: 7-day free trial dominant with 3/2/5-day variants", "monetization",
  "A 7-day free trial is the dominant description, but 3-day, 2-day and 5-day variants also appear — trial length is not consistent across users",
  "7-day trial defaulting to annual; variants 2/3/5 days", "mixed", "trial-mention flag; variants cited by 4 reviews", "research", "corpus-derived", "app-specific",
  ["10132933191","12814784154","12752079228","12675075647"])
c(26, "§2.2 'one-time offer' discount screen during onboarding, before the app has been used (M-fomo-offer)", "dont",
  "A 'one-time offer' discount screen is presented during onboarding, before the app has been used, stating the discount is lost forever if dismissed — small by volume but qualitatively vivid",
  "scarcity-framed onboarding discount", "complaint", "M-fomo-offer 10 reviews, mean 2.90", "dont", "weak, vivid", "yes",
  ["10582541234","11351698438","11950784924","13853322399","13018762164"])
c(27, "§2.3 Prices reviewers report table (verbatim)", "monetization",
  "Prices reviewers report (what users say they were charged, not a price list): $40 dominant, then $70, $50, $60, $39.99…; plus ¥11,000/yr (JP), R1,500 (ZA), RM199 (MY), €45–€80, £30–£120, C$50–C$200, A$30–A$130, ₽3,000–6,000",
  "annual ~$40 (most cited) up to $70–$100", "mixed", table("## 2.3 Prices reviewers report") + " ; hand-read: ¥11,000/yr JP; R1,500 ZA; RM199 MY; €45–€80; £30–£120; C$50–C$200; A$30–A$130; ₽3,000–6,000", "research", "corpus-derived", "app-specific",
  ["13046812794","11204966534","13181758667"])
c(28, "§2.3 The dispersion is itself a finding (M-price-inconsistent); §4.2", "must-never-break",
  "Price dispersion is itself a finding: reviewers report being quoted a different price from a family member or friend on the same day (parent $34.99, son $41.99 — 'That just took all the joy of playing with this today out of my sails'; support 'could not explain the cost differences', range $19.99–$99.99) — WEAK by volume, high-severity trust signal by content because users compare notes inside a household",
  "variable/personalised subscription pricing", "complaint", "M-price-inconsistent 12 reviews, mean 3.75", "must-never-break", "weak volume / high severity", "yes",
  ["13973018233","13859119520","12682049848","12877389441","12506634709"])
c(29, "§2.4 Monetisation model summary", "monetization",
  "Monetisation model: free-to-download; generous free tier; 7-day trial defaulting to an ANNUAL subscription; onboarding-time discounted offer with a scarcity frame; in-game-currency shops with randomised rotation and a paid re-roll; a monthly seasonal pass with paid and free reward tracks; a Guardian tier for gifting; physical merchandise; and from 2026 sponsored IP events",
  "subscription + seasonal pass + gifting + merch + sponsored events", "mixed", "report gives none on this summary", "research", "corpus-derived", "app-specific", [])
c(30, "§2.5 A structural note on the language of this corpus", "market",
  "Finch is, in review terms, an English-language product with a small international tail that is asking loudly to be served: 92.11% of reviews come from four Anglophone storefronts",
  "English-only app", "blocked-conversion", "US 50,932; GB 6,667; CA 4,748; AU 2,166 = 64,513 (92.11%); 21 non-English-primary storefronts 3,840 (5.48%); 90 sub-50 storefronts 956 (1.36%)", "research", "corpus-level fact", "app-specific", [])

# ---- PART 3 ----
c(31, "§3.1 Positive themes, ranked table (verbatim)", "insight",
  "Fourteen positive themes ranked: motivation, cute design, recommend, mental health, ADHD/ND, tools, life-changed, social, companion, team praise, free-generous, gentle, therapist-rec, sobriety",
  "n/a", "praise", table("## 3.1 Positive themes"), "none", "verbatim", "app-specific", [])
c(32, "§3.1 P-motivation is the #1 reported benefit; P-cute-design aesthetics are load-bearing, not decorative; P-recommend", "insight",
  "Motivation / follow-through is the #1 reported benefit, and aesthetics are load-bearing rather than decorative — cute design is the second-largest theme and rates higher than motivation",
  "cute bird pet, cosmetics", "praise", "P-motivation 11,175 (15.96%, HIGH-PRIORITY) mean 4.88; P-cute-design 10,074 (14.38%) mean 4.91; P-recommend 9,765 (13.94%) mean 4.91", "must-have", "high-priority", "yes", [])
c(33, "§3.1 P-mental-health; P-life-changed; core-benefit family", "insight",
  "A concrete mental-health benefit is claimed by one in eight reviewers and 'changed my life' claims rate a near-perfect 4.97; the core-benefit family is nearly 30% of the corpus",
  "self-care tools + pet", "praise", "P-mental-health 8,398 (11.99%) mean 4.89; P-life-changed 2,686 (3.83%, VERY STRONG) mean 4.97; core-benefit family 20,883 (29.82%) mean 4.89", "must-have", "high-priority", "yes", [])
c(34, "§3.1 P-adhd-nd Self-identified ADHD/autistic/ND user", "audience",
  "ADHD / autistic / neurodivergent users are a very large, self-identifying segment — 7.36% of all reviews — and rate slightly below the other positive themes",
  "gentle tone, externalisation via pet", "praise", "P-adhd-nd 5,157 (7.36%, HIGH-PRIORITY) mean 4.76", "do", "high-priority", "yes", [])
c(35, "§3.1 P-tools Breathing, soundscapes, first aid, journaling", "feature",
  "The self-care tool set (breathing, soundscapes, first aid kit, journaling) is praised at high-priority scale",
  "tool set mostly free, some paid", "praise", "P-tools 3,746 (5.35%, HIGH-PRIORITY) mean 4.84", "build-free", "high-priority", "yes", [])
c(36, "§3.1 P-social Tree Town, good vibes, friends", "feature",
  "Social features (Tree Town friend town, 'good vibes' gifting) are a meaningful praise theme",
  "Tree Town, good vibes gifting free", "praise", "P-social 2,035 (2.91%, MEANINGFUL) mean 4.84; Tree Town 325 mentions; good vibes 370", "undecided", "meaningful", "yes", [])
c(37, "§3.1 P-companion; §3.2 (a) The externalisation mechanism works, and users articulate it precisely", "insight",
  "The externalisation mechanism works and users articulate it precisely: 'I will do for the bird what I will not do for myself' — the causal story users tell about why this app worked when others didn't; companionship ('not alone', 'like a friend') is its own theme",
  "pet whose wellbeing depends on the user's goals", "praise", "P-companion 1,309 (1.87%, MEANINGFUL) mean 4.84; most-endorsed review in corpus 358 net votes", "build-free", "meaningful", "yes",
  ["9438141619","12370795858","11489285888","8499763457","8797139022","10841359117","13005792453","12674347241","8389731820","9272023003"])
c(38, "§3.1 P-team-praise", "insight",
  "Praise for the developers specifically is a meaningful theme",
  "developer visibly cares", "praise", "P-team-praise 974 (1.39%, MEANINGFUL) mean 4.90", "do", "meaningful", "yes", [])
c(39, "§3.1 P-free-generous; §3.2 (c) The free tier's reputation is an asset with a measurable size", "insight",
  "The free tier's reputation is an asset with a measurable size: reviewers volunteer that the free version is generous, ad-free and does not nag ('Finally, an app that is actually free… no annoying pop ups'; 'prioritises your mindfulness exercises without pushing its subscription service at all') — this is the asset the 2026 sponsored-IP events spend down",
  "generous, non-nagging free tier", "praise", "P-free-generous 857 (1.22%, MEANINGFUL) mean 4.92", "product-rule", "meaningful", "yes",
  ["8797139022","8619792409","8343850932","8345380038","14135326556","10246078752","13212308967","11984368192","12099230305","13918020477"])
c(40, "§3.1 P-gentle; §3.2 (b) Non-punitiveness is a named differentiator — and it is the exact thing later changes eroded", "product-rule",
  "Non-punitiveness is a named differentiator ('unlike other apps, he doesn't get sick or sad if I miss things… without any guilt from my virtual friend') — and the streak mechanic and the Journeys→Self-Care-Areas change are, in reviewers' own words, the direct negation of it",
  "pet never gets sick or sad; no guilt — until streaks were added", "praise", "P-gentle 476 (0.68%, EMERGING) mean 4.87", "product-rule", "emerging, high mean", "yes",
  ["10243200718","11745067634","13005792453","8389731820","12939486987","14187447203","11824105803","13609263572","12060228726","9668443213"],
  cond="read against §4.5 and §8.5")
c(41, "§3.1 P-therapist-rec; §3.2 (d) Clinical channel", "tactic",
  "A clinician channel exists: 'my therapist recommended this', plus therapists and psychologists writing as professionals who recommend it to clients — a high-trust acquisition channel that is visibly reversible: two clinicians publicly withdrew the recommendation over data loss",
  "therapist-recommended, no formal program", "praise", "P-therapist-rec 381 (0.54%, EMERGING) mean 4.91; 2 clinicians withdrawing", "do", "emerging", "yes",
  ["13192704866","12678214054","10195590904","12025813421","13983749907","8322398440","12658276545","13652698300","13875198474","11714664731","13569423105","13434160590"],
  side="data loss destroys the clinician channel")
c(42, "§3.1 P-sobriety", "audience",
  "A sobriety / recovery use case exists at weak volume and rates lower than other positive themes",
  "no sobriety-specific feature", "praise", "P-sobriety 134 (0.19%, WEAK) mean 4.62", "research", "weak", "yes", [])

# ---- PART 4.1 ----
c(43, "§4.1 Complaint families, ranked table (verbatim)", "data-caveat",
  "Nine complaint families ranked by volume: monetization-any, gamification-harm, reliability, accessibility, content-values, platform-gaps, data-integrity, billing-dispute, product-change",
  "n/a", "complaint", table("## 4.1 Complaint families"), "none", "verbatim", "app-specific", [])
c(44, "§4.1 The ordering by volume and the ordering by damage are almost inverted; The billing-dispute family is the smallest complaint family and by far the most destructive", "insight",
  "Ordering by volume and ordering by damage are almost inverted: the billing-dispute family is the smallest complaint family and by far the most destructive",
  "trial conversion without reminder", "1★-burst", "FAM-billing-dispute 404 (0.58%) mean 1.97, 244 (60.4%) one-star, 17.45% of every reviewer who mentions having paid; FAM-monetization-any 2,045 (2.92%) mean 3.73; FAM-gamification-harm 1,948 (2.78%) mean 4.38; FAM-reliability 1,648 (2.35%) mean 3.32; FAM-data-integrity 658 (0.94%) mean 3.14, 27.5% 1★", "must-never-break", "emerging / highest severity", "yes", [])

with open("Tools/prd_ledger/10/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
