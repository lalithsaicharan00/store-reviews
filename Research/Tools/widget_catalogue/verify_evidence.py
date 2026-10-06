import json, pathlib, collections, hashlib, re

root = next(p for p in pathlib.Path(__file__).resolve().parents if (p/'RULEBOOK.md').exists())
out = root/'Research/Research Reports/Home Screen and Visual Design/Home Screen Cards and Widgets/Widgets'
rows = json.loads((out/'Verified Review Sources.json').read_text(encoding='utf-8'))
# Hand assignments after reading the complete records; multiple themes may overlap.
# These are an audit set, not a new prevalence or representative preference study.
groups = {
 'basic_paywall_or_withdrawal': 'A1#378 A3#2110 A36#273 A56#18 A56#47 A56#58 A56#59 P2#10978 P2#21989 P9#956 P33#1432 P92#20',
 'paid_value_or_additional_style': 'A7#576 A13#18314 A20#3354 A33#1034 A33#3195 A53#702 P2#6586 P11#4988 P41#439 P70#378',
 'presence_and_motivation': 'A56#38 A1#47724 A3#1218 A3#2110 A3#2439 A3#2623 A3#5428 A3#10015 A4#7692 A7#576 A10#2775 A43#358 A52#19868 A56#18 A56#29 A56#34 A56#39 A56#42 A56#47 A56#59 A56#63 A86#1048 P3#12523 P7#333 P8#4507 P10#5199 P11#5469 P12#62538 P24#12838 P31#235 P70#378',
 'interactive_logging_and_step': 'A7#833 A33#164 A34#14 A36#53 A52#19868 A52#20487 A52#20503 A56#6 A56#18 P2#3461 P2#10978 P2#21989 P3#3999 P3#11092 P3#16323 P11#4988 P18#588 P31#235 P37#566 P54#64',
 'stale_broken_install_or_recovery': 'A3#9924 A10#1904 A20#3354 A23#3669 A33#1034 A33#1143 A33#3195 A56#6 A56#23 A56#37 P3#13159 P9#885 P11#4988 P37#566 P123#253',
 'identity_density_and_multiple_items': 'A1#55119 A3#2623 A23#2427 A23#4768 A24#21966 A33#1602 A36#190 A46#183 A48#1970 A52#19868 A52#20487 A53#702 A53#1515 A56#28 A56#29 A56#47 P3#2515 P3#2935 P3#4943 P3#7376 P3#9578 P3#11777 P9#1116 P54#64 P65#8223',
 'done_list_and_correction_safety': 'A1#45378 A3#1937 A52#19868 A52#20487 A53#702 A53#1515 P2#7613 P2#12909',
 'progress_week_month_heatmap_counter_streak': 'A1#54551 A3#2110 A3#5428 A3#9041 A4#7692 A7#576 A20#576 A20#1431 A23#5913 A33#1602 A34#48 A43#358 A48#2992 A56#2 A56#9 A56#22 A56#23 A56#24 A56#28 A56#47 A56#50 A56#51 A56#63 A76#2527 A76#2530 A84#17 P2#4775 P3#3038 P3#3999 P4#3474 P9#515 P19#272 P24#15545 P24#15751 P65#1793 P65#4338 P65#4560 P65#4619',
 'appearance_labels_dark_tint_transparency': 'A1#792 A1#54551 A1#55032 A1#55119 A3#10509 A10#3798 A13#2237 A13#18314 A16#710 A18#1978 A24#21966 A36#190 A46#183 A52#19868 A56#5 A56#8 A56#9 A56#15 A56#18 A56#19 A56#27 A56#29 A56#30 A56#31 A56#32 A56#33 A56#35 A56#37 A56#39 A56#40 A56#46 A56#48 A56#50 A56#52 A56#59 A56#63 A56#64 A56#66 A76#2530 A84#17 P2#4775 P2#8373 P3#2515 P3#7376 P3#11777 P9#636 P9#885 P14#146 P37#439 P65#5707 P65#8223 P70#378',
 'general_app_context_not_widget_specific': 'A3#1529 A1#55032 A3#9041 A13#2237 A13#18314 A16#710 A18#1978 A20#576 A20#1431 A20#1656 A23#2427 A23#5913 A24#21966 A34#48 A36#53 A46#183 A48#2992 A56#0 A56#1 A56#2 A56#3 A56#4 A56#5 A56#7 A56#8 A56#9 A56#10 A56#11 A56#12 A56#13 A56#14 A56#15 A56#16 A56#17 A56#19 A56#20 A56#21 A56#22 A56#23 A56#24 A56#25 A56#26 A56#27 A56#31 A56#32 A56#33 A56#35 A56#36 A56#37 A56#40 A56#41 A56#43 A56#44 A56#45 A56#46 A56#48 A56#49 A56#50 A56#51 A56#52 A56#53 A56#54 A56#55 A56#56 A56#57 A56#58 A56#60 A56#61 A56#62 A56#64 A56#65 A56#66 A76#2527 A76#2530 A84#17 A86#1689',
}
known = {r['ref']: r for r in rows}
previous=json.loads((out/'Historical Research/iPhone Widget Evidence/primary_reviews.json').read_text(encoding='utf-8'))
for old in previous:
    assert old['ref'] in known and old['id']==known[old['ref']]['id'], ('prior id mismatch',old['ref'])
themes = collections.defaultdict(list)
for theme, refs in groups.items():
    refs = refs.split()
    assert len(refs)==len(set(refs)), (theme,'duplicate')
    for ref in refs:
        assert ref in known, ('unknown',ref)
        themes[ref].append(theme)
unassigned = set(known)-set(themes)
assert not unassigned, ('unassigned',sorted(unassigned))
cache = {}
for r in rows:
    path = root/r['source']
    if r['source'] not in cache:
        cache[r['source']] = [json.loads(line) for line in path.open(encoding='utf-8')]
    original = cache[r['source']][r['source_index']]
    assert original == r['record'], ('source mismatch',r['ref'])
    assert str(original['review_id']) == r['id'], ('id mismatch',r['ref'])
    r['themes'] = themes[r['ref']]
    r['scope'] = 'iOS store review' if r['ref'].startswith('A') else 'Android store review; transfer cautiously'
(out/'Verified Review Sources.json').write_text(json.dumps(rows,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
index = ['# Verified Review Index','', 'Written by Codex, 5 October 2026.','',
 '181 complete originals reopened and read: 128 App Store and 53 Play Store records. This deliberately selected audit set combines prior cited evidence and all 67 Dots originals. It is not a representative sample, a new whole-corpus coding exercise or a preference-rate denominator. General app-context records are labelled explicitly. A/P references use numbered app folders and zero-based JSONL line indices. Original language/text and theme membership are preserved in [Verified Review Sources.json](<Verified Review Sources.json>).','',
 'Theme assignments are human judgements made after reading. They validate examples, not the missing September study classification. Some old iOS reviews concern the former Today extension; they establish a historical need, not the behavior of iOS 26. Dots reviews praise its then-free offering; its current listing differs. No country-level conclusions or new star averages are drawn.','',
 '| Reference | Stable review ID | Platform | Date | Stars | Themes | Original source |','|---|---|---|---|---|---|---|']
for r in rows:
    v=r['record'];date=v['date'][:10]
    index.append(f"| `{r['ref']}` | `{r['id']}` | {'iOS' if r['ref'][0]=='A' else 'Android'} | {date} | {v['rating']} | {', '.join(r['themes'])} | {r['source']} (index {r['source_index']}) |")
(out/'Verified Review Index.md').write_text('\n'.join(index)+'\n',encoding='utf-8')
summary=json.loads((root/'Research/Temp/widget_oct5_scan/summary.json').read_text(encoding='utf-8'))
summary['audit']={'complete_records_read':len(rows),'app_store':128,'play_store':53,'numbered_app_corpora':len({r['ref'].split('#')[0] for r in rows}),'source_matches':len(rows),'unknown_refs':0,'within_theme_duplicates':0,'unassigned_records':0,'prior_full_coding_available':False}
summary['input_sha256']={s:hashlib.sha256((root/s).read_bytes()).hexdigest() for s in cache}
(out/'Scan and Verification Summary.json').write_text(json.dumps(summary,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
print(json.dumps(summary['audit']))
