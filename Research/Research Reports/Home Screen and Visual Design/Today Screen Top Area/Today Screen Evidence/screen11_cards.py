"""Card round 3: App Store 1 (Habit Tracker, Inner Grow) fill-card mechanic; corpus-wide whole-row taps, icon tap targets."""
import json, re, sys
sys.path.insert(0,'/Users/lalith/Desktop/store reviews/Research/Temp/today-top')
from screen import recs
from common import NONHABIT_PLAY
X=re.I|re.X
F={}
# App Store 1 only: the fill / bar / swipe / drag / colour card mechanic
F["A1FILL"]=re.compile(r"""\b(?:fill(?:s|ed|ing)?|bar|bars|swip\w*|drag\w*|slid\w*|colou?r(?:s|ed|ful)?|card|cards|tap\w*|press\w*|hold)\b""",X)
# corpus: accidental taps / mis-taps on list rows
F["MISTAP"]=re.compile(r"""\b(?:accidental(?:ly)?|by\s+mistake|mistakenly|unintentional(?:ly)?|inadvertent(?:ly)?)\b[^.!?]{0,60}\b(?:tap\w*|check\w*|tick\w*|mark\w*|complet\w*|click\w*|press\w*|swip\w*|log\w*)\b|\b(?:tap\w*|check\w*|tick\w*|mark\w*|complet\w*|click\w*|press\w*|swip\w*)\b[^.!?]{0,40}\b(?:accidental(?:ly)?|by\s+mistake|by\s+accident)\b""",X)
# corpus: where to tap / tap target / button too small / not obvious tappable
F["TAPTARGET"]=re.compile(r"""\b(?:buttons?|check\s*(?:box|mark)e?s?|circles?|icons?|targets?)\b[^.!?]{0,30}\b(?:too\s+small|tiny|hard\s+to\s+(?:tap|hit|press|click)|small\s+to\s+(?:tap|press|click))\b|\b(?:didn'?t|did\s+not|don'?t|couldn'?t|could\s+not)\s+(?:know|realise|realize|figure\s+out)\b[^.!?]{0,30}\b(?:where|how)\s+to\s+(?:tap|click|press|check|mark|complete)\b|\bnot\s+(?:obvious|clear|intuitive)\b[^.!?]{0,30}\b(?:tap|click|press|button)\b""",X)
if __name__=="__main__":
    outs={k:open(f"/Users/lalith/Desktop/store reviews/Research/Temp/today-top/cand/C_{k}.jsonl","w") for k in F}; h={k:0 for k in F}
    for store,folder,line,r,text in recs():
        if store=="native" or (store=="play" and folder.startswith(NONHABIT_PLAY)): continue
        for k,rx in F.items():
            if k=="A1FILL" and not (store=="app" and folder.startswith("1. ")): continue
            m=rx.search(text)
            if m: h[k]+=1; outs[k].write(json.dumps({"store":store,"folder":folder,"line":line,"rating":r.get("rating"),"m":m.group(0)[:70],"text":text},ensure_ascii=False)+"\n")
    print(h)
