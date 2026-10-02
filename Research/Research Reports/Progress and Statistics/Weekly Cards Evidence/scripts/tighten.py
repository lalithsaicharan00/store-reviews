"""Keep a hit only when a statistics/display word sits within 120 characters of the type wording."""
import json,re,collections
from patterns import T
STAT=r"(stat\w*|chart|graph|histor\w*|calendar|record(s|ed)?|report|percent\w*|%|total|average|avg|sum\b|summary|overview|progress|streak|count(s|ed|ing)?|marks?|marked|shows?|showing|shown|displays?|display(ed|ing)|see (how|my|the|what|which|it|that)|view|tally|logged|tracks?|tracking|tracked|completion|complete(d)?|done|failed|missed|partial|half|fill(s|ed)?)"
W=re.compile(r"(?:%s).{0,120}?(?:%s)|(?:%s).{0,120}?(?:%s)")
by=json.load(open("type_hits_all.json"))
keep=collections.defaultdict(list)
for k,lst in by.items():
    pk=T[k]
    pat=re.compile(r"(?:%s)[\s\S]{0,120}?%s|%s[\s\S]{0,120}?(?:%s)"%(pk,STAT,STAT,pk),re.I)
    for o in lst:
        if pat.search(o["text"]): keep[k].append(o)
tot=set()
for k,v in keep.items(): print(k,len(v)); tot|={o["id"] for o in v}
print("unique",len(tot))
json.dump(keep,open("type_hits_tight.json","w"),ensure_ascii=False)
