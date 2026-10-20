# Habit App Inventory — How to Run

Written by Codex, 13 October 2026.

The inventory separates Google Play cumulative download bands, Apple ratings summed by country, provider download estimates and founder statements/inferences. It never equates ratings with downloads (Rulebook W2).

Run from the repository root with Python 3. Existing source review corpora and scan caches are read-only. Resumable public responses go to `Research/Temp/habit_inventory_2026_10_13/`; final evidence goes to `Research/Research Reports/Market Discovery/Habit App Inventory Data/`.

```powershell
python Research/Tools/habit_inventory.py discover
python Research/Tools/habit_inventory.py play
python Research/Tools/habit_inventory.py apple_candidates
python Research/Tools/habit_inventory.py apple
python Research/Tools/habit_inventory.py estimates
python Research/Tools/build_habit_inventory.py
```

Read `habit_inventory_curation.json` before rebuilding; it records category boundaries and corrections to the earlier curation. `habit_inventory_download_evidence.json` records additional attributed download evidence. The Apple candidate phase preserves all name matches in a discovery queue but prioritizes the original curated list, named leads and newly observed names with at least 500 ratings in the last returned search storefront for worldwide lookups. This is work prioritization, not a download threshold; small discoveries remain unresolved, not excluded. Review them before claiming completeness.

Discovery caches retain original store responses locally. Apple lookups query up to 100 IDs per batch across the repository's country-code list, with bounded retries and success/failure coverage. Search reads up to 200 Apple results per cell. Duplicate searches in one country do not multiply that country's ratings.

Provider requests may fail or be rejected. Stop after repeated rejection and retain gaps. The 13 October run stopped provider collection after rejections; do not rerun it blindly. Failed/missing estimates are not zero, and a monthly estimate below 10,000 cannot determine whether lifetime downloads reach 10,000. Resuming from the dated scratch cache is a continuation of that observation, not a new live snapshot; use a new dated cache path for a later refresh.

The builder requires completed Apple collection, validates platform/store-ID uniqueness, verifies qualifying numeric evidence independently of ratings, and recomputes every Apple total from country evidence. It emits a Markdown inventory, four CSV views, country-level Apple evidence, estimate evidence and a summary JSON. Stable store IDs preserve apps whose titles changed and prevent equally named apps being merged.

Before delivery, check every local report link and the CSV schemas, and run `git diff --check`. No app code changed; no iOS CI is necessary for this research-only artifact (T7/W2). Commit only when asked (W4).
