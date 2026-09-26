"""Section headers: do people need the time shown for Morning/Afternoon/Evening? Confusion about when a part of day starts."""
import json, re, sys
sys.path.insert(0,'/Users/lalith/Desktop/store reviews/Temp/today-top')
from screen import recs
from common import NONHABIT_PLAY
X=re.I|re.X
PART=r'(?:morning|afternoon|evening|night|noon)'
F={}
F["WHENSTART"]=re.compile(rf"""\b(?:what|which)\s+time\s+(?:is|does|do)\b[^.!?]{{0,30}}\b{PART}\b|\bwhen\s+(?:does|do)\s+(?:the\s+)?{PART}\s+(?:start|begin|end)\b|\b{PART}\s+(?:starts?|begins?|ends?)\s+(?:at|too|so)\b|\b(?:define|set|change|customi[sz]e|adjust)\w*\s+(?:the\s+)?(?:times?|hours?)\s+(?:of|for)\s+(?:the\s+)?(?:{PART}|time\s+of\s+day|sections?)\b|\b{PART}\s+(?:is|was)\s+(?:set\s+)?(?:too\s+)?(?:early|late)\b""",X)
F["SECTIONWRONG"]=re.compile(rf"""\b(?:habits?|tasks?)\b[^.!?]{{0,40}}\b(?:show(?:s|ed|ing)?\s+up|appear\w*|moved?|jump\w*)\b[^.!?]{{0,30}}\b(?:in\s+the\s+)?(?:wrong\s+)?{PART}\b|\b{PART}\s+(?:section|habits?|tasks?)\b[^.!?]{{0,40}}\b(?:disappear\w*|vanish\w*|hidden|gone|until)\b""",X)
if __name__=="__main__":
    outs={k:open(f"/Users/lalith/Desktop/store reviews/Temp/today-top/cand/S_{k}.jsonl","w") for k in F}; h={k:0 for k in F}
    for store,folder,line,r,text in recs():
        if store=="native" or (store=="play" and folder.startswith(NONHABIT_PLAY)): continue
        for k,rx in F.items():
            m=rx.search(text)
            if m: h[k]+=1; outs[k].write(json.dumps({"store":store,"folder":folder,"line":line,"rating":r.get("rating"),"m":m.group(0)[:70],"text":text},ensure_ascii=False)+"\n")
    print(h)
