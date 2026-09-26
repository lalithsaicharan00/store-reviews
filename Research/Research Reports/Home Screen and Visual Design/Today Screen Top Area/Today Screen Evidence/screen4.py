"""Fourth screen (habit apps only) for Q9 naming: 'Today' as a UI label, only-today complaints, tab naming."""
import json, re
from screen import recs
from common import NONHABIT_PLAY
X=re.I|re.X
F={}
F["TODAYLBL"]=re.compile(r"""["“”'‘’]today["“”'‘’]|\btoday\s+(?:tab|button|label|section|list|page|screen|view|header|title|menu)\b""",X)
F["ONLYTODAY"]=re.compile(r"""(?:only|just)\s+(?:be\s+able\s+to\s+)?(?:see|shows?|view|displays?|lists?)\s+(?:the\s+)?(?:habits?\s+(?:for\s+)?|tasks?\s+(?:for\s+)?)?(?:today|the\s+current\s+day|one\s+day)\b|stuck\s+(?:on|in)\s+today|beyond\s+today""",X)
F["TABNAME"]=re.compile(r"""(?:rename|name\s+of|called|labell?ed|the\s+label)\s+(?:the\s+|a\s+)?(?:\w+\s+)?(?:tab|screen|page)\b|\b(?:tab|screen|page)\s+(?:is\s+)?(?:called|named|labell?ed)\b""",X)
if __name__=="__main__":
    outs={k:open(f"cand/S4_{k}.jsonl","w") for k in F}; n=0; h={k:0 for k in F}
    for store,folder,line,r,text in recs():
        if store=="native" or (store=="play" and folder.startswith(NONHABIT_PLAY)): continue
        n+=1
        for k,rx in F.items():
            m=rx.search(text)
            if m:
                h[k]+=1
                outs[k].write(json.dumps({"store":store,"folder":folder,"line":line,"review_id":r.get("review_id"),"rating":r.get("rating"),"date":(r.get("date") or "")[:10],"m":m.group(0)[:60],"text":text},ensure_ascii=False)+"\n")
    print("habit reviews",n,h)
