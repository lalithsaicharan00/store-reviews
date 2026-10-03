"""Keyword floors inside the ORDER / FILTER / DISC hit sets, per tier (English-only sub-patterns unless noted).
These are counts of reviews mentioning a phrase, not hand-verified; the hand-read sample gives precision."""
import json, re, collections, os
os.chdir(os.path.dirname(os.path.abspath(__file__)))
C = [json.loads(l) for l in open("cand.jsonl")]
P = {
 "ORDER": {
  "drag_manual_custom": r"(drag|manual\w*\s+(order|sort|arrang)|(own|custom|my)\s+order|re-?order|re-?arrang|change\s+the\s+order|in\s+the\s+order\s+i)",
  "alphabetical": r"(alphabet|\ba[\s-]?(to|-)[\s-]?z\b)",
  "by_time": r"((sort|order|arrang|list)\w*\s+(\w+\s+){0,3}(by|in\s+order\s+of|according\s+to)\s+(the\s+)?(time|scheduled\s+time|start\s+time|time\s+of\s+day)|chronolog|time\s+order|order\s+of\s+time)",
  "by_reminder": r"((sort|order|arrang)\w*\s+(\w+\s+){0,4}(reminder|notification|alarm)|(reminder|notification|alarm)\s+times?\s+(\w+\s+){0,3}(sort|order))",
  "priority": r"(priorit|importance)",
  "done_to_bottom": r"((completed|done|checked|ticked|finished)\s+(\w+\s+){0,5}(to|at)\s+the\s+(bottom|end)|(completed|done|checked|finished)\s+(\w+\s+){0,3}(move|moves|go|goes|sink|drop)\s+down)",
  "new_item_position": r"(new\s+(habit|task|item|goal|one)s?\s+(\w+\s+){0,6}(at|to|on)\s+the\s+(bottom|top|end)|(added|adds|goes|go)\s+(\w+\s+){0,2}(at|to)\s+the\s+(bottom|top|end)\s+of\s+the\s+list)",
  "order_changes_itself": r"((keeps?|kept|always|randomly)\s+(re-?order|re-?arrang|shuffl|jump|mov)\w*|order\s+(keeps|is\s+always|always|gets)\s+(chang|reset|mess)\w*|jump\w*\s+around|random\s+order|(doesn'?t|won'?t|not)\s+(stay|keep|save|remember)\w*\s+(\w+\s+){0,3}order|order\s+(\w+\s+){0,3}(doesn'?t|won'?t)\s+(stay|stick|save))",
  "cant_reorder": r"((can'?t|cannot|can\s+not|unable\s+to|no\s+way\s+to|not\s+able\s+to|wish\s+i\s+could|no\s+option\s+to)\s+(\w+\s+){0,3}(re-?order|re-?arrange|change\s+the\s+order|sort|drag))",
 },
 "FILTER": {
  "filter_by_group": r"(filter\w*.{0,40}(categor|group|tag|area|folder|label|list|type)|(categor|group|tag|area|folder|label)\w*.{0,40}filter)",
  "filter_by_time_of_day": r"(filter\w*.{0,40}(time\s+of\s+day|morning|afternoon|evening|night)|(time\s+of\s+day|morning|afternoon|evening)\w*.{0,40}filter)",
  "hide_completed": r"(hid(e|ing)\s+(the\s+|all\s+)?(completed|done|finished|checked|ticked)|(completed|done|finished|checked|ticked)\s+(habits?|tasks?|items?|ones|goals?)\s+(\w+\s+){0,3}(disappear|hidden|vanish))",
  "keep_completed_visible": r"((completed|done|checked)\s+(habits?|tasks?|items?|ones)\s+(\w+\s+){0,3}(stay|remain|still\s+(show|visible))|don'?t\s+(want|like)\s+(\w+\s+){0,3}(completed|done)\s+(\w+\s+){0,3}(disappear|hidden))",
  "only_today_due": r"(only\s+(show|see|display)\w*\s+(\w+\s+){0,3}(today|due)|(show|see|display)\w*\s+only\s+(\w+\s+){0,3}(today|due))",
 },
 "DISC": {
  "group_category_tag": r"(group|categor|tag|label|folder|area)",
  "section_time_of_day": r"(section|time\s+of\s+(the\s+)?day|morning|afternoon|evening|anytime|time\s+slot|time\s+block)",
  "delete": r"(delet|remov|get\s+rid)", "rename_edit": r"(renam|edit|chang|modif)", "add_create": r"(\badd|creat)",
 },
}
out = {}
for fam, pats in P.items():
    for k, p in pats.items():
        rx = re.compile(p, re.I); cnt = collections.Counter()
        for c in C:
            if fam in c["fam"] and rx.search(c["text"]): cnt[c["tier"]] += 1
        out[f"{fam}.{k}"] = dict(cnt)
json.dump(out, open("floors.json", "w"), indent=1)
for k, v in out.items(): print(k, v)
