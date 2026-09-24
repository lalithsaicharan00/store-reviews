"""Full-corpus screen for day-structure concepts across App Store, Play Store and native corpora.
Writes every matched review (with which families matched) to candidates.jsonl."""
import json, glob, re, collections, os
ROOT = "/Users/lalith/Desktop/store reviews"
OUT = os.path.join(ROOT, "Temp/daystructure")

F = {}
# A. time-of-day sections
F["TOD"] = re.compile(r"""
 time[\s-]of[\s-](the[\s-])?day | times?\s+of\s+day | morning\s*[,/&]\s*(afternoon|evening|night|noon) | (morning|am)\s*(and|&|/)\s*(evening|night|pm)\b.{0,40}(habit|routine|section|split|separat|group|categor|tab)
 | (morning|evening|night|afternoon)\s+(section|block|tab|segment|slot|categor|group|list|bucket)s?
 | (sections?|blocks?|segments?|slots?|parts?|periods?)\s+(of|in|for|throughout)\s+(the\s+|my\s+)?day | day\s*(parts|sections|segments|periods)
 | time\s*(blocks?|segments?|slots?|periods?|windows?)\b | anytime\s+(section|tab|habits?|group)
 | 时间段|早中晚|上午.{0,4}下午|早上.{0,6}晚上|早晨.{0,6}(晚上|夜晚|中午)|时段 | 時間帯|朝.{0,3}昼.{0,3}(夜|晩)|朝.{0,4}夜 | 시간대|아침.{0,6}(저녁|점심|밤)
 | ma[ñn]ana.{0,15}tarde.{0,15}noche | momento\s+del\s+d[ií]a | franja(s)?\s+horaria | per[ií]odos?\s+del\s+d[ií]a | parte(s)?\s+del\s+d[ií]a
 | manh[ãa].{0,15}tarde.{0,15}noite | per[ií]odos?\s+do\s+dia | turnos?\s+do\s+dia | hor[aá]rio\s+do\s+dia
 | matin.{0,15}(midi|apr[eè]s[-\s]midi).{0,15}soir | moment\s+de\s+la\s+journ[ée]e | p[ée]riodes?\s+de\s+la\s+journ[ée]e
 | morgens.{0,15}(mittags|abends)|tageszeit|morgen.{0,10}abend.{0,20}(routine|gewohnheit|trenn|abschnitt)
 | mattin[ao].{0,15}(pomeriggio|sera) | momento\s+della\s+giornata
 | утр.{0,15}(день|дн[её]м|обед).{0,15}веч | время\s+суток | утро.{0,6}вечер | утренн.{0,20}вечерн
 | sabah.{0,12}(öğle|akşam) | günün\s+(saati|bölüm)
 | صباح.{0,15}مساء | pagi.{0,10}(siang|sore|malam)
 | rano.{0,10}(popołudni|wiecz)|pora\s+dnia | ochtend.{0,12}(middag|avond) | sáng.{0,6}(chiều|tối)
""", re.I|re.X)
# B. groups / categories / folders / tags / areas
F["GRP"] = re.compile(r"""
 \b(categor(y|ies|ize|ise|izing|ising|ization)|folders?|sub[\s-]?folders?|tags?\b|tagging|labels?\b|areas?\s+of\s+(my\s+)?life|life\s+areas?|habit\s+groups?|groups?\s+(of\s+)?habits|group(ing|ed)?\s+(my\s+)?(habits|them|tasks|routines)|sort\s+(my\s+)?habits\s+(in|into|by)|organi[sz]e\s+(my\s+)?habits\s+(in|into|by)|filter(s|ing)?\s+(by|habits|my)|lists?\s+of\s+habits|separate\s+(lists|tabs|pages)|multiple\s+(lists|tabs|pages))
 | 分类|分組|分组|类别|類別|文件夹|标签|標籤|フォルダ|カテゴリ|タグ|グループ|폴더|카테고리|태그|그룹
 | categor[ií]as?|carpetas?|etiquetas?|agrupar|grupos?\s+de\s+h[áa]bitos | pastas?\b|categorias?|agrupar|grupos?\s+de\s+h[áa]bitos
 | cat[ée]gories?|dossiers?|[ée]tiquettes?|regrouper|groupes?\s+d.habitudes | kategorien?|ordner|gruppen?\b|gruppieren|schlagw | categori[ae]|cartell[ae]|gruppi | категори|папк|групп|тег|метк | kategori|klasör|etiket|grup | فئ[ةا]|تصنيف|مجلد|مجموع | kategori|folder|grup | kategori|folder|etykiet|grup | categorie|mappen?|groep | danh\s+mục|thư\s+mục|nhóm|thẻ
""", re.I|re.X)
# C. routine execution / guided / timer sequence / start routine
F["RTN"] = re.compile(r"""
 (start|begin|run|play|launch)\s+(the\s+|my\s+|a\s+|your\s+)?(morning\s+|evening\s+|night\s+|bedtime\s+)?routines? | routines?\s+(mode|player|timer|runner|flow|builder|feature|function|option|section|tab)
 | step[\s-]by[\s-]step | guided\s+(routine|mode|session|flow) | (timers?|countdown)\s+(for\s+)?(each|every|per)\s+(step|task|habit|activity|item) | (each|every)\s+(step|task|habit|activity)\s+(has|with|gets)\s+(a\s+)?timer
 | (next|following)\s+(step|task|habit|activity)\s+(automatically|starts|begins|pops) | in\s+(a\s+)?(sequence|order)\b.{0,30}(habit|task|step|routine) | sequence\s+of\s+(habits|tasks|steps|activities) | habit\s+stack(s|ing)? | stack(ing)?\s+(my\s+)?habits | chain\s+(of\s+)?habits
 | (morning|evening|night|bedtime)\s+routines?\s+(as|into|with|in)\s+(one|a\s+single|a\s+group|a\s+list|steps)
 | 例程|日常流程|流程|计时器|倒计时|一步一步|ルーティン(を|の)?(開始|実行|再生)|タイマー|루틴\s*(시작|실행|모드)|타이머
 | temporizador|cron[óo]metro|paso\s+a\s+paso|rutinas?\s+(guiad|con\s+tiempo) | passo\s+a\s+passo|rotinas?\s+(guiad|com\s+tempo) | minuteur|[ée]tape\s+par\s+[ée]tape | schritt\s+f[üu]r\s+schritt|routine\s+starten | passo\s+dopo\s+passo | пошагов|запустить\s+(утренн|рутин|ритуал)|таймер | adım\s+adım|zamanlayıcı | خطوة\s+بخطوة|مؤقت
""", re.I|re.X)
# D. sub-habits / subtasks / checklist within habit / steps
F["SUB"] = re.compile(r"""
 sub[\s-]?(habits?|tasks?|goals?|items?|steps?|routines?|lists?|checklists?|categor\w*|activities|points?|levels?) | nested\s+(habits?|tasks?|routines?|lists?|checklist) | check[\s-]?lists?\s+(inside|within|in|for|under)\s+(a\s+|each\s+|the\s+)?(habit|routine|task) | habits?\s+(inside|within|under)\s+(a\s+|another\s+)?(habit|routine) | (parent|child)\s+(habit|task)s?
 | multi[\s-]?step | (multiple|several|many)\s+steps?\s+(in|to|for|within)\s+(a|one|each)\s+(habit|routine) | steps?\s+(inside|within|of)\s+(a|each|one|the)\s+(habit|routine) | break\s+(a\s+|my\s+|each\s+|the\s+)?(habit|routine|goal|task)s?\s+(down|into)
 | 子任务|子习惯|子項目|子项目|子目标|サブタスク|サブ習慣|하위\s*(습관|항목|작업)|서브\s*(태스크|습관)
 | sub[\s-]?tareas?|subh[áa]bitos?|sub[\s-]?h[áa]bitos?|sub[\s-]?tarefas?|sous[\s-]?t[âa]ches?|sous[\s-]?habitudes?|unteraufgaben?|untergewohnheit|teilschritt|sottoattivit|sotto[\s-]?abitudin|подзадач|подпривыч|под-?пункт|alt\s+görev|alt\s+alışkan|مهام\s+فرعية|عادات\s+فرعية|sub[\s-]?tugas|podzada|subtaken|nhiệm\s+vụ\s+con
""", re.I|re.X)
# E. per-group / category stats
F["GSTAT"] = re.compile(r"""(stat(s|istics)?|analytics|progress|report|chart)s?\s+(by|per|for\s+each|of\s+each)\s+(categor|group|folder|area|tag|section|routine)|(categor(y|ies)|group|folder|area|tag|routine)[\s-]*(level\s+)?(stat|analytic|progress|report|chart)""", re.I|re.X)

def recs():
    for store, pat in [("app","App Store Reviews/*/reviews.jsonl"),("play","Play Store Reviews/*/reviews.jsonl"),("native","Native Store Reviews/*/reviews.jsonl")]:
        for f in sorted(glob.glob(os.path.join(ROOT, pat))):
            folder = f.split("/")[-2]
            for i,l in enumerate(open(f)):
                r = json.loads(l)
                text = ((r.get("title") or "") + " — " + (r.get("body") or r.get("text") or "")).strip()
                yield store, folder, i+1, r, text

tot = collections.Counter(); hit = collections.Counter(); combo=collections.Counter()
with open(os.path.join(OUT,"candidates.jsonl"),"w") as w:
    for store, folder, line, r, text in recs():
        tot[store]+=1
        fams=[k for k,p in F.items() if p.search(text)]
        if fams:
            for k in fams: hit[(store,k)]+=1
            combo[store]+=1
            w.write(json.dumps({"store":store,"folder":folder,"line":line,"id":r["review_id"],"rating":r.get("rating"),"date":r.get("date"),"lang":r.get("language") or r.get("country"),"fam":fams,"text":text},ensure_ascii=False)+"\n")
print(tot); print(sorted(hit.items())); print(combo)
