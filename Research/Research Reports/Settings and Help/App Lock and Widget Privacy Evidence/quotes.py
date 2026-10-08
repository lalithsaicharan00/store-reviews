import json, glob, html
rows = {json.loads(l)["n"]: json.loads(l) for l in open("read.jsonl")}
C = {}
for f in sorted(glob.glob("cls/b*.py")):
    ns = {}; exec(open(f).read(), ns); C.update(ns["C"])
picks = [65,81,148,1441,789,3104,73,132,120,133,242,244,2574,3508,2515,1728,841,842,922,759,1879,2040,2560,2067,749,19,21,419,60,839,59,736,828,1393,3215,3615,867,876,1365,762,232,3446,3622,88,878,888,2200,2927,668,2090,2101,2582,58,203,2529,115,134,1631,3343,2605,1771,2674,380,909,1373,769,1398,2206,766,767,3455,3546,2186,87,836,838,3792,663,703,745,98,122,3514,3507,3526,685,1415,3190,2474,2579,1726,1722,2385,158,554,1311,79,1454,3847,1354,1431,2714,752,96,151,490,209,1063,2223,2186]
out = []
for n in picks:
    r = rows[n]; v = C[n]; q = v[1] if isinstance(v, tuple) else ""
    app = r["app"].split(" - ")[0].split(":")[0]
    app = app.split(". ", 1)[1] if ". " in app else app
    out.append(f"{n}\t{app}\t{r['rating']}\t{r['review_id']}\t{r['store']}\t{q}")
open("quotes.tsv", "w").write("\n".join(out)); print("\n".join(out))
