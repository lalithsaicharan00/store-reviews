import json, re
R = 6
rep = open("App Store Reports/6. Streak Tracker - StreakUp - Habit Builder & Breaker (REPORT).md").read().split("\n")
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


# ---- PART 3 — PRAISE ----
c(51, "Part 3 WHAT PEOPLE PRAISE (full table) (verbatim)", "data-caveat",
  "Praise themes (non-exclusive, n = 44; at this size a single review reads as 'Meaningful')",
  "n/a", "praise", table("# PART 3"), "none", "verbatim", "app-specific",
  ["13093308789","13390634274","13085620460","13767758923","14093501015","13672386764","14292633754","14271116952","14214912053","14456589309"])
c(52, "Part 3 Simplicity / ease row", "insight",
  "Simplicity is praised and conditional: 'Great if you want a simple streak app but only lets you have 2 streaks for free'; 'Super simple et super efficace'",
  "minimal streak counter", "praise", "Simplicity / ease 7 (15.91%), mean 4.57", "product-rule", "high band (n = 7)", "yes",
  ["13390634274","13466777630","13767758923","13795256017","14146487084","14271116952","14346310474"])
c(53, "Part 3 Explicit recommendation row", "insight",
  "Explicit recommendations come from outcome and widget reviewers — the same people who report behaviour change",
  "n/a", "praise", "Explicit recommendation 6 (13.64%), mean 4.83", "do", "high band (n = 6)", "yes",
  ["13093308789","13767758923","13795256017","13845360166","14093501015","14456589309"])

# ---- PART 4 — COMPLAINTS ----
c(54, "Part 4 COMPLAINTS AND UNMET NEEDS (full table) (verbatim)", "data-caveat",
  "Complaint themes (non-exclusive, n = 44): money themes dominate; the only functional gaps are multi-log per day and a mode choice users cannot see",
  "n/a", "complaint", table("# PART 4"), "none", "verbatim", "app-specific",
  ["13185604622","13531820409","13557096013","13628759209","13390634274","13771926913","13085620460","13939159292","14203637124","13994050917","14389534229","14214912053","14471219702"])
c(55, "Part 4 Widget cannot be added row; Part 9 #5", "must-never-break",
  "Investigate 'can't add widget': the widget is the most-loved feature, so it failing to install is disproportionately costly — reported inside a 5★ review",
  "widget install failure for at least one user", "complaint", "1 (2.27%), mean 5.00", "must-never-break", "weak (n = 1), high cost", "yes",
  ["14389534229"])
c(56, "Part 4 UI quality / customization lacking row; Part 6 More customization request", "feature",
  "Lack of customization and poor UI are the grounds on which a user says StreakUp loses to Days Since — 'horrible UI and lack of customizability' — even though no reviewer mentions the paid themes/icons",
  "custom themes & icons paid; UI judged poor by one user", "churn", "1 (2.27%), mean 1.00", "research", "weak (n = 1)", "yes",
  ["13557096013"],
  cond="tension with R06-034: customisation is absent from praise and from purchase talk, present only as a competitor comparison")
c(57, "§4.1 The one real feature gap: multiple logs per day; Part 4 Cannot log a task more than once per day and Friction rows; Part 6; §8.5 #4; Part 9 #12", "feature",
  "Support counting completions, not just days — 'twice a day', '3× per week': the one real feature gap, described from two angles ('Does NOT allow for multiple streaks for one task, within a day. I purchased the Pro Version in hopes it would have'; teeth-brushing twice a day: 'you have to log everyday, not necessarily when goal is accomplished daily'), persisting nine months",
  "one log per day per streak at every tier", "churn",
  "Cannot log a task more than once per day 2 (4.55%), mean 4.00; Friction: must log daily even when goal met 1 (2.27%), 4.00; Nov 2025 → Aug 2026, both from paying-intent users; one paid churn", "must-have", "thin (n = 2), weight raised by a paid churn", "yes",
  ["13390634274","14471219702"])
c(58, "§4.2 What is *not* in this corpus", "insight",
  "The pattern of absence is itself the finding: zero crash reports ('App never has any glitches and works perfectly!'), zero data-loss, zero sync/multi-device complaints, no notification failures, no support-contact complaints as such, no localization complaints despite six declared languages and four non-English reviews, no Apple Watch mentions — alongside dense monetization complaints",
  "local-only storage; no Watch; six languages", "praise", "0 crash; 0 data loss; 0 sync; 0 notification failure; 0 localisation; 0 Watch; Stability / no glitches 1 (2.27%), mean 4.00", "none", "absence (proves little at n = 44)", "yes",
  ["14214912053","14292633754"],
  side="sync may become a complaint if users ever expect it")
c(59, "§4.2 No data-loss reports — consistent with the listing's local-only storage claim", "contradiction",
  "Local-only storage produced zero data-loss and zero sync complaints in report 6 — against report 1, where local-only storage was the root cause of data loss (×10.6 among buyers)",
  "local-only storage, no account", "none", "0 of 44 data-loss or sync complaints", "research", "absence at n = 44", "unknown", [],
  cond="a 13-month-old app with 44 reviews — too young for phone-change and reinstall losses to accumulate; the report expects sync complaints if users come to expect sync")

with open("Tools/prd_ledger/6/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
