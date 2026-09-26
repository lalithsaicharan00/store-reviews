"""Round-3 follow-up screen (habit apps): wording for 'today's habits', deleting/removing default sections, group order."""
import json, re, collections
from screen import recs
from common import NONHABIT_PLAY
X=re.I|re.X
F={}
F["DELSEC"]=re.compile(r"""\b(?:delete|remove|get\s+rid\s+of|hide|turn\s+off|disable)\s+(?:the\s+|a\s+)?(?:morning|afternoon|evening|night|anytime|all\s+day)\s*(?:section|routine|tab|category|time|part|block|period)?s?\b|\b(?:delete|remove|rename|add|edit|change)\s+(?:the\s+|a\s+)?(?:sections?|time\s+of\s+day|times\s+of\s+day|parts?\s+of\s+the\s+day|time\s+blocks?)\b""",X)
F["GRPORDER"]=re.compile(r"""\b(?:order|reorder|re-order|rearrange|sort|arrange|move)\w*\s+(?:the\s+|my\s+)?(?:categor(?:y|ies)|groups?|tags?|areas?|folders?|lists?)\b|\b(?:categor(?:y|ies)|groups?|tags?|areas?|folders?|lists?)\s+(?:are\s+)?(?:sorted|ordered|listed|arranged)\s+(?:alphabetically|randomly|by)|\balphabetical\w*\b[^.!?]{0,40}\b(?:categor|group|tag|area|folder|list)""",X)
PH={"today's habits":r"\btoday(?:'|’)?s\s+(?:habits|tasks|goals|list)\b","habits for today":r"\b(?:habits|tasks|goals)\s+for\s+today\b","habits due today":r"\b(?:habits|tasks|goals)\s+(?:that\s+are\s+)?due\s+today\b","scheduled today/for today":r"\bscheduled\s+(?:for\s+)?today\b","on today":r"\b(?:habits|tasks)\s+(?:on|in)\s+today\b"}
if __name__=="__main__":
    outs={k:open(f"cand/R3b_{k}.jsonl","w") for k in F}; h={k:0 for k in F}; ph=collections.Counter(); PR={k:re.compile(v,re.I) for k,v in PH.items()}
    for store,folder,line,r,text in recs():
        if store=="native" or (store=="play" and folder.startswith(NONHABIT_PLAY)): continue
        for k,rx in F.items():
            m=rx.search(text)
            if m:
                h[k]+=1; outs[k].write(json.dumps({"store":store,"folder":folder,"line":line,"review_id":r.get("review_id"),"rating":r.get("rating"),"date":(r.get("date") or "")[:10],"m":m.group(0)[:60],"text":text},ensure_ascii=False)+"\n")
        for k,rx in PR.items():
            if rx.search(text): ph[k]+=1
    print(h); print(dict(ph)); json.dump(ph,open('r3b_phrases.json','w'),indent=1)
