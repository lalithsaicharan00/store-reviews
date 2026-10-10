# Milestone feel scan (11 Oct 2026): what makes a milestone feel earned, surprise vs seeing them ahead, locked/grey
# future ones, how reached ones are shown. Run from this folder: python scan.py  ->  milestone_feel_scan.json
import json, re, glob, collections
ROOT = '../../..'
files = glob.glob(ROOT + '/App Store Reviews/*/reviews.jsonl') + glob.glob(ROOT + '/Play Store Reviews/*/reviews.jsonl')
MILE = re.compile(r'milestone|badge|trophy|trophies|achievement|award|medal|reward', re.I)
APPICON = re.compile(r'(app|icon|notification)\s+badge|badge\s+(count|number|on the (app )?icon)|red badge', re.I)
THEMES = {
 'feels earned / proud / accomplished': re.compile(r'(feel|feels|felt|feeling)\s+(so\s+|really\s+|very\s+)?(accomplished|proud|rewarded|rewarding|satisf|good|great|amazing)|sense of (accomplishment|achievement|pride)|satisfying|dopamine|proud of (myself|me)', re.I),
 'surprise / unexpected': re.compile(r'surpris|unexpected|out of nowhere|didn.t expect|little gift', re.I),
 'hidden / secret / mystery': re.compile(r'hidden (badge|achievement|reward|milestone)s?|secret (badge|achievement|reward|milestone)s?|mystery', re.I),
 'unlock / locked': re.compile(r'\bunlock|\blocked (badge|achievement|reward|milestone|trophies|trophy)', re.I),
 'see what is next / goal ahead': re.compile(r'next (milestone|badge|goal|level|trophy|reward)|work(ing)? towards?|something to (aim|work|strive|look forward)|to go\b|until (the )?next|how (far|close)|close to', re.I),
 'collection / trophy case / all in one place': re.compile(r'(badge|trophy|trophies|achievement|milestone|medal|award)s?\s+(collection|list|page|case|cabinet|wall|shelf|history|room|gallery)|trophy (case|room|cabinet)|all (my|the) (badges|trophies|achievements|milestones|medals|awards)|collect(ing)? (badges|trophies|achievements|medals|awards)', re.I),
 'look of the badge: beautiful / cute / nice': re.compile(r'(beautiful|cute|nice|gorgeous|pretty|lovely|cool|well[- ]designed|adorable|fun)\s+(little\s+)?(badges?|trophies|medals?|milestones?|achievements?|awards?|rewards?)|(badges?|trophies|medals?|milestones?|achievements?|awards?)\s+(are|look|is)\s+(so\s+)?(beautiful|cute|nice|gorgeous|pretty|lovely|cool|fun)', re.I),
 'look of the badge: boring / plain / ugly': re.compile(r'(boring|plain|ugly|generic|lame|basic|bland|meaningless|pointless|useless)\s+(badges?|trophies|medals?|milestones?|achievements?|awards?|rewards?)|(badges?|trophies|medals?|milestones?|achievements?|awards?|rewards?)\s+(are|feel|is|seem)\s+(so\s+|kind of\s+|a bit\s+)?(boring|plain|ugly|generic|lame|basic|bland|meaningless|pointless|useless)', re.I),
 'small celebration: animation / haptic / sound': re.compile(r'(little|small|subtle|nice|satisfying|cute|fun)\s+(animation|celebration|confetti|vibration|haptic|sound|chime|ding)|(animation|celebration|confetti|haptic|sound)s?\s+(when|after|for) (you |i )?(reach|hit|complete|finish|earn|get)', re.I),
 'too much: childish / gamified / annoying': re.compile(r'childish|gamif|cheesy|annoying|patroniz|condescend|too much celebration|cringe|kiddy|kiddie|for kids', re.I),
 'too far / unreachable / discouraging': re.compile(r'(too far|unreachable|impossible|never (get|reach)|discourag|overwhelm|daunting)', re.I),
 'date / when reached kept': re.compile(r'(date|day|when) (i|you) (reached|hit|earned|got|achieved)|(reached|earned|achieved) on', re.I),
 'lost / reset / disappeared': re.compile(r'(badges?|milestones?|achievements?|trophies|medals?|awards?|rewards?)[^.]{0,40}(lost|disappear|gone|reset|wiped|taken away|vanish)', re.I),
}
GAME = re.compile(r'finch|habitica|pet|forest|plant|tamagotchi|bird|penguin', re.I)
STRICT = re.compile(r'milestone|badge|trophy|trophies|achievement|award|medal', re.I)
scounts = collections.Counter(); sstars = collections.defaultdict(list); sexamples = collections.defaultdict(list); sapps = collections.defaultdict(set); strict_n = 0
counts = collections.Counter(); stars = collections.defaultdict(list); examples = collections.defaultdict(list); apps = collections.defaultdict(set)
total = mile = 0
for f in files:
    for line in open(f, encoding='utf-8'):
        total += 1
        low = line.lower()
        if not any(k in low for k in ('milestone', 'badge', 'troph', 'achiev', 'award', 'medal', 'reward')): continue
        r = json.loads(line); t = (r.get('title') or '') + ' ' + (r.get('body') or r.get('text') or '')
        if not MILE.search(t): continue
        if APPICON.search(t) and not re.search(r'milestone|trophy|achievement|medal|award', t, re.I): continue
        mile += 1
        s = r.get('rating') or r.get('score') or 0
        for name, rx in THEMES.items():
            if rx.search(t):
                counts[name] += 1; stars[name].append(s); apps[name].add(r.get('app_name'))
                if len(examples[name]) < 40:
                    examples[name].append({'app': r.get('app_name'), 'stars': s, 'id': r.get('review_id'), 'text': t[:600].replace('\n', ' ')})
        # Strict: named milestone words (not "reward" alone); apps whose reward is a pet, plant or game left out.
        if STRICT.search(t) and not GAME.search(r.get('app_name') or ''):
            strict_n += 1
            for name, rx in THEMES.items():
                if rx.search(t):
                    scounts[name] += 1; sstars[name].append(s); sapps[name].add(r.get('app_name'))
                    if len(sexamples[name]) < 60:
                        sexamples[name].append({'app': r.get('app_name'), 'stars': s, 'id': r.get('review_id'), 'text': t[:700].replace('\n', ' ')})
out = {'reviews': total, 'milestone_reviews': mile,
       'themes': {k: {'reviews': counts[k], 'apps': len(apps[k]), 'mean_stars': round(sum(stars[k]) / max(1, len(stars[k])), 2)} for k in THEMES},
       'examples': examples,
       'strict_reviews': strict_n,
       'strict_themes': {k: {'reviews': scounts[k], 'apps': len(sapps[k]), 'mean_stars': round(sum(sstars[k]) / max(1, len(sstars[k])), 2)} for k in THEMES},
       'strict_examples': sexamples}
json.dump(out, open('milestone_feel_scan.json', 'w', encoding='utf-8'), indent=1, ensure_ascii=False)
print(total, mile)
for k in THEMES: print(f"{counts[k]:6d}  {round(sum(stars[k]) / max(1, len(stars[k])), 2):4}  {len(apps[k]):3d} apps  {k}")
print('strict', strict_n)
for k in THEMES: print(f"{scounts[k]:6d}  {round(sum(sstars[k]) / max(1, len(sstars[k])), 2):4}  {len(sapps[k]):3d} apps  {k}")
