"""show.py START END -> print candidates with match-window snippets for hand reading."""
import json,sys,re
src=open("screen.py").read().split("def recs")[0]; exec(src)
a,b=int(sys.argv[1]),int(sys.argv[2])
GEN=re.compile(r"(parts?|periods?|sections?|times?)\s+(of|in|for|throughout)\s+(the\s+|my\s+)?day|any\s*time\s+of\s+(the\s+)?day|times?\s+of\s+(the\s+)?day",re.I)
STRUCT=re.compile(r"(section|categor|group|sort|organi[sz]|split|divid|separat|block|segment|filter|\btabs?\b|list|morning|afternoon|evening|night|noon|routine|habit)",re.I)
AUTO=[]
for l in open("index.jsonl"):
    c=json.loads(l)
    if not a<=c["i"]<b: continue
    t=c["text"].replace("\n"," ")
    if c["fam"]==["TOD"] and not STRUCT.search(t) and all(GEN.fullmatch(m.group(0)) for m in F["TOD"].finditer(t)):
        AUTO.append(c["i"]); continue
    if len(t)>500:
        spans=[]
        for k in c["fam"]:
            for m in F[k].finditer(t): spans.append((max(0,m.start()-170),min(len(t),m.end()+170)))
        spans.sort(); merged=[]
        for s,e in spans:
            if merged and s<=merged[-1][1]: merged[-1]=(merged[-1][0],max(e,merged[-1][1]))
            else: merged.append((s,e))
        t=" … ".join(t[s:e] for s,e in merged[:3]) or t[:650]
    print(f'{c["i"]}|{c["folder"].split(".")[0]}{c["store"][0]}|{c["rating"]}|{"/".join(c["fam"])}| {t}')

if AUTO:
    open("autonoise.txt","a").write("\n".join(map(str,AUTO))+"\n")
    print("AUTO-NOISE (generic 'part/time of day', no structure words):",len(AUTO))
