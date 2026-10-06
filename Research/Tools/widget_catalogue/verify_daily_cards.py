"""Read-only verification of the daily-card research/design handoff."""
from collections import defaultdict
import json
import re

from verify_delivery import ROOT, BASE as CATALOGUE, check_png

BASE = CATALOGUE / 'Daily Cards'


def main():
    sources = json.loads((BASE / 'Verified Review Sources.json').read_text(encoding='utf-8'))
    known = {row['ref'] for row in sources}
    assert len(sources) == len(known) == 37
    requests = defaultdict(dict)
    for row in sources:
        assert row['themes'] and len(row['themes']) == len(set(row['themes'])), row['ref']
        requests[row['source']][row['source_index']] = row
    verified = 0
    for source, expected in requests.items():
        with (ROOT / source).open(encoding='utf-8') as stream:
            for index, line in enumerate(stream):
                if index not in expected:
                    continue
                row = expected[index]
                original = json.loads(line)
                assert original == row['record'], row['ref']
                assert str(original.get('review_id', original.get('id'))) == row['id'], row['ref']
                verified += 1
    assert verified == len(sources)
    report = (BASE / 'Daily Progress Widgets — Layout and Actions.md').read_text(encoding='utf-8')
    cited = set(re.findall(r'[AP]\d+#\d+', report))
    assert cited <= known, cited-known

    exports = json.loads((BASE / 'Export Manifest.json').read_text(encoding='utf-8'))
    assert len(exports) == 48
    named = set()
    for row in exports:
        path = BASE / 'Images' / row['file']
        assert path not in named
        named.add(path)
        check_png(path,row)
        assert re.fullmatch(r'\d+:\d+',row['node_id']), row
        if row['kind'] == 'card':
            assert (row['width'],row['height']) == (158,158), row
    assert named == set((BASE / 'Images').glob('*.png'))
    assert sum(row['kind']=='card' for row in exports) == 42

    scenarios = json.loads((BASE / 'Scenarios.json').read_text(encoding='utf-8'))
    audit = json.loads((BASE / 'Figma Audit.json').read_text(encoding='utf-8'))
    assert len(scenarios) == len(audit['cards']) == 29
    assert len(audit['scope_examples']) == 3
    supplemental = json.loads((BASE / 'Supplemental Scenarios.json').read_text(encoding='utf-8'))
    assert len(supplemental) == len(audit['supplemental_cards']) == 4
    main_audit = json.loads((BASE / 'Main Audit.json').read_text(encoding='utf-8'))
    assert len(main_audit['latest_commits']) == 15
    assert all(row['identical_to_prior_baseline'] for row in main_audit['runtime_sources'])
    assert audit['counts'] == {'semantic_variants':29,'numeric_value_overflows':0,'unequal_insets':0,'small_action_targets':0,'additional_scope_examples':3,'supplemental_cards':4}
    all_scenarios = scenarios + supplemental
    all_cards = audit['cards'] + audit['supplemental_cards']
    for scenario,card in zip(all_scenarios,all_cards):
        assert scenario['key'] == card['key']
        assert scenario['name'] == card['name'] and scenario['value'] == card['value']
        assert card['value_fits'] and card['shell_is_instance'] and card['bound_inset']
        assert set(card['insets'].values()) == {16}
        assert len(card['action_targets']) == 1
        assert all(target['width']>=44 and target['height']>=44 for target in card['action_targets'])
        assert all(font['family']=='SF Pro' for font in card['fonts'])
        assert card['group_positions'] == {'header_y':16,'name_y':71,'value_y':93,'capsule_y':124}
    cards_by_key = {card['key']:card for card in all_cards}
    assert cards_by_key['Quit no slips']['value'] == '15d 22:36:35'
    assert cards_by_key['Quit slip recorded']['value'] == '0d 00:04:12'
    assert cards_by_key['Quit no slips']['capsule'] == 'Best 45 days'
    assert cards_by_key['Daily limit reached']['capsule'] == 'Limit reached'
    assert cards_by_key['Daily limit exceeded']['capsule'] == 'Over the limit'
    for key in ['Daily limit below','Daily limit reached','Daily limit exceeded']:
        assert cards_by_key[key]['capsule_typography'] == {'size':12,'style':'Medium'}
    assert {row['id'] for row in audit['existing_sections']} == {'509:3114','509:3116'}

    typography = json.loads((BASE/'Typography Audit.json').read_text(encoding='utf-8'))
    assert len(typography['cards']) == 42
    captions_checked = 0
    for card in typography['cards']:
        assert card['size'] == [158,158] and card['value_fits'], card['file']
        assert len(card['action_targets']) == 1
        assert all(t['width'] >= 44 and t['height'] >= 44 for t in card['action_targets'])
        for label in card['captions']:
            assert label['size'] == 12 and label['font'] == 'Medium' and label['inside'], label
            assert label['style'] == 'S:48ab282aa77e651b1c49cc3c8f47c838052df7c0,'
            captions_checked += 1
    assert captions_checked == 25
    recovery = json.loads((BASE/'Recovery State.json').read_text(encoding='utf-8'))
    assert len(recovery['reviews']) == 6
    assert {r['node_id'] for r in recovery['reviews']} == {r['node_id'] for r in typography['cards'][36:]}
    assert {r['key'] for r in recovery['reviews']} == {'Choose a habit','No habits yet','Selection unavailable','Content hidden','Open to update','Save recovery'}
    dark = typography['dark']
    assert len(dark) == 5
    for row in dark:
        supporting = [t for t in row['texts'] if t['text'] in {'Edit Widget','Open app'}]
        assert len(supporting) == 1 and supporting[0]['size'] == 12 and supporting[0]['font'] == 'Medium'
    assert any(t['text']=='Check in the app' for t in dark[-1]['texts'])
    assert all(t['text'] != '1 cup today' for row in dark for t in row['texts'])

    documents = list(BASE.rglob('*.md')) + [
        ROOT/'iOS/Docs/Checklists/Daily Widget — Layout and Actions — 5 October 2026.md',
    ]
    links = 0
    for document in documents:
        text = document.read_text(encoding='utf-8-sig')
        for match in re.finditer(r'\]\((?:<([^>]+)>|([^\)]+))\)',text):
            target = match[1] or match[2]
            if target.startswith(('https:','http:','#','codex:')):
                continue
            relative = target.split('#')[0]
            if relative:
                assert (document.parent/relative).resolve().exists(),(document,target)
                links += 1
    print(json.dumps({'source_originals_verified':verified,'unassigned_records':0,'unknown_cited_refs':0,'cited_review_refs':len(cited),'pngs_verified':len(named),'individual_cards':42,'semantic_variants':29,'scope_examples':3,'supplemental_cards':4,'recovery_cards':6,'supporting_labels_checked':captions_checked,'supporting_typography':'12 pt Medium','recent_main_commits_audited':15,'value_overflows':0,'unequal_insets':0,'small_action_targets':0,'local_links_checked':links,'broken_local_links':0,'native_validation':'Pending; not performed by this script'},indent=2))


if __name__ == '__main__':
    main()
