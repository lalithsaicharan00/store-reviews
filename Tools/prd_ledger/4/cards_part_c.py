import json, re
R = 4
rep = open("App Store Reports/4. Me+ Lifestyle Routine - Daily Planner & Habit Tracker (REPORT).md").read().split("\n")
def table(start, end):
    rows = [l for l in rep[start-1:end] if l.startswith("|") and not re.match(r"^\|[\s\-:|]+\|$", l)]
    return " ; ".join(re.sub(r"\s*\|\s*", " | ", l.strip("|")).replace("**","").strip() for l in rows)
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))

# ---- PART 2 ----
c(43, "Part 2 5★ table (verbatim)", "insight", "What produces 5★ (n=12,308): organisation outcome 30.7%, strong endorsement 25.1%, mental-health context 7.8%, design 4.6%, motivation/streaks 4.4%, ADHD 4.7%, workout/meditation content 2.5%, free tier 1.6%, any monetization 4.9% — 5★ reviews are short, emotional, about outcomes",
  "n/a", "5★-burst", table(260, 270), "none", "high-priority", "yes",
  ["12165876117","11471121244","10402434611","12146411524","11002598099","10814031887","12070744997"])
c(44, "Part 2 1–2★ table (verbatim) + bold", "insight", "The 1★ band is a billing-complaints channel: must-pay 21.4%, trial charged 18.9%, scam 14.8%, refund 14.2%, unexpected charge 11.3%, cannot cancel 4.4%; only 4.4% of 1★ are about the app breaking; 2★ is where disappointed users sit (bugs 6.5%, nagging 5.4%), 1★ is where charged users sit",
  "n/a", "1★-burst", table(276, 288), "product-rule", "high-priority", "yes", [],
  side="1★ = charged; 2★ = disappointed — two different fixes")
c(45, "Part 2 3–4★ table (verbatim) + bold", "insight", "3–4★ is one coherent message: 'great app, but the paywall and a few missing capabilities stop me giving it five' — feature requests 16.3% of 3★ / 14.9% of 4★, must-pay 17.9% / 12.9%, notifications 7.2% / 5.0%, language 5.1% / 4.4%; 1,352 reviews (6.61%, high-priority) contain an explicit feature request",
  "n/a", "complaint", table(293, 303), "none", "high-priority", "yes", [])

# ---- PART 3 ----
c(46, "Part 3 §1", "insight", "Getting organised — 26.46% at mean 4.29 — the core loop works: 'on days where I didn't complete my tasks it would just drive me to complete them the next day'",
  "daily routine checklist", "praise", "5,416 (26.46%), mean 4.29", "must-have", "high-priority", "yes",
  ["12165876117","11002598099","10334087672","12363238702","10790031201","11026211815","12732230801"])
c(47, "Part 3 §2", "insight", "Strong endorsement / life change — 17.82% at mean 4.77, only 2.1% 1–2★",
  "n/a", "praise", "3,646 (17.82%), mean 4.77", "none", "high-priority", "yes",
  ["10932819511","11471121244","12146411524","12630538551","11477431119","12886388716","13546357208"])
c(48, "Part 3 §3", "audience", "Mental-health and neurodivergence fit is the app's strongest defensible position: 1,424 (6.96%, mean 4.14), 922 (4.51%) name ADHD specifically and 62.4% of ADHD reviews are 5★",
  "routine planner marketed to and adopted by ADHD/anxiety/depression/OCD/autism users", "praise", "1,424 (6.96%) at 4.14; ADHD 922 (4.51%), 575 5★", "do", "high-priority", "yes",
  ["10234553092","10144485344","11009832175","10603862753","10514993532","11097971505","13030561157","12952812019"])
c(49, "Part 3 §4", "positioning", "Design and cuteness — 5.40% at mean 3.85 — appears MORE in 4★ (8.8%) and 3★ (8.0%) than in 5★ (4.6%): it is frequently the 'but' clause — beautiful app, shame about the paywall",
  "cute, aesthetic design with a mascot", "mixed", "1,106 (5.40%), mean 3.85", "do", "high-priority", "yes",
  ["13573494472","10716291473","13558821605","9673450918"],
  side="design earns the 'almost' rating, not the 5★; it does not offset a monetisation grievance",
  cond="contrast report 1 where 'too feminine/cute' was a complaint from men — cute design is audience-dependent")
c(50, "Part 3 §5", "feature", "Motivation and streaks — 790 (3.86%), mean 4.32",
  "streaks + motivational loop", "praise", "790 (3.86%), mean 4.32", "build-free", "very strong", "yes", ["12165876117","11439226063","12231145076","11795008246"])
c(51, "Part 3 §6", "feature", "The content library — workouts 484 (2.37%, 4.23), sleep 148 (0.72%, 4.08), journal/mood 259 (1.27%, 4.17) — is a real differentiator against pure habit trackers and the paid layer's substance",
  "bundled workouts, meditation, sleep sounds, journal, mood", "praise", "484 + 148 + 259", "build-paid", "meaningful", "yes",
  ["12787145374","11500466306","12396370842","11626250981","12952812019","10490388620"],
  cond="a paid tier needs something beyond the core loop to sell; content is one answer")
c(52, "Part 3 §7", "insight", "Ease of use — 479 (2.34%), mean 3.89 — and no ads 67 (0.33%), mean 4.45",
  "n/a", "praise", "479 (2.34%); 67 (0.33%)", "must-have", "meaningful", "yes", ["11808709309","10938043754","10558237535"])
c(53, "Part 3 §8", "feature", "The mascot / character — 50 (0.24%), mean 3.94 — weak but pure: 'there's this very sweet chick that helps you'",
  "a chick mascot", "praise", "50 (0.24%), mean 3.94", "research", "weak", "yes", ["12251793690","13558821605"])

# ---- PART 4 ----
c(54, "Part 4 table (verbatim)", "feature", "Top complaints and unmet needs, 25 rows — full table",
  "n/a", "complaint", table(338, 364), "none", "high-priority", "yes", [])
c(55, "Part 4 row 4 + #1", "must-never-break", "Reliability of reminders and alarms — 212 reviews (1.04%, mean 2.82): 'I never get the notifications on my iPhone or my iWatch… what is the point of paying for this app'; 'the alarm doesn't sound if the app is closed'; 846 (4.13%) discuss notifications in any sentiment",
  "notifications silent or absent, esp. app closed", "1★-burst", "212 (1.04%), mean 2.82; 846 (4.13%) all-sentiment", "must-never-break", "meaningful", "yes",
  ["10778781877","10934193537","11660101678","10358615519","9341354191","11341912770","10584691475","9783610640","11583930736","11628266726","8491078677"],
  side="'we remind you' is the core promise; three of the quoted complainers are paying")
c(56, "Part 4 #2", "feature", "Scheduling flexibility — 332 (1.62%, mean 2.77): weekly, monthly, every-other-day, X-times-per-week, time windows; the most-voted product-feedback review in the corpus (109 votes) asks for it; declined 2.49% (2023) → 0.67% (2026) — partially addressed, not solved",
  "daily-only routines; partial improvement", "complaint", "332 (1.62%), mean 2.77; 2.49% → 0.67%", "must-have", "meaningful", "yes",
  ["10518775457","11002520527","9693649611","10490388620","10033970966","13153079287","10339253592"])
c(57, "Part 4 #3", "feature", "Editing and reordering — 399 customisation reviews (1.95%) + 112 future-day-editing reviews (0.55%): the future-day block was a 2023 problem (1.35% → 0.22%) and looks fixed; renaming and reordering are not — three paying users complain",
  "cannot rename or reorder tasks; future-day editing fixed", "complaint", "399 (1.95%), mean 3.08; 112 (0.55%)", "build-free", "meaningful", "yes",
  ["10080398097","9690694863","10278130819","9774990643","10311098663","10763448380"],
  side="an AuDHD user on a layout regression — layout changes hit neurodivergent users hardest")
c(58, "Part 4 #4", "must-have", "Account portability and data safety — 154 sync/login (0.75%) + 115 backup (0.56%) + 55 data loss (0.27%): 'everything was gone GONE'; 'the Data Recovery they added doesn't recover anything'; 'There's no cloud backup'; a 200+ day streak lost — small individually, catastrophic per user, hits payers hardest",
  "no cloud backup; a 'Data Recovery' feature that doesn't recover", "1★-burst", "154 + 115 + 55", "must-have", "emerging", "yes",
  ["10992217262","9795027359","9796249391","9790985374","9731639217","13965631601","10285166374","10996599524","10951060325","11052130385","10850211623","13249657539"])
c(59, "Part 4 #5", "must-never-break", "Update regressions — 286 'used to be better' (1.40%) + 42 explicit update complaints: 'The app was everything I dreamt of… then Boom… updated! Now the interface is simply ugly, the progress is gone'",
  "updates that change layout and lose progress", "complaint", "286 (1.40%), mean 3.01; 42 (0.21%)", "must-never-break", "meaningful", "yes",
  ["10800043782","10905831477","10760745572","10936736844","13748454414","10763028336","13705509114"])
c(60, "Part 4 row 10", "feature", "Customisation limits (rename, reorder, edit) — 399 (1.95%), mean 3.08",
  "editing gated/limited", "complaint", "399 (1.95%), mean 3.08", "build-free", "meaningful", "yes", [])
c(61, "Part 4 row 12", "monetization", "'More free features please' — 369 (1.80%), mean 3.21",
  "thin free tier (post-cap)", "complaint", "369 (1.80%), mean 3.21", "research", "meaningful", "yes", [])
c(62, "Part 4 row 13", "monetization", "Price too high — 324 (1.58%), mean 2.37",
  "$39.99/yr", "complaint", "324 (1.58%), mean 2.37", "research", "meaningful", "yes", [])
c(63, "Part 4 row 15", "feature", "Confusing / hard to learn — 275 (1.34%), mean 2.73",
  "complex UI", "complaint", "275 (1.34%), mean 2.73", "must-have", "meaningful", "yes", [])
c(64, "Part 4 row 20", "anti-pattern", "Ad ≠ app — advertised features absent — 126 (0.62%), mean 2.42",
  "ads show features the app lacks", "complaint", "126 (0.62%), mean 2.42", "dont", "emerging", "yes", [],
  side="marketing that oversells creates a 'scam' cohort before the app is even opened")
c(65, "Part 4 row 14", "timeline", "'It used to be better / used to be free' — 286 (1.40%), mean 3.01",
  "regressions and re-gating", "complaint", "286 (1.40%), mean 3.01", "product-rule", "meaningful", "yes", [])
c(66, "Part 4 row 7", "must-never-break", "Bugs / crashes / not working — 444 (2.17%), mean 2.66",
  "n/a", "complaint", "444 (2.17%), mean 2.66", "must-never-break", "meaningful", "yes", [])
c(67, "Part 4 'safety-adjacent' theme", "audience", "89 reviews (0.43%, mean 2.60) raise shame, guilt, body image, weight-loss framing or disordered-eating risk — promoted despite the 0.5% bar because the app is rated 4+, heavily used by teenagers, and markets 'weight loss' and 'anti-aging'; 'Promotes shame and disordered eating behaviours' (46 votes); 'Suppress my hunger?? Why? This isn't a diet app'; 'It compared an ADHD brain to a NORMAL brain'; 'a money mill for anxious teens'",
  "diet/weight/anti-aging framing in the quiz and content", "1★-burst", "89 (0.43%), mean 2.60; one 46-vote review", "dont", "weak count, safety", "yes",
  ["10163266248","10568183655","9893977621","10776165546","10093089650","11198749049","9683736698","10852967602","11628266726"],
  side="a quiz that probes anxieties or hunger, in a 4+ app used by teens, is a reputational risk beyond its count",
  cond="daily mood check-ins can read as 'depressing' to the users they target")
c(68, "Part 4 teens paragraph", "audience", "455 reviews (2.22%, mean 4.08) are by or about children and teenagers — and the paywall lands on them directly: 'I'm just a kid and I don't have the money'; 'I am ten years old'",
  "4+ rated, teen-heavy audience, subscription paywall", "mixed", "455 (2.22%), mean 4.08", "do", "meaningful", "yes",
  ["11275052684","13111676999","9847060220","10294858917","10740385550","10402434611"],
  side="a teen audience cannot pay — a paywall on them produces 1★ with no revenue")

with open("Tools/prd_ledger/4/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
