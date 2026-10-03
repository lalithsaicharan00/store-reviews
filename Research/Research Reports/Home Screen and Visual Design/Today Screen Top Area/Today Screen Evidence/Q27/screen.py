"""Whole-corpus screen for four themes: ORDER (how items are ordered), ORDCHG (order changes by itself /
can't be changed / completed or new items move), DISC (can't find how to edit/rename/delete/add a section,
category, group, list, tag), FILTER (filter or view by group; show only; hide completed).
Reads every reviews.jsonl in App Store, Play Store and Native Store corpora; writes cand.jsonl + counts.json.
Citation id = store letter (A/P/N) + folder number + '#' + 0-based line (same as Today Screen Evidence/common.py).
Run from Research/Temp/arrange/: python3 screen.py"""
import json, glob, re, os, collections
ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "../.."))
LET = {"app": "A", "play": "P", "native": "N"}
# Tiers. habit = App Store corpus + Play habit apps (Day Structure refine.py split).
# todo = to-do / list / planner corpora (Play 84,85,95,97,100,111,121,126,129 + native Reminders, Microsoft To Do,
# Google Tasks, Google Keep, Notes). other = gym, food, video calls, skincare, calendar, health, sheets.
TODO_PLAY = {84, 85, 95, 97, 100, 111, 121, 126, 129}
OTHER_PLAY = {96, 122, 127, 131}
TODO_NATIVE = {1, 3, 6, 7, 10}
def tier(store, n):
    if store == "app": return "habit"
    if store == "play": return "todo" if n in TODO_PLAY else "other" if n in OTHER_PLAY else "habit"
    return "todo" if n in TODO_NATIVE else "other"

X = re.X | re.I
F = {}
# 1. ORDER: any talk of ordering / arranging items
F["ORDER"] = re.compile(r"""
 \bre-?order\w* | \bre-?arrang\w* | \bre-?sort\w* | \bre-?organi[sz]\w*\s+(the\s+|my\s+)?(order|habits?|tasks?|list|items?)
 | drag(ging|ged)?\s*(and|&|n|'n'|-n-|/)\s*drop\w* | drag(ging)?\s+(and\s+)?(to\s+)?(re-?order|sort|move|arrange|rearrange)
 | drag(ging)?\s+(the\s+|my\s+|a\s+)?(habits?|tasks?|items?|cards?|them|it)\s+(up|down|around|to|into)
 | \bmove\w*\s+(the\s+|my\s+|a\s+)?(habits?|tasks?|items?|them|it|things)\s+(up|down|around|to\s+the\s+(top|bottom))
 | \bmove\w*\s+(up|down)\s+(and|or|&)\s+(up|down)
 | (custom|manual|own|personal|preferred|chosen|specific|certain|particular|desired)\s+(order(ing)?|sort(ing)?|sequence|arrangement)
 | (sort|sorting|sorted|order|ordered|arrange|arranged|list|listed)\s+(them\s+|it\s+|habits\s+|tasks\s+)?(by|in)\s+(time|reminder|priority|name|alphabet\w*|date|color|colour|category|importance|due|frequency|streak|start|the\s+time|order\s+of)
 | \bsort(s|ing|ed|able)?\b(?!\s+of\b)(?!\s+out\b)(?!\s+through\b)(?!\s+it\s+out)(?!\s+things\s+out)
 | alphabeti\w* | \ba[\s-]?(to|-)[\s-]?z\b
 | order\s+(of|in\s+which)\s+(the\s+|my\s+|your\s+)?(habits?|tasks?|items?|routines?|things|activities|list)
 | (habits?|tasks?|items?|list)\s+order\b | (the|my|their|its|in)\s+order\s+(i|you|they|that\s+i)\s+(want|do|like|prefer|need|choose|set|put)
 | (change|changing|set|setting|choose|choosing|keep|keeping|save|saving|edit|editing|control)\s+(the\s+|my\s+)?order\b
 | (in|into)\s+(a\s+|any\s+|the\s+)?(random|wrong|different|weird|strange|correct|right|logical|chronological)\s+order
 | (jump|jumps|jumping|jumped|shuffl\w*|scrambl\w*)\s+(around|all\s+over) | \bshuffl\w*
 | (goes|go|move|moves|moved|moving|sent|drops?|sinks?|falls?|pushed|jumps?)\s+(down\s+)?to\s+the\s+(bottom|end|top)
 | (at|on|to)\s+the\s+(bottom|top|end)\s+of\s+(the\s+|my\s+)?(list|screen|page)
 | (first|top)\s+(of|in)\s+(the\s+|my\s+)?list
 # Spanish / Portuguese
 | reorden\w* | \bordenar(l[oa]s|me|te)?\b | cambiar\s+(el\s+)?orden | (el|un|mi|su|en|de)\s+orden\s+(de|que|alfab|en)
 | orden\s+alfab\w* | arrastr\w* | reorganiz\w* | mover\s+(los\s+|las\s+|os\s+|as\s+)?(h[áa]bitos|tareas|tarefas|tasks)
 | (mudar|alterar|trocar)\s+(a\s+)?ordem | ordem\s+(dos|das|de|alfab|que|em) | (na|em|uma)\s+ordem
 | arrast\w* | organizar\s+(a\s+)?ordem
 # German
 | sortier\w* | reihenfolge | umsortier\w* | anordn\w* | verschieb\w* | per\s+drag
 # French
 | r[ée]organis\w* | r[ée]ordonn\w* | \btrier\b | \btri(é|ée|és|ées)\b | (l'|d')ordre\s+(des|de|alpha|dans|que|chronolog) | (changer|modifier)\s+l'ordre
 | glisser[\s-]+d[ée]poser | d[ée]placer\s+(les\s+)?(habitudes|t[âa]ches)
 # Italian
 | riordin\w* | \bordinare\b | ordine\s+(delle|dei|alfab|in\s+cui) | (cambiare|modificare)\s+(l')?ordine | trascin\w* | spostare\s+(le\s+)?(abitudini|attivit)
 # Russian
 | порядок | порядк\w* | сортир\w* | перетаск\w* | перемещ\w* | упорядоч\w* | по\s+алфавиту | переставл\w* | поменять\s+местами
 # Japanese / Korean / Chinese
 | 並び替え | 並べ替え | 並び順 | 順番 | 並べ | 順序 | ソート | ドラッグ | 入れ替え | 表示順
 | 순서 | 정렬 | 드래그 | 위치\s*(변경|이동|바꾸)
 | 排序 | 顺序 | 順序 | 拖动 | 拖拽 | 拖曳 | 排列 | 调整位置 | 調整順序 | 移动位置
 # Turkish / Arabic / Indonesian / Hindi transliteration
 | sırala\w* | sıralama | sırası\w* | sürükle\w* | yerini\s+değiştir\w* | sıra\s+değiş\w*
 | ترتيب | إعادة\s+ترتيب | سحب\s+و\s*إفلات | فرز
 | urutan | mengurutkan | \burut\w*
 | order\s+(change|badal|set)\w*\s+(nahi|nhi|nahin|ho|kar|karne) | (upar|uper)\s+(niche|neeche|nichay)
""", X)
# 2. ORDCHG: order changes by itself, resets, can't be changed; completed / new items move
F["ORDCHG"] = re.compile(r"""
 (keeps?|kept|keep|always|constantly|randomly)\s+(re-?order\w*|re-?arrang\w*|re-?sort\w*|shuffl\w*|scrambl\w*|jump\w*|mov\w*\s+(around|my|the|them))
 | order\s+(keeps|is\s+always|always|gets|got|was|is)\s+(changing|changed|reset\w*|mess\w*|lost|scrambl\w*|random\w*|shuffl\w*|wrong|jumbl\w*)
 | (jump|jumps|jumping|jumped)\s+(around|all\s+over)
 | (lost|loses|lose|losing|forgot|forgets|reset|resets|resetting|ignores?|doesn'?t\s+(save|keep|remember)|won'?t\s+(save|keep|remember)|not\s+(save|keep)\w*)\s+(my\s+|the\s+)?(custom\s+|manual\s+|chosen\s+|own\s+)?(order\w*|sort\w*|arrangement|sequence)
 | (order\w*|sort\w*|arrangement)\s+(resets?|reverts?|goes\s+back|changes\s+back|is\s+lost|gets\s+lost|doesn'?t\s+(stay|stick|save))
 | (can'?t|cannot|can\s+not|couldn'?t|unable\s+to|no\s+way\s+to|not\s+able\s+to|impossible\s+to|doesn'?t\s+let\s+(me|you)|won'?t\s+let\s+(me|you)|wish\s+i\s+could|no\s+option\s+to|not\s+possible\s+to|there'?s\s+no\s+way\s+to)\s+(\w+\s+){0,3}?(re-?order|re-?arrange|sort|change\s+the\s+order|move\s+(them|habits|tasks|the\s+habits)|organi[sz]e\s+the\s+order|drag)
 | (random(ly)?|weird|strange|arbitrary|odd)\s+(order|sort\w*|arrange\w*)
 | (completed|done|checked|ticked|finished|marked)\s+(habits?|tasks?|items?|ones|off)?\s*(\w+\s+){0,4}(go|goes|move|moves|moved|sent|drop|drops|jump|jumps|sink|sinks|fall|falls|get\s+moved|are\s+moved)\s+(down\s+)?(to\s+)?(the\s+)?(bottom|end|top|down)
 | new\s+(habits?|tasks?|items?|ones|entries)\s+(\w+\s+){0,4}(at|to|on)\s+the\s+(bottom|top|end)
 # other languages: order changes by itself / can't change order
 | (no\s+(puedo|se\s+puede|deja)|não\s+(consigo|dá|da|é\s+possível|posso))\s+(\w+\s+){0,2}(reordenar|ordenar|cambiar\s+el\s+orden|mudar\s+a\s+ordem|alterar\s+a\s+ordem|organizar)
 | (orden|ordem)\s+(se\s+)?(cambia|muda|altera|desordena|reinicia|pierde|perde)
 | reihenfolge\s+(\w+\s+){0,4}(ändert|verändert|durcheinander|nicht\s+(ändern|speichern|anpassen|änderbar)|zufällig|geht\s+verloren)
 | (kann|lässt\s+sich)\s+(\w+\s+){0,3}(nicht|keine)\s+(\w+\s+){0,3}(sortieren|verschieben|umsortieren|reihenfolge)
 | ordre\s+(\w+\s+){0,3}(change|chang[ée]|al[ée]atoire|n'est\s+pas\s+(gard|sauv|conserv))|impossible\s+de\s+(changer\s+l'ordre|r[ée]organiser|trier|d[ée]placer)
 | (non\s+(si\s+)?pu[òo]|impossibile)\s+(\w+\s+){0,2}(riordinare|ordinare|cambiare\s+l'ordine|spostare)
 | (нельзя|не\s+могу|не\s+получается|невозможно|нет\s+возможности)\s+(\w+\s+){0,3}(поменять\s+порядок|изменить\s+порядок|сортир\w*|перетаск\w*|перемест\w*|упорядоч\w*)
 | порядок\s+(\w+\s+){0,3}(сбива\w*|меня\w*|сбрасыва\w*|теря\w*|не\s+сохран\w*)
 | (並び替え|並べ替え|順番|並び順)(が|を|は)?(でき(ない|ず|ません)|変更でき(ない|ず|ません)|変わ|勝手)
 | 순서\s*(를|가|도)?\s*(바꿀\s*수\s*없|변경\s*(이\s*)?(안|불가|할\s*수\s*없)|못\s*바꾸|바뀌|안\s*바뀌|맘대로|마음대로)
 | (不能|无法|無法|没法|没有办法)\s*(调整|更改|修改|改变|改變)?\s*(排序|顺序|順序) | (顺序|順序|排序)\s*(乱|會變|会变|变了|自动)
 | sıra(sını|layamıyorum|lama\s+yapılamıyor|sı\s+değişiyor)\w*\s*(değiştiremiyorum|değiştirilemiyor)?
 | لا\s+(أستطيع|يمكن)\s+(\w+\s+){0,2}ترتيب
""", X)
# 3. DISC: finding how to edit / rename / delete / add a section, category, group, list, area, tag
OBJ = r"(sections?|categor(y|ies)|groups?|folders?|lists?|areas?|tags?|labels?|time\s+of\s+(the\s+)?day|times\s+of\s+day|time\s+slots?|time\s+blocks?|parts?\s+of\s+(the\s+)?day|morning|afternoon|evening|anytime)"
VERB = r"(edit\w*|renam\w*|delet\w*|remov\w*|add\w*|creat\w*|chang\w*|customi[sz]\w*|manag\w*|modif\w*|get\s+rid)"
FIND = r"(can'?t\s+(find|figure|seem|see|work\s+out)|couldn'?t\s+(find|figure|see|work\s+out)|could\s+not\s+(find|figure)|cannot\s+(find|figure)|unable\s+to\s+(find|figure)|hard\s+to\s+(find|figure|locate)|difficult\s+to\s+(find|figure|locate)|didn'?t\s+(know|realize|realise|see|notice)|did\s+not\s+(know|realize|realise)|took\s+me\s+(a\s+while|forever|ages|long|some\s+time|\d+)|figure\s+out\s+how|figured\s+out|hidden|buried|tucked|not\s+(obvious|intuitive|clear)|unintuitive|non-?intuitive|where\s+(is|are|do|can|to)\b|how\s+(do|can|to|does)\s+(i|you|one|we)?\s*\w*|by\s+accident|accidentally\s+(found|discovered|figured)|stumbled|discover\w*|long[\s-]?press\w*|press\s+and\s+hold|tap\s+and\s+hold|hold\s+down|no\s+way\s+to|no\s+option\s+to|can'?t\s+(delete|edit|rename|remove|change|add)|cannot\s+(delete|edit|rename|remove|change|add)|unable\s+to\s+(delete|edit|rename|remove|change|add))"
F["DISC"] = re.compile(
    rf"({FIND}.{{0,60}}{VERB}.{{0,40}}{OBJ}|{VERB}.{{0,40}}{OBJ}.{{0,60}}{FIND}|{FIND}.{{0,40}}{OBJ}.{{0,40}}{VERB}|{OBJ}.{{0,40}}{VERB}.{{0,40}}{FIND}|{OBJ}.{{0,20}}(settings?|menu|option).{{0,30}}(hidden|buried|hard\s+to\s+find|took\s+me))"
    r"""| (no\s+(encuentro|encontr[ée]|sé|se\s+como|puedo)|n[ãa]o\s+(encontr\w*|sei|consigo|acho)|oculto|escondid\w*)\s+(\w+\s+){0,4}(editar|eliminar|borrar|cambiar|renombrar|crear|agregar|añadir|excluir|apagar|renomear|criar|adicionar|mudar)\s+(\w+\s+){0,3}(categor\w*|grupos?|secci\w*|se[cç][õoã]\w*|listas?|etiquetas?|carpetas?|pastas?|per[ií]odos?)
       | (finde|fand)\s+(\w+\s+){0,3}nicht\s+(\w+\s+){0,6}(kategorie|gruppe|abschnitt|ordner|liste|tageszeit)\w* | (kategorie|gruppe|abschnitt|ordner|liste|tageszeit)\w*\s+(\w+\s+){0,6}(nicht\s+(löschen|bearbeiten|umbenennen|finden|ändern)|versteckt|wo\s+kann)
       | (je\s+ne\s+trouve\s+pas|introuvable|impossible\s+de|cach[ée]|o[uù]\s+(est|sont|peut))\s+(\w+\s+){0,5}(cat[ée]gor\w*|groupes?|sections?|dossiers?|listes?|[ée]tiquettes?)
       | (non\s+trovo|non\s+riesco|nascost\w*|impossibile)\s+(\w+\s+){0,5}(categori\w*|grupp\w*|sezion\w*|cartell\w*|list\w*|etichett\w*)
       | (не\s+(могу|нашел|нашла|найти|нахожу|понял|поняла|понятно|получается|удается|удаётся)|скрыт\w*|как\s+(удалить|переименовать|изменить|редактировать|добавить))\s+(\w+\s+){0,5}(категор\w*|групп\w*|раздел\w*|папк\w*|список\w*|тег\w*|метк\w*)
       | (カテゴリ|グループ|タグ|フォルダ|時間帯|リスト).{0,15}(削除|編集|名前|変更|追加).{0,15}(できない|できません|わからない|分からない|見つから|どこ)
       | (카테고리|그룹|태그|폴더|시간대|목록).{0,15}(삭제|편집|수정|이름|추가|변경).{0,15}(안\s*되|못|모르|찾|없)
       | (分类|类别|類別|分组|分組|标签|標籤|文件夹|时间段).{0,10}(删除|刪除|编辑|編輯|修改|重命名|添加|新增).{0,10}(不了|不能|无法|無法|找不到|不知道|没法)
       | (kategori|grup|etiket|klasör)\w*\s+(\w+\s+){0,4}(silemiyorum|silinmiyor|düzenleyemiyorum|bulamıyorum|bulamadım|nasıl)
       | (لا\s+أستطيع|لا\s+يمكن|كيف)\s+(\w+\s+){0,3}(حذف|تعديل|إضافة)\s+(\w+\s+){0,2}(الفئ|التصنيف|المجموع)""", X)
# 4. FILTER: filter / view by group, show only, focus, hide completed
F["FILTER"] = re.compile(r"""
 \bfilter\w* | show(s|ing)?\s+only | only\s+show\w* | (view|see|display)\w*\s+(only|just)\s+(the\s+|my\s+|one\s+)?(habits?|tasks?|ones|items?|categor\w*|groups?|tags?|areas?|morning|evening|today) | (view|see|display|show)\w*\s+(\w+\s+){0,3}(by|per|for\s+each)\s+(categor\w*|groups?|tags?|areas?|folders?|labels?|lists?)
 | focus\w*\s+on\s+(one|a|each|a\s+single|specific|certain)\s+(categor\w*|groups?|areas?|tags?|list|section|part)
 | (tabs?|pages?)\s+(for|per)\s+(each\s+)?(categor\w*|groups?|areas?|tags?|routines?) | (switch|toggle)\w*\s+between\s+(categor\w*|groups?|areas?|tags?|lists?|routines?)
 | hid(e|es|ing|den)\s+(\w+\s+){0,2}(completed|done|finished|checked|ticked|archived|inactive)\s*(habits?|tasks?|items?|ones)?
 | (completed|done|finished|checked|ticked)\s+(habits?|tasks?|items?|ones)\s+(\w+\s+){0,3}(disappear|vanish|hidden|hide|go\s+away|stay|remain)
 | filtr\w* | mostrar\s+(solo|sólo|apenas|só|somente) | ocult\w*\s+(\w+\s+){0,2}(complet\w*|conclu\w*|hech\w*|feit\w*|termin\w*)
 | nur\s+(\w+\s+){0,4}(anzeig\w*|ansehen) | ausblend\w* | afficher\s+(uniquement|seulement) | masquer | mostrare\s+solo | nascond\w*\s+(\w+\s+){0,2}(complet|fatt)
 | фильтр\w* | показ\w*\s+только | скры\w*\s+(\w+\s+){0,2}(выполн\w*|завершен\w*|сделан\w*)
 | フィルター | フィルタ | 絞り込 | 非表示 | 필터 | 숨기기 | 숨김 | 筛选 | 篩選 | 过滤 | 過濾 | 隐藏 | 隱藏 | filtre\w* | gizle\w* | تصفية | فلتر | إخفاء
""", X)
# noise guards for FILTER: photo/camera/water filters
FILTER_NOISE = re.compile(r"(water\s+filter|photo\s+filter|camera\s+filter|instagram|filtered\s+water|coffee\s+filter|spam\s+filter|blue[\s-]?light\s+filter|filter\s+(coffee|water))", re.I)

PRE = {
 "ORDER": ["order","sort","arrang","drag","move","alphab","a-z","a to z","jump","shuffl","scrambl","bottom","top","first","list",
           "orden","ordem","ordena","arrast","reorganiz","mover","reihenfolge","anordn","verschieb","per drag","organis","ordonn","trier","trié","trie",
           "ordre","gliss","déplac","deplac","riordin","ordinare","ordine","trascin","spostare","поряд","сортир","перетаск","перемещ","упорядоч","алфавит",
           "переставл","местами","並","順","ソート","ドラッグ","入れ替え","순서","정렬","드래그","위치","排序","顺序","順序","拖","排列","调整","移动",
           "sıra","sürükle","yerini","ترتيب","سحب","فرز","urut","upar","uper"],
 "DISC": ["section","categor","group","folder","list","area","tag","label","time","part","morning","afternoon","evening","anytime",
          "grupo","seç","secci","carpeta","pasta","etiquet","período","periodo","kategor","gruppe","abschnitt","ordner","liste","tageszeit",
          "catégor","groupe","dossier","étiquette","grupp","sezion","cartell","etichett","категор","групп","раздел","папк","спис","тег","метк",
          "カテゴリ","グループ","タグ","フォルダ","時間帯","リスト","카테고리","그룹","태그","폴더","시간대","목록","分类","类别","類別","分组","分組","标签","標籤","文件夹","时间段",
          "grup","etiket","klasör","الفئ","التصنيف","المجموع"],
 "FILTER": ["filt","show","only","view","see","display","focus","tab","page","switch","toggle","hid","complet","done","finish","check","tick",
            "mostrar","ocult","nur","ausblend","afficher","masquer","mostrare","nascond","фильтр","показ","скры","フィルタ","絞り込","非表示","필터","숨기","筛选","篩選","过滤","過濾","隐藏","隱藏","gizle","تصفية","فلتر","إخفاء"],
}
PRE["ORDCHG"] = PRE["ORDER"] + ["keep","kept","lost","reset","random","weird","complet","done","checked","new","can","unable","impossible","нельзя","не ","不能","无法","無法","没法","できな","勝手","변경","바뀌","لا "]

def families(text):
    low = text.lower(); fams = []
    for k, p in F.items():
        if any(s in low for s in PRE[k]) and p.search(text): fams.append(k)
    if "FILTER" in fams and FILTER_NOISE.search(text) and len(F["FILTER"].findall(text)) <= 1: fams.remove("FILTER")
    if "ORDCHG" in fams and "ORDER" not in fams: fams.append("ORDER")
    return sorted(fams)

FILES = []
for store, pat in [("app", "App Store Reviews/*/reviews.jsonl"), ("play", "Play Store Reviews/*/reviews.jsonl"), ("native", "Native Store Reviews/*/reviews.jsonl")]:
    for f in sorted(glob.glob(os.path.join(ROOT, pat))): FILES.append((store, f))

def readfile(store, f):
    folder = f.split("/")[-2]; n = int(folder.split(".")[0])
    for i, l in enumerate(open(f)):
        r = json.loads(l)
        text = ((r.get("title") or "") + " \u2014 " + (r.get("body") or r.get("text") or "")).strip(" \u2014")
        yield store, folder, n, i, r, text

def recs():
    for store, f in FILES: yield from readfile(store, f)

def work(arg):
    store, f = arg; rows = []; total = 0
    for store, folder, n, i, r, text in readfile(store, f):
        total += 1
        fams = families(text)
        if fams:
            rows.append({"cite": f"{LET[store]}{n}#{i}", "store": store, "folder": folder, "tier": tier(store, n), "id": r["review_id"],
                         "rating": r.get("rating"), "date": (r.get("date") or "")[:10], "lang": r.get("language") or r.get("country"),
                         "fam": fams, "text": text})
    return store, f, tier(store, int(f.split("/")[-2].split(".")[0])), total, rows

if __name__ == "__main__":
    import multiprocessing
    os.chdir(os.path.dirname(os.path.abspath(__file__)))
    # folder numbers must be unique per store (citation ids rely on it)
    for st in LET:
        nums = [int(f.split("/")[-2].split(".")[0]) for s, f in FILES if s == st]; assert len(nums) == len(set(nums)), st
    tot = collections.Counter(); hit = collections.Counter(); anyhit = collections.Counter(); res = []
    with multiprocessing.Pool(4) as pool:
        for store, f, t, total, rows in pool.imap_unordered(work, sorted(FILES, key=lambda x: -os.path.getsize(x[1]))):
            tot[t] += total; res.append((FILES.index((store, f)), rows))
    with open("cand.jsonl", "w") as w:
        for _, rows in sorted(res, key=lambda x: x[0]):
            for c in rows:
                for k in c["fam"]: hit[(c["tier"], k)] += 1
                anyhit[c["tier"]] += 1
                w.write(json.dumps(c, ensure_ascii=False) + "\n")
    out = {"total_by_tier": tot, "total": sum(tot.values()), "hits": {f"{a}|{b}": c for (a, b), c in sorted(hit.items())}, "any_by_tier": anyhit}
    json.dump(out, open("counts.json", "w"), indent=1)
    print(json.dumps(out, indent=1))
