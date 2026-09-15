import json, re
R = 14
rep = open("App Store Reports/14. My Habits - Daily Habit Builder - Tracker for Goals & Routine (REPORT).md").read().split("\n")
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
c(17, "§3.1 All themes, ranked — Positive themes table (verbatim); Negative themes table (verbatim); Cross-cutting table (verbatim)", "data-caveat",
  "All themes ranked: eleven positive, eleven negative, and cross-cutting rows",
  "n/a", "mixed", "POS: " + table("### Positive themes") + " ;; NEG: " + table("### Negative themes") + " ;; CROSS: " + table("### Cross-cutting"), "none", "verbatim", "app-specific", [])
c(18, "§3.1 P3 Attractive / clean interface; P4 Statistics and visible progress records; P6 Reminders work; P7 Streak/green-square satisfaction; P8 A previously reported problem was fixed; P11 Can edit/backdate previous days", "feature",
  "Positive drivers beyond effectiveness and simplicity: a clean interface, visible statistics and progress records, reminders that work, streak/green-square satisfaction, a previously reported problem being fixed, and the ability to edit or backdate previous days ('on some apps you can't do this… you can't go back')",
  "stats, reminders, streak grid, backdating — all present", "praise", "P3 6 (8.57%) 4.67; P4 5 (7.14%) 5.00; P6 3 (4.29%) 5.00; P7 2 (2.86%) 5.00; P8 2 (2.86%) 5.00; P11 1 5.00", "build-free", "counts", "yes",
  ["961128068","1118980626","961110962","1120439485","1132075503","1147730742","1076855737","1184550500","1193853972","1197160923"])
c(19, "§3.1 N4 Free-tier limits hit (3 habits; 6 daily entries); N5 Interface dated or navigation unintuitive; N10 No tutorial; N11 Updates months or years apart", "feature",
  "Negative themes beyond nags, crashes and data loss: the free-tier caps (3 habits; 6 daily entries), a dated interface or unintuitive navigation, no tutorial, and updates months or years apart",
  "3-habit cap; 6-entry cap; no tutorial; stale UI", "complaint", "N4 3 (4.29%) 3.33; N5 3 (4.29%) 2.67; N10 1 1.00; N11 1 1.00", "research", "counts", "yes",
  ["1174519073","6183382407","1054073250","1138108331","1262227277","6684084592"])
c(20, "§3.2 The corpus splits cleanly into two populations table (verbatim); 13 of the 50 four- and five-star reviews still carry a criticism or a request", "insight",
  "The corpus splits into pure praise (mean 4.79) and reviews carrying a criticism or request (mean 2.75) — a 2.04-star gap; 13 of the 50 four- and five-star reviews still carry a criticism or request: satisfied users telling the developer what to do next, the highest-value records in the corpus",
  "n/a", "mixed", table("## 3.2 The corpus splits") + " ; 13 of 50 4–5★ (26.00%) with criticism", "do", "counts", "yes",
  ["1002707223","1054073250","1056568978","1190931941","1195162150","1262227277","1407746285","5929885128","6183382407","7082831771"])
c(21, "§3.3 Unmet needs — every feature request in the corpus table (verbatim); a list of leads, not a ranked backlog", "feature",
  "Every feature request: Russian localisation (2), iPad/universal, weekly/monthly trend views, raise the 6-entries-per-day cap, adjustable font size, a tutorial, per-day alarm scheduling, widget, colour schemes, non-daily periodicity — a list of leads, not a ranked backlog",
  "absent", "praise", "12 (17.14%) mean 3.42, 7 of 12 at 4–5★; " + table("## 3.3 Unmet needs"), "research", "counts", "yes",
  ["1157833711","1265490751","1002707223","1026996445","1054073250","1056568978","1174519073","1190931941","1195162150","1367475729","1407746285","7082831771"])
c(22, "§3.3 Two are worth more than their counts — non-daily periodicity is a structural limit of the data model; per-day alarm scheduling (weekday vs weekend)", "feature",
  "Two requests are worth more than their counts because both point at the same structural gap — the scheduling model is too rigid for real routines: 'Could the period be changeable rather than limited to daily only? There are habits I want to track over the long term' (the app's most recent substantive feedback; a strictly daily grid cannot represent '3× a week') and 'I have very different life style between weekdays and weekend. So I need more alarm setting properties'",
  "daily-only grid; one alarm schedule for all days", "complaint", "n=1 each (1.43%), both 4★", "must-have", "n=1 each, structural", "yes",
  ["7082831771","1190931941"])
c(23, "§3.4 Competitive position — the reason people picked this app was simplicity and reliability of the basics, not features", "positioning",
  "Competitive position is unusually favourable — 'Tried a lot like these apps but this one is the best by far'; named rivals: Way of Life cited negatively for nag behaviour, Balanced cited as a UI and feature benchmark to copy; named differentiators: offline check-in and editing previous days; the reason people picked it was simplicity and reliability of the basics, not features — precisely the position crashes and data loss destroy",
  "simple, reliable basics; offline; backdating", "purchase-driver", "8 (11.43%) compare against rivals, mean 4.75, 5 rank it first", "product-rule", "high-priority (counts)", "yes",
  ["978448437","1099557740","1222427563","1195988013","1208386132","1056568978","1184550500","1262227277"])

# ---- PART 4 ----
c(24, "§4.1 5★ — two distinct groups; substantive praise; low-information; two 5★ reviews are not endorsements of the current product", "insight",
  "5★ splits into substantive praise (accountability — 'the most important part of forming a new habit or breaking an old one is a sense of accountability') and low-information one-liners (35% of 5★); two 5★ reviews are relief not delight — praising the removal of pop-ups and a bug fix ('The problem in 1.4.2 where recorded Habits became inaccessible has been fixed')",
  "n/a", "praise", "5★ 34 (48.57%): substantive 22, low-info 12 (35.29% of 5★)", "none", "band analysis", "yes",
  ["1092091026","1135523217","1147730742","1210295810","1169580369","1229822768","1015124612","1081962130","1193853972","1197160923","1054073250"])
c(25, "§4.1 4★ — where the corpus is most informative; at least 5 of 16 four-star reviews would plausibly have been 5★ if a prompt had been silenced or a button had worked", "insight",
  "The 4★ band is 'good product, one specific problem': 3 of 16 docked specifically for nag prompts, 2 are blocked buyers, 4 are feature requests wrapped in praise — at least 5 of 16 would plausibly have been 5★ if a prompt had been silenced or a button had worked",
  "n/a", "complaint", "4★ 16 (22.86%): nag-docked 3 (18.75% of 4★); blocked buyers 2 (12.50%); requests 4 (25.00%); 5 of 16 (31.25%) recoverable", "dont", "band analysis", "yes",
  ["1113922936","1115315804","1126869931","5929885128","6183382407","1056568978","1190931941","1407746285","7082831771","1262227277","1118980626","1133763832","1128016301","1137963077","1318342739","7929736347"])
c(26, "§4.1 3★ — mixed or blocked, never hostile; a placeholder rating withheld over language", "insight",
  "3★ is mixed or blocked, never hostile: crashes from first launch rated 3 not 1; the clearest dated-UI signal ('the interface should have a look more modern and neater'); a Russian user explicitly withholding a real rating over language ('I can't rate it') — a placeholder, not a judgement",
  "n/a", "mixed", "3★ 5 (7.14%)", "none", "band analysis", "yes",
  ["961881835","1138108331","1157833711","1367475729","1122529516"])
c(27, "§4.1 2★ — nag prompts are the single largest cause; the corpus's cleanest self-inflicted wounds", "dont",
  "Nag prompts are the single largest cause of 2★ reviews — half of them — and all three explicitly say the app itself is good ('The app works great', 'Decent app'): the corpus's cleanest self-inflicted wounds, three 2★ ratings from users who liked the product",
  "rating/upsell nags", "1★-burst", "3 of 6 2★ (50.00%); other 2★: date bug, undisclosed IAP, no Russian", "dont", "band analysis", "yes",
  ["1099032136","1130477064","1133797353","1077393973","1374720328","1265490751"])
c(28, "§4.1 1★ table (verbatim); reliability, not pricing, is what produced this app's worst ratings", "insight",
  "7 of 9 one-star reviews are reliability or data-integrity failures and only 2 concern money or scope — reliability, not pricing, produced this app's worst ratings, a materially different profile from paywall-driven habit apps in this dataset",
  "n/a", "1★-burst", "1★ 9 (12.86%); reliability/data 7 (77.78% of 1★, 10.00% of all); " + table("### 1★ — 9 reviews"), "must-never-break", "band analysis", "yes",
  ["1195475837","1194862743","6678082433","6684084592","1176859130","1241930865","1174519073","1026996445","1202765053"])
c(29, "§4.2 Themes that appear on both sides of the rating line table (verbatim); the interface split — clean in 2014 reads dated by 2021", "contradiction",
  "Three themes cross the rating line: nag prompts (praised when removed, docked when present), the free tier (try-before-buy is 'the point' vs the 3-habit cap), and the interface — praise clusters in 2014–15 while 'dated' appears from Jan 2015; a visual language that reads as clean in 2014 does not in 2021, and the last visual update predates most remaining users' phones",
  "n/a", "mixed", table("## 4.2 Themes that appear on both sides"), "do", "counts", "yes",
  ["1193853972","1208386132","1130585398","1128016301","1184550500","961128068","1195988013","7929736347","1138108331","1174519073","1262227277"])

with open("Tools/prd_ledger/14/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
