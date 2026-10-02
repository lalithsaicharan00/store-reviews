import json,pathlib,collections,csv
O=pathlib.Path(__file__).resolve().parents[2]/'Temp/progress-week';rs=[json.loads(l) for l in (O/'hits.jsonl').read_text().splitlines()]
# Hand-coded after reading all 339 original-language candidates. Codes deliberately narrow.
M={
'P_WEEK':[1,6,7,31,33,48,69,73,74,82,85,86,87,97,112,115,123,124,126,128,129,130,160,161,162,163,166,167,169,170],
'P_OVERVIEW':[1,32,62,63,64,74,114,128],
'X_MARK':[8,13,34,36,38,39,40,52,58,67,68,90,99,111,146,177],
'X_DENSITY':[5,35,36,41,51,57,168],
'X_SCORE':[13,30,36,144,145,171],
'ASK_WEEK':[0,3,4,9,26,27,28,29,50,51,53,56,61,63,70,117,118,134,135,137,138,139,140,142,143,149,150,153,158,168,171,172],
'P_QUIT':[45,46],
'P_CLARITY':[11,15,18,19,20,25,42,43,47,49,50,59,65,66,71,81,95,96,114,120,136,151,152,154,155,164,165],
'N_MARK':[181,199,201,203,205,206,207,208,209,210,222,226,227,228,229,230,231,234,238,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,256,268,273,321,334],
'N_DENSITY':[184,192,194,195,196,197,198,211,212,214,215,217,218,219,220,221,222,223,224,225,236,237,239,255,280,281,284,288,289,303,317,318,320,321,322,323,326,330,333],
'N_PRAISE':[187,204,291,299,312,316,319,329],
'N_SUMMARY':[259,263,264,266,269,270,273],
}
cls={i:[] for i in range(len(rs))}
for code,inds in M.items():
 assert len(inds)==len(set(inds))
 for i in inds:cls[i].append(code)
for i in cls:
 if not cls[i]:cls[i]=['NA']
assert len(cls)==len(rs) and set(cls)==set(range(len(rs)))
(O/'classification.json').write_text(json.dumps({str(i):codes for i,codes in cls.items()},indent=2))
with (O/'coded_reviews.tsv').open('w') as f:
 w=csv.writer(f,delimiter='\t');w.writerow(['row','review_id','store','app_folder','rating','date','codes','source_line'])
 for i,r in enumerate(rs):w.writerow([i,r['id'],r['store'],r['folder'],r['rating'],r['date'],','.join(cls[i]),r['line']])
counts={k:dict(n=len(v),percent=round(len(v)/339*100,2),apps=len(set(rs[i]['store']+rs[i]['folder'] for i in v)),ids=[rs[i]['id'] for i in v]) for k,v in M.items()}
(O/'counts.json').write_text(json.dumps(counts,indent=2))
print(json.dumps({k:{x:y for x,y in v.items() if x!='ids'} for k,v in counts.items()},indent=2))
print('period',min(r['date'] for r in rs if r['date']),max(r['date'] for r in rs if r['date']))
print('NA',sum(v==['NA'] for v in cls.values()),'all assigned',len(cls))
