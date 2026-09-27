"""Reading set for the free-limit size question (5 vs 6, 7, 8, 10...). Source: the free-plan screen's candidates
(Temp/free-plan/candidates.jsonl, written by ../Free Plan Evidence/scan.py). Takes every cap-mention review whose first
stated number is 6-15, plus 150 whose first number is 5 (at most 12 per app), leaving out paid apps whose cap is a design
choice (Streaks A23/A62), Hevy (gym routines) and the one-goal-by-design app (A70), and reviews already coded in the
free-plan sample (their codes are reused in tally.py)."""
import json, random, collections, os
HERE = os.path.dirname(os.path.abspath(__file__)); ROOT = os.path.abspath(os.path.join(HERE, '../../..'))
WORK = f'{ROOT}/Temp/free-limit'; os.makedirs(f'{WORK}/read', exist_ok=True)
rnd = random.Random(20260929)
C = [json.loads(l) for l in open(f'{ROOT}/Temp/free-plan/candidates.jsonl', encoding='utf-8')]
done = {r['key'] for r in json.load(open(f'{HERE}/../Free Plan Evidence/coded.json'))}
EX = {'P122', 'A23', 'A62', 'A70'}
pool = [c for c in C if 'CAP' in c['modes'] and c['capnums'] and c['key'].split('#')[0] not in EX and c['key'] not in done]
hi = [c for c in pool if 6 <= c['capnums'][0] <= 15]
five = [c for c in pool if c['capnums'][0] == 5]; rnd.shuffle(five)
per, pick5 = collections.Counter(), []
for c in five:
    if per[c['app']] < 12: pick5.append(c); per[c['app']] += 1
    if len(pick5) >= 150: break
order = sorted(hi, key=lambda c: (c['capnums'][0], c['app'])) + pick5
for b in range(0, len(order), 70):
    with open(f'{WORK}/read/batch-{b//70+1:02d}.txt', 'w', encoding='utf-8') as f:
        for c in order[b:b+70]:
            t = c['text']; t = t if len(t) <= 600 else t[:600] + ' …'
            f.write(f"[{c['key']}] N{c['capnums'][0]} | {c['rating']}★ {'PAID ' if c['paid'] else ''}{c['date']} {c['loc']} | {c['app'][:26]}\n{t}\n\n")
json.dump([{'key': c['key'], 'first_num': c['capnums'][0]} for c in order], open(f'{HERE}/sample-index.json', 'w'))
print(len(order), collections.Counter(c['capnums'][0] for c in order))
