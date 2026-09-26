"""Round-2 screen: view-switching frequency, default view, strip value, filter/options vocabulary, group-filter frequency, date wording."""
import json, re
from screen import recs
from common import NONHABIT_PLAY
X=re.I|re.X
V=r"(?:daily|weekly|monthly|yearly|annual|day|week|month|year|calendar|list|grid|today|overview|stats?|history|heat\s?map)"
F={}
F["VIEWFREQ"]=re.compile(rf"""
 \b(?:only|always|mostly|mainly|usually|never|rarely|just)\s+(?:ever\s+)?(?:use|look\s+at|check|open|need|see)\s+(?:the\s+)?{V}\s+(?:view|tab|screen|page|mode)
|\b(?:default|starting|start[- ]?up|opening|landing|initial)\s+(?:view|screen|tab|page)
|\b(?:opens?|starts?|launch(?:es)?|load(?:s)?)\s+(?:up\s+)?(?:on|to|in|with)\s+(?:the\s+)?{V}\s+(?:view|tab|screen|page)
|\bremember(?:s|ing|ed)?\s+(?:the\s+|my\s+|which\s+)?(?:last\s+)?(?:selected\s+)?(?:view|tab|screen|page|filter|selection|category)
|\bswitch(?:ing|es)?\s+(?:back\s+and\s+forth\s+)?between\s+(?:the\s+)?(?:{V}|different|views|tabs)
|\b(?:toggle|toggling|flip|flipping|jump|jumping)\s+between\s+(?:the\s+)?(?:{V}|views|different)
|\b{V}\s+view\s+(?:is|was)\s+(?:all\s+)?(?:i|what\s+i)\s+(?:need|use|want)
""",X)
F["STRIPVAL"]=re.compile(r"""
 \b(?:week|weekly|7[- ]?day|seven[- ]?day|date|day)s?\s+(?:strip|bar|row|slider|scroller|selector|picker|carousel|line)\b
|\b(?:calendar|week|dates|days)\s+(?:at|on|across)\s+(?:the\s+)?top\b
|\btop\s+(?:bar|row|strip)\s+(?:of|with)\s+(?:the\s+)?(?:days|dates|week)
|\b(?:circles?|rings?|dots?)\s+(?:for|of)\s+(?:each|every)\s+day\b
""",X)
F["FILTVOCAB"]=re.compile(r"""
 \b(?:show|hide|hiding|showing)\s+(?:the\s+|all\s+)?(?:completed|finished|done|checked|archived|skipped|paused|inactive)\b
|\b(?:filter|sort|group|view|organi[sz]e)\s+(?:them\s+|habits\s+|tasks\s+|it\s+)?by\s+(?:category|categories|tag|tags|group|groups|area|areas|time|time\s+of\s+day|folder|list|type|priority|color|colour)
|\bonly\s+(?:show|see|display)\s+(?:the\s+)?(?:habits|tasks|ones|things|items)\s+(?:for|in|from|that|due|left|remaining|not)
|\b(?:what(?:'|’)?s|what\s+is)\s+left\b
""",X)
F["GROUPFREQ"]=re.compile(r"""
 \b(?:filter|filters|filtering|tab|tabs|chips?)\b[^.!?]{0,60}\b(?:every\s+time|each\s+time|constantly|always|all\s+the\s+time|annoying|tedious|never\s+use|rarely|don'?t\s+use)
|\b(?:every\s+time|each\s+time|constantly|always)\b[^.!?]{0,40}\b(?:switch|tap|select|choose|change)\w*\s+(?:the\s+|a\s+|between\s+)?(?:category|categories|tag|tags|group|groups|list|lists|filter|tab|area)
|\b(?:never|rarely|don'?t)\s+(?:really\s+)?use\s+(?:the\s+)?(?:categories|category|tags|groups|filters?|areas|lists)
|\b(?:use|love|like)\s+(?:the\s+)?(?:categories|category|tags|groups|filters?|areas)\s+(?:to|for)\s+(?:filter|focus|see|view|separate|organi[sz]e)
""",X)
F["DATEWORD"]=re.compile(r"""
 \b(?:this|current)\s+week\b[^.!?]{0,40}\b(?:last|past|previous)\s+7\s+days\b|\b(?:last|past|previous)\s+7\s+days\b[^.!?]{0,40}\b(?:this|current|calendar)\s+week\b
|\b(?:date\s+range|week\s+number|week\s+\d{1,2}\b|which\s+week|what\s+week|what\s+date|which\s+date|which\s+day\s+i(?:'|’)?m\s+(?:on|looking))
|\b(?:date|dates|month|year)\s+(?:at|on)\s+(?:the\s+)?top\b
""",X)
if __name__=="__main__":
    outs={k:open(f"cand/R2_{k}.jsonl","w") for k in F}; n=0; h={k:0 for k in F}; hn={k:0 for k in F}
    for store,folder,line,r,text in recs():
        nonhabit = store=="play" and folder.startswith(NONHABIT_PLAY)
        for k,rx in F.items():
            if k!="FILTVOCAB" and (store=="native" or nonhabit): continue
            m=rx.search(text)
            if m:
                h[k]+=1
                outs[k].write(json.dumps({"store":store,"folder":folder,"line":line,"review_id":r.get("review_id"),"rating":r.get("rating"),"date":(r.get("date") or "")[:10],"m":m.group(0)[:60],"text":text},ensure_ascii=False)+"\n")
    print(h)
