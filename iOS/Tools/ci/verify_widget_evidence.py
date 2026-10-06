#!/usr/bin/env python3
"""Validate every quoted record against immutable source data; no new coding/count claims."""
import json
from pathlib import Path
from collections import defaultdict

root = Path(__file__).resolve().parents[3]
evidence = root / 'Research/Research Reports/Home Screen and Visual Design/Home Screen Cards and Widgets/Widgets/Historical Research/iPhone Widget Evidence/primary_reviews.json'
by_app = defaultdict(list)
for item in json.loads(evidence.read_text()):
    by_app[item['app']].append(item)
verified = 0
for app, records in by_app.items():
    source = next((root / 'Research/App Store Reviews').glob(f'{app}. */reviews.jsonl'))
    needed = {int(item['ref'].split('#')[1]): item for item in records}
    for index, line in enumerate(source.open()):
        if index not in needed:
            continue
        original, quote = json.loads(line), needed[index]
        for key in ['rating', 'title', 'body', 'date', 'country']:
            assert original[key] == quote[key], (quote['ref'], key)
        assert str(original['review_id']) == quote['id'], quote['ref']
        verified += 1
assert verified == 43, verified
print(f'Widget evidence: {verified} primary records match immutable sources')
