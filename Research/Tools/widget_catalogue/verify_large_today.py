"""Read-only verification of the accepted Large Today design handoff."""
import json
import re
from verify_delivery import ROOT, BASE as CATALOGUE, check_png

BASE = CATALOGUE / 'Today List/Large Designs — 6 October 2026'


def main():
    state = json.loads((BASE/'Figma State.json').read_text(encoding='utf-8'))
    audit = json.loads((BASE/'Figma Audit.json').read_text(encoding='utf-8'))
    assert state['accepted'] == {'treatment':'Filled only','maximumItemsPerPage':5,'rowGap':12,'headerGap':10,'logicalSize':[338,354],'contentInsets':16}
    assert len(state['cards']) == 16 and len(state['reviews']) == len(audit['cards']) == 18
    assert audit['oldDraftRootsRemoved']
    roles = {
        'Water':('537:2983','509:2873','+1'), 'Read':('537:2985','509:2891','537:3001'),
        'Stretch':('537:2987','509:2879','537:3001'), 'Meditate':('537:2991','509:2885','537:3003'),
        'Walk':('537:2989','509:2873','+500'), 'Steps':('537:2999','509:2885','537:3007'),
        'Check':('537:2993','509:2891','537:3001'), 'Quit':('537:2997','509:2885','537:3007'),
        'Limit':('537:2995','509:2891','+1'), 'TimedLimit':('537:2991','509:2885','537:3003'),
        'HealthSteps':('537:2989','509:2873','537:3007'), 'Task':('537:2993','509:2879','537:3001')}
    rows_checked = 0
    scenes = {s['key']:s for s in state['scenes']}
    for card in audit['cards']:
        assert card['size'] == [338,354] and card['insets'] == [16]*4
        assert card['rowGap'] == 12 and card['headerGap'] == 10
        assert len(card['rows']) <= 5 and card['fonts'] == ['SF Pro']
        assert all(w>=44 and h>=44 for w,h in card['targets'])
        previous_bottom = None
        for row in card['rows']:
            icon,color,action = roles[row['role']]
            assert row['icon'] == icon and row['action'] == action, (card['key'],row)
            assert row['fill'] == (color if row['done'] else '597:7399')
            assert row['content'] == (['597:7400'] if row['done'] else ['369:6'])
            assert row['size'][0] == 306 and row['size'][1]>=44
            assert row['position'][0] == 0 and row['position'][1]+row['size'][1]<=268
            if previous_bottom is not None:
                assert row['position'][1]-previous_bottom == 12
            previous_bottom=row['position'][1]+row['size'][1]
            rows_checked += 1
        scene = scenes[card['sceneKey']]
        assert scene['summary'] in card['header'] or not scene['summary']
        if 'page' in scene:
            assert f"{scene['page']}/{scene['pages']}" in card['header']
            assert scene['pages'] == (scene['total']+4)//5
    assert [len(scenes[k]['rows']) for k in ['Six first page','Six final page']] == [5,1]
    assert [len(scenes[k]['rows']) for k in ['Twelve first page','Twelve middle page','Twelve final page']] == [5,5,2]
    assert scenes['Sixteen first page']['pages'] == scenes['Sixteen final page']['pages'] == 4
    fills=json.loads((BASE/'Progress Fill Audit.json').read_text(encoding='utf-8'))
    assert len(fills)==18
    for view in fills:
        for fill in view['fills']:
            assert 0<fill['width']<=306 and fill['visible']
            assert abs(fill['opacity']-(.26 if view['key'].startswith('Dark') else .15))<.0001
    assert len(next(v for v in fills if v['key']=='Long names and goals')['fills']) == 1
    exports=json.loads((BASE/'Export Manifest.json').read_text(encoding='utf-8'))
    assert len(exports)==20 and sum(e['kind']=='card' for e in exports)==18
    named=set()
    for e in exports:
        path=BASE/'Images'/e['file']; check_png(path,e); named.add(path)
        if e['kind']=='card':
            assert (e['width'],e['height'],e['scale']) == (676,708,2)
    assert named==set((BASE/'Images').glob('*.png'))
    daily=json.loads((CATALOGUE/'Daily Cards/CTA Audit.json').read_text(encoding='utf-8'))
    done={'02 Single checked.png':'509:2885','06 Above quantity goal.png':'509:2873','15 Checklist complete.png':'509:2873'}
    assert len(daily['cards'])==36
    for c in daily['cards']:
        assert len(c['controls'])==1
        control=c['controls'][0]
        assert control['strokes']==0
        assert control['fill']==['VariableID:'+done.get(c['file'],'597:7399')]
        assert all(q['fill']==['VariableID:'+('597:7400' if c['file'] in done else '369:6')] for q in control['content'])
    assert daily['cards'][8]['controls'][0]['content'][0]['text']=='+500'
    counts=[]
    map_path=ROOT/'Research/Research Reports/Home Screen and Visual Design/Today Screen Jobs/Today Jobs Evidence/Q46/review-classification-map.txt'
    for line in map_path.read_text(encoding='utf-8-sig').splitlines():
        if line.startswith('#') or not line.strip(): continue
        codes=line.split('\t')[2].split(',')
        if 'CAP' in codes or 'DUP' in codes: continue
        for code in codes:
            if code.startswith('OWN='):
                values=[float(v) for v in code[4:].split('-')]
                counts.append(sum(values)/len(values))
    assert (len(counts),sum(n<=5 for n in counts),sum(n<=6 for n in counts))==(446,247,283)
    documents=list(BASE.rglob('*.md'))+[ROOT/'iOS/Docs/Checklists/Large Today Widget — Plain and Filled Rows — 6 October 2026.md',ROOT/'iOS/Docs/Checklists/Widget CTA Colors — Match Today Rows — 6 October 2026.md']
    links=0
    for document in documents:
        for match in re.finditer(r'\]\((?:<([^>]+)>|([^\)]+))\)',document.read_text(encoding='utf-8-sig')):
            target=match[1] or match[2]
            if target.startswith(('https:','http:','#','codex:')):continue
            target=target.split('#')[0]
            if target:
                assert (document.parent/target).resolve().exists(),(document,target)
                links+=1
    print(json.dumps({'large_scenarios':16,'review_instances':18,'rows_checked':rows_checked,'max_items_per_page':5,'row_gap':12,'header_gap':10,'unequal_insets':0,'small_action_regions':0,'row_overflow':0,'large_pngs_verified':20,'daily_cta_cards_verified':36,'saved_step_increment':'+500','q46_retained_counts':{'total':446,'at_most_five':247,'at_most_six':283},'local_links_checked':links,'broken_local_links':0,'native_validation':'Pending; Figma geometry and saved artifacts only'},indent=2))


if __name__=='__main__':
    main()
