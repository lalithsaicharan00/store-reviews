# Widget Catalogue Evidence Tools

Written by Codex, 5 October 2026.

Run from the repository root with Python 3. The scripts discover the root using `RULEBOOK.md`. Raw numbered App Store/Play Store `reviews.jsonl` files are read-only inputs. The bundled workspace Python works on Windows if Python is not on PATH.

```text
python Research/Tools/widget_catalogue/scan.py
python Research/Tools/widget_catalogue/reopen_sources.py
python Research/Tools/widget_catalogue/verify_evidence.py
python Research/Tools/widget_catalogue/verify_delivery.py
```

`scan.py` inventories widget-word candidates in all eligible numbered files. It writes `Research/Temp/widget_oct5_scan/candidate_index.jsonl` and `summary.json`. The multilingual lexical screen is not theme coding and is not exhaustive for implicit references to widgets without a matched word. Insufficient-volume subfolders are deliberately excluded. The count is an input inventory, not popularity.

`reopen_sources.py` extracts exact A/P source references from the specified earlier widget and free-plan reports, reopens the earlier 43 iPhone evidence records, resolves the 30 September report's cited IDs and includes every Dots original (A56). It writes complete original records to the dated study folder. Its historical refs use **zero-based JSONL record indices**. It does not reconstruct the missing September whole-corpus classification.

`verify_evidence.py` reapplies the explicit hand assignments made after complete-original reading, checks every stable review ID and original record against its raw source, asserts zero unknown refs / within-theme duplicates / unassigned records, and writes the complete per-review index plus a scan/verification summary with audited-input SHA-256 values. It reads physical JSONL lines rather than Unicode `splitlines()`, because Unicode line separators can occur inside original review text. Re-running it does not mean the reviews were newly read by a human.

The fixed audit set is **181 originals: 128 App Store, 53 Play Store, 45 numbered app corpora**. It is deliberately selected, includes general app-design context and all 67 Dots records, and is not a prevalence denominator. Do not turn the theme membership totals into a ranking or infer iPhone percentages from Android records.

`verify_delivery.py` is read-only and can run independently of the scratch inventory. It checks every local Markdown link in the package, handoff, tool guide, request audit and iPhone integration guide; all 54 cited review references; all 28 PNG exports against their manifest dimensions, byte sizes, SHA-256 values and PNG chunk CRCs; exact manifest/image coverage; and stable Figma node ID syntax. It does not assert native behavior or accessibility. Run it after packaging or integrating onto current main.

Outputs: [Widget Catalogue Study](<../../Research Reports/Home Screen and Visual Design/Home Screen Cards and Widgets/Widget Catalogue Study — 5 October 2026/iPhone Widgets — Types, Native Setup and Free vs Plus.md>), with the source JSON, full index and summary beside it. These scripts preserve original source text and leave raw corpora untouched. They write only the dated evidence package and ignored scratch inventory.
