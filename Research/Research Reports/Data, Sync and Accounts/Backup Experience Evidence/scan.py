"""Backup/sync experience: choosing a backup place, sign-in after buying, moving to another device without an account,
automatic vs manual expectations. App Store + Play, habit apps (to-do/gym/planner apps excluded)."""
import json, re, glob, os, collections
ROOT = '/home/user/store-reviews/Research'; HERE = os.path.dirname(os.path.abspath(__file__))
I = re.I
BK = r"(back ?-?ups?|backing up|backup|restore)"
M = {
 # choosing where the backup goes / having options
 'CHOOSE_PLACE': rf"(choose|choice|option|select|pick)\w*.{{0,40}}(where|which).{{0,30}}{BK}|{BK}.{{0,40}}(to|on|in) (either|my choice of|google drive or|icloud or|dropbox or)|(icloud|google drive|dropbox).{{0,20}}\bor\b.{{0,20}}(icloud|google drive|dropbox|your own|our server)",
 # signing in / account step around buying
 'SIGNIN_PURCHASE': r"(after|when|before) (i )?(bought|buying|purchas\w*|paid|upgrad\w*|subscrib\w*).{0,60}(sign|log) ?(in|up)|(sign|log) ?(in|up).{0,60}(after|when|before) (i )?(bought|buying|purchas\w*|paid|upgrad\w*)|(asked|made|forced|required|had) (me )?to (create an account|sign up|log ?in|sign in).{0,60}(premium|pro|paid|purchase|bought)",
 # moving data to another device without an account
 'MOVE_DEVICE': r"(transfer|move|moving|migrat\w*|copy|bring)\w*.{0,40}(data|habits|progress|history|streaks?).{0,40}(new phone|another (phone|device)|other (phone|device)|tablet|ipad|new device)|(export|import|backup file|file).{0,50}(new phone|another (phone|device)|other device|tablet|ipad)",
 # backup should just happen
 'AUTO_EXPECT': r"(automatic\w*|auto) ?(back ?up|backup|sync)|back ?s? ?up automatically|without (me )?having to (back|export|remember)|(should|must|need to) (be )?(back ?up|backup|sync)\w* automatically",
 # status confusion: where is my data
 'WHERE_DATA': r"where (is|does|are) (my|the) (data|habits|backup|progress)\w* (stored|saved|kept|go|backed)|(don.?t|doesn.?t|didn.?t|do not) (know|say|tell|explain).{0,40}(where|if|whether).{0,30}(backed up|saved|stored|synced)",
}
EXCL = ['To Do List','Tasks -','School Planner','Gym','Video Calls','Bordio','Skincare','Tiimo','Calendar - ','Reminders','Notes']
M = {k: re.compile(v, I) for k, v in M.items()}
cands, st = [], collections.Counter()
for store, base in [('A', 'App Store Reviews'), ('P', 'Play Store Reviews')]:
    for d in sorted(glob.glob(f'{ROOT}/{base}/*/')):
        if any(x in d for x in EXCL) or not os.path.exists(d + 'reviews.jsonl'): continue
        n = os.path.basename(d.rstrip('/')).split('.')[0]; app = os.path.basename(d.rstrip('/'))
        for i, l in enumerate(open(d + 'reviews.jsonl', encoding='utf-8')):
            r = json.loads(l); t = ((r.get('title') or '') + ' || ' + (r.get('body') or r.get('text') or '')).replace('\n', ' ')
            st['total'] += 1
            modes = [k for k, rx in M.items() if rx.search(t)]
            if modes:
                cands.append({'key': f'{store}{n}#{i}', 'app': app, 'review_id': r.get('review_id'), 'rating': r.get('rating'),
                              'date': (r.get('date') or '')[:10], 'loc': r.get('country') or r.get('language'), 'modes': modes, 'text': t})
                for m in modes: st[m] += 1
json.dump(cands, open(f'{HERE}/candidates.json', 'w'), ensure_ascii=False)
print(dict(st), len(cands))
