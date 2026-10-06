"""Read-only verification of the Medium Today design delivery, not native behavior."""
import json
import re
from verify_delivery import ROOT, BASE as CATALOGUE, check_png

BASE=CATALOGUE/'Today List/Medium Designs — 6 October 2026'


def intersects(a,b):
    return a[0]<b[0]+b[2] and b[0]<a[0]+a[2] and a[1]<b[1]+b[3] and b[1]<a[1]+a[3]


def main():
    state=json.loads((BASE/'Figma State.json').read_text(encoding='utf-8'))
    audit=json.loads((BASE/'Figma Audit.json').read_text(encoding='utf-8'))
    assert len(state['cards'])==21 and len(state['reviews'])==len(audit['cards'])==24
    assert state['accepted']['maximumItemsPerPage']==2
    assert len(state['foundation']['styleIds'])==5
    assert state['finalStyleAudit']['preserved']=={'largeRows':24,'largeScenarios':16,'largeBoardId':'608:8033'}
    for v in state['finalStyleAudit']['tokens']:
        assert 'ALL_SCOPES' not in v['scopes'] and v['syntax']['iOS']
        if v['name'].startswith('medium-today/'):
            assert v['values']['620:0']['type']=='VARIABLE_ALIAS'
    scenes={s['key']:s for s in state['scenes']}
    role_fractions={'Water':.375,'Read':1,'Stretch':1,'Meditate':.6,'Walk':.4,'Steps':.4,'Check':0,'Quit':0,'Limit':0,'TimedLimit':0,'HealthSteps':.4,'Task':0}
    roles={'Water':('537:2983','509:2873','+1'),'Read':('537:2985','509:2891','537:3001'),'Stretch':('537:2987','509:2879','537:3001'),'Meditate':('537:2991','509:2885','537:3003'),'Walk':('537:2989','509:2873','+500'),'Steps':('537:2999','509:2885','537:3007'),'Check':('537:2993','509:2891','537:3001'),'Quit':('537:2997','509:2885','537:3007'),'Limit':('537:2995','509:2891','+1'),'TimedLimit':('537:2991','509:2885','537:3003'),'HealthSteps':('537:2989','509:2873','537:3007'),'Task':('537:2993','509:2879','537:3001')}
    row_count=target_count=0
    for card in audit['cards']:
        scene=scenes[card['sceneKey']]
        assert card['size']==[338,158] and card['insets']==[12]*4
        assert (card['headerHeight'],card['headerGap'])==(22,12)
        assert card['fonts']==['SF Pro'] and not card['clipping']
        capacity=scene.get('capacity',2)
        assert len(card['rows'])==len(scene['rows'])<=capacity
        if card['rows']:assert card['rowGap']==12
        header={t['name']:t['text'] for t in card['header']}
        assert header['View title']==scene['title']
        if scene['summary']:assert header['Whole-view day progress']==scene['summary']
        else:assert 'Whole-view day progress' not in header
        if 'page' in scene:
            assert header['Page indicator']==f"{scene['page']}/{scene['pages']}"
            assert scene['pages']==(scene['total']+capacity-1)//capacity
            assert len(card['headerTargets'])==3
            previous=next(t for t in card['headerTargets'] if 'previous' in t['name'])
            nxt=next(t for t in card['headerTargets'] if 'next page' in t['name'])
            assert abs(previous['opacity']-(.22 if scene['page']==1 else 1))<.0001
            assert abs(nxt['opacity']-(.22 if scene['page']==scene['pages'] else 1))<.0001
        else:
            assert len(card['headerTargets'])==1 and 'Page indicator' not in header
        targets=[t['bounds'] for t in card['headerTargets']]
        for i,(row,raw) in enumerate(zip(card['rows'],scene['rows'])):
            cfg={'role':raw} if isinstance(raw,str) else raw
            role=cfg['role'];icon,color,action=roles[role]
            assert row['icon']==icon and row['action']==cfg.get('glyph',action)
            done=cfg.get('done',bool(re.search(r'(?:^|· )Done$',row['status']['text'])))
            assert row['ctaFill']==[color if done else '597:7399']
            assert all(c==['597:7400' if done else '369:6'] for c in row['ctaContent'])
            bounds=row['bounds'];height=100 if len(scene['rows'])==1 and ('page' not in scene or capacity==1) else 44
            assert bounds==[12,46+i*56,314,height]
            targets.append(row['actionBounds'])
            fraction=0 if cfg.get('periodOnly') else cfg.get('fraction',role_fractions[role])
            visible=[f for f in row['progress'] if f['visible']]
            if fraction:
                assert len(visible)==1
                f=visible[0]
                assert abs(f['width']-314*min(1,fraction))<.02 and f['height']==height
                assert abs(f['opacity']-(.26 if card['dark'] else .15))<.0001
            else:assert not visible
            assert row['status']['height']>=row['status']['line']
            if role in {'Limit','TimedLimit','Quit'}:assert row['status']['font']=='Semibold' and not done
            row_count+=1
        for i,target in enumerate(targets):
            x,y,w,h=target
            assert w>=44 and h>=44 and x>=0 and y>=0 and x+w<=338 and y+h<=158
            assert not any(intersects(target,other) for other in targets[i+1:])
            target_count+=1
    exports=json.loads((BASE/'Export Manifest.json').read_text(encoding='utf-8'))
    assert len(exports)==26 and sum(e['kind']=='card' for e in exports)==24
    named=set()
    for e in exports:
        path=BASE/'Images'/e['file'];check_png(path,e);named.add(path)
        if e['kind']=='card':assert (e['width'],e['height'],e['scale'])==(676,316,2)
    assert named==set((BASE/'Images').glob('*.png'))
    links=0
    for document in list(BASE.rglob('*.md'))+[ROOT/'iOS/Docs/Checklists/Medium Today Widget — Today and Selected Section — 6 October 2026.md']:
        for m in re.finditer(r'\]\((?:<([^>]+)>|([^\)]+))\)',document.read_text(encoding='utf-8-sig')):
            target=m[1] or m[2]
            if target.startswith(('https:','http:','#','codex:')):continue
            target=target.split('#')[0]
            if target:
                assert (document.parent/target).resolve().exists(),(document,target)
                links+=1
    print(json.dumps({'medium_scenarios':21,'review_instances':24,'rows_checked':row_count,'action_and_header_regions_checked':target_count,'max_items_per_page':2,'larger_text_capacity':1,'row_gap':12,'visible_insets':12,'clipped_text':0,'overlapping_action_regions':0,'pngs_verified':26,'local_links_checked':links,'broken_local_links':0,'native_validation':'Pending; saved Figma/artifact checks only'},indent=2))


if __name__=='__main__':main()
