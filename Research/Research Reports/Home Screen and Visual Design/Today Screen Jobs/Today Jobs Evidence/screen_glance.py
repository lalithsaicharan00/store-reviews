"""Q42 morning glance: what people want to see when they look at today's habits, and how lists scale with many habits.
Full-corpus pass (App Store, Play, Native). Writes cand/<FAM>.jsonl."""
import json, glob, re, collections, os, sys
sys.path.insert(0, "../today-top")
from screen import recs
X = re.I | re.X
F = {}
# G1: glance / overview of the day / what's on today
F["G1_GLANCE"] = re.compile(r"""
 at\s+a\s+(?:quick\s+)?glance | quick\s+(?:glance|look|overview|view) | glanceable
 | overview\s+of\s+(?:my|the|your|all|today|each)\s*(?:day|habits|tasks|routine|schedule|week)?
 | (?:see|know|shows?|tells?|view|check)\s+(?:me\s+)?(?:exactly\s+)?what\s+(?:i|you)\s+(?:have|need|must|still\s+(?:have|need))\s+to\s+do\s+(?:today|for\s+the\s+day|each\s+day|that\s+day)
 | what.?s\s+(?:on\s+)?(?:for\s+)?(?:today|my\s+(?:plate|agenda|schedule|day))
 | (?:see|view|check|look\s+at)\s+(?:my|the\s+whole|the\s+entire|my\s+whole|my\s+entire)\s+(?:day|schedule|routine)\s+(?:at\s+once|in\s+one|ahead|for\s+the\s+day)
 | (?:first\s+thing\s+in\s+the\s+morning|every\s+morning|each\s+morning|in\s+the\s+morning)\s+(?:i\s+)?(?:open|check|look|glance|see|plan)
 | plan\s+(?:out\s+)?my\s+day | (?:today|daily)\s+(?:summary|overview|agenda|briefing|dashboard)
 | auf\s+einen\s+blick | d.un\s+coup\s+d.œil | de\s+un\s+vistazo | num\s+relance | 一目で | 一目了然 | 한눈에 | с\s+первого\s+взгляда
""", X)
# G2: many habits / long list / scrolling / fitting on screen
F["G2_MANY"] = re.compile(r"""
 (?:lots\s+of|many|a\s+lot\s+of|too\s+many|so\s+many|dozens?\s+of|over\s+\d+|more\s+than\s+\d+|\b[1-9]\d)\s+(?:different\s+)?(?:daily\s+)?(?:habits|tasks|routines|items|trackers)\b.{0,80}\b(?:scroll|list|screen|overwhelm|see|fit|page|clutter|long|messy|find)
 | \b(?:scroll|scrolling|scrolled)\b.{0,50}\b(?:habits|list|tasks|down|through|forever|endless|all\s+the\s+way)
 | (?:long|endless|huge|massive|big)\s+list
 | (?:fit|see|show|view|display)s?\s+(?:all\s+)?(?:of\s+)?(?:my|the|your)?\s*(?:habits|tasks|items)\s+(?:on|in)\s+(?:one|a\s+single|the\s+same|1)\s+(?:screen|page|view)
 | (?:all|everything)\s+(?:of\s+my\s+habits\s+)?(?:on|in)\s+(?:one|a\s+single|1)\s+(?:screen|page|view)
 | without\s+(?:having\s+to\s+)?scroll | (?:no|less|more|too\s+much|lot\s+of)\s+scrolling
 | overwhelm(?:ed|ing)?\b.{0,60}\b(?:list|habits|tasks|screen|everything)
""", X)
# G3: collapse, hide done, show only what's left / next / now
F["G3_FOCUS"] = re.compile(r"""
 collaps(?:e|ed|ible|ing)\s+(?:the\s+)?(?:sections?|groups?|categor|lists?|folders?|habits?|completed|done)
 | (?:sections?|groups?|categor(?:y|ies)|lists?|folders?)\s+(?:that\s+)?(?:can\s+be\s+)?collaps
 | (?:hide|hides|hiding|hidden)\s+(?:the\s+)?(?:completed|finished|done|checked(?:\s+off)?)
 | (?:completed|finished|done|checked(?:\s+off)?)\s+(?:habits|tasks|items|ones)\s+(?:disappear|vanish|go\s+away|move|drop|sink|stay|remain|clutter|at\s+the\s+bottom)
 | (?:only|just)\s+(?:show|see|display|shows)\s+(?:me\s+)?(?:the\s+)?(?:habits|tasks|what|ones|things)\s+(?:that\s+)?(?:(?:are|is)\s+)?(?:left|remaining|due|i\s+(?:still\s+)?(?:need|have)|not\s+(?:yet\s+)?done|undone|for\s+today|scheduled)
 | (?:what|the\s+ones?|habits|tasks)\s+(?:i\s+have\s+)?(?:left|remaining)\s+(?:to\s+do\s+)?(?:today|for\s+the\s+day)
 | (?:next|upcoming)\s+(?:habit|task)\b | one\s+(?:habit|task|thing)\s+at\s+a\s+time
""", X)
# G4: summary number / how many today
F["G4_COUNT"] = re.compile(r"""
 how\s+many\s+(?:habits|tasks|things)\s+(?:i\s+have\s+)?(?:to\s+do\s+)?(?:today|for\s+today|left|remaining|due)
 | (?:number|count)\s+of\s+(?:habits|tasks)\s+(?:for\s+)?(?:today|due|left|remaining|to\s+do)
 | (?:badge|counter)\s+(?:on|with)\s+(?:the\s+)?(?:app\s+)?icon
""", X)
if __name__ == "__main__":
    outs = {k: open(f"cand/{k}.jsonl","w") for k in F}
    tot = collections.Counter(); hit = collections.Counter()
    for store, folder, line, r, text in recs():
        tot[store]+=1
        for k,rx in F.items():
            m = rx.search(text)
            if not m: continue
            hit[k]+=1
            outs[k].write(json.dumps({"store":store,"folder":folder,"line":line,"review_id":r.get("review_id"),
                "rating":r.get("rating"),"date":(r.get("date") or "")[:10],"m":m.group(0)[:60],"text":text},ensure_ascii=False)+"\n")
    print("screened", dict(tot), sum(tot.values()))
    for k in F: print(k, hit[k])
