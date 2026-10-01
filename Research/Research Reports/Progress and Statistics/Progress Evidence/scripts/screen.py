"""Whole-corpus screen for progress / statistics / history concepts (Progress page research, 30 Sep 2026).
Reads every reviews.jsonl in App Store, Play Store and Native corpora; writes candidates.jsonl."""
import json, glob, re, collections, os
ROOT = "/home/user/store-reviews/Research"
ADJ_PLAY = {84,85,95,96,97,100,111,121,122,126,127,129,131}
F = {}
F["STAT"] = re.compile(r"""
 \bstat(s|istic|istics|istical)\b | \banalytic | \binsights?\b | \bcharts?\b | \bgraph(s|ic(al)?\s+(view|representation|overview))?\b | \bgraphs?\b | heat[\s-]?maps? | \bdashboard | data\s+(viz|visuali[sz]ation) | visuali[sz](e|ation|ing)\s+(my\s+|the\s+|your\s+)?(progress|data|habits|streak)
 | estad[ií]stic | gr[áa]fic[oa]s? | anal[ií]tic | estat[ií]stic | statistiq | graphiques? | statisti[kc] | diagramm | auswertung | statistich | grafic[io] | статистик | график | аналитик | istatistik | grafik | إحصا | احصا | رسوم?\s+بياني | statystyk | wykres | statistieken | grafiek | thống\s*kê | biểu\s*đồ
 | 统计 | 統計 | 图表 | 圖表 | 热力图 | 熱力圖 | 数据分析 | 數據分析 | グラフ | 통계 | 그래프 | 분석
""", re.I|re.X)
F["VIEW"] = re.compile(r"""
 (calendar|month(ly)?|year(ly)?|annual|week(ly)?|history|grid|overview)\s+(view|page|screen|tab|grid|calendar|overview|heat)
 | (see|view|look\s+(back|at))\s+(my\s+|the\s+|your\s+|all\s+(my\s+)?)?(history|past\s+(days|weeks|months|progress|data)|whole\s+year|entire\s+year|year|month|progress\s+over)
 | year\s+in\s+pixels | contribution\s+(graph|grid|chart) | github | (habit|streak|completion)\s+history | history\s+of\s+(my\s+)?(habits|progress|completions)
 | calendario\s+(de|con|mensual|anual) | historial | hist[óo]rico | historique | verlauf | jahres(ansicht|übersicht) | monats(ansicht|übersicht) | cronologia | storico | истори[яюи]\s+(привыч|выполн|отмет) | календар[ья]\s+(привыч|выполн|отмет) | geçmiş
 | 日历视图 | 月视图 | 年视图 | 历史记录 | 歷史紀錄 | カレンダー(表示|ビュー) | 月表示 | 年表示 | 振り返 | 달력\s*(보기|뷰) | 월간\s*(보기|뷰|통계) | 연간
""", re.I|re.X)
F["RATE"] = re.compile(r"""
 (completion|success|consistency|achievement|hit)\s+(rate|percentage|%|score|ratio) | percentage\s+of\s+(days|completion|success|the\s+time) | %\s*of\s+(the\s+)?(days|time) | (habit|strength)\s+(score|strength) | habit\s+strength
 | taxa\s+de\s+(conclus|sucesso) | tasa\s+de\s+(éxito|exito|cumplimiento) | porcentaje | porcentagem | pourcentage | taux\s+de\s+r[ée]ussite | prozent | erfolgsquote | percentual | процент | yüzde | النسبة | procent
 | 完成率 | 达成率 | 達成率 | 成功率 | 百分比 | 달성률 | 완료율 | 성공률
""", re.I|re.X)
F["STREAKSTAT"] = re.compile(r"""
 (best|longest|record|highest|max(imum)?|previous|past|all[\s-]time)\s+(streak|run|chain) | streak\s+(history|record|stats|statistics|count\s+history) | (total|cumulative|overall|lifetime)\s+(days|count|completions|times|hours|minutes|amount|number|total|streak|progress|stats)
 | total\s+de\s+d[ií]as | mejor\s+racha | racha\s+m[áa]s\s+larga | melhor\s+sequ[êe]ncia | meilleure\s+s[ée]rie | l[äa]ngste\s+(serie|strähne) | rekord | лучш(ая|ий)\s+(серия|результат|стрик) | рекорд | en\s+uzun\s+seri
 | 最长连续 | 最長連続 | 最高記録 | 最佳纪录 | 累计 | 累計 | 최장\s*연속 | 최고\s*기록 | 누적
""", re.I|re.X)
F["QUIT"] = re.compile(r"""
 days?\s+(since|clean|sober|free|without) | (time|days)\s+since | sober\s+(days|time|counter|streak) | relaps | \bslip(s|ped)?\b | money\s+saved | (cigarettes?|drinks?)\s+(not\s+(smoked|drunk|had)|avoided|saved) | reset\s+(my\s+)?(counter|streak|clock|timer) | quit\s+(counter|timer|clock|tracker|habit)
 | d[ií]as\s+sin | reca[ií]da | reca[ií]das | dias\s+sem | reca[íi]da | jours\s+sans | rechute | tage\s+ohne | rückfall | giorni\s+senza | ricaduta | дней\s+без | срыв | рецидив | gün(dür)?\s+(içmiyorum|temiz) | nüks
 | 戒 | 天没 | 復発 | 再発 | 禁煙 | 금연 | 금주 | 재발
""", re.I|re.X)
F["OVERVIEW"] = re.compile(r"""
 (see|view|track|check|monitor|visuali[sz]e|watch|measure)\s+(my\s+|your\s+|the\s+|our\s+|all\s+(my\s+)?)?(progress|improvement|consistency|growth|results?) | progress\s+(page|tab|screen|view|report|section|chart|graph|overview|tracker|tracking|history|stats|visuali)
 | (all|every)\s+(my\s+|of\s+my\s+)?habits\s+(at\s+(a|one)\s+glance|in\s+one\s+(view|place|screen|page)|together) | at\s+a\s+glance | overall\s+(progress|stats|statistics|view|score|percentage|completion)
 | (ver|seguir|acompanhar|monitorear|visualizar)\s+(mi|meu|minha|o\s+meu|el|los|mis|meus)?\s*(progreso|progresso|evoluci[óo]n|evolu[çc][ãa]o) | voir\s+(ma|mes|la)\s+(progression|[ée]volution) | fortschritt(e)?\s+(sehen|verfolgen|anzeigen|übersicht) | übersicht | vedere\s+i\s+(miei\s+)?progressi | (видеть|отслеживать|смотреть)\s+(свой\s+|мой\s+)?прогресс | ilerlememi\s+(görmek|takip)
 | 查看进度 | 看到进步 | 进度 | 進捗 | 成長が見える | 진행\s*상황 | 진척
""", re.I|re.X)
F["REPORT"] = re.compile(r"""
 (weekly|monthly|yearly|annual|year[\s-]end|end[\s-]of[\s-]year|daily)\s+(report|review|summary|recap|stats|statistics|overview|analysis|insight) | year\s+in\s+review | \bwrapped\b | \brecap\b | (report|reports)\s+(page|tab|feature|section)
 | (informe|reporte|resumen)\s+(semanal|mensual|anual) | relat[óo]rio\s+(semanal|mensal|anual) | (bilan|rapport)\s+(hebdo|mensuel|annuel) | (wochen|monats|jahres)(bericht|auswertung|statistik|rückblick) | resoconto | (недельн|месячн|годов)\w*\s+(отч[её]т|статистик|итог) | (haftalık|aylık|yıllık)\s+(rapor|istatistik)
 | 周报 | 月报 | 年报 | 年度报告 | 年度總結 | 年度总结 | 週報 | 月報 | 年報 | レポート | リポート | 리포트 | 보고서
""", re.I|re.X)
F["GROUPSTAT"] = re.compile(r"""(stat(s|istics)?|analytics|progress|report|chart|graph|percentage|completion)s?\s+(by|per|for\s+each|of\s+each|across)\s+(categor|group|folder|area|tag|section|routine|list)|(categor(y|ies)|group|folder|area|tag|routine|list)[\s-]*(level\s+)?(stat|analytic|progress|report|chart|percentage|completion)""", re.I|re.X)
F["PARTIAL"] = re.compile(r"""partial\s+(progress|completion|credit|day) | (half|partially)\s+(done|complete|filled) | (over|beyond|exceed(ed|ing)?)\s+(the\s+|my\s+)?(goal|target) | over[\s-]?achiev | (\d+)\s+(of|out\s+of)\s+(\d+)\s+(glasses|pages|times|cups|minutes|reps|km|steps)\s+(shows|counts|marked|is\s+(marked|shown))""", re.I|re.X)
def recs():
    for store, pat in [("app","App Store Reviews/*/reviews.jsonl"),("play","Play Store Reviews/*/reviews.jsonl"),("native","Native Store Reviews/*/reviews.jsonl")]:
        for f in sorted(glob.glob(os.path.join(ROOT, pat))):
            folder = f.split("/")[-2]
            for i,l in enumerate(open(f)):
                r = json.loads(l)
                text = ((r.get("title") or "") + " — " + (r.get("body") or r.get("text") or "")).strip()
                yield store, folder, i+1, r, text
tot = collections.Counter(); hit = collections.Counter(); anyhit=collections.Counter()
with open("candidates.jsonl","w") as w:
    for store, folder, line, r, text in recs():
        n = int(folder.split(".")[0])
        tier = "adjacent" if store=="native" or (store=="play" and n in ADJ_PLAY) else "habit"
        tot[(store,tier)] += 1
        fams = [k for k,p in F.items() if p.search(text)]
        if fams:
            for k in fams: hit[(tier,k)] += 1
            anyhit[(store,tier)] += 1
            w.write(json.dumps({"store":store,"tier":tier,"folder":folder,"line":line,"id":r["review_id"],"rating":r.get("rating"),"date":r.get("date"),"lang":r.get("language") or r.get("country"),"fam":fams,"text":text},ensure_ascii=False)+"\n")
print("totals",dict(tot)); print("any",dict(anyhit))
for k,v in sorted(hit.items()): print(k,v)
