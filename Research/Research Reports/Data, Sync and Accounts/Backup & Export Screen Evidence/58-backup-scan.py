"""58: Backup & Export screen redesign evidence. Screen of habit-app reviews (App Store + Play; to-do, gym, planner,
native apps excluded, same EXCL list as Backup Experience Evidence/scan.py). English patterns. Writes 58-candidates.json."""
import json, re, glob, os, collections
ROOT = '/home/user/store-reviews/Research'; OUT = f'{ROOT}/Temp/58-candidates.json'
I = re.I
BK = r"(back ?-?ups?|backing up|restor\w*|import\w*)"
M = {
 'FIND_RESTORE': r"(can'?t|cannot|couldn'?t|could not|unable to|don'?t know how to|didn'?t know how to|no way to|how (do|can|would) (i|you|we)|where (is|are|do i|can i|would i)|hard to|impossible to|no idea how to|figure out how to)\s+(find|see|locate|get to|access|use|do)?\s*(the |a |my |any )?(restor\w*|import\w*|recover\w*|load (the |my )?back ?up)|\b(restore|import|recover)\w* (button|option|feature|function|setting)s?\b.{0,50}(hidden|find|where|missing|buried|hard|confus)|where.{0,25}\b(restore|import)\b",
 'CONFUSE_KINDS': r"(difference|differences|confus\w*|unclear|don'?t understand|not sure|what'?s the|what is the|no idea)\b.{0,50}\b(backup|back up|export|sync|restore|import)\w*\b.{0,50}\b(backup|back up|export|sync|restore|import)\w*|\bthought (it|the app|my data|everything|my progress|my habits)\w* (was|were|is|would be|had been) (being )?(synced|syncing|backed up|backing up|saved (to|in|on) (the )?(cloud|icloud|account|server))",
 'TRUST_SERVER': r"(your|their|the developer'?s?|developers'?|company'?s?|someone else'?s|third[- ]party|external|remote|own) servers?\b|(stored|saved|kept|uploaded|sent|store|send|upload|storing|sending|uploading)\w* (my |our |the |your )?(data|info\w*|habits|entries)? ?(on|to|in) (the |a |their |your |some )?(cloud|servers?)\b|(don'?t|do not|never|wouldn'?t) (want|trust|like).{0,40}(cloud|server|online|upload)|(data|everything|it) (stays?|is (stored|kept|saved)|remains?) (local\w*|on (my|the|your) (phone|device))|\blocal[- ]only\b|stored locally",
 'AUTO_BACKUP_STATUS': r"auto(matic)?(ally)?[- ]?(back ?-?ups?|backing)|back(s|ed|ing)? ?-?up automatically|\blast (back ?-?up|backed up|synced|sync)|when (it|the app|my data)( was)? last (backed|synced)|(daily|nightly|weekly|scheduled|periodic|regular) (cloud )?back ?-?ups?",
 'NEW_PHONE': r"(new (phone|iphone|device|android|ipad|cell)|(switch|switched|changing|changed|upgrad\w*|got|get|bought)( to)? (a |my )?(new )?(phone|iphone|device|android)s?\b|(transfer|move|moving|migrat\w*|carry)\w* .{0,40}(another|other|new|second|different) (phone|device|iphone|android))",
 'EXPORT': r"\bexport\w*|\bcsv\b|spreadsheet|\bexcel\b|\bjson\b|google sheets",
 'SIGN_OUT': r"\b(sign|log)[ -]?(out|off)\b|\blogout\b|\bsignout\b",
 'DELETE_ACCOUNT': r"delet\w* (my |the |your |an |our )?account|account delet\w*|(remove|close|erase|cancel) (my |the )?account",
 'FIND_ACCOUNT': r"(can'?t|cannot|couldn'?t|unable to|no way to|how (do|can) i|where (is|do i|can i)|no option to|nowhere to|don'?t see (a|any|the|how))\s.{0,20}(log ?out|sign ?out|log ?in|sign ?in|delete (my |the )?account|my account|account settings|profile)",
 'SYNC_TOGGLE': r"(turn|switch|toggle)\w* (on|off) (the |icloud |cloud )?sync|(turn|switch)\w* (the |icloud |cloud )?sync\w* (on|off)|sync\w* (toggle|switch|button|setting|option)s?|(disable|enable)\w* (the )?(icloud |cloud )?sync|manual(ly)? sync|sync now|force (a )?sync|(press|hit|tap|click)\w* (the )?sync",
 'ICLOUD_BACKUP': r"icloud.{0,60}back ?-?up|back ?-?up.{0,60}icloud",
}
EXCL = ['To Do List','Tasks -','School Planner','Gym','Video Calls','Bordio','Skincare','Tiimo','Calendar - ','Reminders','Notes']
M = {k: re.compile(v, I) for k, v in M.items()}
cands, st, tot = [], collections.Counter(), collections.Counter()
for store, base in [('A', 'App Store Reviews'), ('P', 'Play Store Reviews')]:
    for d in sorted(glob.glob(f'{ROOT}/{base}/*/')):
        if any(x in d for x in EXCL) or not os.path.exists(d + 'reviews.jsonl'): continue
        n = os.path.basename(d.rstrip('/')).split('.')[0]; app = os.path.basename(d.rstrip('/'))
        for i, l in enumerate(open(d + 'reviews.jsonl', encoding='utf-8')):
            r = json.loads(l); t = ((r.get('title') or '') + ' || ' + (r.get('body') or r.get('text') or '')).replace('\n', ' ')
            tot[store] += 1
            modes = [k for k, rx in M.items() if rx.search(t)]
            if modes:
                cands.append({'key': f'{store}{n}#{i}', 'app': app, 'review_id': r.get('review_id'), 'rating': r.get('rating'),
                              'date': (r.get('date') or '')[:10], 'loc': r.get('country') or r.get('language'), 'modes': modes, 'text': t})
                for m in modes: st[m] += 1
json.dump(cands, open(OUT, 'w'), ensure_ascii=False)
print(dict(tot), dict(st), len(cands))
