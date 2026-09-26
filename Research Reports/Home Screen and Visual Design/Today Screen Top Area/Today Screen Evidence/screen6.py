"""Round-3 screen (habit apps): adding groups/sections, counts per group/section, empty groups, not-due access, day-start wording, what people call day sections, layout words."""
import json, re, collections
from screen import recs
from common import NONHABIT_PLAY
X=re.I|re.X
CAT=r"(?:categor(?:y|ies)|groups?|tags?|areas?|folders?|lists?|sections?)"
F={}
F["ADDGRP"]=re.compile(rf"""(?:how|where|can'?t|cannot|couldn'?t|unable|no\s+way|option)\s[^.!?]{{0,30}}\b(?:add|create|make|set\s+up)\s+(?:a\s+|my\s+own\s+|new\s+|custom\s+)*{CAT}\b|\b(?:add|create|new)\s+(?:a\s+)?(?:new\s+)?(?:custom\s+)?{CAT}\s+(?:button|option)""",X)
F["GRPCOUNT"]=re.compile(rf"""\b(?:number|count|how\s+many|total)\b[^.!?]{{0,30}}\b(?:habits|tasks|goals|items)\b[^.!?]{{0,20}}\b(?:in|per|each|for\s+each)\s+(?:a\s+|the\s+|each\s+)?{CAT}|\b{CAT}\s+(?:shows?|with)\s+(?:the\s+)?(?:number|count)""",X)
F["EMPTYGRP"]=re.compile(rf"""\b(?:empty|blank)\s+{CAT}|\b{CAT}\s+(?:is|are|shows?|stays?)\s+(?:still\s+)?(?:empty|blank)|\bno\s+(?:habits|tasks)\s+(?:in|for)\s+(?:the\s+|that\s+|this\s+)?{CAT}""",X)
F["NOTDUE"]=re.compile(r"""\b(?:habits|tasks|goals)\s+(?:that\s+(?:are|aren'?t)\s+|which\s+are\s+)?not\s+(?:due|scheduled|planned)\b|\b(?:see|view|show)\s+all\s+(?:of\s+)?(?:my\s+)?(?:habits|tasks|goals)\b|\ball\s+(?:my\s+)?habits\s+(?:list|page|screen|view)""",X)
F["DAYSTART"]=re.compile(r"""\b(?:start|beginning)\s+of\s+(?:the|my|a)\s+(?:new\s+)?day\b|\bday\s+(?:starts?|begins?|resets?|ends?|rolls?\s+over|changes?)\s+(?:at|after)\b|\b(?:end|start)\s+of\s+(?:the\s+)?day\s+(?:time|setting|hour)|\broll\s?over\b|\breset\s+time\b|\bnew\s+day\s+(?:starts?|begins?)\b|\bstart\s+day\s+at\b""",X)
F["LAYOUT"]=re.compile(r"""\b(?:list|grid|calendar|card|tile|compact|week(?:ly)?|month(?:ly)?)\s+(?:view|layout|mode)\b[^.!?]{0,60}\b(?:switch|toggle|choose|option|setting|button|change)|\b(?:switch|toggle|change)\s+(?:the\s+)?(?:view|layout)\b""",X)
if __name__=="__main__":
    outs={k:open(f"cand/R3_{k}.jsonl","w") for k in F}; h={k:0 for k in F}
    names=collections.Counter()
    NAMERX={'section':r'\bsections?\b','time of day':r'\btimes?\s+of\s+(?:the\s+)?day\b','part of the day':r'\bparts?\s+of\s+(?:the|my)\s+day\b','routine':r'\broutines?\b','block':r'\b(?:time\s+)?blocks?\b','period':r'\bperiods?\b','category':r'\bcategor(?:y|ies)\b','group':r'\bgroups?\b','tag':r'\btags?\b','area':r'\bareas?\b','folder':r'\bfolders?\b','list':r'\blists?\b'}
    NR={k:re.compile(v,re.I) for k,v in NAMERX.items()}
    MOE=re.compile(r'\bmorning\b',re.I);EVE=re.compile(r'\b(?:evening|night|afternoon)\b',re.I)
    ORG=re.compile(r'\b(?:organi[sz]e|sort|filter|group(?:ing)?|separate|categori[sz]e)\b',re.I)
    n=0;nm=0;no=0;orgc=collections.Counter()
    for store,folder,line,r,text in recs():
        if store=="native" or (store=="play" and folder.startswith(NONHABIT_PLAY)): continue
        n+=1
        for k,rx in F.items():
            m=rx.search(text)
            if m:
                h[k]+=1
                outs[k].write(json.dumps({"store":store,"folder":folder,"line":line,"review_id":r.get("review_id"),"rating":r.get("rating"),"date":(r.get("date") or "")[:10],"m":m.group(0)[:60],"text":text},ensure_ascii=False)+"\n")
        if MOE.search(text) and EVE.search(text):
            nm+=1
            for k,rx in NR.items():
                if rx.search(text): names[k]+=1
        if ORG.search(text):
            no+=1
            for k in ['category','group','tag','area','folder','list']:
                if NR[k].search(text): orgc[k]+=1
    print(n,h); print('reviews naming morning+afternoon/evening',nm,dict(names.most_common())); print('reviews about organising',no,dict(orgc.most_common()))
    json.dump({'morning_evening':nm,'names':names,'organising':no,'org_names':orgc},open('r3_names.json','w'),indent=1)
