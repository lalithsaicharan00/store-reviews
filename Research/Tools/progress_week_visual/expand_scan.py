import json,pathlib,re,collections
R=pathlib.Path(__file__).resolve().parents[2];O=R/'Temp/progress-week'
# Weekly/progress and visual/meaning terms. Language-independent English terms are also run on every record.
pairs={
'af':('week|vordering|statistiek','duidelik|mooi|verwarr|eenvoudig'), 'am':('ሳምንት|ሳምንታዊ|እድገት','ግልጽ|ቆንጆ|ግራ'),
'ar':('أسبوع|اسبوع|إحصائ|تقدم','جميل|واضح|مربك|بسيط'), 'az':('həftə|statistika','aydın|gözəl|qarış|sadə'),
'be':('тыдзень|тыднё|статыстык','зразум|прыгож|блытан'), 'bg':('седмиц|статистик','ясн|красив|обърк|прост'),
'bn':('সপ্তাহ|সাপ্তাহিক|পরিসংখ্যান','পরিষ্কার|সুন্দর|বিভ্রান্ত|সহজ'), 'bs':('sedmic|tjed|statistik','pregled|jasn|lijep|zbun|jednostav'),
'ca':('setman|estadístic','clar|bonic|confús|senzill'), 'cs':('týden|týdn|statistik','přehled|jasn|krás|matouc|jednoduch'),
'da':('uge|statistik','oversku|klar|smuk|forvir|enkel'), 'de':('woche|statistik','übersicht|schön|verwirr|einfach'),
'el':('εβδομάδ|εβδομαδ|στατιστικ','σαφ|όμορφ|μπερδ|απλ'), 'en':('week|statistics|progress','clean|beautiful|clutter|confus|simple|dot|ring|legend'),
'es':('seman|estadístic','clar|bonit|confus|sencill'), 'et':('nädal|statistik','selge|ilus|segad|lihtne'),
'eu':('asteko|estatistik','argi|eder|nahasi|sinple'), 'fa':('هفته|هفتگی|آمار','واضح|زیبا|گیج|ساده'),
'fi':('viikko|viiko|tilasto','selke|kauni|sekav|yksinkert'), 'fr':('semaine|hebdom|statistiq','clair|beau|confus|simple|épur'),
'gl':('seman|estatístic','clar|bonit|confus|sinxel'), 'gu':('અઠવાડિ|સાપ્તાહિક|આંકડા','સ્પષ્ટ|સુંદર|મૂંઝ|સરળ'),
'he':('שבוע|סטטיסטיק','ברור|יפה|מבלבל|פשוט'), 'hi':('सप्ताह|साप्ताहिक|आंकड़','स्पष्ट|सुंदर|भ्रम|सरल|साफ'),
'hr':('tjed|statistik','pregled|jasn|lijep|zbun|jednostav'), 'hu':('heti|statisztik','átláthat|szép|zavar|egyszerű'),
'hy':('շաբաթ|վիճակագր','հստակ|գեղեցիկ|շփոթ|պարզ'), 'id':('minggu|statistik','jelas|indah|bingung|sederhana'),
'is':('viku|tölfræði','skýrt|falleg|rugling|einfald'), 'it':('settiman|statistic','chiar|bell|confus|semplic|pulit'),
'ja':('週|統計|進捗','見やす|美し|分かり|わかり|ごちゃ|シンプル|きれい'), 'ka':('კვირა|სტატისტიკ','ნათელ|ლამაზ|დაბნეულ|მარტივ'),
'kk':('апта|статистик','түсінікт|әдемі|шатас|қарапайым'), 'km':('សប្តាហ៍|ស្ថិតិ','ច្បាស់|ស្អាត|ច្រឡំ|សាមញ្ញ'),
'kn':('ವಾರ|ಅಂಕಿಅಂಶ','ಸ್ಪಷ್ಟ|ಸುಂದರ|ಗೊಂದಲ|ಸರಳ'), 'ko':('주간|통계|진척','깔끔|혼란|복잡|예쁘|아름|간단'),
'ky':('апта|статистик','түшүнүк|кооз|чаташ|жөнөкөй'), 'lo':('ອາທິດ|ສະຖິຕິ','ຊັດ|ງາມ|ສັບສົນ|ງ່າຍ'),
'lt':('savait|statistik','aišk|graž|pain|paprast'), 'lv':('nedēļ|statistik','skaidr|skaist|muls|vienkārš'),
'mk':('недел|статистик','јасн|убав|збун|едностав'), 'ml':('ആഴ്ച|സ്ഥിതിവിവര','വ്യക്ത|മനോഹര|ആശയക്കുഴപ്പ|ലളിത'),
'mn':('долоо хоног|статистик','тодорхой|үзэсгэлэн|ойлгомж|энгийн'), 'mr':('आठवड|साप्ताहिक|आकडेवार','स्पष्ट|सुंदर|गोंधळ|सोप'),
'ms':('minggu|statistik','jelas|cantik|keliru|mudah|kemas'), 'my':('အပတ်|စာရင်းဇယား','ရှင်းလင်း|လှပ|ရှုပ်ထွေး|ရိုးရှင်း'),
'nl':('week|statistiek','duidelijk|mooi|verwarr|overzicht|eenvoudig'), 'no':('uke|statistikk','oversikt|tydelig|vakker|forvirr|enkel'),
'pa':('ਹਫ਼ਤ|ਅੰਕੜ','ਸਪਸ਼ਟ|ਸੁੰਦਰ|ਉਲਝ|ਸਧਾਰਨ'), 'pl':('tygodn|statystyk','czytel|piękn|myląc|prost|przejrz'),
'pt':('seman|estatístic','clar|bonit|confus|simple|limp'), 'ro':('săptămân|statistic','clar|frumos|confuz|simpl'),
'ru':('недель|статистик|прогресс','понят|красив|путан|прост|нагляд'), 'si':('සති|සතිය|සංඛ්‍යාලේඛන','පැහැදිලි|ලස්සන|ව්‍යාකූල|සරල'),
'sk':('týžde|štatistik','prehľad|jasn|krás|mätú|jednoduch'), 'sl':('teden|tedensk|statistik','pregled|jasn|lep|zmeden|preprost'),
'sq':('javë|javore|statistik','qartë|bukur|ngatërr|thjesht'), 'sr':('недељ|nedelj|статистик|statistik','јасн|jasn|леп|lep|збуњ|zbun|једностав|jednostav'),
'sv':('vecka|vecko|statistik','tydlig|vacker|förvirr|enkel|snygg'), 'sw':('wiki|takwimu','wazi|nzuri|changany|rahisi'),
 'ta':('வார|புள்ளிவிவர','தெளிவ|அழக|குழப்ப|எளி'), 'te':('వారం|వారపు|గణాంక','స్పష్ట|అందం|అందమ|గందరగోళ|సులభ'),
 'th':('สัปดาห์|สถิติ','ชัดเจน|สวย|สับสน|เรียบง่าย'), 'tl':('linggo|istatistika','malinaw|maganda|nakakalito|simple'),
 'tr':('hafta|istatistik','açık|güzel|karış|sade'), 'uk':('тижн|статистик','зрозум|красив|плутан|прост'),
 'ur':('ہفتہ|ہفتے|اعداد','واضح|خوبصورت|الجھن|سادہ'), 'uz':('hafta|statistik','aniq|chiroyli|chalkash|oddiy'),
 'vi':('tuần|thống kê','rõ|đẹp|nhầm|đơn giản'), 'zh-CN':('周|统计|进度','清晰|漂亮|美观|混乱|简单|简洁|不懂'),
 'zh-TW':('週|統計|進度','清晰|漂亮|美觀|混亂|簡單|簡潔|不懂'), 'zu':('isonto|izibalo','cacile|hle|dide|lula')}
# Add matches only for language families not already covered by the inherited 17-language screen,
# and for additional Chinese/Japanese/Korean wording. English candidate population is unchanged.
covered={'en','es','pt','fr','de','it','ru','tr','ar','pl','nl','vi','id'}
P=[(k,re.compile(a,re.I),re.compile(b,re.I)) for k,(a,b) in pairs.items() if k not in covered]
old=[json.loads(l) for l in (O/'hits.jsonl').read_text().splitlines()];seen={(x['store'],x['folder'],x['id']) for x in old};extra=[]
for store in ['App','Play','Native']:
 for f in sorted(R.glob(f'{store} Store Reviews/*/reviews.jsonl')):
  for n,l in enumerate(f.open(),1):
   r=json.loads(l); t=(r.get('title') or '')+' — '+(r.get('body') or r.get('text') or '')
   if any(a.search(t) and b.search(t) for _,a,b in P) and (store,f.parent.name,r['review_id']) not in seen:
    extra.append(dict(store=store,folder=f.parent.name,line=n,id=r['review_id'],date=r.get('date'),rating=r.get('rating'),language=r.get('language') or r.get('country'),text=t));seen.add((store,f.parent.name,r['review_id']))
(O/'extra_hits.jsonl').write_text(''.join(json.dumps(r,ensure_ascii=False)+'\n' for r in extra));(O/'language_pairs.json').write_text(json.dumps(pairs,ensure_ascii=False,indent=2));print('Additional candidates',len(extra))
