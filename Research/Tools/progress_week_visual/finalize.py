"""Reproduce the focused language expansion and saved hand classification, after scan.py,
expand_scan.py and classify_initial.py. Run from any directory. All intermediates stay in Research/Temp.
"""
import json,re,pathlib,csv,collections
R=pathlib.Path(__file__).resolve().parents[2];O=R/'Temp/progress-week';T=pathlib.Path(__file__).resolve().parent
pairs=json.loads((T/'language_pairs.json').read_text());covered={'en','es','pt','fr','de','it','ru','tr','ar','pl','nl','vi','id'};P=[]
for lang,(a,b) in pairs.items():
 if lang in covered:continue
 w=a.split('|')[0]
 if w.isascii():w=r'\b'+w+r'\w*'
 P.append(re.compile('(?:'+w+r').{0,80}(?:'+b+')|(?:'+b+r').{0,80}(?:'+w+')',re.I))
extra=[json.loads(l) for l in (O/'extra_hits.jsonl').read_text().splitlines()];b=[r for r in extra if any(p.search(r['text']) for p in P)]
a=[json.loads(l) for l in (O/'hits.jsonl').read_text().splitlines()];rs=a+b
assert (len(a),len(b))==(339,323), 'Corpus/scan changed: re-read candidates and classify before reporting counts.'
c={int(k):v for k,v in json.loads((O/'classification.json').read_text()).items()};m=json.loads((T/'supplement_classification.json').read_text())
for k,v in m.items():assert len(v)==len(set(v)) and all(0<=i<len(b) for i in v)
for i in range(len(b)):c[len(a)+i]=[k for k,v in m.items() if i in v] or ['NA']
assert len(c)==len(rs) and all(c.values());assert len({(r['store'],r['folder'],r['id']) for r in rs})==len(rs)
(O/'all_classification.json').write_text(json.dumps(c,indent=2));(O/'all_hits.jsonl').write_text(''.join(json.dumps(r,ensure_ascii=False)+'\n' for r in rs))
with (O/'all_coded_reviews.tsv').open('w') as f:
 w=csv.writer(f,delimiter='\t',lineterminator='\n');w.writerow(['row','review_id','store','app_folder','rating','date','codes','source_line','retrieval_pass'])
 for i,r in enumerate(rs):w.writerow([i,r['id'],r['store'],r['folder'],r['rating'],r['date'],','.join(c[i]),r['line'],'focused' if i<339 else 'language_expansion'])
print(len(rs),'assigned; no duplicates or unknown classification rows.')
