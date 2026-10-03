# Milestone scan (3 Oct 2026): which numbers people mark, how they want milestones shown, what they dislike.
import json, re, glob, collections, sys
ROOT='../..'
files=glob.glob(ROOT+'/App Store Reviews/*/reviews.jsonl')+glob.glob(ROOT+'/Play Store Reviews/*/reviews.jsonl')
KEY=re.compile(r'milestone|badge|trophy|trophies|achievement|award|medal|streak|in a row|consecutive|sober|clean for|clean since|smoke[- ]free|days? since', re.I)
MILE=re.compile(r'milestone|badge|trophy|trophies|achievement|award|medal', re.I)
NUM=re.compile(r'\b(\d{1,4})\s*[- ]?\s*(day|days|week|weeks|month|months|year|years)\b', re.I)
TOTAL=re.compile(r'\b(\d{1,5})(?:th|st|nd|rd)?\s+(?:times|completions|check[- ]?ins|sessions|workouts|pages|books|hours)\b', re.I)
DISPLAY={
 'collection/list of badges': re.compile(r'(badge|trophy|achievement|milestone)s?\s+(collection|list|page|case|cabinet|wall|shelf|history)|all (my|the) (badges|trophies|achievements|milestones)', re.I),
 'see what is next / progress to next': re.compile(r'next (milestone|badge|goal|level|trophy)|progress (bar|towards?)|how (far|close)|to go\b|until (the )?next', re.I),
 'reached ones kept/saved': re.compile(r'(badges?|milestones?|achievements?|trophies)[^.]{0,40}(saved|kept|lost|disappear|gone|reset|remain)', re.I),
 'beautiful/nice design of badges': re.compile(r'(beautiful|cute|nice|gorgeous|pretty|lovely|cool|well[- ]designed)\s+(badges?|trophies|medals?|milestones?|achievements?)|(badges?|trophies|medals?|milestones?|achievements?)\s+(are|look)\s+(beautiful|cute|nice|gorgeous|pretty|lovely|cool)', re.I),
 'childish/gamified/annoying': re.compile(r'(childish|gamif|cheesy|annoying|patroniz|condescend|too much celebration|confetti)', re.I),
 'share milestone': re.compile(r'share (my |the )?(milestone|badge|streak|achievement|progress)', re.I),
 'total/lifetime survives a break': re.compile(r'(total|lifetime|overall|all[- ]time)\s+(days|count|completions|times|progress)', re.I),
}
nums=collections.Counter(); numsMile=collections.Counter(); totals=collections.Counter()
disp=collections.Counter(); dispStars=collections.defaultdict(list); examples=collections.defaultdict(list)
n=0; kept=0
for f in files:
    for line in open(f, encoding='utf-8'):
        n+=1
        low=line.lower()
        if not any(k in low for k in ('milestone','badge','troph','achiev','award','medal','streak','in a row','consecutive','sober','clean','since','free')): continue
        r=json.loads(line); t=(r.get('title') or '')+' '+(r.get('body') or r.get('text') or '')
        if not KEY.search(t): continue
        kept+=1
        star=r.get('rating') or 0
        rid=r.get('review_id'); app=r.get('app_name')
        for m in NUM.finditer(t):
            v=int(m.group(1)); u=m.group(2).lower().rstrip('s')
            if v==0: continue
            nums[(v,u)]+=1
            if MILE.search(t): numsMile[(v,u)]+=1
        if MILE.search(t):
            for m in TOTAL.finditer(t): totals[int(m.group(1))]+=1
        for name,rx in DISPLAY.items():
            if rx.search(t) and (MILE.search(t) or name in ('total/lifetime survives a break',)):
                disp[name]+=1; dispStars[name].append(star)
                if len(examples[name])<12: examples[name].append((app,star,rid,t[:300].replace('\n',' ')))
out={'reviews':n,'keyword_reviews':kept,
 'numbers_with_streak_words':[[f'{v} {u}',c] for (v,u),c in nums.most_common(60)],
 'numbers_with_milestone_words':[[f'{v} {u}',c] for (v,u),c in numsMile.most_common(60)],
 'totals_with_milestone_words':totals.most_common(30),
 'display':{k:{'reviews':disp[k],'mean_stars':round(sum(dispStars[k])/max(1,len(dispStars[k])),2)} for k in DISPLAY},
 'examples':examples}
json.dump(out,open('milestone_scan.json','w'),indent=1,ensure_ascii=False)
print(n,kept)
