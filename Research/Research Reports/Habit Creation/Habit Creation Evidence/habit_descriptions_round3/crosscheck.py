"""crosscheck.py — checks the Round 3 New Habit design against every hand-coded habit description.

Run from Research/:  python3 "Research Reports/Habit Creation/Habit Creation Evidence/habit_descriptions_round3/crosscheck.py"
Reads Temp/mental-model/coded.jsonl (built by aggregate.py from the hand codes in codes/, dcodes/, rcodes/) and
x_themes.txt (hand sort of the ':x' statements). Writes crosscheck.csv next to this file and prints the tables used in
the report.

Two checks:
 1. Design fit. Each hand code (the way the person said it) maps to the rows it fills in the new form, with a verdict:
      Direct        their words fill How much and How often as said, nothing added
      Default       one thing they did not say is filled in for them (e.g. "run 5K" -> every day), shown and editable
      Partial       the design covers the main habit but not the extra they asked for (e.g. averages)
      Not covered   out of scope for this design (progression, rotations, recording a value)
 2. Parser. describe.py reads the raw review sentence; its How often family is compared with the hand code's family.
"""
import json, re, os, csv, collections, sys
here = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, here)
from describe import describe, family, render
CODE = re.compile(r"^(L|Q|N)?(Dn|Wn|Mn|Yn|W1|M1|Y1|D|W|M|Y|I|S|H|T|0|C|X)?(A)?(?::([trx]))?$")
exec(open(os.path.join(here, "families.py")).read().split("rows = ")[0])  # fam()

rows = [json.loads(l) for l in open("Temp/mental-model/coded.jsonl")]
xrows = [i for i, r in enumerate(rows) if any(c.endswith(":x") for c in r["codes"])]
themes = {}
for l in open(os.path.join(here, "x_themes.txt")):
    if l[:1].isdigit():
        p = l.split(); themes[xrows[int(p[0]) - 1]] = p[1:]
assert len(themes) == len(xrows) == 284, (len(themes), len(xrows))

THEME = {  # hand-sorted ':x' themes -> name, verdict in the new design, what covers it
 "X1": ("Log a goal in parts, a set step, or type it", "Direct", "+ adds the step written on it; tap the number to type; −"),
 "X2": ("Split time across sessions, pause the timer", "Direct", "▶ pauses and resumes; sessions add up; Add Time without the timer"),
 "X3": ("Start or end date, or a fixed length (for 30 days)", "Direct", "Ends: On a date · After a number of days"),
 "X4": ("Exceptions and rest days (every day except Sunday)", "Direct", "On certain days with 6 days reads 'Every day except Sun'"),
 "X5": ("A date in the month or year (the 15th, first Saturday, last day)", "Direct", "How often › On a date"),
 "X6": ("Counted from the last time I did it", "Partial", "Tasks keep 'Repeat after done'; habits keep fixed rhythms (Design Rules)"),
 "X7": ("Progression (add 5 each month)", "Not covered", "Change the amount; it applies from today"),
 "X8": ("Different on different days, rotations, cycles", "Not covered", "One habit per variant"),
 "X9": ("Either/or, tiers, baseline + stretch", "Not covered", "Name it 'Gym or run'"),
 "X10": ("Tolerance and averages (ok to miss twice a month)", "Partial", "'6 times a week' covers a rest day; averages are not a goal"),
 "X11": ("What counts in a period (twice on one day, rolling 7 days)", "Partial", "'3 times a week' counts each time, '3 days a week' counts days; rolling 7 days and 'N times in M days' not covered"),
 "X12": ("Recording a value (weight, wake-up time)", "Not covered", "Out of scope"),
 "X13": ("Spacing and windows (every 2 hours, 9 to 5)", "Direct", "When › Remind every N hours, from … to …"),
 "X15": ("Two rhythms in one (30 min on 5 days a week)", "Direct", "30 min each time · 5 times a week"),
 "X17": ("Doing more than the goal should count", "Direct", "Logging goes past the goal: 7 / 5 km"),
 "X18": ("Quit, but record how many on a slip", "Partial", "Cut down › Count, no target; Stop completely logs a slip, not a number"),
 "X20": ("Change the goal without rewriting past days", "Direct", "Edits apply from today (Round 2 rule)"),
 "X14": ("Other (bugs, units, stats, health sync)", None, "Not about how a habit is described"),
}
RANK = {"Direct": 0, "Default": 1, "Partial": 2, "Not covered": 3}
OFTEN = {"D": "Every day", "Dn": "N times a day", "W": "N times a week", "Wn": "N times a week", "W1": "Once a week", "S": "On certain days",
         "I": "Every few days / weeks / months", "M1": "Once a month or On a date", "Mn": "N times a month", "M": "N times a month",
         "Y1": "Once a year or On a date", "Yn": "N times a year", "Y": "N times a year", "H": "Every day + Remind every N hours",
         "T": "Every day + When", None: "Every day (not said)", "0": "Every day (not said)", "C": "?", "X": "?"}
TOTAL = {"D": "Every day (a day)", "W": "A week (in total)", "M": "A month (in total)", "Y": "A year (in total)", "W1": "A week (in total)",
         "M1": "A month (in total)", "Y1": "A year (in total)"}


AMT_FAM = ("F02", "F05", "F06", "F12", "F15")
def form(k, a):
    """What the form ends up showing: the How often option (with 'not said' filled in as Every day) and whether How much has an amount."""
    o = {"F01": "day", "F02": "day", "F17": "day", "F18": "day", "F16": "day", "F07": "week1", "F10": "month1", "F13": "year1"}.get(k[:3], k[:3])
    if k[:3] in ("F06",): o = "week-total"
    if k[:3] in ("F04", "F05"): o = "week-times"
    return o, bool(a)


def design(code, xs):
    d, f, a, s = CODE.match(code).groups()
    how_much = {"L": "At most <amount>", "Q": "Stop completely", "N": "Count, no target"}.get(d, "<amount>" if a else "Done or not")
    if a and f in ("Dn", "Wn", "Mn", "Yn", "S", "I", "H"): how_much += " each time"
    often = TOTAL.get(f, OFTEN.get(f)) if a and f in ("D", "W", "M", "Y", "W1", "M1", "Y1") else OFTEN.get(f, "?")
    if d == "Q" and f in (None, "0"): often = "—"
    v, why = "Direct", ""
    if f in ("H",): v, why = "Default", "reminder hours filled in (wake to bedtime)"
    if f == "T": v, why = "Default", "every day assumed"
    if f in (None, "0") and d not in ("Q", "N"): v, why = "Default", "every day assumed"
    if f in ("C", "X"): v, why = "Partial", "no rhythm"
    if s == "r": v, why = max(v, "Default", key=RANK.get), (why + "; " if why else "") + "range: goal is the lower number"
    if s == "x":
        tv = [THEME[t][1] for t in xs if THEME[t][1]]
        if tv:
            w = max(tv, key=RANK.get)
            if RANK[w] > RANK[v]: v = w
            why = (why + "; " if why else "") + ", ".join(t + " " + THEME[t][0] for t in xs if THEME[t][1])
    return how_much, often, v, why


out = csv.writer(open(os.path.join(here, "crosscheck.csv"), "w", newline=""))
out.writerow(["review_id", "store", "app", "rating", "date", "sentence", "hand_codes", "families", "x_themes", "design_rows", "verdict", "why",
              "parser_rows", "parser_family", "parser_agrees"])
V = collections.Counter(); VS = collections.Counter(); VF = collections.defaultdict(collections.Counter); TH = collections.Counter(); THs = collections.defaultdict(set)
agree = collections.Counter(); same_rows = collections.Counter(); conf = collections.Counter(); amt_ok = collections.Counter(); dir_ok = collections.Counter(); disagree = []
for i, r in enumerate(rows):
    xs = themes.get(i, [])
    for t in xs: TH[t] += 1; THs[t].add(r["id"])
    worst = "Direct"; rowsd = []; fams = []; whys = []
    for c in r["codes"]:
        hm, of, v, why = design(c, xs)
        k = fam(c)[1]; fams.append(k[:3])
        V[v] += 1; VF[k][v] += 1; rowsd.append(f"{hm} | {of}"); whys.append(why)
        if RANK[v] > RANK[worst]: worst = v
    VS[worst] += 1
    p = describe(r["s"]); pf = family(p); ok = ""
    if len(r["codes"]) == 1 and not r["codes"][0].endswith(":x"):
        c = r["codes"][0]; hk = fam(c)[1]; ok = pf == hk
        agree[ok] += 1; agree[("quote", ok)] += r["quote"]; conf[(hk[:3], pf[:3])] += 1
        same_rows[form(hk, "A" in c or hk[:3] in AMT_FAM) == form(pf, p["amount"] is not None or p["blank"])] += 1
        if not ok: disagree.append((hk[:3], pf[:3], r["id"], r["s"]))
        a = "A" in c; amt_ok[(a, p["amount"] is not None)] += 1
        hd = {"L": "at most", "Q": "stop", "N": "count"}.get(CODE.match(c).group(1), "do"); dir_ok[(hd, p["do"])] += 1
    out.writerow([r["id"], r["store"], r["app"], r["rating"], r["date"], r["s"], ",".join(r["codes"]), ",".join(fams), " ".join(xs),
                  " ; ".join(rowsd), worst, " ; ".join(w for w in whys if w), render(p), pf[:3], ok])

N = len(rows); I = sum(V.values())
print(f"statements {N}, habit instances {I}")
print("\nVerdict per habit instance:"); [print(f"  {k:12s} {V[k]:5d} {100*V[k]/I:5.1f}%") for k in RANK]
print("Verdict per statement (worst of its habits):"); [print(f"  {k:12s} {VS[k]:5d} {100*VS[k]/N:5.1f}%") for k in RANK]
print("\nBy family (instances): Direct / Default / Partial / Not covered")
for k in sorted(VF): print(f"  {k:42s} {VF[k]['Direct']:5d} {VF[k]['Default']:5d} {VF[k]['Partial']:4d} {VF[k]['Not covered']:4d}")
print("\n':x' themes (statements, distinct reviews):")
for t, n in TH.most_common(): print(f"  {t:4s} {n:4d} {len(THs[t]):4d}  {THEME[t][1] or '—':12s} {THEME[t][0]}")
n = agree[True] + agree[False]
print(f"\nParser vs hand code, single-habit statements without ':x': {n}; same How often family {agree[True]} ({100*agree[True]/n:.1f}%)")
q = agree[("quote", True)] + agree[("quote", False)]
print(f"  of these, the {q} marked quotable (plain, literal wording): same family {agree[('quote', True)]} ({100*agree[('quote', True)]/q:.1f}%)")
print(f"  same rows in the form once 'not said' is filled with Every day: {same_rows[True]} ({100*same_rows[True]/n:.1f}%)")
print("  amount found (hand has amount, parser found):", {f"{k}": v for k, v in amt_ok.items()})
print("  direction (hand, parser):", dict(dir_ok.most_common(12)))
print("  commonest disagreements (hand -> parser):", conf_most := [(k, v) for k, v in conf.most_common(40) if k[0] != k[1]][:12])
json.dump({"verdict_instances": V, "verdict_statements": VS, "agree": {str(k): v for k, v in agree.items()},
           "disagree_sample": disagree[::max(1, len(disagree) // 60)][:60]},
          open("Temp/mental-model/crosscheck_summary.json", "w"), ensure_ascii=False, indent=1)
