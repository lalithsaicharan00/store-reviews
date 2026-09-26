"""Habit count research: every review that states a number of habits (digits or words) next to 'habit(s)'. Full corpus."""
import json,re,collections,sys
sys.path.insert(0,"../today-top")
from screen import recs
W=r"(?:one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve|thirteen|fourteen|fifteen|sixteen|seventeen|eighteen|nineteen|twenty|thirty|forty|fifty|sixty|hundred|a\s+dozen|dozens?|a\s+couple|a\s+few|several|a\s+handful)"
N=rf"(?:\d{{1,3}}\s*\+?|{W})(?:\s*(?:-|–|to|or)\s*(?:\d{{1,3}}|{W}))?\s*\+?"
RX=re.compile(rf"\b{N}\s+(?:\w+[\s-]+){{0,2}}?(?:habits?|habbits?|habit\s+trackers?)\b",re.I)
if __name__=="__main__":
    out=open("cand/COUNT.jsonl","w"); c=collections.Counter()
    for store,folder,line,r,text in recs():
        if store=='native': continue
        ms=[m.group(0) for m in RX.finditer(text)]
        if ms:
            c[store]+=1
            out.write(json.dumps({"store":store,"folder":folder,"line":line,"rating":r.get("rating"),"date":(r.get("date") or "")[:10],"m":" | ".join(ms)[:200],"text":text},ensure_ascii=False)+"\n")
    print(dict(c))
