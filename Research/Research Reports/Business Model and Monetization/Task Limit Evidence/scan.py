"""Full-corpus screen for the task-limit question: should tasks (one-time and recurring) in a habit app be capped,
counted with the free habit limit, paid, or free? Screens App Store, Play Store and native-app reviews.
Writes Temp/task-limit/candidates.jsonl and mode-stats.txt (here)."""
import json, re, glob, os, collections, statistics
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, '../../..'))
OUT = os.path.join(ROOT, 'Temp', 'task-limit'); os.makedirs(OUT, exist_ok=True)
I = re.I
# task words, several languages
T = (r"(?:tasks?|to-?dos?|todos?|to do list|to-do list|todo list|reminders?|chores?|errands?|one-?off|one-?time (?:tasks?|items?|to-?dos?)"
     r"|задач\w*|дел[аоу]?\b|tareas?|tarefas?|aufgaben?|to-?do-?liste|tâches?|attività|compiti|görev\w*|zadani\w*|タスク|やること|todo|할 ?일|작업|待办|任务|待辦|任務|小事)")
NUM = r"(\d{1,3}|one|two|three|four|five|six|seven|eight|nine|ten|twelve|fifteen|twenty)"
PAYW = (r"(?:premium|\bpro\b|paid|pay|purchas|subscri|paywall|locked|unlock|upgrade|membership|plus version|full version"
        r"|課金|有料|付费|會員|会员|收费|유료|결제|구독|bezahl|kostenpflichtig|abo\b|payant|abonnement|pagar|pago|paga|assinatura|плат|подписк|премиум)")
RECUR = (r"(?:recurring|repeat(?:ing|ed)?|repetitive|repeatable|recurrent|daily tasks?|weekly tasks?|every (?:day|week|month)"
         r"|повтор\w*|recurrentes?|repetit\w+|wiederkehrend\w*|wiederhol\w*|récurrent\w*|繰り返し|반복|重复|循环|定期)")
MODES = {
 # a numeric cap on tasks / to-dos
 'TASK_CAP': re.compile(
    rf"(?:limit(?:ed)?(?: (?:to|at|of|on))?|only(?: (?:allows?|lets? you|get|have|add|create|make))?|max(?:imum)?(?: of)?|up to|cap(?:ped)?(?: at)?|restricted to)\s+(?:(?:you|me|us|to|add|create|have|a|the|of)\s+){{0,3}}{NUM}\s+(?:free\s+|daily\s+|active\s+|recurring\s+)?{T}"
    rf"|{NUM}\s+(?:free\s+)?{T}\s+(?:limit|max|only|for free|in the free|on the free|without (?:paying|premium|pro|subscri))"
    rf"|(?:task|to-?do|todo|reminder) (?:limit|cap)\b|limit (?:of|on) (?:the )?(?:number of )?(?:tasks|to-?dos|reminders)|limited (?:number of )?(?:tasks|to-?dos)|more than {NUM} {T}"
    rf"|(?:only|just|nur|solo|sólo|apenas|только|всего)\s+{NUM}\s+(?:задач|tareas|tarefas|aufgaben|tâches)|(\d+)\s*(?:個|つ)の?(?:タスク)|(\d+)\s*个(?:任务|待办)", I),
 # tasks / to-do list / reminders behind a paywall
 'TASK_PAY': re.compile(rf"{T}.{{0,60}}{PAYW}|{PAYW}.{{0,60}}{T}", I),
 # recurring / repeating tasks behind a paywall (or free)
 'RECUR_PAY': re.compile(rf"{RECUR}.{{0,50}}{T}.{{0,60}}{PAYW}|{PAYW}.{{0,60}}{RECUR}.{{0,50}}{T}|{RECUR} {T}.{{0,40}}(?:free|gratis|kostenlos|gratuit|бесплатн)", I),
 # habits and tasks share one limit, or tasks used to get round the habit limit
 'SHARED_OR_WORKAROUND': re.compile(
    rf"(?:habits? (?:and|&|\+|or) {T}|{T} (?:and|&|\+|or) habits?).{{0,60}}(?:limit|combined|together|total|count|max)"
    rf"|{T}.{{0,40}}count(?:s|ed)? (?:toward|towards|against|as|in|into) (?:the |my )?(?:habit|limit|total|free)"
    rf"|(?:get|got|getting|work) (?:a)?round (?:the |this )?(?:habit )?limit|work.?around|loophole|trick (?:to|is)|cheat the"
    rf"|(?:use|used|using|put|added|adding|add) (?:\w+ ){{0,3}}(?:habits? as {T}|{T} as habits?|{T} instead of habits?|habits? instead of {T})", I),
 # a habit app's tasks / to-dos are free or unlimited (praise)
 'TASK_FREE': re.compile(rf"(?:unlimited|infinite|as many|no limit(?:s)? (?:on|to)) (?:\w+ ){{0,2}}{T}|{T}.{{0,30}}(?:are|is|for|completely|totally|still|all) free\b|free {T}", I),
}
HABITY = re.compile(r"habit|привыч|hábito|habitude|gewohnheit|習慣|习惯|습관|abitudin|alışkanlık|nawyk", I)
def text(r): return ((r.get('title') or '') + ' || ' + (r.get('body') or r.get('text') or '')).replace('\n', ' ')
total = 0
cands, mstat = [], collections.defaultdict(lambda: {'n': 0, 'r': [], 'apps': collections.Counter()})
for store, base in [('A', 'App Store Reviews'), ('P', 'Play Store Reviews'), ('N', 'Native Store Reviews')]:
    for d in sorted(glob.glob(f'{ROOT}/{base}/*/')):
        m = re.match(r'(\d+)\.', os.path.basename(d.rstrip('/')))
        if not m or not os.path.exists(d + 'reviews.jsonl'): continue
        app = os.path.basename(d.rstrip('/')); akey = f'{store}{m.group(1)}'
        for i, l in enumerate(open(d + 'reviews.jsonl', encoding='utf-8')):
            if not l.strip(): continue
            r = json.loads(l); t = text(r); rt = r.get('rating') or 0
            total += 1
            if len(t) < 25: continue
            modes = [k for k, rx in MODES.items() if rx.search(t)]
            # TASK_PAY and TASK_FREE are loose: keep only when the review also names a habit, a limit, or recurring tasks, or the app is a to-do app
            if 'TASK_PAY' in modes and not (HABITY.search(t) or re.search(r"limit|recurr|repeat|free|бесплат|gratis|kostenlos|gratuit|無料|免费", t, I)): modes.remove('TASK_PAY')
            if 'TASK_FREE' in modes and not HABITY.search(t) and store != 'N': modes.remove('TASK_FREE')
            if not modes: continue
            for k in modes:
                s = mstat[k]; s['n'] += 1; s['r'].append(rt); s['apps'][app] += 1
            cands.append({'key': f'{akey}#{i}', 'store': store, 'app': app, 'review_id': r.get('review_id'), 'rating': rt,
                          'date': (r.get('date') or '')[:10], 'loc': r.get('country') or r.get('language'), 'modes': modes, 'text': t})
with open(f'{OUT}/candidates.jsonl', 'w', encoding='utf-8') as f:
    for c in cands: f.write(json.dumps(c, ensure_ascii=False) + '\n')
out = [f'screened {total} App Store + Play + native reviews; candidates {len(cands)}']
for k, s in sorted(mstat.items(), key=lambda x: -x[1]['n']):
    out.append(f"{k:22} n={s['n']:6} apps={len(s['apps']):3} mean={statistics.mean(s['r']):.2f} "
               f"1star={100*sum(1 for x in s['r'] if x == 1)/s['n']:4.1f}%  top: " + ', '.join(f'{a[:24]} {v}' for a, v in s['apps'].most_common(6)))
open(f'{HERE}/mode-stats.txt', 'w').write('\n'.join(out) + '\n'); print('\n'.join(out))
