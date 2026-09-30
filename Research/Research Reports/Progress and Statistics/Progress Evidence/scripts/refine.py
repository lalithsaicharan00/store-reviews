import json,re,collections
exec(open('screen.py').read().split('def recs')[0])
NOISE = {
 "OVERVIEW": re.compile(r"übersichtlich|\bat a glance\b(?!.{0,40}(habit|progress|stat|week|month|year|calendar))", re.I),
}
# per-family: which matches are weak (keyword alone insufficient)
WEAK = re.compile(r"^(grafik|gr[áa]fic[oa]s?|graphiques?|grafic[io]|progresso?|戒|slips?|slip|slipped|übersicht|进度|レポート|分析|historial|hist[óo]rico|historique|verlauf|storico|geçmiş|rekord|рекорд|срыв|at a glance|analytic|insights?|insight)$", re.I)
cand=[json.loads(l) for l in open('candidates.jsonl')]
cand=[c for c in cand if c['tier']=='habit']
out=[];cnt=collections.Counter();why=collections.Counter()
for c in cand:
    t=c['text']; strong=False; fams=[]
    for k in c['fam']:
        ms=[m.group(0).strip() for m in F[k].finditer(t)]
        ms2=[m for m in ms if not WEAK.match(m) and not (k=="OVERVIEW" and re.match(r"übersicht",m,re.I))]
        if k=="OVERVIEW" and NOISE["OVERVIEW"].search(t) and not ms2: continue
        if ms2: strong=True; fams.append(k)
        elif ms:
            # weak-only match: keep only if a habit/stat context word is near
            if re.search(r"(stat|chart|graph|calendar|habit|h[áa]bito|habitude|gewohnheit|привыч|习惯|習慣|습관|streak|racha|sequ[êe]ncia|progress|progreso|progr[eè]s|fortschritt|прогресс|daten|data|dados|datos|données|report|informe|relat[óo]rio|month|week|year|mes|semana|año|ano|mois|monat|woche|jahr|месяц|недел|год|月|週|年)",t,re.I) and k in ("STAT","VIEW","REPORT"):
                fams.append(k+"w")
    if not fams: why['dropped']+=1; continue
    c['fam2']=fams; out.append(c)
    cnt[tuple(sorted(set(f.rstrip('w') for f in fams)))]+=1
print(len(cand),len(out),why)
fc=collections.Counter(f for c in out for f in set(c['fam2']))
print(fc.most_common())
only_ov=sum(1 for c in out if set(f.rstrip('w') for f in c['fam2'])=={'OVERVIEW'})
only_q=sum(1 for c in out if set(f.rstrip('w') for f in c['fam2'])=={'QUIT'})
print('overview-only',only_ov,'quit-only',only_q)
json.dump(out,open('refined.json','w'),ensure_ascii=False)
