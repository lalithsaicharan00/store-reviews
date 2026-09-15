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

# ---- PART 2 ----
c(44, "Part 2 5★ table (verbatim)", "insight", "What produces 5★ (n=9,250): simple 3,369 (36.4%), widget 678 (7.3%), free 407 (4.4%), unlimited counters 215 (2.3%), no ads 195 (2.1%), time-unit flexibility 117 (1.3%), privacy 131 (1.4%), reset history 97 (1.0%)",
  "n/a", "5★-burst", table(213, 222), "none", "high-priority", "yes", [])
c(45, "Part 2 5★ row 4", "positioning", "Multiple / unlimited counters is the explicit switch reason from I Am Sober (which caps at 2)",
  "unlimited counters free", "purchase-driver", "215 of 5★ (2.3%); 244 corpus-wide (2.3%); 30 direct I Am Sober comparisons at mean 4.47", "build-free", "meaningful", "yes", [],
  side="a competitor's quantity cap is a stated acquisition channel")
c(46, "Part 2 5★ row 6", "feature", "Time-unit flexibility (hours → years) is underrated: it is what makes day 1 survivable — 'Seeing 105 hours instead of 4 days gives me that little boost'",
  "time-unit switching, free", "praise", "117 of 5★ (1.3%); 130 corpus (1.22%), mean 4.89, zero 1–2★", "build-free", "meaningful", "yes",
  ["11415043405","10707468669","11593417307","13180844816","8002227973","9649217076"])
c(47, "Part 2 1–2★ table (verbatim)", "insight", "What produces 1★ (n=225) and 2★ (n=106) — full table",
  "n/a", "1★-burst", table(226, 239), "none", "high-priority", "yes", [])
c(48, "Part 2 1★ bold", "insight", "62% of one-star reviews are about money, not about the product working badly; reliability accounts for roughly 8% — the opposite profile of most apps in this dataset family",
  "reliable app, aggressive monetisation", "1★-burst", "widget paywall 26.2% + other paywall 19.6% + price/greed 16.4% of 1★; reliability ~8%", "product-rule", "high-priority", "yes", [],
  side="when the product works, the monetisation decisions ARE the rating")
c(49, "Part 2 1★ row 'Too basic'", "positioning", "'Too basic / glorified stopwatch' is 5.8% of 1★ — the flip side of radical simplicity",
  "minimal by design", "complaint", "13 of 225 1★, 4 of 106 2★", "none", "weak", "yes", [],
  cond="simplicity is the core engine (36.4% of 5★); the 'too basic' minority is the price of it")
c(50, "Part 2 3–4★ table (verbatim)", "feature", "The 'almost' band (3★ n=191, 4★ n=849) is dominated by absence, not defect — full table",
  "n/a", "complaint", table(247, 259), "none", "high-priority", "yes", [])
c(51, "Part 2 3–4★ bold", "feature", "Pause / stop / archive a counter alone is worth roughly a star to 44 people — the highest-leverage single feature in this corpus per unit of engineering",
  "cannot pause a counter", "complaint", "5 3★ + 23 4★ in the band; 44 corpus-wide (0.41%), mean 4.02; 'You can't pause a counter'", "must-have", "high-priority (by leverage)", "yes",
  ["12591019352","13547063908","13415546831"])

# ---- PART 3 ----
c(52, "Part 3 §1", "insight", "Radical simplicity — 34.34% at mean 4.90 — users choose this app AFTER rejecting others for being too much: 'I don't need to log all of my reasons and thoughts… I already know my reasons'; 'the only one of 3 apps that didn't give me bible quotes every time I logged on'",
  "minimal: counter, reset, widget", "praise", "3,647 (34.34%), mean 4.90", "product-rule", "high-priority", "yes",
  ["11351620542","9725862564","11549990017","8911015925","12948824437","9900639372"],
  side="in the quit-habit category, journaling prompts, motivational quotes and 'Sobriety Plus' upsells are named as reasons to leave competitors")
c(53, "Part 3 §2", "feature", "The widget is the intervention, not decoration: 'the first thing I see when I unlock my phone. 240 days later'; 'It is like having a life coach for free'",
  "Home/Lock Screen widget", "praise", "920 (8.66%)", "build-free", "high-priority", "yes",
  ["11613261974","13068617301","11550435166","12090382709","14363669933"])
c(54, "Part 3 §3", "positioning", "'Actually free' (495, 4.66%) and the reviews name the competitor: 30 compare directly to I Am Sober, almost all citing its 2-counter cap as the reason they left — and two now recommend I Am Sober BECAUSE of this app's widget paywall",
  "free, unlimited counters", "purchase-driver", "495 (4.66%); 30 I Am Sober comparisons (mean 4.47); 2 reversed after the paywall", "build-free", "very strong", "yes",
  ["8132517827","8256187600","9356129632","12268649843","10931567211","9276814946","13185972322","10733606008","12102036646","11100020455","13471712113","13960930426"],
  side="the competitive risk made explicit: the gating that won users from a competitor can send them back")
c(55, "Part 3 §4", "feature", "Privacy and discretion — Face ID lock, alternate icons, a neutral app name, no account, no data collection — is the only theme with a perfect negative-free record (145 reviews, mean 4.90, zero 1–2★); 'the name was more discreet… so that I could download it without being questioned by my family'",
  "free privacy stack; discreet name", "praise", "145 (1.37%), mean 4.90, 0 1–2★", "must-have", "meaningful", "yes",
  ["9562673641","8103285120","8670863468","14479485824","14069349379","14215526815","13121449322","12123965670","13879035654"],
  side="in a recovery/sobriety category the app's NAME is a privacy feature",
  cond="category-critical for quit-habit; passcode lock is free here")
c(56, "Part 3 §5", "feature", "The reset mechanic — reset history, longest streak, average streak — is praised by 116 (1.09%), and 14 explicitly praise the ABSENCE of shame: 'relapse is part of recovery'; 'When you reset there's not a popup telling you to stay strong'",
  "reset keeps history; no shaming copy", "praise", "116 (1.09%); 14 praise no-shame", "must-have", "meaningful", "yes",
  ["13535056893","13091581867","12724148088","8034842662","9976059748","12972611936","12280678796","11792382769"],
  side="'the customer experience [elsewhere] is usually based around shaming you for falling off' — tone on failure is a product decision")
c(57, "Part 3 §7", "tactic", "Developer responsiveness — 42 reviews (0.40%), several are rating UPGRADES after support contact: an update-broken app fixed within hours, Watch fixed, notes editing shipped after a request; 'support quality is a real asset and it is being spent patching a self-inflicted pricing wound'",
  "fast, personal support", "5★-burst", "42 (0.40%)", "do", "weak count, clear mechanism", "yes",
  ["12937787678","9484075370","11053721045","12891271083","10862813507","11577546860","12879539920","9809365963","6789235976","12460281591"])

# ---- PART 4 ----
c(58, "Part 4 table (verbatim)", "feature", "Top complaints and unmet needs, 20 rows with n, %, mean, band — full table",
  "n/a", "complaint", table(293, 314), "none", "high-priority", "yes", [])
c(59, "Part 4 row 1", "monetization", "'Paywall in general' is the #1 complaint theme: 214 reviews (2.01%), mean 3.44",
  "subscription gating", "complaint", "214 (2.01%), mean 3.44", "research", "meaningful", "yes", [])
c(60, "Part 4 row 4", "monetization", "'Price too high / greed' draws 109 reviews (1.03%, mean 2.94)",
  "$17.99/yr, $49.99 lifetime on a counter app", "complaint", "109 (1.03%), mean 2.94", "research", "meaningful", "yes", [])
c(61, "Part 4 row 5", "feature", "Wants notifications / reminders (or wants them free): 94 reviews (0.89%) at mean 4.38 — asked by happy users",
  "reminders paid", "complaint", "94 (0.89%), mean 4.38", "undecided", "emerging", "yes", [])
c(62, "Part 4 row 6", "feature", "Apple Watch — missing, broken or paywalled — 50 reviews (0.47%, mean 4.22)",
  "Watch app exists (paywalled), sometimes broken", "complaint", "50 (0.47%), mean 4.22", "undecided", "weak", "yes", [])
c(63, "Part 4 row 7", "feature", "Graphs / deeper stats requested by 48 (0.45%) at mean 4.60",
  "basic stats only", "complaint", "48 (0.45%), mean 4.60", "build-paid", "weak", "yes", [])
c(64, "Part 4 row 10", "feature", "Folders / categories requested by 43 (0.40%) at mean 4.67 — the highest-mean request",
  "flat list of counters", "complaint", "43 (0.40%), mean 4.67", "undecided", "weak", "yes", [])
c(65, "Part 4 row 12", "feature", "More / custom colours and photo backgrounds requested by 33 (0.31%, mean 4.48)",
  "limited colour set", "complaint", "33 (0.31%), mean 4.48", "undecided", "weak", "yes", [])
c(66, "Part 4 row 13", "feature", "iPad / Mac / landscape support requested by 29 (0.27%, mean 4.10)",
  "iPad/Mac exist but weak; no landscape", "complaint", "29 (0.27%), mean 4.10", "undecided", "weak", "yes", [])
c(67, "Part 4 row 14", "feature", "Countdown ('days until') requested by 27 (0.25%, mean 4.37)",
  "count-up only", "complaint", "27 (0.25%), mean 4.37", "research", "weak", "yes", [])
c(68, "Part 4 row 15", "feature", "Export / CSV requested by 23 (0.22%, mean 3.52)",
  "export paid", "complaint", "23 (0.22%), mean 3.52", "build-free", "weak", "yes", [])
c(69, "Part 4 row 16", "feature", "Social / accountability partner requested by 21 (0.20%, mean 4.38)",
  "none", "complaint", "21 (0.20%), mean 4.38", "research", "weak", "yes", [])
c(70, "Part 4 row 17", "must-never-break", "Crash / won't open is only 12 reviews (0.11%) at mean 4.00 — reliability is not this app's problem",
  "stable", "complaint", "12 (0.11%), mean 4.00", "must-never-break", "weak", "yes", [])
c(71, "Part 4 row 18", "feature", "Can't backdate / edit start date — 12 reviews (0.11%, mean 4.33)",
  "start date not editable (for some)", "complaint", "12 (0.11%), mean 4.33", "build-free", "weak", "yes", [])
c(72, "Part 4 row 19", "feature", "Money-saved counter requested by 14 (0.13%, mean 4.57)",
  "none", "complaint", "14 (0.13%), mean 4.57", "research", "weak", "yes", [],
  cond="category-specific: quitting smoking/drinking has a cost to show")
c(73, "Part 4 row 20", "market", "Localisation is an ignore-band theme here (9 reviews, 0.08%) despite the app being English-only — the anglophone core is 74% of reviews",
  "English only", "complaint", "9 (0.08%), mean 3.89", "none", "ignore", "yes", [],
  cond="contrast reports 1–2 where localisation was a top blocker; depends on where the audience is")
c(74, "Part 4 A", "feature", "Pause / stop / archive is the most-requested MISSING capability from satisfied users (44, mean 4.02): a counter should stop without being deleted so a relapse period isn't counted as abstinence and history isn't destroyed; two 3★ and two 2★ say it is the only thing between them and 5★",
  "cannot pause", "complaint", "44 (0.41%), mean 4.02", "must-have", "high-priority (by leverage)", "yes",
  ["6386713912","7958751185","8247692991","8307733145","8583664620","8781228163","9071875815","9336427052","9497859261","9742186794","9815612198","9839492855","9853574448","9911225624","10006666229","10032185981","10114793784","10192967798","10406386435","10445660170","10556917933","10804111903","11089174862","11183891301","11205849645","11300877108","11560026280","11818815829","11873716787","12090334442","12110217758","12157388115","12284818560","12450405620","12591019352","12622562349","12707899782","12793759754","13317648020","13348650970","13415546831","13504054157","13547063908","14017242606"])
c(75, "Part 4 B", "must-never-break", "Accidental widget reset (33, mean 4.09): the interactive widget's reset button destroys streaks with one mis-tap and cannot be undone or disabled — 'I have a toddler'; 'I don't want a visual cue to stop being sober'; one user stays on the free trial BECAUSE paying would put the reset button on their widget — a safety issue in a recovery app, not a UI nit",
  "interactive widget with an un-undoable reset", "complaint", "33 (0.31%), mean 4.09; includes 2 paying users and one paywall-adjacent conversion blocker", "must-never-break", "weak count, safety-critical", "yes",
  ["11969610649","14087849144","10624806513","11108689966","12399679376","11767328058","14292313517","11588058672","11989500206","11086772681","11188497308","13246151828","14005562428","14014676976","11768313172","10519275774"],
  side="destructive actions on an interactive widget need confirmation or undo; a reset button on the Home Screen is 'a visual cue to break the streak'",
  cond="interactive widget check-off (report 1, lift ×5.2) and this are the same surface — make the destructive action hard, the constructive one easy")
c(76, "Part 4 C", "must-never-break", "iCloud sync / backup (44, mean 3.91): losing years of sobriety data on a phone upgrade is the highest-severity failure mode — 'I have quit smoking for two years… they deleted the whole lot'; 'Back up is literally PREMIUM?'; nine outright data-loss reports promoted under the safety exception to the 0.1% rule",
  "backup/sync paid; restore from iOS backup loses data", "1★-burst", "44 (0.41%), mean 3.91; 9 (0.08%) outright data loss", "must-have", "weak count, extreme severity", "yes",
  ["13629061971","11299477588","12548572664","12166645069","13465985854","13055204197","9112628469","12094477051","13021750903","11497487916","10551769710"],
  side="charging for backup in a recovery app reads as holding sobriety history hostage",
  cond="the report promotes this above its count deliberately — severity overrides the band")
c(77, "Part 4 D", "feature", "Milestone celebration / badges (235, 2.21%, mean 4.74) is the largest positive-intent feature request in the corpus, spanning 2020→2026 in every era — almost all 4–5★ users describing a gap; Achievements shipped in v4.1.0 (31 Aug 2026), post-dating almost all of them",
  "shipped Achievements Aug 2026", "complaint", "235 (2.21%), mean 4.74", "undecided", "meaningful", "yes",
  ["5623501226","6799825017","6725577104","6916503157","7937733616","7788890241","13516767357","14477704812","13673255758","14443856328","14193482636","12972611936","12224121640"],
  cond="a six-year-old top request; whether it becomes a purchase driver is not yet visible")
c(78, "Part 2 3–4★ row 'Notes / journaling'", "feature", "Notes / journaling wanted or too cramped — 6 3★ + 33 4★ (3.9% of 4★)",
  "reset note only; no journal", "complaint", "39 in the 3–4★ band", "research", "meaningful (band)", "yes", [])

with open("Tools/prd_ledger/3/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
