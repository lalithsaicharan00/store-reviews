import json,re,collections
from multiprocessing import Pool
from scope import in_scope
AF=re.compile(r"(can'?t|cannot|can not|couldn'?t|could not|unable to|not able to|don'?t have the money|no money|too broke|i'?m broke|am broke)\b.{0,30}\b(afford|pay|buy|subscribe|spend)|\bcan'?t afford\b|\bcannot afford\b|\bafford\b|\btoo expensive\b|\bso expensive\b|\bway too (much|expensive|pricey)\b|\bbroke (college )?student\b|\bfixed income\b|\bon disability\b|\bunemployed\b|\blow income\b|\bpoor\b.{0,15}\b(student|person|people)\b",re.I)
WP=re.compile(r"\b(i'?d|i would|would|i will|i'?ll|happy to|gladly|willing to|love to|happily)\b.{0,20}\b(pay|buy|purchase|subscribe)\b",re.I)
def w(l):
    r=json.loads(l)
    if not in_scope(r): return None
    t=r['t'].replace('’',"'")
    return (f"{r['s']}|{r['app'].split('.')[0]}|{r['id']}",bool(AF.search(t)),bool(WP.search(t)))
if __name__=='__main__':
    with Pool(8) as p:
        res={k:(a,b) for x in p.imap(w,open('corpus.jsonl'),chunksize=3000) if x for k,a,b in [x]}
    json.dump(res,open('afford.json','w'))
    print(sum(a for a,b in res.values()),sum(b for a,b in res.values()))
