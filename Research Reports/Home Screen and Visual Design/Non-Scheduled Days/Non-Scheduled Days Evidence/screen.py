"""Full-corpus screen for how non-scheduled weekdays should appear (habit done only on some weekdays).
Writes every matched review to candidates.jsonl with the families it matched.
line = 1-based line number in the source reviews.jsonl.
Families:
  OFF  off-day / not-scheduled language (rest day, day off, not scheduled, days I don't have to...)
  SCH  specific-weekday scheduling (specific days, only on Mondays, Mon/Wed/Fri, X times a week...)
  DSP  display / consequence words (missed, streak, calendar, grey, hidden, percentage, shows...)
  PEN  explicit penalty phrases (counts as missed, breaks my streak, marked as failed, lowers my %)"""
import json, glob, re, collections, os
ROOT = "/Users/lalith/Desktop/store reviews"
D = r"(?:mon|tue|tues|wed|thu|thur|thurs|fri|sat|sun)(?:day)?s?"
F = {}
F["OFF"] = re.compile(r"""
 \b(?:rest|off|free|skip|non[\s-]?scheduled|unscheduled|non[\s-]?working|break|recovery|cheat|lazy|exempt|excused?)\s+days?\b
 | \bdays?\s+off\b | \bday\s+of\s+rest\b
 | not\s+(?:scheduled|due|planned|assigned|set)\s+(?:for|on|that|today|those|these)?
 | (?:isn.?t|aren.?t|wasn.?t|weren.?t|is\s+not|are\s+not)\s+(?:scheduled|due|planned|supposed|meant|required|needed)
 | days?\s+(?:that\s+)?(?:i|you|we)\s+(?:don.?t|do\s+not|didn.?t)\s+(?:need|have|plan|want|intend|do)
 | days?\s+(?:it|they|the\s+habit|a\s+habit|habits)\s+(?:is|are|isn.?t|aren.?t)\s+(?:not\s+)?(?:scheduled|due|set)
 | not\s+supposed\s+to\s+(?:do|be\s+doing|work\s*out|train|run|exercise)
 | ruhetag|freie[rn]?\s+tag|nicht\s+geplant|d[ií]as?\s+(?:de\s+)?descanso|d[ií]a\s+libre|jours?\s+de\s+(?:repos|pause|congé)|jour\s+off|dias?\s+de\s+(?:descanso|folga)|dia\s+livre|giorn[oi]\s+(?:di\s+)?riposo|dinlenme\s+g[üu]n|izin\s+g[üu]n|выходн|дн[ия]\s+отдыха|休みの日|休息日|休み|休日|쉬는\s*날|휴식일|휴일|rustdag|vrije\s+dag
""", re.I|re.X)
F["SCH"] = re.compile(r"""
 \b(?:specific|certain|particular|selected|select|chosen|choose|specified|individual|custom|set|given|designated)\s+(?:week\s*)?days\b
 | \b(?:only|just)\s+(?:on\s+)?(?:""" + D + r"""|weekdays|weekends|work\s*days|week\s*days)\b
 | \b""" + D + r"""\s*(?:,|and|&|/|\+|-)\s*""" + D + r"""\b
 | \bdays?\s+of\s+(?:the\s+)?week\b | \b(?:on\s+)?week\s*days?\s+only\b | \bweekdays?\b | \bweekends?\s+off\b
 | \bnot\s+(?:every\s*day|daily|everyday)\b | \bevery\s+other\s+day\b | \bnon[\s-]?daily\b
 | \b(?:\d|two|three|four|five|six|twice|once)\s+(?:times|days|x)\s+(?:a|per|each|every)\s+week\b | \b\d\s*x\s*(?:a|per)\s+week\b | \btimes\s+per\s+week\b | \bweekly\s+(?:goal|target|habit|frequency)s?\b
 | \bfrequency\b | \brepeat\s+(?:on|every)\b | \bschedul
 | bestimmte[n]?\s+(?:wochen)?tage|an\s+bestimmten\s+tagen|wochentag|mal\s+pro\s+woche|d[ií]as?\s+espec[ií]ficos|ciertos\s+d[ií]as|d[ií]as\s+de\s+la\s+semana|veces\s+(?:por|a\s+la)\s+semana|jours?\s+(?:sp[ée]cifiques|pr[ée]cis|de\s+la\s+semaine)|certains\s+jours|fois\s+par\s+semaine|dias\s+espec[ií]ficos|certos\s+dias|dias\s+da\s+semana|vezes\s+por\s+semana|giorni\s+(?:specifici|della\s+settimana)|alcuni\s+giorni|volte\s+a\s+settimana|belirli\s+g[üu]nler|haftan[ıi]n\s+g[üu]nleri|определ[её]нн\w*\s+дн|дни\s+недели|раз\s+в\s+неделю|曜日|特定の日|週に?\d回|星期几|指定日期|特定日期|每周\d次|每週|요일|주\s*\d회|특정\s*요일|bepaalde\s+dagen|dni\s+tygodnia|określone\s+dni
""", re.I|re.X)
F["DSP"] = re.compile(r"""
 \bmiss(?:ed|es|ing)?\b|\bfail(?:ed|s|ure|ing)?\b|\bred\b|\bx\b|\bcross(?:ed)?\b|\bgr[ae]y(?:ed)?\b|\bblank\b|\bempty\b|\bstreaks?\b|\bpercent|%|\brate\b|\bcalendar\b|\bhistory\b|\bchart|\bstat(?:s|istics)?\b|\bgraph|\bheat\s*map|\bgrid\b
 | \bshow(?:s|ed|n|ing)?\b|\bdisplay|\bhid(?:e|es|den|ing)\b|\bappear|\bvisib|\bclutter|\bincomplete\b|\bnot\s+done\b|\bunchecked\b|\bpenali|\bpunish|\bcount(?:s|ed|ing)?\b|\bbreak(?:s|ing)?\b|\bbroke(?:n)?\b|\breset|\bweek\s*view|\bmonth\s*view
 | verpasst|serie|kalender|ausgegraut|perdid|racha|calendario|gris|manqu|s[ée]rie|calendrier|perdido|sequ[êe]ncia|sequenza|seri|takvim|пропущ|серия|календар|серым|連続|カレンダー|未達成|グレー|连续|日历|日曆|灰色|未完成|연속|달력|회색|미완료
""", re.I|re.X)
F["PEN"] = re.compile(r"""
 (?:count|mark|show|register|record|log|flag|treat|consider|display)\w*\s+(?:it\s+|them\s+|that\s+|those\s+days\s+|the\s+day\s+)?as\s+(?:a\s+)?(?:missed|miss|failed|fail|failure|incomplete|not\s+done|undone|skipped|broken|red|zero|0%?)
 | (?:break|breaks|broke|broken|ruin|ruins|ruined|reset|resets|lose|lost|kill|kills|end|ends)\s+(?:my\s+|the\s+|your\s+)?streaks?
 | streaks?\s+(?:break|breaks|broke|broken|resets?|ends?|lost|gone|dies|goes\s+(?:back\s+)?to\s+(?:0|zero))
 | (?:count|counts|counted|counting|goes|go|went|held)\s+against
 | (?:lower|lowers|drops?|dragged?|drags|brings?|ruin|ruins|skew|skews|hurt|hurts|affects?)\s+(?:down\s+)?(?:my\s+|the\s+)?(?:percentage|%|score|rate|average|stats|success\s+rate|completion)
 | penali[sz]|punish
""", re.I|re.X)

def recs():
    for store, pat in [("app","App Store Reviews/*/reviews.jsonl"),("play","Play Store Reviews/*/reviews.jsonl"),("native","Native Store Reviews/*/reviews.jsonl")]:
        for f in sorted(glob.glob(os.path.join(ROOT, pat))):
            folder = f.split("/")[-2]
            for i,l in enumerate(open(f)):
                r = json.loads(l)
                text = ((r.get("title") or "") + " — " + (r.get("body") or r.get("text") or "")).strip(" —")
                yield store, folder, i+1, r, text

if __name__ == "__main__":
    tot = collections.Counter(); hit = collections.Counter()
    with open("candidates.jsonl","w") as out:
        for store, folder, line, r, text in recs():
            tot[store]+=1
            fams = [k for k,rx in F.items() if rx.search(text)]
            # keep only reviews that talk about scheduling/off days at all
            if not ({"OFF","SCH"} & set(fams)): continue
            for k in fams: hit[(store,k)]+=1
            out.write(json.dumps({"store":store,"folder":folder,"line":line,"review_id":r.get("review_id"),
                "rating":r.get("rating"),"date":(r.get("date") or "")[:10],"fams":fams,"text":text},ensure_ascii=False)+"\n")
    print("screened", dict(tot), sum(tot.values()))
    for k in F: print(k, {s:hit[(s,k)] for s in ("app","play","native")})
