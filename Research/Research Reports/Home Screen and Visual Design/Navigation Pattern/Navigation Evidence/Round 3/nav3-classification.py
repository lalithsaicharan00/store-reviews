# Navigation round 3 (30 Sep 2026): hand codes for every relevant review in DUP/ORG/ICON/FILT.tsv.
# Every other matched review was read and judged not about app navigation (duplicate a habit, charged twice,
# "setting up", three lines of text, workout filters, spreadsheet filters...). Run to validate.
CODES = {
 # --- the same thing in two places ---
 'DUP-':  ['A1#52156','A10#56067','A24#5502','A24#6939','A24#26879','A24#32800','A24#40349','N5#13237','N7#12920','P2#5440','P8#11641'],  # redundant places / too many ways
 'DUPX':  ['A24#32854','A24#37242'],   # two ways in that behave differently
 'DUP+':  ['A1#51697','A59#12429','N10#20335'],  # several ways in praised or asked for
 # --- menus and settings ---
 'HIDE':  ['A1#2380','A10#9377','A10#20221','A10#43886','P2#11332','A31#3273','P122#6103','P12#55311'],  # wanted up front, found only in a menu/settings
 'FIND':  ['A1#46092','A54#188','P111#3173','A4#4527','P9#16','N4#3547','P63#248','P8#383','N3#3070'],  # couldn't find a setting
 'SPLIT': ['A23#2164','P84#15258','P4#3964','A1#50835','A24#24005'],  # one kind of setting split across places
 'WRONG': ['P8#9660','P97#3716'],     # a setting somewhere illogical
 'RARE':  ['A43#135','P106#517'],     # rarely used things should move to settings
 'MESS':  ['A23#2168','A23#1978','P111#3363','N1#8840','N2#1935','N4#3765','N5#12898','N8#27942'],
 'ORG+':  ['A31#2514','A31#3191','P126#36529','P84#11617','P9#344','N3#26328','P84#9473','P84#11365','P84#26927','P84#30393','P84#7617','P84#18803'],
 # --- the ≡ icon and drawer ---
 'DR-':   ['P111#2283','P8#3301','P84#26595','P84#32890','P97#2690','N7#6167','N8#24838','N8#22673'],
 'SWIPE': ['P97#3628','N6#6260'],     # expects a swipe to open the ≡ menu
 'DR+':   ['A10#29500','N6#4827','N6#4840'],
 'HELPM': ['P125#19566'],             # wants help/tutorial in the ≡ menu
 # --- the filter button (habit and to-do apps) ---
 'F-GROUP':  ['A1#52733','A1#54362','A4#11733','A4#18418','A41#94','A48#2755','A76#2240','P14#276','P2#7223','P2#7900','P2#8885','P2#9611','P2#12391','P24#16145','P3#5243','P3#6824','P3#8431','P36#194','P50#116','P8#8923','P8#8814','P8#10203'],
 'F-TIME':   ['A1#49150','A1#53099','A33#3588','P3#6444','P8#15936'],
 'F-STATUS': ['A43#218','P65#1864','P8#121','P125#17759','A41#755'],
 'F-SORT':   ['A54#295','A85#983','P106#965','P8#4866','A76#4950'],    # wants arrange/sort beside the filter
 'F-SECT':   ['A1#54664','A31#4696','P14#95','P20#116'],              # wants groups shown as sections, not only a filter
 'F-KEEP':   ['A1#55065','P8#13267'],                                  # the filter resets on reopen
 'F-ICON':   ['P49#3684'],                                             # settings icon mistaken for a filter icon
}
if __name__ == '__main__':
    import os
    here = os.path.dirname(os.path.abspath(__file__))
    ids = {}
    for f in ['DUP','ORG','ICON','FILT']:
        for l in open(os.path.join(here, f + '.tsv'), encoding='utf-8'):
            ids.setdefault(l.split('\t')[0], f)
    allc = [i for v in CODES.values() for i in v]
    unknown = [i for i in allc if i not in ids]
    dups = {k: [i for i in set(v) if v.count(i) > 1] for k, v in CODES.items()}
    print('unknown IDs:', unknown); print('intra-code duplicates:', {k: v for k, v in dups.items() if v})
    for k, v in CODES.items(): print(f'{k:9} {len(v)}')
    print('distinct reviews coded:', len(set(allc)), 'of', len(ids), 'matched')
