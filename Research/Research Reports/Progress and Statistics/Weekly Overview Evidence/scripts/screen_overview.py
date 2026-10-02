"""Weekly overview card research (2 Oct 2026): pull every review already coded ALL/?ALL in the Progress evidence,
plus a fresh whole-corpus screen for the words people use about one combined number or a weekly summary."""
import json, glob, re, os, csv, collections
ROOT = "/home/user/store-reviews/Research"
ADJ_PLAY = {84,85,95,96,97,100,111,121,122,126,127,129,131}
P = re.compile(r"""
 perfect\s+(day|days|week|weeks) | (full|complete|completed|clean|100\s*%)\s+days?\b(?!\s+(free|trial)) | (all|every)\s+(of\s+)?(my\s+)?(habits|goals|tasks)\s+(were\s+|are\s+|is\s+)?(done|completed|complete|checked|finished|ticked|met|achieved)
 | \b\d+\s*(/|of|out\s+of)\s*\d+\s+(habits|goals) | how\s+many\s+(of\s+my\s+)?(habits|goals)\s+(i|i've|have|were|did|are)
 | on\s+track | weekly\s+(summary|recap|review|report|score|overview|progress|stat|stats|statistics|percentage|completion|rate|snapshot|dashboard|insight|chart|graph|total|view)
 | (overall|combined|aggregate|global|general|average|total)\s+(score|percentage|percent|rate|completion|progress|success|consistency|performance|stat|stats|statistics|overview|view|graph|chart)
 | (all|every)\s+(my\s+|of\s+my\s+|the\s+)?habits\s+(together|combined|at\s+once|in\s+one|at\s+a\s+glance|on\s+one)
 | (day|daily)\s+score | (week|weekly)\s+score | productivity\s+score | consistency\s+score | habit\s+score
 | (compare[ds]?|comparison|vs\.?|versus|better\s+than|worse\s+than)\s+(to\s+|with\s+)?(the\s+)?(last|previous|prior)\s+(week|month) | week[\s-]+(over|to|by)[\s-]+week | since\s+last\s+week
 | (most|least)\s+(consistent|successful|neglected|missed|skipped) | (weakest|strongest|worst|best)\s+habits? | (habits?|ones?)\s+(that\s+)?(need|needs|needing)\s+(more\s+)?(attention|improvement|work)
 | total\s+(time|hours|minutes)\s+(spent|invested|logged|tracked|on) | time\s+(spent|invested)\s+on\s+(my\s+)?habits
 | resumen\s+semanal | semana\s+perfecta | d[ií]as?\s+perfectos? | resumo\s+semanal | dias?\s+perfeitos? | bilan\s+(de\s+la\s+)?semaine | journ[ée]es?\s+parfaites? | wochen(übersicht|bilanz|statistik|auswertung|rückblick) | perfekte[rn]?\s+tag | riepilogo\s+settimanale | giorn[oi]\s+perfett
 | итог(и)?\s+недели | идеальн\w+\s+(день|дни|недел) | haftalık\s+(özet|istatistik) | mükemmel\s+gün
 | 全部完成 | 完美的一天 | 每周(总结|统计|报告) | 週間(レポート|まとめ|統計) | 全部達成 | 주간\s*(리포트|통계|요약) | 모두\s*완료
""", re.I|re.X)
def recs():
    for store, pat in [("app","App Store Reviews/*/reviews.jsonl"),("play","Play Store Reviews/*/reviews.jsonl")]:
        for f in sorted(glob.glob(os.path.join(ROOT, pat))):
            folder = f.split("/")[-2]; n = int(folder.split(".")[0])
            if store=="play" and n in ADJ_PLAY: continue
            for i,l in enumerate(open(f)):
                r = json.loads(l)
                text = ((r.get("title") or "") + " — " + (r.get("body") or r.get("text") or "")).strip()
                yield store, folder, i+1, r, text
coded = {}
for r in csv.DictReader(open(ROOT+"/Research Reports/Progress and Statistics/Progress Evidence/coded_reviews.tsv"), delimiter="\t"):
    codes = set(r["codes"].split(","))
    if codes & {"ALL","?ALL"}: coded[r["review_id"]] = r["codes"]
out = []; seen=set(); tot=0
for store, folder, line, r, text in recs():
    tot += 1
    rid = str(r["review_id"])
    why = []
    if rid in coded: why.append("prior:"+coded[rid])
    m = P.search(text)
    if m: why.append("new:"+m.group(0).strip()[:40])
    if why and rid not in seen:
        seen.add(rid)
        out.append({"id":rid,"store":store,"app":folder,"stars":r.get("rating"),"date":(r.get("date") or "")[:10],"why":why,"text":text})
print("reviews scanned", tot, "candidates", len(out), "prior ALL found", sum(1 for o in out if any(w.startswith("prior") for w in o["why"])), "of", len(coded))
with open("candidates.jsonl","w") as w:
    for i,o in enumerate(out): o["n"]=i; w.write(json.dumps(o,ensure_ascii=False)+"\n")
c=collections.Counter()
for o in out:
    for w in o["why"]:
        if w.startswith("new:"): c[w[4:].lower()[:18]]+=1
print(c.most_common(60))
