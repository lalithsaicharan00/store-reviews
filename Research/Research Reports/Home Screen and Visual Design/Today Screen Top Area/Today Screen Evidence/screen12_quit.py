"""Quit habits on Today: placement, what the counter shows, accidental reset, vocabulary."""
import json, re, sys, collections
sys.path.insert(0,'/Users/lalith/Desktop/store reviews/Research/Temp/today-top')
from screen import recs
from common import NONHABIT_PLAY
X=re.I|re.X
BAD=r'(?:bad|quit|negative|break|breaking|avoid|stop|addiction|vice)\s+habits?|quit(?:ting)?\s+(?:habits?|counters?|trackers?)|bad\s+ones|counters?'
F={}
F["QPLACE"]=re.compile(rf"""\b(?:separate|seperate|own|different|second|another)\s+(?:tab|list|page|section|screen|category)\b[^.!?]{{0,40}}\b(?:{BAD})\b|\b(?:{BAD})\b[^.!?]{{0,50}}\b(?:separate|seperate|same\s+(?:list|screen|page|place)|together|mixed|one\s+(?:list|place|screen)|alongside|next\s+to|main\s+(?:screen|page|list)|home\s+(?:screen|page)|today)\b""",X)
F["QSHOW"]=re.compile(r"""\b(?:hours?|minutes?|seconds?|time|days?)\s+(?:since|clean|sober|without|free)\b[^.!?]{0,60}\b(?:show|shows|display\w*|see|counter|widget|screen|list|format|units?)\b|\b(?:longest|best|record|personal\s+best|average)\s+(?:streak|time|run)\b|\bmoney\s+saved\b|\b(?:show|display)\w*\s+(?:in\s+)?(?:hours|minutes|seconds|weeks|months|years)\b""",X)
F["QRESET"]=re.compile(r"""\b(?:accidental(?:ly)?|by\s+(?:accident|mistake)|mistakenly)\b[^.!?]{0,50}\breset\w*\b|\breset\w*\b[^.!?]{0,50}\b(?:accidental(?:ly)?|by\s+(?:accident|mistake)|no\s+undo|can'?t\s+undo|cannot\s+undo|confirm\w*)\b""",X)
VOC={'relapse':r'\brelaps\w*','slip':r'\bslip(?:ped|s|\s+up)?\b','reset':r'\breset\w*','clean':r'\b(?:days?|time)\s+clean\b','sober':r'\bsober\w*','days since':r'\bdays?\s+since\b','time since':r'\btime\s+since\b','streak':r'\bstreak\w*'}
QUITCTX=re.compile(r'\b(?:quit\w*|sober\w*|relaps\w*|addict\w*|bad\s+habits?|smok\w*|vap\w*|alcohol|drink\w*|porn|nicotine|days\s+since|abstain\w*)\b',re.I)
if __name__=="__main__":
    outs={k:open(f"/Users/lalith/Desktop/store reviews/Research/Temp/today-top/cand/Q_{k}.jsonl","w") for k in F}; h={k:0 for k in F}
    v=collections.Counter(); VR={k:re.compile(x,re.I) for k,x in VOC.items()}; nq=0
    for store,folder,line,r,text in recs():
        if store=="native" or (store=="play" and folder.startswith(NONHABIT_PLAY)): continue
        for k,rx in F.items():
            m=rx.search(text)
            if m and (k!="QSHOW" or QUITCTX.search(text)): h[k]+=1; outs[k].write(json.dumps({"store":store,"folder":folder,"line":line,"rating":r.get("rating"),"m":m.group(0)[:70],"text":text},ensure_ascii=False)+"\n")
        if QUITCTX.search(text):
            nq+=1
            for k,rx in VR.items():
                if rx.search(text): v[k]+=1
    print(h); print('quit-context reviews',nq,dict(v)); json.dump({'n':nq,'vocab':v},open('quit_vocab.json','w'))
