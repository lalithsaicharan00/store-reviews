# Heat-map expectations (2 Oct 2026): every review, in any language, that talks about a heat map / grid of days.
# A: any app, the review names a heat map. B: apps built around a heat map, the review talks about its grid or visual.
import json, glob, re
HM = re.compile(r"(heat ?-?maps?|github|contribution (?:graph|chart|grid|calendar)|year in pixels|life in pixels|grid of (?:little |small |colou?red )?(?:squares|boxes|tiles|cells)|"
    r"(?:little|small|colou?red|green|empty) (?:squares|tiles|boxes|cells)|(?:fill(?:ing)?|colou?r(?:ing)?|light(?:ing)? up) (?:in )?(?:the |all the |those )?(?:squares|tiles|boxes|cells)|"
    r"mapa de calor|cuadr(?:ito|ado)s(?: de colores)?|cuadros de colores|casillas de colores|quadradinhos|quadrados coloridos|carte de chaleur|petits carrés|carrés colorés|cases colorées|"
    r"wärmekarte|kästchen|kacheln|mappa di calore|quadratini|теплов(?:ая|ую) карт|хитмап|квадратик|клеточк|ısı haritası|renkli kareler|mapa cieplna|kwadracik|vakjes|hokjes|"
    r"peta panas|bản đồ nhiệt|ô vuông|خريطة حرارية|מפת חום|čtverečk|热力图|熱力圖|热图|熱圖|热度图|贡献图|格子|方格|小方块|小方塊|ヒートマップ|草を生や|マス目|히트맵|잔디)", re.I)
VISUAL = re.compile(r"(square|grid|box|tile|cell|pixel|block|colou?r|shade|darker|lighter|calendar|heat|github|year|month|week|visual|graph|chart|view|"
    r"cuadr|casilla|color|calendario|quadrad|grade|cor\b|cores|carré|case|grille|couleur|kästchen|kachel|raster|farbe|kalender|quadrat|griglia|colore|"
    r"квадрат|клет|сетк|цвет|календар|kare|kutu|renk|takvim|kwadrat|krat|kolor|kalendarz|vak|hok|kleur|kotak|warna|kalender|ô|màu|lịch|مربع|لون|تقويم|"
    r"格|方块|方塊|颜色|顏色|日历|日曆|热力|ヒート|マス|色|カレンダー|잔디|칸|색|달력|히트)", re.I)
HM_APPS = ("HabitKit", "Habit Pixel", "everyday", "Evoday", "HabitGrid", "Ripples", "HabitSwipe", "Pixel Habit", "Tessari", "HabitRix")
rows = {}
for f in glob.glob("App Store Reviews/*/reviews.jsonl") + glob.glob("Play Store Reviews/*/reviews.jsonl"):
    folder = f.split('/')[1]
    hm_app = any(a in folder for a in HM_APPS)
    if 'Hevy' in folder: continue
    for line in open(f, errors='ignore'):
        try: d = json.loads(line)
        except Exception: continue
        text = ((d.get('title') or '') + ' — ' + (d.get('body') or d.get('text') or '')).strip(' —')
        if len(text) < 15: continue
        a = bool(HM.search(text))
        b = hm_app and bool(VISUAL.search(text)) and len(text) >= 40
        if not (a or b): continue
        if a and re.search(r"(on github|github (?:repo|page|issue)|open ?source|source code)", text, re.I) and not re.search(r"(graph|chart|grid|style|like github|squares|contribution)", text, re.I):
            continue
        rid = str(d.get('review_id') or d.get('id') or '')
        rows[rid] = {'id': rid, 'app': folder, 'store': 'app' if f.startswith('App') else 'play', 'lang': d.get('language') or d.get('country'),
                     'r': d.get('rating'), 'date': (d.get('date') or '')[:10], 'src': 'A' if a else 'B', 'hm_app': hm_app, 'text': text}
json.dump(list(rows.values()), open('Temp/heatmap_expect/corpus.json', 'w'), ensure_ascii=False)
import collections
c = collections.Counter((r['src'], r['hm_app']) for r in rows.values())
print(len(rows), c)
print(collections.Counter(r['app'].split('. ',1)[-1][:30] for r in rows.values()).most_common(20))
