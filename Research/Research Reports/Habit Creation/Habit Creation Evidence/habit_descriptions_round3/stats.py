import json, re, collections
CODE = re.compile(r"^(L|Q|N)?(Dn|Wn|Mn|Yn|W1|M1|Y1|D|W|M|Y|I|S|H|T|0|C|X)?(A)?(?::([trx]))?$")
FREQ = {"D":"Every day","Dn":"N times a day","W":"N times/days a week (any days)","Wn":"N times/days a week (any days)","W1":"Once a week / weekly",
        "M1":"Once a month / monthly","Mn":"N times a month","M":"N times a month","Y1":"Once a year / yearly","Yn":"N times a year","Y":"N times a year",
        "I":"Every N days/weeks/months","S":"On set weekdays / weekdays / weekends","H":"Every N hours","T":"Time of day only","0":"No frequency (amount only)",None:"No frequency (amount only)","C":"Other","X":"Other"}
rows = [json.loads(l) for l in open("Temp/mental-model/coded.jsonl")]
def parse(c):
    m = CODE.match(c); d, f, a, s = m.groups()
    return (d or "B", f, bool(a), s)
fc = collections.Counter(); fa = collections.Counter(); dirc = collections.Counter(); suf = collections.Counter(); per = collections.Counter()
for r in rows:
    for c in r["codes"]:
        d, f, a, s = parse(c)
        fc[FREQ[f]] += 1; dirc[d] += 1
        if s: suf[s] += 1
        if a:
            rel = "per time (with N times)" if f in ("Dn","Wn","Mn","Yn") else "no period" if f in ("0",None) else "total for the period"
            fa[(FREQ[f], rel)] += 1; per[rel] += 1
tot = sum(fc.values())
print("instances", tot)
for k, v in fc.most_common(): print(f"{v:5d} {100*v/tot:5.1f}%  {k}")
print("direction", dirc)
print("suffix", suf)
print("amount relation", per, "of", sum(per.values()))
for k, v in fa.most_common(): print(f"{v:5d}  {k}")
# per statement: has amount?
wa = sum(1 for r in rows if any(parse(c)[2] for c in r["codes"]))
print("statements with an amount", wa, "of", len(rows))
