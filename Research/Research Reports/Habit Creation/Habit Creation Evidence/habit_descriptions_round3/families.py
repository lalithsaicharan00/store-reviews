"""Group hand codes into the phrasing families used in the document; count instances and statements; pick example ids."""
import json, re, collections
CODE = re.compile(r"^(L|Q|N)?(Dn|Wn|Mn|Yn|W1|M1|Y1|D|W|M|Y|I|S|H|T|0|C|X)?(A)?(?::([trx]))?$")
def fam(c):
    d, f, a, s = CODE.match(c).groups()
    if f == "Wn" and a: return d or "B", "F05 an amount each time, N times a week", a, s
    if f in ("Mn", "Yn") and a: return d or "B", {"Mn": "F11 N times a month", "Yn": "F14 N times a year"}[f], a, s
    f = {"Wn": "W", "M": "Mn", "Y": "Yn", None: "0", "C": "X"}.get(f, f)
    if f in ("W", "Mn", "Yn") and a: f = {"W": "WA", "Mn": "MA", "Yn": "YA"}[f]; a = False  # coded WA = weekly total
    key = {"D": "F01 every day", "Dn": "F03 several times a day", "W": "F04 N times a week, any days", "WA": "F06 an amount per week",
           "W1": "F07 once a week / weekly", "S": "F08 on set weekdays", "I": "F09 every N days, weeks or months", "M1": "F10 once a month / monthly",
           "Mn": "F11 N times a month", "MA": "F12 an amount per month", "Y1": "F13 once a year / yearly", "Yn": "F14 N times a year",
           "YA": "F15 an amount per year", "H": "F16 every N hours", "T": "F17 time of day only", "0": "F18 an amount, no period", "X": "F19 other"}[f]
    if f == "D" and a: key = "F02 an amount per day"
    return d or "B", key, a, s
rows = [json.loads(l) for l in open("Temp/mental-model/coded.jsonl")]
inst = collections.Counter(); stm = collections.defaultdict(set); ex = collections.defaultdict(list); peramt = collections.Counter()
dirc = collections.defaultdict(set); suf = collections.defaultdict(set)
for i, r in enumerate(rows):
    for c in r["codes"]:
        d, k, a, s = fam(c)
        inst[k] += 1; stm[k].add(i)
        if a and k.startswith(("F03", "F05", "F11", "F14", "F16", "F08", "F09")): peramt[k] += 1
        if r["quote"] and len(ex[k]) < 400: ex[k].append(i)
        dirc[d].add(i)
        if s: suf[s].add(i)
json.dump({"inst": inst, "stm": {k: len(v) for k, v in stm.items()}, "peramt": peramt}, open("Temp/mental-model/families.json", "w"))
N = len(rows)
for k in sorted(inst): print(f"{k:40s} inst {inst[k]:5d} stm {len(stm[k]):5d} ({100*len(stm[k])/N:4.1f}%)  with per-time amount {peramt[k]}")
print({k: len(v) for k, v in dirc.items()}, {k: len(v) for k, v in suf.items()}, "N", N)
