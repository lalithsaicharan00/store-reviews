"""Cards for report 24 — Part 2 (product & monetisation) and Part 3 (global findings)."""
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

# ---- §2.1 inventory
c(21, "§2.1 Feature inventory table (verbatim)", "data-caveat", "Feature inventory from reviewers' own words", "n/a", "mixed", table("## 2.1 Feature inventory derived from reviews"), "none", "inventory", "app-specific", [])
c(22, "§2.1 Onboarding — long questionnaire via social ads, 'letter from your future self', held-finger 'contract' signing with the fingerprint sensor", "feature",
  "Onboarding is a long questionnaire (often reached via an Instagram / Facebook / X advert), a 'letter from your future self' and a held-finger 'contract' signing using the fingerprint sensor", "long ritual onboarding after paid social ads", "mixed", "inventory row; onboarding too long 45 (0.10%, mean 1.600)", "dont", "inventory", "yes",
  ["7608105779","13641827689","11036419330","11785559577"])
c(23, "§2.1 Rituals / routines — morning, afternoon, evening checklists with timers and per-habit guided content", "feature",
  "Morning / afternoon / evening routine checklists with timers and per-habit guided content are the core product", "routine checklists with timers, guided", "praise", "routine built 3,611 (8.31%, mean 4.467)", "build-free", "inventory", "yes", ["11122189610","12016141805","11743843988"])
c(24, "§2.1 The first habit — 'drink a glass of water on waking', gated 3 days before the next unlocks; then breakfast, then exercise", "feature",
  "The first habit is universally 'drink a glass of water on waking', gated three days before the next unlocks, then 'eat a healthy breakfast', then exercise", "forced, time-gated starter sequence", "mixed", "124 (0.29%) object", "product-rule", "inventory", "yes", ["11007332063","12377235635","14003383594"])
c(25, "§2.1 Journeys / mountains — multi-week guided programmes as a mountain map with an animated traveller", "feature",
  "Multi-week guided programmes ('Journeys') rendered as a mountain map with an animated traveller", "guided programmes, premium", "praise", "inventory row", "build-paid", "inventory", "yes", ["11842141822","13355228633","13650208449"])
c(26, "§2.1 Daily / focus / nightly coaching — three short narrated audio-plus-text pieces per day with quotes from named authors and researchers; letters", "feature",
  "Three short narrated audio-plus-text coaching pieces per day quoting named authors and researchers, plus written 'letters' including 'from your future self'", "daily coaching content, premium", "praise", "coaching praised 6,095 (14.02%, mean 4.483); science framing 736 (1.69%, mean 3.865)", "build-paid", "inventory", "yes",
  ["11622883414","11839073307","12832796136","11066361054","5594181955"])
c(27, "§2.1 Challenges — time-boxed group challenges ('no sugar for a week'); Circles — in-app community feed", "feature",
  "Time-boxed group challenges and an in-app community feed ('Circles') with comments and writing prompts", "challenges and community feed", "mixed", "Circles 370 (0.85%, mean 3.897)", "research", "inventory", "yes",
  ["6543667873","11305397471","11294707285","11691602301"])
c(28, "§2.1 Make Me Fabulous / Launch — activity launcher repeatedly reported removed or unfindable after a redesign; Deep work — reason long-tenure users renew", "feature",
  "The 'Make Me Fabulous' activity launcher (guided meditation, stretching, deep-work ritual) is repeatedly reported removed or unfindable after a redesign; the deep-work ramp-up ritual is named by long-tenure users as the single reason they renew",
  "removed / hid a feature that long-tenure users renewed for", "churn", "3 + 1 reviews cited", "product-rule", "inventory", "yes", ["11842141822","12337019505","14506251739"])
c(29, "§2.1 Ambient sound / music; mood tracking; streaks / freezes / certificates", "feature",
  "Background soundscapes and per-task music (praised, mean 4.387), a daily mood check-in, and streak counters with 'freeze' passes and certificates", "audio, mood, streaks with freezes", "mixed", "music 282 (0.65%, mean 4.387)", "undecided", "inventory", "yes",
  ["5282944837","14346117158","13514681303","13044004537","12611007165","14245283579","13650208449"])
c(30, "§2.1 Apple Watch present but thin (69, 0.16%); Widget present but thin (53, 0.12%)", "feature",
  "Apple Watch and widget exist but are barely mentioned — 69 (0.16%) and 53 (0.12%) — in a 43,469-review corpus", "Watch and widget present, marginal", "mixed", "Watch 69 (0.16%, mean 3.116); widget 53 (0.12%, mean 3.868)", "undecided", "weak", "app-specific",
  ["2006599866","6405204376","8265107322","2095635360","9515548817","10519844634"])
c(31, "§2.1 AI assistant — chat/coach bubble from ~2025, an unwanted addition for long-tenure users; AI-generated art/copy theme mean 1.156", "feature",
  "An AI chat/coach bubble appearing from roughly 2025 is described as an unwanted addition by long-tenure users; AI-generated art/copy is the worst-rated non-billing theme (mean 1.156, 90.6% 1★), small and recent",
  "added an AI assistant; AI-generated art/copy", "complaint", "AI art/copy 64 (0.15%, weak, mean 1.156, 90.6% 1★)", "dont", "weak", "yes", ["12846915013","14262152932","13581200143"])
c(32, "§2.1 Sister apps — Clarify, Shape, Elixir, Lumière, Lune, Ambiance, Sphere, Mind, Enchant — each its own download and its own subscription; Clarify named almost only inside billing complaints", "anti-pattern",
  "Nine sister apps each need their own download and their own subscription; named in corpus: Sphere 88 (mean 2.989), Clarify 80 (mean 1.637), Shape 54 (3.593), Ambiance 14 (4.071), Elixir 9, Lumière 8, Lune 4 (1.000), Enchant 1 — Clarify, the ADHD-targeted sister app, is named almost exclusively inside billing complaints",
  "app family with separate subscriptions", "complaint", "Sphere 88 · Clarify 80 (1.637) · Shape 54 · Ambiance 14 · Elixir 9 · Lumière 8 · Lune 4 (1.000) · Enchant 1", "dont", "emerging", "yes",
  ["11592429998","11879138719","14404089964"])

# ---- §2.2 monetisation
c(33, "§2.2 a — a real free tier exists and is hard to find (behind a small X/skip on the trial splash); ~3–4 habits, coaching locked", "monetization",
  "A real free tier exists but is hard to find — behind a small 'X' or 'skip' on the trial splash; limits reported as roughly 3–4 habits with coaching locked", "hidden free tier, ~3–4 habits, coaching paid", "mixed", "free-tier-generous 77 (0.18%, mean 4.442)", "must-have", "weak", "yes",
  ["12877743366","13649333600","11726445406","11086090742","12130093563","12206048353"])
c(34, "§2.2 b — the trial is usually not free: a 'pay what you can' non-refundable set-up fee ($1 / $10 / $16.41) on a donation-style screen", "monetization",
  "The 'free trial' charges: a 'pay what you can' set-up fee presented on a donation-style screen with options around $1 / $10 / $16.41, described in the terms as non-refundable",
  "paid, non-refundable trial set-up fee", "1★-burst", "506 (1.16%) say the trial charged; 100 name the set-up fee, mean 1.110", "dont", "meaningful", "yes",
  ["8078038999","11270936086","11998625607","12241507559","12644539764","13252486000","13417041561","13614621943","13761067153","14057143520"])
c(35, "§2.2 c — billing runs outside Apple: not in Apple Subscriptions, cancelling via Apple does nothing, cancel on the developer's website; merchants 'Fabulous SAS', 'Fabulous App Paris', 'thefab.co', processor Chargebee", "monetization",
  "Billing runs outside Apple: reviewers state the charge does not appear in Apple Subscriptions, cancelling through Apple does not stop it, and they had to cancel on the developer's website; statement merchant names 'Fabulous SAS', 'Fabulous App Paris', 'thefab.co', processor Chargebee",
  "web checkout via Chargebee", "1★-burst", "204 (0.47%) explicit, mean 1.118", "product-rule", "emerging (explicit) / high-priority (composite)", "yes",
  ["5562765503","8681528284","9383000414","11023024817","11781065148","12060309335","12390941468","12864469399","13295929517","13631053622","13849680698","14119700381"])
c(36, "§2.2 Why this is the root cause — three mechanical consequences: invisible where iOS users look; App Store cancel does nothing; Apple cannot refund, user routed to a 250-character web form with no phone", "insight",
  "Three consequences follow mechanically from web billing and all appear in the corpus: (i) the subscription is invisible where iOS users are trained to look, so people believe they have none; (ii) cancelling in the App Store does nothing, so people who did cancel are charged anyway; (iii) Apple cannot refund a charge it never processed, so the user is routed to a web form with a 250-character limit and no telephone number — why the theme's mean (1.110) is lower than any product theme",
  "off-Apple billing", "1★-burst", "bill_core mean 1.110", "product-rule", "interpretation", "yes",
  ["12932307919","14396308469","13029061238","14372809998","13130540330","14079270691","12684356794","13473184526"])
c(37, "§2.2 d — prices named by reviewers: $40 (491) · $39.99 (409) · $50 (289) · $1 (221) · $60 (137) · $100 (121) · $49.99 (109) · $35 (95) · $29.99 (91) · $30 (82) · $80 (81) · $70 (80) · $34.99 (62) · $67 (35) · $19.99 (31); $39.99 + $29.99 or + $49.99 same day is the bundle signature", "monetization",
  "Prices named (testimony, mixed currencies): $40 (491) · $39.99 (409) · $50 (289) · $1 (221) · $60 (137) · $100 (121) · $49.99 (109) · $35 (95) · $29.99 (91) · $30 (82) · $80 (81) · $70 (80) · $34.99 (62) · $67 (35) · $19.99 (31); the recurring pairs $39.99 + $29.99 or $39.99 + $49.99 on the same day are the bundle signature in hundreds of 2024–26 reviews",
  "~$40/yr headline; bundle adds $29.99–49.99", "complaint", "$40 ×491; $39.99 ×409; pairs in hundreds of reviews", "research", "corpus-level fact", "app-specific", [])
c(38, "§2.2 e — billing periods are inconsistent (annual, quarterly, bimonthly, monthly, weekly at overlapping prices); the inconsistency of what users believe they bought is itself a product failure", "must-never-break",
  "Reviewers report annual, quarterly ('every 3 months'), bimonthly, monthly and weekly cycles at overlapping prices ('this page says $59 for a year… it's $40 billed every three months'; '$39.99 for a biweekly subscription plan') — the inconsistency of what users believe they bought is itself a measurable failure and the direct cause of 'charged twice' reports, several of which are two real subscriptions",
  "multiple overlapping plan periods", "1★-burst", "4 representative reviews; duplicate charges 584 (1.34%, mean 1.134)", "must-never-break", "meaningful", "yes",
  ["12308000770","13067587566","13351480495","14383766600"])
c(39, "§2.2 f — the bundle: enrolled in a multi-app bundle during onboarding via near-identical full-screen offers whose decline is a small skip/X in a corner", "dont",
  "Users are enrolled in a multi-app bundle during onboarding without an explicit priced confirmation — a sequence of near-identical full-screen offers where the decline control is a small 'skip'/'X' in a corner", "bundle upsell in onboarding with hidden decline", "1★-burst", "324 (0.75%, emerging), mean 1.398, 83.6% 1★", "dont", "emerging", "yes",
  ["12238712030","12420478007","12901184992","13272341928","13584041512","13744387263","14087096771","14420525318"])

# ---- §3.1 theme table
c(40, "§3.1 Complete ranked theme table (verbatim), 57 themes", "data-caveat", "Master theme table, denominator 43,469", "n/a", "mixed", table("## 3.1 Complete ranked theme table"), "none", "corpus-level fact", "app-specific", [])
T = [
 (41,"#1 Coaching / motivation / gentle tone","insight","Coaching / motivation / gentle tone praised — the largest theme","6,095 (14.02%, high-priority), mean 4.483, 1★ 5.7%, 5★ 75.1%","build-paid","praise"),
 (42,"#2 Life-changing / best app","insight","'Life-changing / best app'","4,468 (10.28%, high-priority), mean 4.799, 1★ 1.8%, 5★ 88.7%","none","praise"),
 (43,"#3 Routine or habit actually built","insight","A routine or habit was actually built","3,611 (8.31%, high-priority), mean 4.467, 1★ 5.4%, 5★ 73.7%","build-free","praise"),
 (44,"#4 Scam / fraud / theft vocabulary","must-never-break","Scam / fraud / theft vocabulary","3,468 (7.98%, high-priority), mean 1.073, 1★ 96.6%","product-rule","1★-burst"),
 (45,"#5 Art / design / graphics","feature","Art / design / graphics praised","2,969 (6.83%, high-priority), mean 4.089, 1★ 11.4%, 5★ 61.3%","do","praise"),
 (46,"#6 Small-steps pacing / won't let you over-commit","insight","Small-steps pacing — the app won't let you over-commit","1,817 (4.18%, very strong), mean 4.692, 1★ 2.0%, 5★ 81.1%","product-rule","praise"),
 (47,"#7 Refund requested or mentioned","monetization","Refund requested or mentioned","1,737 (4.00%, very strong), mean 1.163, 1★ 92.4%","must-have","complaint"),
 (48,"#8 Charged after cancelling","must-never-break","Charged after cancelling","1,620 (3.73%, very strong), mean 1.085, 1★ 95.9%","must-never-break","1★-burst"),
 (49,"#9 Confusing / unintuitive navigation","anti-pattern","Confusing / unintuitive navigation","1,507 (3.47%, very strong), mean 2.338, 1★ 46.2%","must-have","complaint"),
 (50,"#10 Cluttered / overwhelming / overstimulating","anti-pattern","Cluttered / overwhelming / overstimulating UI","1,324 (3.05%, very strong), mean 3.068, 1★ 28.9%, 5★ 32.0%","must-have","complaint"),
 (51,"#11 Depression / anxiety / PTSD / grief","audience","Depression / anxiety / PTSD / grief context","1,256 (2.89%, meaningful), mean 3.938, 1★ 19.5%, 5★ 64.6%","do","praise"),
 (52,"#12 Cannot find / complete cancellation","must-have","Cannot find / complete cancellation","1,146 (2.64%, meaningful), mean 1.115, 1★ 92.3%","must-have","1★-burst"),
 (53,"#13 Refund refused","must-never-break","Refund refused","968 (2.23%, meaningful), mean 1.070, 1★ 96.3%","must-have","1★-burst"),
 (54,"#14 Support unresponsive / automated only","must-have","Support unresponsive / automated only","947 (2.18%, meaningful), mean 1.528, 1★ 80.0%","must-have","complaint"),
 (55,"#15 Crash / freeze / bug / won't load","must-never-break","Crash / freeze / bug / won't load","944 (2.17%, meaningful), mean 2.367, 1★ 44.7%","must-never-break","complaint"),
 (56,"#16 ADHD / autism / executive dysfunction","audience","ADHD / autism / executive dysfunction","933 (2.15%, meaningful), mean 2.747, 1★ 47.7%, 5★ 35.5%","do","mixed"),
 (57,"#17 Price objection","monetization","Price objection","791 (1.82%, meaningful), mean 2.248, 1★ 53.0%","research","complaint"),
 (58,"#18 Notification volume / control","feature","Notification volume / control","744 (1.71%, meaningful), mean 2.437, 1★ 43.7%","must-have","complaint"),
 (59,"#19 Science / research / university framing","positioning","Science / research / university framing praised","736 (1.69%, meaningful), mean 3.865, 1★ 18.6%, 5★ 60.6%","do","praise"),
 (60,"#20 Duplicate / repeated charges","must-never-break","Duplicate / repeated charges","584 (1.34%, meaningful), mean 1.134, 1★ 93.7%","must-never-break","1★-burst"),
 (61,"#21 'Free' trial was not free","must-never-break","'Free' trial was not free","506 (1.16%, meaningful), mean 1.136, 1★ 92.9%","must-never-break","1★-burst"),
 (62,"#22 Community / Circles","feature","Community / Circles","370 (0.85%, emerging), mean 3.897, 1★ 14.3%, 5★ 54.9%","research","mixed"),
 (63,"#23 Charge without consent / warning","must-never-break","Charge without consent / warning — the lowest mean in the corpus","338 (0.78%, emerging), mean 1.047, 1★ 97.3%","must-never-break","1★-burst"),
 (64,"#24 Bundle / sister-app subscription","monetization","Bundle / sister-app subscription","324 (0.75%, emerging), mean 1.398, 1★ 83.6%","dont","1★-burst"),
 (65,"#25 In-app advertising of sister apps","dont","In-app advertising of sister apps","308 (0.71%, emerging), mean 1.932, 1★ 57.8%","dont","complaint"),
 (66,"#26 Childish / condescending tone","anti-pattern","Childish / condescending tone","304 (0.70%, emerging), mean 2.701, 1★ 40.5%","must-have","complaint"),
 (67,"#27 Music / audio / narration","feature","Music / audio / narration praised","282 (0.65%, emerging), mean 4.387, 5★ 69.5%","build-paid","praise"),
 (68,"#28 No iPad / lost progress on device change","must-never-break","No iPad / lost progress on device change","257 (0.59%, emerging), mean 2.693, 1★ 33.5%","must-never-break","complaint"),
]
for seq, w, kind, claim, mag, d, react in T:
    c(seq, f"§3.1 theme table {w}", kind, claim, "see §3.1", react, mag, d, "theme-table signal", "yes", [])
c(69, "§3.1 theme table #29–#57 weak/ignore rows", "data-caveat",
  "Weak/ignore rows: escalated to bank/BBB/FTC/legal 212 (0.49%, mean 1.236); auto-renewal with no notice 197 (0.45%, 1.168); occult/new-age/cult objection 195 (0.45%, 2.410); pop-ups/unskippable steps 182 (0.42%, 2.082); cannot customise/too rigid 175 (0.40%, 2.097); too slow/shallow content 168 (0.39%, 2.393); privacy/personal data 138 (0.32%, 1.225); referral/share prompts 131 (0.30%, 3.053); accessibility 129 (0.30%, 3.101); not visible in Apple Subscriptions 125 (0.29%, 1.136); forced first habit 124 (0.29%, 2.452); localisation request 121 (0.28%, 3.380); repetitive coaching 103 (0.24%, 2.660); competitor named 102 (0.23%, 3.020); cannot log in/paid but no access 96 (0.22%, 1.375); free tier generous 77 (0.18%, 4.442); cannot undo/backfill 70 (0.16%, 2.700); Apple Watch 69 (0.16%, 3.116); AI-generated art/copy 64 (0.15%, 1.156); diet-culture/ED trigger 61 (0.14%, 2.918); audio overrides silent switch 56 (0.13%, 2.036); widget 53 (0.12%, 3.868); Apple/Editor's Choice invoked 47 (0.11%, 1.085); onboarding too long 45 (0.10%, 1.600); no dark mode 43 (0.10%, 3.535); no per-weekday schedule 31 (0.07%, 3.484); clinical/professional role 24 (0.06%, 4.042); 'God' blocked in Circles 14 (0.03%, 1.714); recommended by therapist/doctor 9 (0.02%, 4.111)",
  "see §3.1", "mixed", "29 weak/ignore rows as listed", "none", "weak/ignore", "yes", [])
c(70, "§3.1 #29 Escalated to bank / BBB / FTC / legal", "timeline", "212 reviewers say they escalated to their bank, the BBB, the FTC or legal action", "off-Apple billing disputes escalate outside the store", "1★-burst", "212 (0.49%, weak), mean 1.236, 92.5% 1★", "product-rule", "weak", "yes", [])
c(71, "§3.1 #30 Auto-renewal with no notice", "must-never-break", "Auto-renewal with no notice", "no renewal reminder", "1★-burst", "197 (0.45%, weak), mean 1.168, 88.8% 1★, 0.0% 5★", "must-never-break", "weak", "yes", [])
c(72, "§3.1 #31 Occult / new-age / cult objection; #56 word 'God' blocked in Circles", "audience",
  "A segment objects to occult / new-age / 'cult-like' content (195, mean 2.410); separately, the word 'God' was blocked in the Circles community (14, mean 1.714)", "spiritual framing; profanity filter blocks 'God'", "complaint", "195 (0.45%, mean 2.410, 47.7% 1★); 14 (0.03%, mean 1.714)", "research", "weak", "yes", [])
c(73, "§3.1 #32 Pop-ups / unskippable steps; #33 cannot customise / too rigid; #34 too slow / shallow content", "anti-pattern",
  "Pop-ups / unskippable steps (182, mean 2.082), cannot customise / too rigid (175, mean 2.097) and too slow / shallow content (168, mean 2.393) are the worst substantial non-billing UX themes after sister-app ads", "rigid, interruptive programme", "complaint", "182 (0.42%); 175 (0.40%); 168 (0.39%)", "must-have", "weak", "yes", [])
c(74, "§3.1 #35 Privacy / personal data — mean 1.225", "must-have", "Privacy / personal data complaints run at mean 1.225 (87.7% 1★)", "long questionnaire, web billing collects card data", "complaint", "138 (0.32%, weak), mean 1.225", "must-have", "weak", "yes", [])
c(75, "§3.1 #36 Referral / share-with-friend prompts", "dont", "Referral / share-with-friend prompts drew 131 mentions (mean 3.053)", "referral prompts", "mixed", "131 (0.30%, weak), mean 3.053", "dont", "weak", "yes", [])
c(76, "§3.1 #37 Accessibility (vision, font, VoiceOver)", "feature", "Accessibility (vision, font size, VoiceOver) requests", "accessibility gaps", "complaint", "129 (0.30%, weak), mean 3.101", "must-have", "weak", "yes", [])
c(77, "§3.1 #40 Language / localisation request", "market", "More languages requested", "limited localisation", "complaint", "121 (0.28%, weak), mean 3.380", "do", "weak", "yes", [])
c(78, "§3.1 #41 Repetitive coaching content", "feature", "Repetitive coaching content", "content repeats", "complaint", "103 (0.24%, weak), mean 2.660", "build-paid", "weak", "yes", [])
c(79, "§3.1 #43 Cannot log in / paid but no access", "must-never-break", "Cannot log in / paid but no premium access", "entitlement not delivered", "1★-burst", "96 (0.22%, weak), mean 1.375, 78.1% 1★", "must-never-break", "weak", "yes", [])
c(80, "§3.1 #45 Cannot undo or backfill a day", "feature", "Cannot undo a tick or backfill a missed day", "no backfill/undo", "complaint", "70 (0.16%, weak), mean 2.700", "build-free", "weak", "yes", [])
c(81, "§3.1 #48 Diet-culture / eating-disorder trigger", "audience", "Some users find the content a diet-culture / eating-disorder trigger", "diet-adjacent content", "complaint", "61 (0.14%, weak), mean 2.918", "research", "weak", "yes", [])
c(82, "§3.1 #49 Audio overrides silent switch", "must-never-break", "Audio plays through the silent switch or after close", "audio ignores silent switch", "complaint", "56 (0.13%, weak), mean 2.036, 58.9% 1★", "must-never-break", "weak", "yes", [])
c(83, "§3.1 #51 Apple / Editor's Choice invoked — mean 1.085, 95.7% 1★", "insight", "Reviews invoking Apple or Editor's Choice have mean 1.085 (95.7% 1★) — 'Apple should not feature this'", "featured by Apple", "churn", "47 (0.11%, weak), mean 1.085", "do", "weak", "yes", [])
c(84, "§3.1 #52 Onboarding too long — mean 1.600", "dont", "Onboarding too long", "long questionnaire onboarding", "complaint", "45 (0.10%, weak), mean 1.600, 73.3% 1★", "dont", "weak", "yes", [])
c(85, "§3.1 #53 No dark mode; #54 no per-weekday / shift-work schedule", "feature", "Dark mode (43) and per-weekday / shift-work scheduling (31) requested, predominantly by satisfied users", "absent", "complaint", "43 (0.10%, mean 3.535); 31 (0.07%, mean 3.484)", "must-have", "ignore", "yes", [])
c(86, "§3.1 #55 Reviewer states clinical/professional role; #57 recommended by a therapist or doctor", "audience", "Clinicians review it (24, mean 4.042) and a few arrive on a therapist's or doctor's recommendation (9, mean 4.111)", "clinical recommendation channel", "praise", "24 (0.06%); 9 (0.02%)", "do", "ignore", "yes", [])
c(87, "§3.1 Composite measures table (verbatim) — bill_core, bill_any, transaction-aware vs not", "data-caveat",
  "Composites: bill_core 5,791 (13.32%, mean 1.110, 94.2% 1★); bill_any 6,612 (15.21%, mean 1.201); transaction-aware 11,200 (25.77%, mean 2.006, 65.9% 1★); not transaction-aware 32,269 (74.23%, mean 4.356, 9.4% 1★)",
  "n/a", "mixed", table("**Composite measures**"), "none", "corpus-level fact", "app-specific", [])
c(88, "§3.1 The single most important number — reviews that mention money average 2.006, those that do not 4.356; a 2.35-star gap", "insight",
  "The single most important number in the report: reviews that mention money at all average 2.006 and reviews that do not average 4.356 — a 2.35-star gap; the money is the problem and the product is not",
  "off-Apple subscription billing under a well-liked product", "mixed", "2.006 vs 4.356; gap 2.35 stars", "product-rule", "high-priority", "yes", [])

# ---- §3.2
c(89, "§3.2 Worst rating profile table (verbatim) — the top twelve are all billing", "data-caveat",
  "Of themes with n ≥ 100 ranked by mean, the top twelve are all billing: charge without consent 1.047, refund refused 1.070, scam language 1.073, charged after cancelling 1.085, cannot cancel 1.115, duplicate charges 1.134, not in Apple Subscriptions 1.136, trial not free 1.136, refund requested 1.163, auto-renew no notice 1.168, privacy 1.225, escalated to bank/BBB/FTC 1.236, bundle 1.398, support unresponsive 1.528",
  "n/a", "1★-burst", table("## 3.2 The findings with the worst rating profile"), "product-rule", "corpus-level fact", "yes", [])
c(90, "§3.2 The worst non-billing themes — AI-generated content (64, 1.156, co-occurs with billing); sister-app ads 1.932; pop-ups 2.082; no customisation 2.097; confusing navigation 2.338", "anti-pattern",
  "The worst non-billing theme is AI-generated content (n=64, mean 1.156) but it is small, recent and co-occurs with billing; the worst substantial non-billing themes are sister-app ads (308, 1.932), pop-ups (182, 2.082), no customisation (175, 2.097) and confusing navigation (1,507, 2.338)",
  "n/a", "complaint", "as listed", "must-have", "corpus-level fact", "yes", [])

# ---- §3.3
c(91, "§3.3 What the product does well table (verbatim)", "data-caveat",
  "Positive themes by mean: life-changing 4.799; small-steps pacing 4.692; coaching 4.483; routine built 4.467; music/audio 4.387; art/design 4.089; depression/anxiety context 3.938; Circles 3.897; science framing 3.865", "n/a", "praise", table("## 3.3 What the product genuinely does well"), "none", "corpus-level fact", "app-specific", [])
c(92, "§3.3 The pacing finding is the product's real moat — a refusal to let users add more habits ('it warns you when trying to add too much')", "insight",
  "The product's real moat is a refusal: the app declines to let users add more habits ('it warns you when trying to add too much'; 'I stacked everything I wanted to change and failed miserably; this time I followed the program') — the highest-rated theme of meaningful size across nine years and many languages",
  "hard-limited habit stacking with a gated programme", "praise", "1,817 (4.18%), mean 4.692, 2.0% 1★", "product-rule", "very strong", "yes",
  ["1948880555","5325209035","6021355606","6785291083","7190336108","7658661973","8179896888","8501483563","9471116676","11494466523"])
c(93, "§3.3 This is also the source of the biggest product complaint — the constraint is the value proposition and the top product objection; any relaxation must be an opt-out, not a default change", "product-rule",
  "The same constraint that produces small-steps praise (4.18%, mean 4.692) produces the forced-water/breakfast complaint (0.29%, mean 2.452) and feeds 'cannot customise' (0.40%, 2.097) and 'too slow / shallow' (0.39%, 2.393); any relaxation has to be an opt-out for the minority who already have the habit, not a default change — the corpus is explicit that the default is why the product works",
  "constraint as product", "mixed", "4.18% praise vs 0.29% + 0.40% + 0.39% objection", "product-rule", "interpretation", "yes", [])

# ---- §3.4
c(94, "§3.4 Broken table (verbatim) — crash/won't load past the first screen 944; cannot log in / paid but no access 96; progress lost on device change 257; audio through silent switch 56", "must-never-break",
  "Broken things: crash / freeze / won't load past the first screen (944, 2.17%, mean 2.367); cannot log in / paid but no premium access (96, mean 1.375); progress lost on device change / no restore (257, 0.59%, mean 2.693); audio plays through the silent switch or after close (56, mean 2.036)",
  "n/a", "complaint", table("**Broken** (it exists and fails):"), "must-never-break", "meaningful", "yes",
  ["2010369280","6305332926","7752054215","10054955195","12202917593","13339042150","4120717487","7166047365","9167146840","11074882111","12528709109","13576987510","1990102873","4726706775","6722624148","8221914407","10650989543","12047728556","2412897605","3497727528","5849678518","7561940570","9943848741"])
c(95, "§3.4 Unbuilt table (verbatim) — calmer home screen, fewer notifications, skip first habit, per-weekday scheduling, dark mode, backfill, iPad, more languages, with 4–5★ share", "data-caveat",
  "Unbuilt: calmer home screen 1,324 (3.05%, 46.1% 4–5★); fewer/controllable notifications 744 (1.71%, 28.5%); choose or skip the first habit 124 (0.29%); per-weekday / shift-work scheduling 31 (0.07%, 51.6%); dark mode 43 (0.10%, 58.1%); backfill a missed day / undo a tick 70 (0.16%, 35.7%); iPad app / cross-device continuity 257 (0.59%, 34.2%); more languages 121 (0.28%)",
  "n/a", "complaint", table("**Unbuilt** (it does not exist and is asked for):"), "none", "corpus-level fact", "yes",
  ["7280199018","9617541402","11583598458","12674646598","13654261115","4831434999","7192135813","8812657942","10075146878","13509348951","2059294945","5251295013","7231330364","9936616848","12846167630","3862126193","5984966483","7852053634","9671088387","11251746171","2419357081","6929437572","7390272530","7848606261","9789125721","2060469141","4366061898","6272200071","8412476835","12421385072","3669324936","5629701161","7613143521","9190530552","12047728556","2403941042","4462510307","6403357982","8147026632","12505684120"])
c(96, "§3.4 A calmer, less busy home screen — 46.1% requested by 4–5★ users", "feature",
  "A calmer, less busy home screen is the largest unbuilt request and 46.1% of it comes from satisfied 4–5★ users — a retention-preserving feature", "busy home screen", "complaint", "1,324 (3.05%), 46.1% 4–5★", "must-have", "very strong", "yes",
  ["7280199018","9617541402","11583598458","12674646598","13654261115"])
c(97, "§3.4 Fewer / controllable notifications", "feature", "Fewer or controllable notifications requested", "high notification volume", "complaint", "744 (1.71%, meaningful), mean 2.437, 28.5% 4–5★", "must-have", "meaningful", "yes",
  ["4831434999","7192135813","8812657942","10075146878","13509348951"])
c(98, "§3.4 Per-weekday / shift-work scheduling — 51.6% from 4–5★ users", "feature", "Per-weekday / shift-work scheduling is requested predominantly by satisfied users", "daily-only routines", "complaint", "31 (0.07%), 51.6% 4–5★", "must-have", "ignore (but retained users)", "yes",
  ["3862126193","5984966483","7852053634","9671088387","11251746171"])
c(99, "§3.4 Dark mode — 58.1% from 4–5★ users", "feature", "Dark mode is requested predominantly by satisfied, retained users", "no dark mode", "complaint", "43 (0.10%), 58.1% 4–5★", "build-free", "ignore (but retained users)", "yes",
  ["2419357081","6929437572","7390272530","7848606261","9789125721"])
c(100, "§3.4 iPad app / cross-device continuity; progress lost on device change", "feature", "An iPad app and cross-device continuity are requested; progress is lost on device change with no restore", "no iPad; no restore", "complaint", "257 (0.59%, emerging), mean 2.693, 34.2% 4–5★", "must-have", "emerging", "yes",
  ["3669324936","5629701161","7613143521","9190530552","12047728556"])
c(101, "§3.4 The 4–5★ share column is the actionable one — dark mode, per-weekday scheduling and a calmer home screen are retention-preserving features, not complaint triage", "insight",
  "Requests made predominantly by satisfied, retained users (dark mode 58.1%, per-weekday scheduling 51.6%, calmer home screen 46.1% 4–5★) are retention-preserving features, not complaint triage", "n/a", "praise", "58.1% / 51.6% / 46.1%", "do", "interpretation", "yes", [])

# ---- §3.5
c(102, "§3.5 Competitors named table (verbatim) — Finch 19 (1.579), Noom 18 (3.833), Duolingo 14 (3.286), Notion 13 (2.077), Stoic 11 (4.000), Way of Life 6 (5.000), Habitica 4 (1.750), Todoist 3 (2.000)", "positioning",
  "Competitors named (rare, 102, 0.23%, almost always as a switching destination inside a negative review): Finch 19 (mean 1.579), Noom 18 (3.833), Duolingo 14 (3.286), Notion 13 (2.077), Stoic 11 (4.000), Way of Life 6 (5.000), Habitica 4 (1.750), Todoist 3 (2.000)",
  "n/a", "churn", table("## 3.5 Competitors named in the corpus"), "do", "weak", "yes",
  ["8615390894","10009624824","13673827247","13827309312","5265102784","7331730434","7572330191","8426666167","7452356609","11735454398","11961834216","11995700791","4343478678","5660073877","7906240165","10822765363","5266699257","7325587887","10123977762","14452875038","2599238888","6534980130","8676496810","8752308740","6659839724","7970990328","8915659990","14112324759","3216104597","6883582926","6944638164"])
c(103, "§3.5 Finch is the named alternative in the modern era and is named in anger — about the business model, not features ('Finch is much less greedy')", "positioning",
  "Finch is the named alternative in the modern era and it is named in anger (mean 1.579) — the recommendation is explicitly about the business model, not the features ('Finch is much less greedy… they actually care about the people that subscribed'); Noom and Duolingo are comparisons of mechanic (click-through lessons; streak freezes), not alternatives",
  "n/a", "churn", "Finch 19, mean 1.579", "do", "weak", "yes", ["12422067440"])

with open("Tools/prd_ledger/24/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
