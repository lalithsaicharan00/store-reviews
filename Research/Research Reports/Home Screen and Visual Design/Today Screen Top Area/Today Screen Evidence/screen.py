"""Full-corpus screen for the Today-screen top-area questions (see QUESTIONS.md).
One pass over every review (App Store, Play, Native). Writes cand/<FAMILY>.jsonl, one matched review per line.
line = 1-based line in the source reviews.jsonl. A review can land in several families.
Families are keyed by question: Q1 date/title/header, Q2 progress display, Q3 date strip / day navigation,
Q4/Q5 views + filters + clutter, Q6 now/time-of-day focus, Q7 density, Q8 editing sections / findability, Q9 naming."""
import json, glob, re, collections, os
ROOT = "/Users/lalith/Desktop/store reviews/Research"
X = re.I | re.X
F = {}
# ---- Q1 title row: date, day, time, header space
F["Q1_DATE"] = re.compile(r"""
 (?:show|shows|showing|display|displays|displaying|see|tell|know|shown|displayed)\s+(?:me\s+)?(?:the\s+|what\s+)?(?:current\s+|today.?s\s+)?(?:date|day\s+of\s+the\s+week|weekday|day\s+it\s+is)
 | what\s+(?:day|date)\s+it\s+is | which\s+(?:day|date)\s+(?:it\s+is|i.?m\s+(?:on|looking|viewing|checking)|am\s+i|is\s+(?:selected|shown))
 | (?:no|without\s+(?:a|the)|missing\s+(?:the\s+)?)\s+date\b | date\s+(?:at|on)\s+the\s+top | date\s+(?:is\s+)?(?:not\s+)?(?:shown|displayed|visible)
 | (?:wrong|different|previous)\s+day\s+by\s+(?:mistake|accident) | (?:accidentally|mistakenly|by\s+mistake)\s+(?:\w+\s+){0,3}(?:yesterday|previous\s+day|wrong\s+day|wrong\s+date|another\s+day|past\s+day)
 | thought\s+(?:it\s+was|i\s+was\s+on)\s+(?:today|the\s+current\s+day) | (?:didn.?t|did\s+not|don.?t|couldn.?t)\s+(?:realise|realize|notice|know)\s+(?:i\s+was\s+on|it\s+was\s+(?:on\s+)?)\s*(?:yesterday|a\s+different|another|the\s+wrong)
 | datum\s+(?:anzeigen|fehlt) | mostrar\s+(?:la\s+)?fecha | afficher\s+la\s+date | 日付(?:が|を)?(?:表示|わから)
""", X)
F["Q1_HEAD"] = re.compile(r"""
 \b(?:header|headline|title\s+bar|top\s+bar|nav(?:igation)?\s+bar|banner)\b.{0,60}\b(?:space|big|large|huge|too|waste|room|clutter|small|remove|hide)
 | (?:waste[sd]?|wasting|lot\s+of|too\s+much|unused|empty|white|dead)\s+(?:screen\s+)?space\s+(?:at|on)\s+the\s+top
 | top\s+of\s+the\s+(?:screen|page|app)\s+(?:is|takes|has|wastes|shows)
 | (?:big|huge|large|giant|massive)\s+(?:title|heading|header|banner|date|font\s+at\s+the\s+top)
 | (?:show|display|see)\s+the\s+(?:current\s+)?time\b | \bclock\s+(?:at|on)\s+the\s+top
 | today\s+(?:heading|header|title|label)
""", X)
# ---- Q2 progress display
F["Q2_PROG"] = re.compile(r"""
 progress\s+(?:ring|rings|circle|circles|bar|bars|wheel|indicator|meter|tracker|graph|chart|percentage|number|count|display)
 | (?:daily|today.?s|overall|total|day.?s)\s+(?:progress|completion|percentage|score)
 | (?:percentage|percent|%)\s+(?:of|for)\s+(?:the|today|each|my)\s+(?:day|habits|tasks)
 | how\s+many\s+(?:habits\s+|tasks\s+)?(?:i\s+have\s+)?(?:left|remaining|done|completed|i.?ve\s+done|to\s+go)
 | \b(?:\d+|x)\s*(?:/|out\s+of|of)\s*(?:\d+|y)\s+(?:habits|tasks|done|completed|complete)
 | (?:close|closing|fill|filling|complete)\s+(?:the|my|your)\s+(?:rings?|circles?)
 | (?:ring|circle)s?\s+(?:fill|fills|filling|closes|closing)
 | (?:rather|prefer|just|only|instead)\s+(?:see\s+)?(?:a\s+|the\s+)?(?:numbers?|percentage|fraction|count)
 | redundant|duplicat(?:e|ed)\s+(?:info|information|data)|same\s+information\s+twice|shown\s+twice
 | fortschritt(?:sbalken|sring|skreis)? | barra\s+de\s+progreso | progression\s+(?:du\s+jour|quotidienne) | 進捗 | 进度 | 진행률 | прогресс
""", X)
# ---- Q3 date strip / move between days
F["Q3_NAV"] = re.compile(r"""
 (?:swipe|scroll|go|navigate|move|switch|jump|flip|browse|look|toggle)\s+(?:back\s+|forward\s+|between\s+|through\s+|across\s+)?(?:to\s+)?(?:the\s+)?(?:previous|past|earlier|prior|other|different|next|future|older|yesterday|tomorrow|last\s+week|days|dates|weeks)
 | (?:edit|check|mark|log|tick|fill\s+in|update|change|complete|record|enter|add)\s+(?:\w+\s+){0,3}(?:for\s+|on\s+|in\s+)?(?:previous|past|yesterday|missed|prior|earlier|older|last\s+week.?s|forgotten)\s*(?:days?|dates?|entries|habits)?
 | retroactive|retro-?actively|backfill|back-?date|back\s+log|after\s+the\s+fact|missed\s+(?:a\s+)?(?:day|check.?in)\s+to\s+(?:log|record|mark)
 | (?:week|weekly|date|day|calendar)\s+(?:strip|bar|row|slider|picker|selector|scroller)
 | calendar\s+(?:at|on|across)\s+the\s+top | (?:days|dates)\s+(?:at|on|across)\s+the\s+top
 | (?:go|get|jump|return)\s+back\s+to\s+today | today\s+button
 | (?:can.?t|cannot|can\s+not|unable\s+to|no\s+way\s+to|not\s+able\s+to)\s+(?:go\s+back|see|view|check|edit|mark|access)\s+(?:to\s+)?(?:previous|past|yesterday|earlier|future|tomorrow|other)
 | (?:see|view|plan|show)\s+(?:the\s+)?(?:upcoming|future|tomorrow.?s|next\s+week.?s|coming)\s+(?:days|habits|week|schedule)
 | vorherige[nr]?\s+tag|vergangene\s+tage|d[ií]as?\s+anteriores|jours?\s+pr[ée]c[ée]dents|dias\s+anteriores|giorni\s+precedenti|前の日|過去の日|前日|以前的日期|过去的日子|이전\s*날|지난\s*날|предыдущ\w+\s+дн|прошл\w+\s+дн
""", X)
# ---- Q4/Q5 views, switcher, filters, clutter
F["Q45_VIEW"] = re.compile(r"""
 \b(?:week|weekly|month|monthly|year|yearly|annual|calendar|list|grid|table|day|daily|today)\s+view
 | (?:switch|switching|toggle|toggling|change|changing|swap)\s+(?:between\s+)?(?:the\s+)?(?:views?|layouts?|display|modes?)
 | (?:default|different|multiple|several)\s+views?\b | view\s+(?:options?|modes?|switch|toggle|button)
""", X)
F["Q45_FILT"] = re.compile(r"""
 filter(?:s|ed|ing)?\s+(?:by\s+)?(?:the\s+)?(?:categor|tags?|groups?|areas?|lists?|folders?|type)
 | (?:categor(?:y|ies)|tags?|groups?|areas?|folders?)\s+(?:tabs?|filters?|chips?|bar|buttons?|pills?|view)
 | (?:tabs?|chips?|pills?)\s+(?:for|of)\s+(?:categor|tags?|groups?|areas?)
 | (?:sort|organi[sz]e|group|separate)\s+(?:my\s+|the\s+)?habits\s+(?:by|into|in)\s+(?:categor|groups?|areas?|tags?|folders?)
""", X)
F["Q45_CLUT"] = re.compile(r"""
 \b(?:cluttered|clutter|too\s+busy|visually\s+busy|overwhelming|overloaded|too\s+many\s+(?:buttons|icons|options|tabs|menus|things\s+on)|crowded|cramped|noisy)\b
 | (?:less|more)\s+minimal | declutter | too\s+much\s+(?:going\s+on|on\s+(?:the|one)\s+screen|information|stuff)
""", X)
# ---- Q6 now / time of day focus
F["Q6_NOW"] = re.compile(r"""
 (?:only|just)\s+(?:show|see|display|shows)\s+(?:me\s+)?(?:the\s+)?(?:habits|tasks|what.?s|what\s+is|things)\s+(?:due|for|i\s+need)\s+(?:now|right\s+now|at\s+the\s+moment|this\s+(?:morning|afternoon|evening|time))
 | (?:current|this)\s+(?:time\s+of\s+(?:the\s+)?day|part\s+of\s+the\s+day|time\s+slot|period)
 | time\s+of\s+(?:the\s+)?day\s+(?:tabs?|sections?|view|filter|groups?)
 | (?:morning|afternoon|evening|night)\s+(?:tabs?|view|filter)\b
 | \bfocus\s+(?:mode|view)\b | \bright\s+now\s+(?:view|tab|list|section)
 | (?:hide|hides|hiding)\s+(?:the\s+)?(?:completed|finished|done|checked)\s+(?:habits|tasks|items|ones)
 | (?:completed|finished|done|checked)\s+(?:habits|tasks|items|ones)\s+(?:disappear|vanish|go\s+away|move\s+(?:to\s+the\s+)?(?:bottom|down)|stay|remain|clutter)
""", X)
# ---- Q7 density / layout
F["Q7_DENS"] = re.compile(r"""
 compact\s+(?:view|mode|list|layout|design|option)
 | (?:list|grid|card|cards|tile|tiles|table)\s+(?:view|layout|mode|format|style)
 | (?:bigger|smaller|larger|large|small|huge|giant|tiny)\s+(?:cards?|tiles?|rows?|buttons?|boxes|bubbles|circles|icons)
 | fit\s+more\s+(?:habits|on\s+(?:the|one)\s+screen|tasks|items) | (?:too\s+much|lots\s+of|a\s+lot\s+of|endless|constant)\s+scrolling
 | (?:see|fit|view)\s+(?:all\s+)?(?:my\s+)?(?:habits|tasks)\s+(?:on\s+one\s+(?:screen|page)|at\s+(?:a|one)\s+glance|without\s+scrolling)
""", X)
# ---- Q8 edit sections / findability of settings
F["Q8_EDIT"] = re.compile(r"""
 (?:edit|rename|customi[sz]e|change|add|remove|delete|reorder|rearrange|move|set)\s+(?:the\s+|my\s+|new\s+)?(?:times?\s+of\s+(?:the\s+)?day|sections?|morning\s+(?:and|/)\s+evening|categories|routines?\s+(?:times?|order)|day\s+start|start\s+of\s+(?:the|my)\s+day)
 | (?:where|how)\s+(?:do\s+i|to|can\s+i|do\s+you)\s+(?:edit|change|rename|reorder|rearrange|customi[sz]e|delete|find\s+the\s+setting)
 | (?:hidden|buried|tucked\s+away|hard\s+to\s+find|impossible\s+to\s+find|couldn.?t\s+find|can.?t\s+find|took\s+(?:me\s+)?(?:ages|forever|a\s+while)\s+to\s+find)\s+(?:in\s+(?:the\s+)?settings|the\s+(?:setting|option|button|edit))
 | edit\s+(?:mode|button) | long[\s-]?press | press\s+and\s+hold
 | (?:day|new\s+day)\s+(?:starts?|begins?|resets?|rolls?\s+over)\s+at | (?:day\s+start|end\s+of\s+(?:the\s+)?day)\s+(?:time|setting)
""", X)
# ---- Q9 naming of the main screen
F["Q9_NAME"] = re.compile(r"""
 \b(?:today|home|main|habits?|dashboard|journal|overview|daily|summary|my\s+day|agenda|feed|checklist|tracker)\s+(?:tab|screen|page|view)\b
 | \bmain\s+(?:list|menu)\b | \bdashboard\b
""", X)

def recs():
    for store, pat in [("app","App Store Reviews/*/reviews.jsonl"),("play","Play Store Reviews/*/reviews.jsonl"),("native","Native Store Reviews/*/reviews.jsonl")]:
        for f in sorted(glob.glob(os.path.join(ROOT, pat))):
            folder = f.split("/")[-2]
            for i,l in enumerate(open(f)):
                r = json.loads(l)
                text = ((r.get("title") or "") + " — " + (r.get("body") or r.get("text") or "")).strip(" —")
                yield store, folder, i+1, r, text

if __name__ == "__main__":
    os.makedirs("cand", exist_ok=True)
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
