"""Tallies every codes_*.py into coded_counts.json: per code, reviews, apps and mean rating; cites example IDs."""
import json, importlib.util, collections, glob, os
T = '/home/user/store-reviews/Research/Temp/rowtext/'
def load(py, name='CODES'):
    spec = importlib.util.spec_from_file_location(py, py); m = importlib.util.module_from_spec(spec); spec.loader.exec_module(m)
    return getattr(m, name)
sets = [('info', load('codes_info.py')), ('glance', load('codes_glance.py')), ('clutter', load('codes_clutter.py')),
        ('wrap', load('codes_wrap.py')), ('quit', load('codes_quit.py')), ('task', load('codes_task_note.py', 'TASK')),
        ('note2', load('codes_task_note.py', 'NOTE'))]
by = collections.defaultdict(dict)
for q, codes in sets:
    hits = json.load(open(T + f'narrowed_{q}.json'))
    for i, cs in codes.items():
        h = hits[i]
        for c in cs:
            if c in ('praise', 'native'): continue
            by[c][h['id']] = h
out = {}
for c, d in sorted(by.items(), key=lambda kv: -len(kv[1])):
    hs = list(d.values())
    native = sum(1 for h in hs if h['src'] == 'Native Store Reviews' or h['app'] in ('Reminders', 'Calendar', 'Notes', 'Google Calendar: Get Organized', 'Google Keep - Notes and lists', 'Microsoft To Do', 'Apple Fitness', 'Apple Health', 'Google Tasks: Get Things Done'))
    rated = [h['rating'] for h in hs if h['rating']]
    out[c] = {'reviews': len(hs), 'apps': len({h['app'] for h in hs}), 'native_or_list_apps': native,
              'mean_rating': round(sum(rated) / len(rated), 2) if rated else None, 'ids': [h['id'] for h in hs][:8]}
json.dump(out, open('coded_counts.json', 'w'), indent=1, ensure_ascii=False)
for c, v in out.items(): print(f"{c:24} {v['reviews']:4} reviews {v['apps']:3} apps  native {v['native_or_list_apps']:3}  {v['mean_rating']}★  {v['ids'][:4]}")
