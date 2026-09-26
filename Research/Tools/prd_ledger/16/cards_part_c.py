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

# ---- PART 3 ----
c(28, "§3.1 All themes, ranked — Negative themes table (verbatim); Positive themes table (verbatim); Cross-cutting table (verbatim)", "data-caveat",
  "All 57 themes ranked: 37 negative, 12 positive, 5 cross-cutting",
  "n/a", "mixed", "NEG: " + table("### Negative themes") + " ;; POS: " + table("### Positive themes") + " ;; CROSS: " + table("### Cross-cutting"), "none", "verbatim", "app-specific", [])
c(29, "§3.1 #2 Subscription model objection; #7 Stated churn / uninstall; #9 Price is fair / good value (positive)", "monetization",
  "The subscription model itself draws a high-priority objection and stated churn is very strong, while a small group says the price is fair — every one of them 5★",
  "subscription only", "mixed", "sub objection 136 (11.64%) mean 2.32; churn 55 (4.71%) mean 2.00, 76.4% 1–2★; price fair 17 (1.46%) mean 5.00", "product-rule", "high-priority", "yes", [])
c(30, "§3.1 #11 Habit model too rigid (time-locked, no stacking, no flexible frequency); §3.3 #7 A flexible habit model", "feature",
  "The habit model is too rigid: time-locked habits, no habit stacking, no 'X times a week on any day', no bad-habit/quit mode, no end dates, no multiple logs per day",
  "one time-locked daily habit template", "complaint", "39 (3.34%, VERY STRONG) mean 3.21, 33.3% 1–2★", "must-have", "very strong", "yes", [])
c(31, "§3.1 #14 Confusing / over-designed UX; #21 Weak progress visualisation / no real calendar; #22 Wants customisation; #33 Animation / loading friction", "feature",
  "UX themes: confusing / over-designed; weak progress visualisation — 'Reading a sentence about my progress doesn't feel as rewarding as seeing a visual tracker'; wants colour and reordering customisation; animation/loading friction",
  "sentence-based progress; heavy animation", "complaint", "confusing 35 (3.00%) mean 2.80; visualisation 15 (1.28%) mean 2.67; customisation 14 (1.20%) mean 3.64; animation friction 7 (0.60%) mean 2.57", "build-free", "meaningful", "yes",
  ["11052153505","11007997431","13681275543"])
c(32, "§3.1 #20 Accountability-partner limits; positive #10 Accountability partner; §3.3 #11 More / better accountability partners", "feature",
  "The accountability partner (invite a friend, Pro) is praised and its limits complained about — multiple partners, seeing a partner's recent progress, random matching",
  "one partner, Pro", "mixed", "limits 15 (1.28%) mean 3.27; positive 13 (1.11%) mean 3.62", "research", "meaningful", "yes",
  ["11129229740","13276061916","11749997696"])
c(33, "§3.1 #23 Account creation / sign-in broken; #26 Widget problems; #32 Notification problems; #34 Support unreachable; #36 Privacy concern; #37 US-centric date/time formats", "must-never-break",
  "Reliability and trust tail: account creation / sign-in broken (mean 1.50), widget problems, notification problems, support unreachable, privacy concern, US-centric date/time formats (no 24-hour clock, Sunday week start)",
  "n/a", "complaint", "sign-in 12 (1.03%) mean 1.50, 83.3% 1–2★; widget 11 (0.94%) 3.00; notifications 8 (0.68%); support 7 (0.60%) 2.14; privacy 5 (0.43%); date formats 3 (0.26%)", "must-never-break", "meaningful–weak", "yes",
  ["10983726873","11001435276","11835036235"])
c(34, "§3.1 #25 Regional pricing / purchasing-power objection", "market",
  "A regional pricing / purchasing-power objection exists at emerging band — explicit proposals for a mid tier, student plan, scholarship and regional pricing",
  "single global price", "complaint", "11 (0.94%, emerging) mean 2.73", "do", "emerging", "yes",
  ["10983501760","13456206729","11095912492","11001435276"])
c(35, "§3.1 positive #11 Believes the app is free / praises free access; §5.5", "data-caveat",
  "Ten reviewers believe the app is free or praise free access — reviews written inside the trial window before the wall",
  "28-day trial reads as free", "praise", "10 (0.86%) mean 4.80, 90.0% 5★", "none", "emerging", "app-specific", [])
c(36, "§3.1 cross-cutting ADHD / neurodivergent / depression self-identified [limited evidence]", "audience",
  "ADHD / neurodivergent / depression self-identification is rare in this corpus",
  "n/a", "mixed", "7 (0.60%) mean 3.86 [limited evidence]", "research", "limited evidence", "yes",
  ["11572795669"])
c(37, "§3.2 The corpus is bimodal, and the middle is hollow; contrast with HabitKit", "insight",
  "The corpus is bimodal and the middle is hollow: half the corpus is a five and 30% is a one-or-two; the 4★ band is the smallest — the signature of a product where the decision is binary (accept the model and love it, or hit the wall and reject it); Atoms has 3.8× HabitKit's one-star rate on a product reviewers describe as better-designed",
  "n/a", "mixed", "5★ 49.74%, 4★ 8.73% (smallest), 1–2★ 29.97%; HabitKit 78.5% 5★ / 4.7% 1★ mean 4.56", "product-rule", "structural", "yes", [])
c(38, "§3.3 Unmet needs — every request in the corpus, ranked table (verbatim); free cap 1 → 3 is what they ask for, not free everything", "feature",
  "Every request ranked: raise the free cap 1 → 3 (repeatedly three, not 'free everything'), raise the Pro cap 6 → unlimited (several name 10–15), a one-time/lifetime SKU (the most-repeated counter-proposal), a cheaper tier, localisation (Spanish 14, Turkish 4, Russian 3, French 3, German 2…), back-logging, a flexible habit model, dark mode, customisation, a real calendar, better accountability partners, offline logging, undo, iPad/Watch/Mac/Android, integrations (Health, Garmin, Spotify), 24-hour clock / non-Sunday week start",
  "absent", "complaint", table("## 3.3 Unmet needs"), "build-free", "verbatim", "yes",
  ["10975505569","10988610880","11749997696","13838905269","13573785597","13709994614","10984353099","13076289855","12135884025"])
c(39, "§3.4 Competitors reviewers name, and why table (verbatim); Atoms is not losing on features, it is losing to a one-time price", "positioning",
  "86 reviews name an alternative and naming a competitor is a churn signal: Streaks (eight times, every mention for its one-time purchase), pen and paper ('$200 buys a lot of habit journals'), Apple Reminders/Calendar, (Not Boring) Habits (cheaper, lifetime; 'essentially a clone'), Fabulous, Notion/Sheets, HabitKit ('$16 for lifetime use'), Miracle Morning ('only $39'), Duolingo as the streak benchmark — Atoms is not losing on features, it is losing to a one-time price",
  "subscription only vs one-time rivals", "churn", "86 (7.36%, HIGH-PRIORITY) mean 2.52; " + table("## 3.4 Competitors reviewers name"), "product-rule", "high-priority", "yes",
  ["10986293973","11094114464","11489179909","10983893115","12199586867","11110393035","14046766451","10975525747","10989617169","10984314402","11177029172","11737855300","11685719155"])

with open("Tools/prd_ledger/16/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
