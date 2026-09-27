"""Predictability scan: surprise after setup, creation confusion, alarm vs notification, reminder/section mismatch."""
import json, re, glob, os, collections
ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '../../..'))
RX = {
 'alarm_vs_notif': r"\b(alarm (instead|rather) of (a |just )?(a )?notification|not just a notification|notification (instead|rather) of an? alarm|like an alarm|an actual alarm|a real alarm|alarm-?like|alarm option|option (for|of) an alarm|rings? like an alarm)\b",
 'silent_missed': r"\b(silent mode|on silent|do not disturb|dnd|focus mode|sleep focus)\b.{0,80}\b(remind|notif|alarm)|\b(remind\w*|notif\w*|alarm)\b.{0,80}\b(silent mode|on silent|do not disturb|focus mode)\b",
 'surprise': r"\b(didn'?t|did not) (know|realize|realise|expect|understand) (that |it |the |what |why |how )|\bwasn'?t (clear|obvious)\b|\bno idea (what|how|why|where)\b|\b(where|why) did (all )?(my|the) (habits?|tasks?|routines?) (go|disappear)|\b(habits?|tasks?) (disappeared|vanished|went missing|don'?t show up|didn'?t show up|doesn'?t show up|not showing up)\b",
 'setup_confusing': r"\b(confus\w*|unclear|not intuitive|unintuitive|counter-?intuitive) (to set up|setting up|to create|when creating|to add|how to (add|create|set))|\b(hard|difficult|tricky) to (set up|figure out (how|what))\b",
 'time_of_day_reminder': r"\b(morning|afternoon|evening|time of day)\b.{0,60}\b(remind\w*|notif\w*)\b|\b(remind\w*|notif\w*)\b.{0,60}\b(morning|afternoon|evening|time of day)\b",
}
HABIT = re.compile(r"\b(habit|routine|task|reminder|remind)", re.I)
C = {k: re.compile(v, re.I|re.S) for k, v in RX.items()}
hits = collections.defaultdict(list)
for store, base in [('A', 'App Store Reviews'), ('P', 'Play Store Reviews')]:
    for d in sorted(glob.glob(f'{ROOT}/{base}/*/')):
        m = re.match(r'(\d+)\.', os.path.basename(d.rstrip('/')))
        if not m or not os.path.exists(d + 'reviews.jsonl'): continue
        for i, l in enumerate(open(d + 'reviews.jsonl', encoding='utf-8')):
            if not l.strip(): continue
            r = json.loads(l); t = ((r.get('title') or '') + ' ' + (r.get('body') or r.get('text') or '')).strip()
            if not HABIT.search(t): continue
            for k, rx in C.items():
                mm = rx.search(t)
                if mm: hits[k].append((f'{store}{m.group(1)}#{i}', r.get('rating') or r.get('score'), t[max(0,mm.start()-260):mm.end()+260]))
for k, v in hits.items(): print(k, len(v))
json.dump(hits, open(f'{os.path.dirname(os.path.abspath(__file__))}/placement_hits3.json', 'w'), ensure_ascii=False)
