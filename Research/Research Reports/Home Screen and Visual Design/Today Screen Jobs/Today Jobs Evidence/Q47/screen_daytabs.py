"""Q47: day parts shown as top tabs / filters, swiping between them, and seeing one part vs the whole day. Habit apps + Google Tasks (N6)."""
import json,re,collections,sys
sys.path.insert(0,"../today-top")
from screen import recs
X=re.I|re.X
PART=r"(?:morning|afternoon|evening|night(?:time)?|noon|midday|time[s]?\s+of\s+(?:the\s+)?day|any\s?time|all[\s-]day|day\s?parts?|parts?\s+of\s+the\s+day|periods?|morgen|abend|mañana|tarde|noche|matin|soir|manhã|朝|夜|昼)"
CTRL=r"(?:tabs?|tabbed|filters?|filtering|swip\w*|switch\w*|toggl\w*|slid\w*|pages?|segments?|chips?|buttons?\s+at\s+the\s+top|top\s+bar|header|carousel|scroll\w*\s+(?:left|right|sideways|horizontally))"
F={}
F["D1_PARTCTRL"]=re.compile(rf"\b{PART}\b.{{0,60}}\b{CTRL}|\b{CTRL}\b.{{0,60}}\b{PART}\b",X)
F["D2_ONLYPART"]=re.compile(rf"(?:only|just)\s+(?:shows?|see|display\w*|lists?)\s+(?:the\s+)?(?:current|this|one|a\s+single)\s+(?:time|part|period|section)|(?:can.?t|cannot|unable\s+to)\s+see\s+(?:all|the\s+whole|everything|other)\s+(?:my\s+)?(?:habits|tasks|sections|parts|day)|focus\w*\s+on\s+(?:the\s+)?(?:current|this)\s+(?:time|part|period)",X)
F["D3_SWIPELIST"]=re.compile(r"\bswip\w*\b.{0,40}\b(?:between|through|across|to\s+(?:the\s+)?next|left|right)\b.{0,40}\b(?:lists?|tabs?|sections?|categor\w+|groups?|pages?)\b|\b(?:lists?|tabs?|sections?|categor\w+|groups?)\b.{0,40}\bswip\w*",X)
F["D4_PARTHIDE"]=re.compile(rf"\b{PART}\b.{{0,60}}\b(?:hid\w*|disappear\w*|vanish\w*|gone|only\s+(?:see|show)\w*|can.?t\s+see|not\s+(?:see|show)\w*|out\s+of\s+sight)\b|\b(?:hid\w*|disappear\w*|can.?t\s+see)\b.{{0,40}}\b(?:until|when|once)\b.{{0,30}}\b{PART}\b",X)
if __name__=="__main__":
    outs={k:open(f"cand/{k}.jsonl","w") for k in F}; hit=collections.Counter()
    for store,folder,line,r,text in recs():
        if store=='native' and not folder.startswith('6. Google Tasks'): continue
        for k,rx in F.items():
            m=rx.search(text)
            if m: hit[k]+=1; outs[k].write(json.dumps({"store":store,"folder":folder,"line":line,"rating":r.get("rating"),"m":m.group(0)[:80],"text":text},ensure_ascii=False)+"\n")
    print(dict(hit))
