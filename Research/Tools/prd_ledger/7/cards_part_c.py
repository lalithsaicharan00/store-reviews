import json, re
R = 7
rep = open("App Store Reports/7. Habit Tracker - HabitKit - Streaks & Accountability (REPORT).md").read().split("\n")
def table(after, k=0):
    """k-th markdown table after the first line containing `after`, flattened."""
    i = next(n for n, l in enumerate(rep) if after in l)
    blocks, cur = [], []
    for l in rep[i+1:]:
        if l.startswith("|"): cur.append(l)
        elif cur:
            blocks.append(cur); cur = []
            if len(blocks) > k: break
        elif l.startswith("#") and blocks == [] and k == 0 and False: pass
    if cur: blocks.append(cur)
    rows = [l for l in blocks[k] if not re.match(r"^\|[\s\-:|]+\|$", l)]
    return " ; ".join(re.sub(r"\s*\|\s*", " | ", l.strip("|")).replace("**","").strip() for l in rows)
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))


# ---- PART 2 — RATING DRIVERS ----
c(52, "Part 2 5★ — n = 692 (78.46%) table (verbatim)", "data-caveat",
  "5★ themes: simplicity 43.6%, design 37.1%, developer 17.9%, tried-many 17.5%, widgets 9.5%, customization 9.0%, grid 8.5%, fair price 6.9%, life change 5.5%, one-time purchase 5.1%",
  "n/a", "5★-burst", table("## 5★ — n = 692"), "none", "verbatim", "app-specific", [])
c(53, "Part 2 5★ recipe; Part 3 #11 Life-changing", "insight",
  "The 5★ recipe is unusually consistent: 'I tried N other habit trackers, they were bloated, this one shows me a coloured grid, I stopped looking' — and everyone who says it changed their life or is their favourite app gives 5★",
  "n/a", "5★-burst", "Life-changing / best app 38 (4.31%), mean 5.00, 100% 5★", "do", "very strong", "yes", [])
c(54, "Part 2 5★ A 5★ here is not evidence the product is complete", "data-caveat",
  "A 5★ is not evidence the product is complete: 18 of the 692 five-star reviews still ask for sync and 2 are people whose Pro purchase is broken",
  "n/a", "none", "18 of 692 5★ want sync; 2 of 692 paid-but-broken", "none", "observed", "yes", ["12836329335","13398478371"])
c(55, "Part 2 4★ — n = 95 (10.77%) — the 'one missing thing' band table (verbatim)", "data-caveat",
  "4★ themes: wants sync 18.9%, design praise 38.9%, simplicity 25.3%, widget praise 13.7%, iPad 8.4%, weekly goals 8.4%, paywall 8.4%, Watch 6.3%, cap 6.3%",
  "n/a", "mixed", table("## 4★ — n = 95"), "none", "verbatim", "app-specific", [])
c(56, "Part 2 4★ Nearly one in five 4★ reviews would be a 5★ if sync existed", "insight",
  "Nearly one in five 4★ reviews would be a 5★ if sync existed, and several say so verbatim — 'I'll upgrade to 5 stars if I can sync across iCloud' — the cheapest star in the corpus",
  "no sync", "blocked-conversion", "18 of 95 4★ (18.9%)", "build-paid", "high-priority", "yes",
  ["12487171971","13594471502","13856682531"])
c(57, "Part 2 3★ — n = 35 (3.97%) — almost entirely sync + paywall table (verbatim)", "insight",
  "3★ is a feature-gap band, not a quality band: only 3 of 35 three-star reviews are about the app working badly; the rest are sync (31.4%), cap, iPad, paywall and widget paywall",
  "n/a", "complaint", table("## 3★ — n = 35") + " ; only 3 of 35 about the app working badly", "none", "verbatim", "app-specific", [])
c(58, "Part 2 2★ — n = 19 (2.15%) — the free cap's band", "insight",
  "2★ is the free cap's band: 8 of 19 name the habit cap, 6 more name sync or missing platforms; only one is about usability ('a bit complicated') and one about the redesign",
  "4-habit cap", "complaint", "2★ n = 19: cap 8 (42.1%); sync/platforms 6; usability 1; redesign 1", "build-free", "observed", "yes",
  ["13213024086","14447636722"])
c(59, "Part 2 1★ — n = 41 (4.65%) — money, then broken purchases, then everything else table (verbatim)", "data-caveat",
  "1★ causes: paywall/price/free cap 51.2%, paid but Pro doesn't work 9.8%, data loss / won't load 9.8%, missing platform or feature 9.8%, confusing 7.3%, redesign 4.9%, content-free 4.9%, wrong app 2.4% — more than half of all one-star reviews are a pricing-and-packaging decision",
  "n/a", "1★-burst", table("## 1★ — n = 41"), "none", "verbatim", "app-specific", [])

# ---- PART 3 — PRAISE ----
c(60, "Part 3 WHAT PEOPLE PRAISE (full table) (verbatim)", "data-caveat",
  "Nineteen praise themes with n, %, mean, 5★% and signal",
  "n/a", "praise", table("# PART 3"), "none", "verbatim", "app-specific", [])
c(61, "Part 3 #6 Customization; Part 4 #13 Wants more colours / icons; Part 6 #8; Part 9 #14", "feature",
  "More colours and a colour picker: customization is praised, but 21 preset colours (4 of them greys) break down past ~10 habits — a payer makes the operational case that habits become visually indistinguishable, which directly limits the value of Pro's unlimited habits",
  "21 preset colours, no picker", "complaint", "Customization praise 78 (8.84%), mean 4.72; wants more colours/icons 13 (1.47%), mean 4.38, 7.7% 1–2★", "undecided", "meaningful", "yes",
  ["13621381288"])
c(62, "Part 3 #8 Price is fair; #12 Free tier is generous", "monetization",
  "Price is fair and the free tier is generous, say a large set of satisfied users — the same packaging that angers the 5–8-habit user reads as good value to others",
  "4 free habits; lifetime ≈ $30", "praise", "Price is fair 51 (5.78%), mean 4.94, 94.1% 5★; free tier generous 25 (2.83%), mean 4.52, 80.0% 5★; paid cohort fair-price 15 of 51 (29.4%)", "none", "high-priority", "yes", [])
c(63, "§3.1 The grid is the product, and reviewers explain the mechanism unprompted; Part 3 #7", "feature",
  "The grid is the product and reviewers explain the behavioural loop unprompted: 'The addiction comes from wanting to paint the whole heatmap with your habit streak, and it works'; 'seeing the grid fill up is so satisfying you'll think twice about missing a single day'; 'Didn't know I needed a habit tracker with GitHub like heat map'",
  "GitHub-style year heat-map, free", "praise", "Grid / GitHub heat-map 73 (8.28%, HIGH-PRIORITY), mean 4.73, 80.8% 5★; high-spend 10.1% vs rest 5.6%", "must-have", "high-priority", "yes",
  ["11371105238","11237726788","10260406195","13116413283"])
c(64, "§3.1 the year-scale view specifically defuses failure; Part 3 #19; Part 9 #17", "insight",
  "The year-scale view defuses failure: users say it is the only tracker that does not induce anxiety when a streak breaks — 'this is the only one that doesn't give me so much anxiety and stress when I miss my streaks'; 'It doesn't guilt you'; 'Trusts you to own your goals'; 'you don't feel discouraged if you have been off track for one entire week' — a differentiator against the whole streak-shaming category, absent from the store listing",
  "months-scale grid, no shaming", "praise", "6 (0.68%); Non-judgmental / no guilt 6 (0.68%, EMERGING), mean 5.00, 100% 5★", "do", "emerging", "yes",
  ["12458258118","12949502025","11650437167","10260406195"])
c(65, "§3.2 ADHD is a small but perfect-scoring segment; Part 3 #13; Part 9 #17", "audience",
  "ADHD / autistic / executive-dysfunction users are a small but perfect-scoring segment — every one is 5★ ('die benutzerfreundlichste App die ich kenne') — yet the listing never mentions ADHD, while competitors in this set (apps 1 and 5) put it in the app title",
  "not marketed", "praise", "13 (1.47%), mean 5.00, 100% 5★; 0.70% (P1) → 0.43% → 2.60% → 1.52%", "do", "meaningful", "yes",
  ["12306236126","12639428322","12836092446","13220877574","13332990475","13461770688","13605202758","13666998704","13647254621"])
c(66, "§3.3 People use it for things that are not habits; Part 3 #15; Part 9 #18", "audience",
  "People use it for things that are not habits — migraines and medical incidents, supplements for themselves and their dog, art-project days, gym sessions, medication adherence, imported 2015-era JSON history, a bullet journal's digital twin: 'I love that it does not necessarily have to have a goal and you can use it to just track whatever you like' — a real, high-satisfaction, unmarketed segment (listing says only 'form new habits or break old ones')",
  "generic tracker by accident", "praise", "11 (1.25%), mean 4.91, 90.9% 5★", "do", "meaningful", "yes",
  ["10226902295","13149743389","13939554665","11915650641","13690973300","12471637696","10705970933","14440599892"])
c(67, "§3.4 Competitors reviewers name, and why they left them table (verbatim)", "data-caveat",
  "Named competitors and switching reasons — for HabitKit: Atoms, Habitify, Productive, Notion, Todoist; against: HabitMate, superhabit, HabitShare, Tiimo",
  "n/a", "mixed", table("## 3.4 Competitors"), "none", "verbatim", "app-specific",
  ["12134207623","13596249635","12025027893","11040398420","12015479550","12934585259","11713771657","10933253113","9901846846","13499288017"])
c(68, "§3.4 against HabitKit rows", "positioning",
  "Where HabitKit loses users to competitors: HabitMate 'does it too but with more features' (2★), superhabit has a calendar view HabitKit lacked, HabitShare has real accountability-partner features, and a user churned to Tiimo after data loss",
  "minimal feature set; no social; local-only", "churn", "4 reviews against (IT 2★, GB 4★, KR 4★, MX 1★)", "research", "limited", "yes",
  ["11713771657","10933253113","9901846846","13499288017"])
c(69, "Part 3 #14 Shortcuts / Siri / NFC automation; Part 5 quantified-self row; Part 6 #16", "feature",
  "Shortcuts / Siri / NFC automation serves a small, extremely loyal quantified-self segment — hotel key cards used as NFC triggers — who also ask for a read-only API, REST APIs and deep links",
  "Shortcuts free", "praise", "13 (1.47%, MEANINGFUL), mean 4.77, 84.6% 5★; Read-only API / deep links 3, mean 5.00", "undecided", "meaningful", "yes",
  ["13244460118","12336116396","14402619133","13650913780","12934585259","12108952662"])
c(70, "Part 3 #16 Reliability / no bugs; §4.5 Almost no crash reports", "insight",
  "Reliability is volunteered as praise — 'no bugs', 'never crashes' — and almost no crash reports exist",
  "stable", "praise", "Reliability / no bugs 8 (0.91%, EMERGING), mean 5.00, 100% 5★", "must-never-break", "emerging", "yes", [])
c(71, "Part 3 #18 Privacy / local data / no account; §4.5 No privacy or data-selling accusations at all", "insight",
  "The offline / no-account posture appears to have completely eliminated privacy and data-selling accusations — zero in a category where they are common — and some users praise local-only storage and even the absence of sync ('not based around some opaque cloudy AI nonsense')",
  "no account, local-only, no ads", "praise", "Privacy / local data / no account 7 (0.79%), mean 4.71; 0 privacy accusations", "do", "emerging", "yes",
  ["11241317063","13860278748","13177753546"])
c(72, "§4.5 privacy posture vs §0.5 sync gap and data loss; Part 9 #11 'Do it without breaking the privacy promise'", "contradiction",
  "No account and local-only storage cut both ways: they eliminate privacy complaints and are praised, and they cause the #1 product gap (no sync, 54) and the data-loss churn (5) — the report's resolution is sync shipped opt-in, end-to-end, on the CloudKit private database, with no account",
  "no account, local-only", "mixed", "0 privacy accusations; 7 privacy praise; 54 sync requests at 3.85; 5 data-loss at 2.20", "build-paid", "resolved by recommendation", "yes",
  ["11241317063","13499288017"],
  cond="contradicts 'account system from day one' (report 1) as the only fix: iCloud-based sync can deliver continuity without an account")

with open("Tools/prd_ledger/7/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
