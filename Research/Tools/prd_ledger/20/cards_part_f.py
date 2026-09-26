"""Cards added from the blind-pass diff (report 20)."""
import json
R = 20
cards = []
def c(seq, where, kind, claim, does, react, mag, direction, conf, gen, ids, side="", cond=""):
    cards.append(dict(id=f"R{R:02d}-{seq:03d}", report=R, where=where, kind=kind, claim=claim,
        this_app_does=does, user_reaction=react, magnitude=mag, direction=direction,
        report_confidence=conf, generalisable=gen, side_effects=side, conditions=cond,
        review_ids=ids, canonical=[]))
c(110, "§2.1 'Extended'/rich notifications — paid", "feature",
  "Extended / rich notifications are a paid feature", "paid", "mixed", "2 inventory IDs; N-notifications 59 (1.46%, mean 3.07)", "paid", "inventory", "yes", ["4556013072","6924164885"])
c(111, "§2.1 Colour per habit (random by default) — 3 free / rest paid; §3.1 #31 N-colors", "feature",
  "Colour per habit is random by default with 3 colours free and the rest paid; colour requests run at 33 (0.82%, mean 3.76)", "3 free colours, rest paid", "complaint", "N-colors 33 (0.82%, emerging, mean 3.76)", "free", "emerging", "yes", ["3902556063","5915798121"])
c(112, "§2.1 Drag to reorder habits — free, buggy", "feature",
  "Drag-to-reorder is free but buggy", "free, buggy", "complaint", "2 inventory IDs", "free", "inventory", "yes", ["5085465606","6124395270"])
c(113, "§2.1 Cross-device sync — never shipped (84 mentions); §3.1 #16 N-sync-backup", "feature",
  "Cross-device sync never shipped in 92 months; sync/backup mentions run at 84 (2.08%) and spike to 9.9% of the data-wipe era", "absent", "complaint", "N-sync-backup 84 (2.08%, meaningful, mean 2.43); 9.9% of E4; 4★ band sync 15", "paid", "meaningful", "yes", [])
c(114, "§3.1 #34 N-crash; §7.8 crash trend not claimed — two dated incidents", "must-never-break",
  "Crashes are emerging (27, 0.67%, mean 2.52), clustered on two dated incidents — a Jun 2019 add-habit crash and a 20 Oct 2020 launch failure fixed next day", "two dated crash incidents", "complaint", "27 (0.67%, emerging, mean 2.52)", "must-never-break", "emerging", "yes", ["6557009066","6560591296"])
c(115, "§3.1 #46 N-checks-disappear; §3.5 broken: check marks disappearing", "must-never-break",
  "Check marks disappearing — a certainly-undercounted defect (more seen in reading than the classifier caught)", "check-off state lost", "complaint", "7 (0.17%, weak — undercounted), mean 2.14", "must-never-break", "weak (undercounted)", "yes", [])
with open("Tools/prd_ledger/20/cards.jsonl", "a") as f:
    for k in cards: f.write(json.dumps(k, ensure_ascii=False) + "\n")
print(len(cards), "cards appended")
