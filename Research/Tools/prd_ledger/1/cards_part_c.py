import json
R = 1
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=None))

# ---- PART 4 complaints table ----
c(90, "Part 4 table row 1 + dilution note", "must-never-break", "Crashes / freezes / won't-open is the #1 complaint and runs at 5–7% of non-China reviews per year since 2024",
  "recurring crash incidents", "1★-burst", "1,072 global (1.89%); 305 US (5.61% HIGH-PRIORITY); mean 2.98; 5–7% of non-CN reviews per year since 2024",
  "must-never-break", "high-priority", "yes", [],
  side="global % is diluted by 22,136 contentless CN filler reviews — report says treat as HIGH-PRIORITY")
c(91, "Part 4 table row 4", "must-never-break", "Shared / group habits broken is the worst-rated theme in the dataset (mean 2.33), broken continuously 2020 → 2026",
  "shared habits exist but invites never arrive, records fail to modify, invitee's board vanishes, duplicates after sync, partner can delete your habits", "1★-burst",
  "66 reviews, mean 2.33 — lowest-rated theme; 28 US (0.52%)", "must-never-break", "high-priority", "app-specific",
  ["11872142407","14368195442","11619587662","8223936579","13507165984","8814459765","9655198596","9114508292","13628025400","11575579529","12367483644","14450880574","13689542636","12865599006","11729343016","10823077252","14074266911","13974330030"],
  side="one user bought specifically for shared habits, couldn't use it, was refused a refund, wrote '一生黑' (lifelong hater)",
  cond="a purchase driver that fails costs more than a missing feature")
c(92, "Part 4 table row 9", "must-never-break", "Editing a habit's frequency wiped its history for years; when it was fixed in late 2025 a user came back specifically to raise their rating",
  "bug existed for years; fixed late 2025", "complaint", "20 global, 9 US (0.17%), mean 3.60", "must-never-break", "weak count", "yes",
  ["13835499661","11064175608","13331897384","13449875017"],
  side="fixing a long-standing bug produces revised ratings — users do come back (Part 8 #15)")
c(93, "Part 4 table row 10", "must-never-break", "DST / timezone changes break streaks",
  "timezone handling breaks streaks", "complaint", "28 global, 15 US (0.28%), mean 3.50", "must-never-break", "weak count", "yes", [])
c(94, "Part 4 table row 11", "must-have", "'No support channel' is the second-worst-rated complaint theme (mean 2.04)",
  "no support channel", "1★-burst", "28 global, 8 US, mean 2.04", "must-have", "weak count, very low mean", "yes", [])

# ---- crash timeline ----
c(95, "Part 4 crash timeline", "timeline", "The year-end / year-in-review report crashed in Jan 2020, Dec 2020, Jan 2021, Dec 2024 and hung again Jan–Mar 2026 — same bug, same season, five years running",
  "year-end report crashes every New Year", "1★-burst",
  "Jan 1–3 2020: 42 crash reviews; Dec 2020: 57 (Dec 10 alone 16); Jan 2021: 43; Dec 29–30 2024: 29 (alongside the stats paywall); Jan–Mar 2026: 49 at mean 2.24",
  "must-never-break", "high-priority", "yes", [],
  side="the year-end report is both the biggest emotional payoff and the most reliable crash; 'fixing New Year robustness is worth more than any new feature' (Part 8 #4)",
  cond="load-test the year-end path before every December")
c(96, "Part 4 crash timeline row Apr 2024", "timeline", "The Apr 27–29 2024 launch-crash regression is the biggest single incident in the corpus (94 reviews in 3 days) even though it was fixed in ~2 days",
  "shipped a launch crash; fixed in ~2 days", "1★-burst", "94 crash reviews in 3 days", "must-never-break", "high-priority", "yes", [],
  side="two days of a launch crash produced more 1★ than years of minor bugs; the rating never fully recovered")

# ---- persistent bugs ----
c(97, "Part 4 persistent bugs bullet 2", "must-never-break", "Widgets go blank, stop updating, disappear after updates, or show different numbers from the app",
  "widget reliability bugs", "complaint", "60 reviews, mean 3.40 (table); 'widget shows 10, app shows 5'", "must-never-break", "weak count", "yes",
  ["9611400134","11230464766","9925842684","8035455211","13073928408","10529025581","11190100507"])
c(98, "Part 4 persistent bugs bullet 4", "feature", "The Apple Watch app is half-built: black screen, no timer, one-way sync only",
  "Watch app exists but is weak", "complaint", "8 IDs; Watch 3★ ×4.7, 2★ ×5.7 (Part 2)", "build-paid", "moderate", "app-specific",
  ["7736947415","10406252185","11630025684","12115342572","12993356431","11489065352","9788537083","9495420825"],
  cond="Part 8 #16: Watch done properly means a Watch timer and two-way sync")
c(99, "Part 4 persistent bugs bullet 5", "feature", "The Mac / M1 build won't open, groups don't display, fonts are tiny",
  "Mac (iPad-on-M1) build is broken", "complaint", "6 IDs", "build-paid", "weak count", "app-specific",
  ["8193933847","8772612449","9236687881","9294699968","10970545034","13673065255"],
  cond="a real Mac app is a 3★-lift ×4.8 gap (R01-073)")
c(100, "Part 4 persistent bugs bullet 6", "must-never-break", "Notification spam — reminders firing after completion, or hundreds of repeats",
  "reminder bugs", "complaint", "3 IDs", "must-never-break", "weak count", "yes", ["11497748147","13565202357","8354356581"])

# ---- PART 5 feature requests ----
c(101, "Part 5 table row 1", "feature", "Data export / backup / CSV is the #1 feature request by volume, from happy users (mean 4.76)",
  "export is paid", "complaint", "442 global (0.78%); 92 US (1.69% MEANINGFUL); mean 4.76", "build-free", "meaningful (US)", "yes", [],
  cond="requested by 4.76-mean users = not anger, but the request volume shows the paywall on export is felt (R01-022)")
c(102, "Part 5 table row 2 + bullet", "feature", "Sub-tasks / folders / grouping / tags / multiple profiles (me, kids, pet, work) is the #2 request",
  "missing", "complaint", "275 global (0.49%); 63 US (1.16% MEANINGFUL); mean 4.41", "undecided", "meaningful (US)", "yes",
  ["13747367536","7634754264","13682524933","9764200754","8348985579"],
  side="one user wants Apple-Watch-style closing rings; one wants nested items")
c(103, "Part 5 table row 3", "feature", "One-off to-dos alongside habits is an emerging request",
  "habits only, no to-dos", "complaint", "237 global (0.42%); 33 US (0.61% EMERGING); mean 4.53", "research", "emerging", "yes", [])
c(104, "Part 5 table row 4", "feature", "Interactive widget check-off is requested by 128 users at mean 4.58",
  "not interactive at the time of most requests", "complaint", "128 global (0.23%); 14 US (0.26% WEAK); mean 4.58", "undecided", "weak (US)", "yes", [],
  cond="pairs with R01-030 (lift ×5.2 among buyers)")
c(105, "Part 5 table row 5 + paragraph", "feature", "Every-X-days / custom frequency is the #1 outstanding functional request — the single change most likely to convert 4★ → 5★",
  "fixed daily/weekly only", "complaint", "107 global (0.19%); 42 US (0.77% EMERGING); mean 3.99; 4★ lift ×4.2 (highest in dataset)", "must-have", "high-priority", "yes",
  ["11546677755","13653691592","8192442876","8386361837","10039214833","13399803793","9323772372","11102698750","13397631582","12161101542","11292583414","10638765978","9542852807","13182168411","14161153524","12821336230","9346815481"],
  cond="asks: every other day, every 3 days, bi-weekly, quarterly, specific weekdays, yearly goal period, fixed total over a custom window")
c(106, "Part 5 table row 7", "feature", "An Android version is requested by 94 users",
  "iOS only", "complaint", "94 global (0.17%); 24 US (0.44% WEAK); mean 4.41", "research", "weak", "yes", [])
c(107, "Part 5 table row 8", "feature", "Shortcuts / Siri / automation / API requested by 87 users",
  "missing", "complaint", "87 global (0.15%); 24 US (0.44% WEAK); mean 4.34", "undecided", "weak", "yes", [])
c(108, "Part 5 table row 9", "feature", "Mac / Windows / web app requested by 67 users",
  "missing (broken M1 build only)", "complaint", "67 global (0.12%); 14 US (0.26% WEAK); mean 4.03", "build-paid", "weak", "yes", [])
c(109, "Part 5 table row 10", "feature", "Photo attachment to the journal — ignorable volume",
  "missing", "complaint", "16 global (0.03%); 1 US; mean 4.38", "none", "ignore", "yes", [])
c(110, "Part 5 'other asks' bullet 2", "feature", "Cumulative totals ('how many total hours have I spent on this habit?') are requested, not just streaks",
  "streaks only", "complaint", "4 IDs; Part 8 #14", "undecided", "weak", "yes", ["13625602594","11444116403","9346815481","9004383645"])
c(111, "Part 5 'other asks' bullet 3", "feature", "Points / rewards / wish list requested; one user proposes a cash-stake mode",
  "no rewards system", "complaint", "6 IDs", "research", "weak", "yes", ["13884191988","11653460054","8415166135","9503979717","8656766818","10269104804"])
c(112, "Part 5 'other asks' bullet 4", "feature", "Custom time-of-day segments beyond morning/afternoon/evening — needed by shift workers",
  "fixed three segments", "complaint", "2 IDs", "undecided", "weak", "yes", ["13005403096","8504117544"])
c(113, "Part 5 'other asks' bullet 5", "feature", "A total-days counter instead of consecutive-days, to reduce streak anxiety",
  "consecutive streaks only", "complaint", "1 ID; Part 8 #14 adopts it", "undecided", "weak", "yes", ["9088862282"],
  side="streak anxiety is a churn mechanism the report takes seriously despite n=1")
c(114, "Part 5 'other asks' bullet 6", "feature", "Broader Apple Health plus Fitbit / Garmin — shipped by mid-2026",
  "shipped Fitbit/Garmin support by mid-2026", "praise", "2 IDs", "research", "weak", "yes", ["13049304019","14449213471"])
c(115, "Part 5 'other asks' bullet 7", "feature", "Accessibility and cultural gaps: bigger fonts, missing disability icons, missing Islamic icons while cross/church/Star-of-David exist, Hijri calendar, lunar calendar for China",
  "icon set and calendars are Western-default", "complaint", "several era-referenced IDs", "do", "weak", "yes", ["8979","6049","8796","9950542821"],
  cond="cheap to fix, and it lands in the markets where localisation already blocks purchase")
c(116, "Part 5 'other asks' bullet 8", "positioning", "'Too feminine / childish' design is a real, repeated critique from men and from users wanting a premium look",
  "pastel/cute default design", "complaint", "several era-referenced IDs; Part 8 #21", "do", "repeated, uncounted", "yes", ["14008424474"],
  cond="Part 8 #21: offer a design that isn't pastel/cute-by-default")

with open("Tools/prd_ledger/1/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
