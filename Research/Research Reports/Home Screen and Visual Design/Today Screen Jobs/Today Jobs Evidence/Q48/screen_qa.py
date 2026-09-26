"""Q48: how many quit habits (counters) and how many anytime habits people keep. Habit + quit apps, App + Play."""
import json,re,collections,sys
sys.path.insert(0,"../today-top")
from screen import recs
X=re.I|re.X
W=r"(?:one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve|fifteen|twenty|thirty|a\s+couple(?:\s+of)?|a\s+few|several|a\s+handful(?:\s+of)?|a\s+dozen|dozens\s+of|multiple|many|lots\s+of)"
N=rf"(?:\d{{1,3}}\s*\+?|{W})(?:\s*(?:-|–|to|or)\s*(?:\d{{1,3}}|{W}))?"
F={}
F["Q1_COUNT"]=re.compile(rf"\b{N}\s+(?:\w+\s+){{0,2}}?(?:counters?|timers?|trackers?|addictions?|vices|bad\s+habits?|negative\s+habits?|habits?\s+(?:i.?m|i\s+am|to)\s+(?:quit\w*|break\w*|kick\w*|stop\w*|trying\s+to\s+(?:quit|break|kick|stop))|things?\s+(?:i.?m|i\s+am)\s+(?:quitting|giving\s+up|avoiding)|sobriety\s+\w+)\b",X)
F["Q2_QUITN"]=re.compile(rf"\b(?:quit|quitting|kick\w*|break\w*|stopp?\w*|given\s+up|give\s+up|sober\s+from|clean\s+from|abstain\w*\s+from)\s+(?:\w+\s+){{0,2}}?{N}\s+(?:\w+\s+){{0,1}}?(?:habits?|things|addictions?|vices|substances)\b",X)
F["A1_ANYN"]=re.compile(rf"\b{N}\s+(?:\w+\s+){{0,2}}?(?:any\s?time|all[\s-]day|untimed|flexible|whenever|unscheduled|no[\s-]time)\s+(?:habits?|tasks?|ones|goals?|items?)|\b(?:any\s?time|all[\s-]day)\s+(?:habits?|tasks?|section|list|tab)\b.{{0,40}}\b\d{{1,2}}\b|\b\d{{1,2}}\s+(?:of\s+(?:them|my\s+habits)|habits?)\s+(?:are|have)\s+(?:no\s+(?:set|specific)\s+time|any\s?time|all[\s-]day)",X)
F["A2_SPLIT"]=re.compile(rf"\b{N}\s+(?:habits?\s+)?(?:in\s+the\s+|for\s+the\s+|for\s+)?(?:morning|evening|night|afternoon)\b.{{0,80}}\b{N}\s+(?:\w+\s+){{0,2}}?(?:any\s?time|all[\s-]day|throughout\s+the\s+day|whenever|during\s+the\s+day|evening|night|afternoon)",X)
if __name__=="__main__":
    outs={k:open(f"cand/{k}.jsonl","w") for k in F}; hit=collections.Counter()
    for store,folder,line,r,text in recs():
        if store=='native': continue
        for k,rx in F.items():
            m=rx.search(text)
            if m: hit[k]+=1; outs[k].write(json.dumps({"store":store,"folder":folder,"line":line,"rating":r.get("rating"),"m":m.group(0)[:80],"text":text},ensure_ascii=False)+"\n")
    print(dict(hit))
