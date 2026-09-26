"""Q43/Q44: untimed ('anytime') habits and quit-counter counts. Full-corpus pass."""
import json, re, collections, sys
sys.path.insert(0, "../today-top")
from screen import recs
X = re.I | re.X
F = {}
F["U1_UNTIMED"] = re.compile(r"""
 \bany\s?time\s+(?:of\s+(?:the\s+)?day|during\s+the\s+day|in\s+the\s+day|habits?|tasks?|section|category|list)
 | (?:habits?|tasks?|things|goals?)\s+(?:that\s+)?(?:(?:I|you|can|could)\s+)*(?:be\s+)?(?:do(?:ne)?|complete[d]?)\s+(?:at\s+)?any\s?time
 | \bwhenever\s+I\s+(?:can|want|have\s+(?:the\s+)?time|get\s+(?:the\s+)?(?:chance|time)|feel\s+like)
 | (?:no|not\s+a|without\s+a|don.?t\s+have\s+a|doesn.?t\s+have\s+a)\s+(?:specific|set|fixed|particular|exact)\s+time
 | not\s+(?:tied|bound|linked)\s+to\s+(?:a\s+)?(?:specific\s+)?(?:time|period|time\s+of\s+day)
 | all.?day\s+(?:habits?|tasks?|section|list|category|goals?)
 | \ball\s+day\b.{0,30}\b(?:morning|afternoon|evening)
 | (?:force[sd]?|have\s+to|must|required\s+to|make[s]?\s+(?:me|you))\s+(?:to\s+)?(?:set|pick|choose|assign|select)\s+(?:a\s+)?(?:time|time\s+of\s+(?:the\s+)?day|reminder\s+time)
 | throughout\s+the\s+day\s+(?:habits?|tasks?)
""", X)
F["Q_COUNT"] = re.compile(r"""
 (?:\b\d{1,2}\b|two|three|four|five|six|seven|eight|nine|ten|several|multiple|many|a\s+few|lots\s+of|a\s+bunch\s+of)\s+(?:different\s+)?(?:counters?|timers?|streaks?|addictions?|bad\s+habits|things\s+I.?m\s+(?:quitting|tracking)|vices|trackers?)
""", X)
QUIT=('3. Days Since','90. Quit','6. Streak Tracker','89.','I Am Sober','Quitzilla','Nomo','Quit')
if __name__=="__main__":
    outs={k:open(f"cand/{k}.jsonl","w") for k in F}; hit=collections.Counter()
    for store,folder,line,r,text in recs():
        for k,rx in F.items():
            m=rx.search(text)
            if not m: continue
            hit[k]+=1
            outs[k].write(json.dumps({"store":store,"folder":folder,"line":line,"rating":r.get("rating"),"m":m.group(0)[:60],"text":text},ensure_ascii=False)+"\n")
    print(dict(hit))
