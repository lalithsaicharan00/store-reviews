"""Verify all saved classifications and every cited review against canonical sources, including Native."""
import csv,json,pathlib,re,sys,collections
R=pathlib.Path(__file__).resolve().parents[2]
E=R/'Research Reports/Progress and Statistics/Week Visual Evidence'
rows=list(csv.DictReader((E/'Coded Reviews.tsv').open(),delimiter='\t'));groups=collections.defaultdict(list)
for r in rows:groups[R/f"{r['store']} Store Reviews"/r['app_folder']/'reviews.jsonl'].append(r)
known=set()
for p,rr in groups.items():
 # JSON strings can contain Unicode line separators. Source line is the physical
 # JSONL record number, so str.splitlines() would incorrectly split a review body.
 lines=p.open().readlines()
 for r in rr:
  raw=json.loads(lines[int(r['source_line'])-1]);assert raw['review_id']==r['review_id'];known.add(raw['review_id']);assert r['codes']
keys=[(r['store'],r['app_folder'],r['review_id']) for r in rows];assert len(keys)==len(set(keys))
counts=json.loads((E/'Theme Counts.json').read_text())
for k,v in counts.items():
 actual=[r for r in rows if k in r['codes'].split(',')];assert len(actual)==v['n'];assert set(r['review_id'] for r in actual)==set(v['ids']);assert abs(len(actual)/len(rows)*100-v['percent'])<.006
report=pathlib.Path(sys.argv[1]).read_text() if len(sys.argv)>1 else ''
ids=set(re.findall(r'`([0-9a-f]{8}-[0-9a-f-]{27}|\d{9,11})`',report));assert ids<=known,sorted(ids-known)
print(f'{len(rows)} source records verified; zero duplicates, unassigned records or count mismatches; {len(ids)} cited IDs verified (all three stores).')
