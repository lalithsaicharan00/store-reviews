"""Every quote in the report must appear word for word in the review it cites (candidates.jsonl). Also checks a wrong quote fails."""
import json, sys, html
rows={json.loads(l)['key']:json.loads(l) for l in open("candidates.jsonl")}
Q=[l.rstrip('\n').split('\t',1) for l in open("quotes.tsv") if l.strip()]
bad=0
for k,q in Q:
    t=html.unescape(rows[k]['text']) if k in rows else ''
    if q not in t: print("MISMATCH", k, q); bad+=1
assert "this sentence is not in any review" not in html.unescape(rows['A3#7582']['text'])
print(len(Q),"quotes,",bad,"mismatches")
for k,_ in Q: print(k, rows[k]['review_id'], rows[k]['app'][:30], rows[k]['rating'], rows[k]['date'])
