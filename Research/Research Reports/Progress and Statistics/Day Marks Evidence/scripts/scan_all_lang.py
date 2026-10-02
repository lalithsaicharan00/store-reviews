# Day-mark styles across every language (2 Oct 2026). Each style has terms in the corpus's languages; a mention is a
# sentence holding one. Sentiment comes from the review's stars (4–5★ = a positive mention), the same for every
# language, then a hand-checked random sample per style gives the share that truly praises that style.
import json, glob, re, collections, random, sys
CAL = (r"(calendar|calendario|calendário|calendrier|kalender|календар|takvim|kalendarz|kalendář|naptár|ημερολόγιο|lịch|"
       r"تقويم|לוח שנה|ปฏิทิน|日历|日曆|月历|カレンダー|달력|캘린더|\bdays?\b|\bdías?\b|\bdias?\b|\bjours?\b|\btage?n?\b|\bgiorni\b|"
       r"дн[ейяи]|\bgün|\bdni\b|\bhari\b|\bngày\b|天|日|일|\bmonth|mes\b|mês|mois|monat|mese|месяц|\bay\b|miesiąc|\bweek|semana|semaine|woche|settimana|недел|hafta|tydzień|周|週|주)")
FILL = (r"(fill|clos|complet|llen|cerr|preench|fech|rempl|ferm|füll|schließ|vollst|riemp|chiud|заполн|закры|выполн|doldur|tamamla|"
        r"wypełn|zamyk|ukończ|\bvul|sluit|voltooi|\bisi\b|penuh|selesai|lấp|hoàn thành|ملء|اكتمال|إكمال|填|满|滿|完成|闭合|埋ま|満た|閉じ|塗|채우|채워|완성|닫)")
CALONLY = (r"(calendar|calendario|calendário|calendrier|kalender|календар|takvim|kalendarz|kalendář|naptár|ημερολόγιο|lịch|تقويم|לוח שנה|ปฏิทิน|"
           r"日历|日曆|月历|カレンダー|달력|캘린더|\bmonth|\bmes\b|\bmês\b|\bmois\b|monat|\bmese\b|месяц|miesiąc|\bweekly view|history|historial|histórico|historique|verlauf|история|"
           r"\brow\b|in a row|seguid|seguidos|d'affilée|hintereinander|подряд|üst üste|z rzędu|连续|連續|連続|연속|streak|racha|sequência|série|serie|серия|seri)")
STYLES = {
 'heatmap': (r"(heat ?-?maps?|github|contribution (?:graph|chart|grid|calendar)|year in pixels|life in pixels|grid of (?:little |small |colou?red )?(?:squares|boxes|tiles|cells)|"
             r"(?:little|small|colou?red|green) (?:squares|tiles|boxes|cells)|(?:fill(?:ing)?|colou?r(?:ing)?|light(?:ing)? up) (?:in )?(?:the |all the |those )?(?:squares|tiles|boxes|cells)|"
             r"mapa de calor|mapa de calor|cuadr(?:ito|ado|o)s(?: de colores)?|cuadrícula|casillas de colores|quadradinhos|quadrados coloridos|grade de quadrados|"
             r"carte de chaleur|petits carrés|carrés colorés|cases colorées|wärmekarte|kästchen|kacheln|bunte quadrate|mappa di calore|quadratini|caselle colorate|"
             r"теплов(?:ая|ую) карт|хитмап|квадратик|клеточк|ısı haritası|renkli kareler|kutucuk|mapa cieplna|kwadracik|kratk|vakjes|hokjes|vierkantjes|"
             r"peta panas|kotak-kotak|bản đồ nhiệt|ô vuông|خريطة حرارية|مربعات|נקשه حرارتی|מפת חום|ריבועים|čtverečk|kostičk|"
             r"热力图|熱力圖|热图|熱圖|热度图|贡献图|格子|方格|小方块|小方塊|ヒートマップ|草を生や|草が生え|マス目|히트맵|잔디|แผนที่ความร้อน)", None),
 'checks_x': (r"(red x|big x|green check|ticks? and (?:x|crosses)|checks? and x'?s|check or x|tick or (?:x|cross)|\bx'?s on|crosses on|✓.{0,12}✗|✔.{0,12}✘|✅.{0,12}❌|❌.{0,12}✅|"
              r"palomitas? y tach|tachar|tachad|\bcruces\b|häkchen und kreuz|kreuzchen|ankreuz|крестик|хрестик|çarpı|krzyżyk|kruisje|silang|dấu x|"
              r"打叉|画叉|叉叉|○×|〇×|バツ|x표|엑스표|"
              r"check ?marks?|tick ?marks?|\bticks\b|\bchecks\b|✓|✔|✅|☑|palomitas?|\bvistos\b|coches|cocher|\bhaken\b|spunt\w*|галоч\w*|\btik\b|ptaszk\w*|vinkjes?|centang|dấu tích|علامة صح|打勾|打钩|对勾|對勾|チェックマーク|체크 ?표시)", "WEAKCHECK"),
 'rings': (r"(\brings?\b|\bcircles?\b|progress wheel|donut|pie charts?|anillos?|círculos?|\baros?\b|anéis|anel|cercles?|anneaux|\bringe?\b|\bkreise?\b|anell[io]|cerch[io]|"
           r"кольц|кружоч|круг|halka|daire|pierścień|kółk|cirkel|lingkaran|vòng tròn|حلق|دائر|圆环|圓環|圆圈|圓圈|圈|リング|円|丸|링|원형|동그라미|วงกลม)", FILL),
 'chain': (r"(seinfeld|break the chain|\bchains?\b|chaining|cadena|não quebr\w* a corrente|quebrar a corrente|corrente de dias|chaîne|\bkette\b|catena|цепочк|цеп[ьи]|zincir|łańcuch|ketting|rantai|chuỗi|سلسلة|שרשרת|řetěz|"
           r"链条|鏈|连锁|不要中断|チェーン|鎖|체인|사슬)", None),
 'dots': (r"(\bdots?\b|puntitos|bolinhas|petits points|pünktchen|puntini|точк|noktalar|kropk|stipjes|titik|chấm|نقاط|圆点|圓點|小点|ドット|도트)", CALONLY),
 'stamps_stickers': (r"(stickers?|\bstamps?\b|sellos?|pegatinas|estampas|figurinhas|adesivos|carimbos?|tampons?|autocollants|gommettes|\bstempel\b|aufkleber|timbri|"
                     r"наклейк|стикер|штамп|печат|çıkartma|damga|naklejk|pieczątk|stempels?|stiker|nhãn dán|ملصق|印章|贴纸|貼紙|盖章|蓋章|スタンプ|シール|ハンコ|はんこ|스탬프|도장|스티커)", CAL),
}
EXCL = {
 'heatmap': re.compile(r"(on github|github (?:repo|page|issue|link)|open ?source|muscle|músculo|мышц)", re.I),
 'rings': re.compile(r"(ring ?tone|ringing|circle back|inner circle|circle of friends|go(?:ing)? in circles|круглосуточ|вокруг|кругом)", re.I),
 'chain': re.compile(r"(supply chain|block ?chain|chain ?saw|food chain|key ?chain|cadena de suministro|цепочка поставок|блокчейн)", re.I),
 'stamps_stickers': re.compile(r"(time ?stamps?|timestamp|date ?stamp|marca de tiempo|временн)", re.I),
 'dots': re.compile(r"(three dots|3 dots|dots? menu|tres puntos|três pontos|трёх точ|трех точ|три точк)", re.I),
}
SKIP_APPS = ('Hevy',)
STRONG = re.compile(r"(red x|big x|green check|ticks? and (?:x|crosses)|checks? and x'?s|check or x|tick or (?:x|cross)|\bx'?s on|crosses on|✓.{0,12}✗|✔.{0,12}✘|✅.{0,12}❌|❌.{0,12}✅|palomitas? y tach|tachar|tachad|\bcruces\b|häkchen und kreuz|kreuzchen|ankreuz|крестик|хрестик|çarpı|krzyżyk|kruisje|silang|dấu x|打叉|画叉|叉叉|○×|〇×|バツ|x표|엑스표)", re.I)
SPLIT = re.compile(r"(?<=[.!?。！？\n])\s*")
res = {k: [] for k in STYLES}
lang_total = collections.Counter()
for f in glob.glob("App Store Reviews/*/reviews.jsonl") + glob.glob("Play Store Reviews/*/reviews.jsonl"):
    folder = f.split('/')[1].split('. ', 1)[-1]
    if any(s in folder for s in SKIP_APPS): continue
    store = 'app' if f.startswith('App') else 'play'
    for line in open(f, errors='ignore'):
        try: d = json.loads(line)
        except Exception: continue
        text = (d.get('title') or '') + '. ' + (d.get('body') or d.get('text') or '')
        if len(text) < 8: continue
        lg = d.get('language') or d.get('country') or '?'
        lang_total[lg] += 1
        try: r = int(d.get('rating'))
        except Exception: r = None
        sents = None
        for k, (pat, ctx) in STYLES.items():
            if not re.search(pat, text, re.I): continue
            if sents is None: sents = [s for s in SPLIT.split(text) if s.strip()]
            for s in sents:
                m = re.search(pat, s, re.I)
                if not m: continue
                if k in EXCL and EXCL[k].search(s): continue
                if ctx == "WEAKCHECK":
                    if not STRONG.search(s) and not re.search(CALONLY, s, re.I): continue
                elif ctx and not re.search(ctx, s, re.I): continue
                res[k].append({'app': folder, 'store': store, 'lang': lg, 'r': r, 'id': str(d.get('review_id') or d.get('id') or ''), 'term': m.group(0), 's': s.strip()[:300]})
                break
json.dump(res, open('Temp/mark_styles/all_lang.json', 'w'), ensure_ascii=False)
for k, v in res.items():
    pos = [x for x in v if x['r'] and x['r'] >= 4]
    langs = collections.Counter(x['lang'] for x in v)
    print(f"{k:16} mentions={len(v):6} in4-5★={len(pos):6} apps={len({x['app'] for x in v}):3} non-English={sum(c for l,c in langs.items() if l not in ('en','us','gb','ca','au','nz','ie','in','za','ph','sg')):5}  top langs={langs.most_common(8)}")
