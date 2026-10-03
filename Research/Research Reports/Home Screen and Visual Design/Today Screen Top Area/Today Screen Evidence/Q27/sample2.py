"""Second, targeted reading draw (seed 20261004) after the first FILTER and DISC samples were mostly off-topic
(FILTER 28/70 relevant, DISC 38/70). Draws only reviews not already read.
  FILTER2: habit-tier FILTER hits matching FSTRONG (filter near category/group/tag/time words, hide completed, show only ...): 25 low + 25 high
  DISC2  : habit-tier DISC hits naming a group/category/tag/folder/section/time-of-day object (not just 'list'): 25 low + 15 high"""
import json, random, re, os, collections
os.chdir(os.path.dirname(os.path.abspath(__file__)))
C = [json.loads(l) for l in open("cand.jsonl")]
H = [c for c in C if c["tier"] == "habit"]
read = {json.loads(l)["cite"] for l in open("sample.jsonl")}
FSTRONG = re.compile(r"(filter\w*.{0,50}(categor|group|tag|area|folder|label|list|time\s+of\s+day|morning|evening|routine|type)|(categor|group|tag|area|folder|label|time\s+of\s+day|routine)\w*.{0,50}filter|hid(e|ing)\s+(the\s+)?(completed|done|finished|checked)|(completed|done|finished|checked)\s+(habits?|tasks?|items?|ones)\s+.{0,30}(disappear|hidden|hide|vanish)|show\w*\s+only\s+(the\s+)?(habits|tasks|ones|today|uncomplet|incomplet|undone|what)|filtr\w*.{0,50}(categor|grupo|etiquet|tag)|(categor|grupo|etiquet)\w*.{0,50}filtr|筛选|篩選|フィルタ|絞り込|필터|фильтр|隐藏已完成|完了.{0,5}非表示)", re.I)
DOBJ = re.compile(r"(section|categor|group|folder|\btags?\b|label|area|time\s+of\s+(the\s+)?day|morning|afternoon|evening|routine|категор|групп|раздел|папк|カテゴリ|グループ|タグ|카테고리|그룹|태그|分类|分组|分組|标签|kategor|grupo|categor|etiquet)", re.I)
rnd = random.Random(20261004)
def pick(pool, nl, nh):
    pool = [c for c in pool if c["cite"] not in read]
    low = [c for c in pool if (c["rating"] or 0) <= 3]; high = [c for c in pool if (c["rating"] or 0) >= 4]
    rnd.shuffle(low); rnd.shuffle(high); return low[:nl] + high[:nh]
fp = [c for c in H if "FILTER" in c["fam"] and FSTRONG.search(c["text"])]
dp = [c for c in H if "DISC" in c["fam"] and DOBJ.search(c["text"])]
print("pools", len(fp), len(dp))
out = {"FILTER2": pick(fp, 25, 25), "DISC2": pick(dp, 25, 15)}
with open("sample.jsonl", "a") as w:
    for theme, rows in out.items():
        with open(f"batches/{theme}.txt", "w") as f:
            for c in rows:
                f.write(f"{c['cite']} ★{c['rating']} [{c['folder'][:28]}] {c['text']}\n\n")
                w.write(json.dumps({k: c[k] for k in ("cite", "id", "folder", "rating", "date", "fam")} | {"drawn": theme}, ensure_ascii=False) + "\n")
print({k: len(v) for k, v in out.items()})
