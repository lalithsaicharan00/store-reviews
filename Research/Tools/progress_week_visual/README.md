# Progress Week Visual Research Tools

Run from `Research/Tools/`; paths resolve from the script location. All intermediate review text, classifications and downloaded references stay in gitignored `Research/Temp/progress-week/`.

```sh
python3 progress_week_visual/scan.py
python3 progress_week_visual/expand_scan.py
python3 progress_week_visual/classify_initial.py
python3 progress_week_visual/finalize.py
python3 progress_week_visual/verify.py '../Research Reports/Progress and Statistics/Progress Week — Visual Options.md'
```

The scanner imports the existing Progress audit's multilingual context patterns. `language_pairs.json` and the explicit expansion terms widen weekly/visual retrieval. `finalize.py` applies the disclosed focused proximity rule to broad expansion candidates and combines the saved manual indices for 339 initial and 323 supplemental records. Keyword hits never assign sentiment automatically. If the corpus or candidate ordering changes, its assertions stop: reread and hand-code changed candidates before quoting new counts.

`classify_initial.py` and `supplement_classification.json` preserve hand-curated row maps. The evidence folder contains the durable full per-review index and theme-to-ID map. `verify.py` checks canonical records using physical JSONL lines, including Native and Unicode line separators in review bodies. It does not verify design comprehension or native app performance.

Mockup reproduction lives separately in `Research Reports/Progress and Statistics/Week View Options/render.cjs`. It needs Playwright and the installed Chrome path; the research run used the bundled workspace Playwright via `NODE_PATH`. It renders local research HTML only, not app code, and writes all 15 mode/layout checks.
