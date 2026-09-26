import json, re
R = 5
rep = open("App Store Reports/5. Routine Planner, Habit Tracker - Daily Time Management for ADHD (REPORT).md").read().split("\n")
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
c(35, "Part 2 5★ table (verbatim)", "insight", "What produces 5★ (n=2,074): simple/clean/cute design 15.9%, ADHD fit 14.7%, life change 13.1%, timer+ETA 7.5%, any reliability defect (still 5★) 9.4%, any monetization 11.1%; 305 reviews (9.13%, mean 4.82, 2.0% 1–2★) are unqualified life-change endorsements — the rating engine",
  "n/a", "5★-burst", table(264, 271), "none", "high-priority", "yes", [])
c(36, "Part 2 1★ table (verbatim)", "insight", "The 1★ band is money + total failure: any monetization 37.9%, any reliability 33.4%, subscription objection 16.4%, billing integrity 16.1%, crash/won't open 12.3%, refund 9.5%, trial charged 7.3%, confirmed payer 7.3%",
  "n/a", "1★-burst", table(277, 286), "none", "high-priority", "yes", [])
c(37, "Part 2 2–3★ table (verbatim) + bold", "insight", "The recoverable band: reliability 50.3% of 2★ / 37.2% of 3★; crash 12.3%/8.3%; battery drain 9.8%/5.1%; data loss 8.0%/5.1%; Watch 6.7%/6.5%; notifications not firing 6.1%/6.1%; free routine cap 6.1%/11.2%; bad translation 4.3%/1.8%; ADHD user 8.0%/13.4% — 788 reviews (23.58%) sit in the 3–4★ band, where six themes over-index vs global: free cap (9.8% vs 5.03%), widget gaps (5.5% vs 2.75%), Watch (6.0% vs 3.26%), notifications-not-firing (4.9% vs 2.96%), bug reports (5.7% vs 3.71%), untimed-checklist requests (3.3% vs 2.06%) — 'the specific price of the missing 0.5 stars'",
  "n/a", "complaint", table(292, 303), "none", "high-priority", "yes", [])

# ---- PART 3 ----
c(38, "Part 3 §1", "insight", "Design and simplicity — 458 (13.70%, mean 4.48): minimal, clean, intuitive, cute, NOT overwhelming — for an ADHD-targeted product this is a functional claim, not an aesthetic one",
  "minimal, calm UI", "praise", "458 (13.70%), mean 4.48", "product-rule", "high-priority", "yes",
  ["8357131715","7929555373","5703729632","7776908865","9080607016","7512377032","12689118359","12710625570","13116003380"],
  side="'not overwhelming' is the design requirement for a neurodivergent audience")
c(39, "Part 3 §2", "insight", "The ADHD mechanism reviewers name is always the same: removal of decision load, not motivation — 'This app doesn't orient itself around should but is'; 'I just need to decide to start the routine, the rest is decided'",
  "sequential, pre-decided routine", "praise", "431 (12.90%), mean 4.47", "product-rule", "high-priority", "yes", ["12118266764","14371526010"],
  side="for ADHD users the product is a decision-remover, not a motivator — motivational copy and streak pressure are the wrong lever")
c(40, "Part 3 §3", "insight", "Life change / strong endorsement — 305 (9.13%), mean 4.82 — '人生変わった' (my life changed)",
  "n/a", "praise", "305 (9.13%), mean 4.82", "none", "high-priority", "yes", ["14168412445","13782913025","12842116546","12490763542","14497946151","13259393688"])
c(41, "Part 3 §4", "feature", "Timer, countdown and live ETA — 277 (8.29%), mean 4.16 — the lower mean is because the theme also appears in complaints about the timer being MANDATORY (§4.6)",
  "timer always on", "mixed", "277 (8.29%), mean 4.16", "must-have", "high-priority", "yes", [])
c(42, "Part 3 §6", "feature", "Streaks, plants and gamification — 80 (2.39%, mean 4.44): the plant → tree → forest badge system lands — 'when I see that plant turn into a tree, I wanna keep going'; '215 jours… je compte bien devenir une forêt'; streak-restore tickets praised",
  "plant-growth streak badges; streak savers", "praise", "80 (2.39%), mean 4.44", "build-free", "meaningful", "yes",
  ["12268271071","13126347470","13459034679","12842116546","9326484636","12359093778"],
  cond="a growth metaphor (plant→forest) works as a streak visual; streak-restore tickets are liked until ad-gated (R05-019)")
c(43, "Part 3 §7", "monetization", "The free tier is generous — 68 reviews (2.03%, mean 4.54) say so with NO offsetting complaint (a deliberately conservative floor): 'Its free, unless you need a third routine'; 'the free version is sufficient and not a scam'",
  "2 routines + full timer free", "praise", "68 (2.03%), mean 4.54", "product-rule", "meaningful", "yes",
  ["11640510418","9914706305","6389137165","7696360486","13939498558","14349836021"])
c(44, "Part 3 §8", "tactic", "Developer responsiveness — 37 (1.11%, mean 4.14): the founder/CEO personally answers email ('a very thoughtful email from the CEO completely addressing my concerns'); NINE reviews are visible star-upgrades after developer contact — a strong argument for treating review replies as a retention channel",
  "CEO answers support email; replies to reviews", "5★-burst", "37 (1.11%); 9 visible star-upgrades", "do", "meaningful", "yes",
  ["13641280121","12405974062","13718226517","12734597961","13661473607","14075143379","14061240049"])
c(45, "Part 3 §9", "feature", "Recommended / celebrity / community routines — 19 (0.57%, mean 4.37) — genuinely mixed: liked by some, 'the Dwayne Johnson and Kim Kardashian routine examples are cringey' to others",
  "celebrity routine templates", "mixed", "19 (0.57%), mean 4.37", "research", "weak, mixed", "yes",
  ["8619714804","12109193143","13951195485","11984464052","13094268733"],
  cond="templates from named celebrities polarise; community routines are safer")

with open("Tools/prd_ledger/5/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
