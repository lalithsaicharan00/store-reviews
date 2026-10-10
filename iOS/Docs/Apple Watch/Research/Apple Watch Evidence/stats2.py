import json, collections
exec(open('codes.py').read())
d = json.load(open('watch_app.json'))
ab = {i:c for i,c in CODES.items() if not set(c) <= {'N','H'}}
per = collections.defaultdict(list)
for i,c in ab.items(): per[d[i]['app']].append(i)
watchapps = [a for a,ids in per.items() if sum(1 for i in ids if set(ab[i])&set('PBSXUCDZYJQ'))>=10 and sum(1 for i in ids if 'W' in ab[i])/len(ids) < .5]
print(len(watchapps), sorted(a[:18] for a in watchapps))
ids = [i for a in watchapps for i in per[a]]
prob = [i for i in ids if set(ab[i])&set('BSXDZYJQ')]
pr = [i for i in ids if 'P' in ab[i]]
both=[i for i in prob if 'P' in ab[i]]
m=lambda L: sum(d[i]['rating'] for i in L)/len(L)
print('reviews',len(ids),'problem',len(prob),f'{len(prob)/len(ids):.1%}',f'{m(prob):.2f}','praise',len(pr),f'{len(pr)/len(ids):.1%}',f'{m(pr):.2f}','both',len(both))
sb=[i for i in ids if set(ab[i])&set('SB')]
print('S or B',len(sb),f'{len(sb)/len(ids):.1%}',f'{m(sb):.2f}')
yr=collections.defaultdict(lambda:[0,0])
for i in ids:
    y=int(d[i]['date'][:4]); b='2015-17' if y<2018 else '2018-20' if y<2021 else '2021-23' if y<2024 else '2024-26'
    yr[b][0]+=1; yr[b][1]+= bool(set(ab[i])&set('SB'))
for b in sorted(yr): print(b, yr[b], f"{yr[b][1]/yr[b][0]:.1%}")
# W-only apps
w=[i for i,c in ab.items() if 'W' in c]; print('W apps', len({d[i]['app'] for i in w}), 'W mean', f'{m(w):.2f}')
# combos
L=[i for i,c in ab.items() if 'L' in c or 'O' in c]; print('L or O', len(L))
C=[i for i,c in ab.items() if 'C' in c or 'V' in c]; print('C or V', len(C), f'{m(C):.2f}')
Cp=[i for i in C if set(ab[i])&set('BS')]; print('complication broken/stale', len(Cp), f'{m(Cp):.2f}')
