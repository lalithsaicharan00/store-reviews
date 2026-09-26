"""Full-corpus screen for backup-without-account topics (topic 3). Writes candidates.jsonl + mode-stats.txt."""
import json, re, glob, os, collections
ROOT = '/Users/lalith/Desktop/store reviews/Research'
OUT = os.path.dirname(os.path.abspath(__file__))
I = re.I
M = {
 'ICLOUD': r"icloud\b.{0,40}\b(back ?up|sync|drive|save|saved|restore|storage|full)|(back ?up|sync|save|restore)\w*\b.{0,30}\bicloud",
 'GDRIVE': r"google ?drive|\bg ?drive\b|google (cloud )?back ?up|back ?up\w* (to|on|in) (my )?google",
 'OTHER_CLOUD': r"dropbox|onedrive|one drive|box\.com|mega\.nz|nextcloud|webdav",
 'AUTO_BACKUP': r"auto(matic)?(ally)?[ -]?back(ed)? ?up|back ?up automatic|scheduled back ?up|daily back ?up|backs? up (every|daily|automatically)",
 'MANUAL_BACKUP': r"manual(ly)?[ -]?back(ed)? ?up|back ?up\w* manually|(have|need|remember) to (remember to )?back ?up|forgot to back ?up|didn.?t back ?up",
 'BACKUP_FILE': r"back ?up file|\.json\b|\.db\b|\.sqlite|export(ed)? file|backup\.(zip|csv)|zip file",
 'RESTORE_BACKUP': r"restor\w* (from )?(a |my |the |an old )?back ?up|import\w* (my |the |a )?back ?up|back ?up\b.{0,30}\b(won.?t|didn.?t|doesn.?t|can.?t|cannot|not) (restore|import|load|open|work)",
 'LOCAL_BACKUP': r"local (back ?up|storage|file)|sd ?card|internal storage|phone storage|downloads? folder|files app",
 'BACKUP_REMINDER': r"back ?up reminder|remind\w* (me |you )?to back ?up|(nag|pop ?up)\w*\b.{0,20}\bback ?up",
 'NOACC_BACKUP': r"(without|no|not requir\w*|don.?t want) (an |a )?(account|login|log ?in|sign ?in|sign ?up|registration)\b.{0,60}\bback ?up|back ?up\b.{0,60}\b(without|no need (for|of)|not requir\w*) (an |a )?(account|login|sign ?in)",
 'OS_BACKUP': r"(phone|iphone|device|samsung|android|google one|itunes) back ?up\b|restor\w* (my )?(phone|iphone|device) from (a |the )?back ?up|smart ?switch|quick start|move to ios|switch to android|transferred (everything|all my apps)",
 'BACKUP_STATUS': r"last back ?up|when (was|is) (the|my) (last )?back ?up|back ?up (date|status|history|log)|(is|was|were) (it|my data|everything|my habits) (being )?backed up|no idea (if|whether) .{0,20}back",
 'STORAGE_FULL': r"icloud (storage )?(is )?full|storage (is )?full|not enough (icloud )?storage|out of (icloud )?storage",
 'ML_BACKUP': r"sauvegard|copia de seguridad|respaldo|c[oó]pia de seguran|Sicherung|резервн\w* коп|бэкап|バックアップ|备份|備份|백업|yedekle",
}
M = {k: re.compile(v, I) for k, v in M.items()}
cands, stats, apps, total = [], collections.defaultdict(collections.Counter), collections.defaultdict(set), collections.Counter()
for store, base in [('A', 'App Store Reviews'), ('P', 'Play Store Reviews'), ('N', 'Native Store Reviews')]:
    for d in sorted(glob.glob(f'{ROOT}/{base}/*/')):
        m = re.match(r'(\d+)\.', os.path.basename(d.rstrip('/')))
        if not m or not os.path.exists(d + 'reviews.jsonl'): continue
        app = os.path.basename(d.rstrip('/'))
        for i, l in enumerate(open(d + 'reviews.jsonl', encoding='utf-8')):
            if not l.strip(): continue
            r = json.loads(l); total[store] += 1
            t = ((r.get('title') or '') + ' || ' + (r.get('body') or r.get('text') or '')).replace('\n', ' ')
            modes = [k for k, rx in M.items() if rx.search(t)]
            if not modes: continue
            cands.append({'key': f'{store}{m.group(1)}#{i}', 'store': store, 'app': app, 'review_id': r.get('review_id'),
                          'rating': r.get('rating'), 'date': (r.get('date') or '')[:10], 'loc': r.get('country') or r.get('language'),
                          'modes': modes, 'text': t})
            for k in modes:
                stats[k][r.get('rating')] += 1; stats[k][store] += 1; apps[k].add(f'{store}{m.group(1)}')
with open(f'{OUT}/candidates.jsonl', 'w', encoding='utf-8') as f:
    for c in cands: f.write(json.dumps(c, ensure_ascii=False) + '\n')
with open(f'{OUT}/mode-stats.txt', 'w') as f:
    f.write(f"screened {sum(total.values())} {dict(total)}; candidates {len(cands)}\n\n{'mode':20}{'n':>6}{'apps':>5}{'A':>6}{'P':>6}{'N':>6}{'1★%':>6}{'mean':>6}\n")
    for k in sorted(stats, key=lambda k: -sum(stats[k][s] for s in 'APN')):
        c = stats[k]; n = sum(c[s] for s in 'APN'); mean = sum(c[s]*s for s in range(1, 6))/n
        f.write(f"{k:20}{n:6}{len(apps[k]):5}{c['A']:6}{c['P']:6}{c['N']:6}{100*c[1]/n:6.1f}{mean:6.2f}\n")
print(open(f'{OUT}/mode-stats.txt').read())
