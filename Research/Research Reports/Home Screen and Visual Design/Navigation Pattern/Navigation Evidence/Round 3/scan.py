# Navigation round 3: duplicate entry points, menu/settings organisation, the ≡ icon, filter button contents.
import json, re, glob, os
ROOT='/home/user/store-reviews/Research'
UI=r"(buttons?|icons?|menus?|tabs?|options?|screens?|pages?|settings?|links?|shortcuts?|entr(y|ies)|sidebar|side ?menu|drawer|toolbar|nav(igation)?( bar)?|bottom bar)"
FAM={
 # same destination reachable from two places
 'DUP': re.compile(r"\b(redundant|duplicated?|duplicates|repeated|twice)\b.{0,40}\b"+UI+r"\b|\b"+UI+r"\b.{0,40}\b(redundant|duplicated?|twice)\b"
                   r"|\b(two|2|multiple|several|different|many) (places|ways|buttons|menus|spots|entry points)\b.{0,20}\b(to|for)\b.{0,30}\b(same|access|get to|reach|open|find|settings|stats|statistics)\b"
                   r"|\bsame (thing|button|option|menu|screen|page|setting|feature|info(rmation)?)s?\b.{0,25}\b(in|on|at|from) (two|both|multiple|several|different)\b"
                   r"|\bwhy (are|is) there (two|2)\b|\b(both|also) (in|under) the (side ?menu|sidebar|drawer|hamburger|settings|menu)\b", re.I),
 # menu / settings organisation praised or criticised
 'ORG': re.compile(r"\b(settings?( menu| page| screen)?|side ?menu|sidebar|drawer|hamburger( menu)?|main menu)\b.{0,50}\b(confusing|messy|a mess|cluttered|disorgani[sz]ed|unorgani[sz]ed|all over the place|scattered|overwhelming|too many (options|things|items)|well[- ]organi[sz]ed|organi[sz]ed well|logical(ly)?|intuitive|makes? no sense|hard to navigate|easy to navigate|maze|labyrinth)\b"
                   r"|\b(confusing|messy|cluttered|disorganized|scattered|well organized|intuitive|logical)\b.{0,30}\b(settings?( menu| page| screen)?|side ?menu|sidebar|drawer|hamburger( menu)?)\b"
                   r"|\b(hidden|buried|tucked( away)?|lost)\b.{0,15}\b(in|under|inside|behind) (the )?(settings|side ?menu|sidebar|drawer|hamburger|menu|profile|more tab)\b"
                   r"|\b(couldn.?t|can.?t|cannot|could not|hard to|difficult to|unable to|took me (a while|ages|forever) to) find\b.{0,40}\b(in|under) (the )?(settings|menu|side ?menu|sidebar|profile)\b"
                   r"|\bshould(n.?t)? be (in|under|moved to|on) (the )?(settings|main screen|home ?screen|menu|side ?menu|sidebar|front|top)\b"
                   r"|\b(instead of|rather than) (being )?(hidden |buried )?(in|under) (the )?(settings|menu|side ?menu|sidebar|profile)\b", re.I),
 # the ≡ icon itself
 'ICON': re.compile(r"\b(three|3)[- ](lines?|bars?|dashes|stripes)\b|\bhamburger (icon|button|menu)\b|\bmenu (icon|button)\b.{0,40}\b(didn.?t|did not|never|took|found|notice|realis|realiz|know)\b", re.I),
 # the filter button and what people expect in it
 'FILT': re.compile(r"\bfilter(s|ing)?\b.{0,40}\b(button|icon|menu|option|by (category|categories|group|tag|area|time|section|type|status))\b|\bfilter (habits|tasks|by)\b|\b(by|with) (a )?filter\b", re.I),
}
hits={k:[] for k in FAM}
srcs=[('A','App Store Reviews'),('P','Play Store Reviews'),('N','Native Store Reviews')]
for store,base in srcs:
    for d in sorted(glob.glob(f'{ROOT}/{base}/*/')):
        m=re.match(r'(\d+)\.',os.path.basename(d.rstrip('/')))
        f=d+'reviews.jsonl'
        if not m or not os.path.exists(f): continue
        with open(f,encoding='utf-8') as fh:
            for i,l in enumerate(fh):
                if not l.strip(): continue
                r=json.loads(l); t=((r.get('title') or '')+' || '+(r.get('body') or r.get('text') or r.get('content') or '')).replace('\n',' ').replace('\t',' ')
                for k,rx in FAM.items():
                    mm=rx.search(t)
                    if mm:
                        a=max(0,mm.start()-260)
                        hits[k].append((f'{store}{m.group(1)}#{i}',os.path.basename(d.rstrip('/'))[:30],r.get('rating') or r.get('score'),(r.get('date') or r.get('at') or '')[:10],t[a:a+700]))
for k,v in hits.items():
    with open(f'{ROOT}/Temp/nav3/{k}.tsv','w',encoding='utf-8') as f:
        for h in v: f.write('\t'.join(map(str,h))+'\n')
    print(k,len(v))
