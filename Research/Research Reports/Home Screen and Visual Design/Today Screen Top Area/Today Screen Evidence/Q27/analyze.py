"""Merge hand codes (codes/*.txt: cite<TAB>codes<TAB>note) with the samples, validate, write coding.jsonl and stats.json.
Note field = expectation (mental model); what went wrong/right; request, in short form."""
import json, glob, re, collections, os
os.chdir(os.path.dirname(os.path.abspath(__file__)))
cand = {}
for l in open("cand.jsonl"):
    c = json.loads(l); cand[c["cite"]] = c
S = {}
for l in open("sample.jsonl"):
    s = json.loads(l); assert s["cite"] not in S, ("dup", s["cite"]); S[s["cite"]] = s
NORM = {"FILT+": "F_USE+", "FILT": "F_WANT", "F_USE": "F_USE+"}
ORD = {"DRAG","CANT","HARD","RESET","TIME","DOING","DOING-","AZ","AZ-","REM","PRIO","PRIO-","DONEBOT","DONESTAY","UNDONETOP","NEWPOS","OTHERSORT","SORTOPT","PRAISE","WRONG","SUBITEM","FUTURE","SYNC","AUTO-","FIND","GRP","NOREM","REMMENTION"}
DIS = {"DFIND","DMISS","DPAY","DFIND_OK","DFIND_ACC","PRAISE_EDIT","LONGPRESS","F_CATEDIT"}
FIL = {"F_WANT","F_USE+","F_HIDE","F_HIDE-","F_BUG","F_FOCUS","F_NOTDUE","F_WIDGET","F_WEAK","F_COLLAPSE","F_ALLDAY","F_CATEDIT","HIDEDONE","HIDEDONE-","PAGES-","GROUPHDR"}
KNOWN = ORD | DIS | FIL | {"X","BUG","SEC","OBJ_GRP","OBJ_SEC","OBJ_HABIT","GROUPING","SECFORCED","SECCHANGE-","GD"}
codes = {}
for f in sorted(glob.glob("codes/*.txt")):
    for l in open(f):
        if not l.strip(): continue
        cite, cs, note = l.rstrip("\n").split("\t")
        assert cite not in codes, ("dup code", cite)
        cs = [NORM.get(x, x) for x in cs.split(",")]
        bad = [x for x in cs if x not in KNOWN]; assert not bad, (cite, bad)
        codes[cite] = (cs, note)
assert set(codes) == set(S), (set(S) ^ set(codes))
for c in S: assert c in cand and cand[c]["id"] == S[c]["id"]
out = []
for cite, s in S.items():
    cs, note = codes[cite]; c = cand[cite]
    themes = sorted({t for t, st in [("ORDER", ORD), ("DISC", DIS), ("FILTER", FIL)] if set(cs) & st})
    out.append({"cite": cite, "review_id": s["id"], "app": c["folder"], "store": c["store"], "tier": c["tier"], "rating": s["rating"],
                "date": s["date"], "drawn_for": s["drawn"], "relevant": cs != ["X"], "themes": themes, "codes": cs, "note": note})
with open("coding.jsonl", "w") as w:
    for r in out: w.write(json.dumps(r, ensure_ascii=False) + "\n")
REMTXT = re.compile(r"(remind|notif|alarm|lembrete|recordatorio|erinnerung|rappel|напомин|уведомл|通知|提醒|알림|リマインド)", re.I)
st = {"n_read": len(out), "by_draw": {}, "themes": {}}
for d in sorted({r["drawn_for"] for r in out}):
    rr = [r for r in out if r["drawn_for"] == d]
    st["by_draw"][d] = {"read": len(rr), "relevant_any": sum(r["relevant"] for r in rr),
                        "ratings": collections.Counter(str(r["rating"]) for r in rr)}
for t in ["ORDER", "DISC", "FILTER"]:
    rr = [r for r in out if t in r["themes"]]
    cnt = collections.Counter(x for r in rr for x in set(r["codes"]))
    st["themes"][t] = {"n": len(rr), "apps": len({r["app"] for r in rr}), "mean_rating": round(sum(r["rating"] for r in rr) / len(rr), 2),
                       "low_1_3": sum(r["rating"] <= 3 for r in rr), "codes": dict(cnt.most_common()),
                       "ids_by_code": {k: [r["cite"] for r in rr if k in r["codes"]] for k in cnt}}
# ORDER cross-tabs
O = [r for r in out if "ORDER" in r["themes"]]
def has(r, *k): return any(x in r["codes"] for x in k)
st["order_x"] = {
 "mentions_reminder_in_text": sum(bool(REMTXT.search(cand[r["cite"]]["text"])) for r in O),
 "drag_or_doing": sum(has(r, "DRAG", "DOING") for r in O),
 "time_or_rem": sum(has(r, "TIME", "REM") for r in O),
 "time_and_drag": sum(has(r, "TIME", "REM") and has(r, "DRAG", "DOING") for r in O),
 "time_only": sum(has(r, "TIME", "REM") and not has(r, "DRAG", "DOING") for r in O),
 "drag_no_reminder_text": sum(has(r, "DRAG", "DOING") and not REMTXT.search(cand[r["cite"]]["text"]) for r in O),
 "complaint_order_changes": sum(has(r, "RESET") for r in O),
 "cant_reorder": sum(has(r, "CANT") for r in O),
 "hard_or_buggy_reorder": sum(has(r, "HARD") for r in O),
 "praise": sum(has(r, "PRAISE") for r in O),
 "auto_neg": sum(has(r, "AUTO-", "AZ-", "PRIO-", "DONESTAY") for r in O),
 "sec_context": sum(has(r, "SEC") for r in O),
}
json.dump(st, open("stats.json", "w"), ensure_ascii=False, indent=1)
for t, v in st["themes"].items(): print(t, v["n"], "apps", v["apps"], "mean", v["mean_rating"], "1-3★", v["low_1_3"], v["codes"])
print(st["order_x"]); print(json.dumps(st["by_draw"]))
