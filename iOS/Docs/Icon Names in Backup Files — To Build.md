# Icon Names in Backup Files — To Build

Written by Claude (Claude Code), 5 November 2026, at the user's request: "note down for iOS as well", so this isn't forgotten
when the iPhone app is rewritten in Swift.

**Status: not built on the iPhone. Android has it (A111, schema 11).** The rewrite has to build this for a backup file to
keep its icons in both directions (Rulebook: "A backup file works on both phones").

The user's words: "whatever multiple names we have for that icon, we should store all of them … So when we move to the another
platform, whichever the icons that fits or matches very closely, we just pick that up."

## What the iPhone must do

The format and rules are in [Backup File Format](<../../Core/Backup File Format.md#icon-names-5-nov-2026>). In short:

1. **Store the names.** Each habit and task keeps `symbol` (its SF Symbol's name, as now) and `symbol_names`, a
   comma-separated list: `figure.run,directions_run,run_circle,sprint,run,jog`. Write both to `data.json`, and read
   `symbol_names` as optional, because older files don't have it.
2. **Copy the table to Swift.** Android's is `Android/app/src/main/kotlin/com/oftenenough/app/data/IconNames.kt`: each SF Symbol
   with its Material names and plain words. It needs the same names in the same order, for the same reasons.
3. **Pick the icon when reading.** Go through `symbol_names` in order, then `symbol`:
   - A name in the table's picker, or one iOS can draw (`UIImage(systemName:)` isn't nil), is the answer.
   - Otherwise look it up among the table's Material names and plain words, ignoring capitals and a trailing `.fill`.
   - If nothing matches, keep the habit's own values and draw the default icon.
4. **Keep the names when saving.** While the icon is still the one its names lead to, keep them in their order and add any
   the iPhone knows, so an icon only Android has goes back to Android. An icon the person chose since starts again from
   its own names.
5. **Fill in the ones that are missing:** a habit with none, from an older file or an earlier version, gets its names on
   load. Change only that field, and not `updated_at`.
6. **Sync it:** `symbol_names` goes through iCloud like every other habit field.

**A new icon in either picker goes in both tables, in the same change.**

## Check before calling it done

- A file saved on Android opens on the iPhone with every icon right, and the other way round.
- A file with no `symbol_names` still opens, and its icons come from `symbol` (keep a sample of each, D5).
- An icon only one phone has goes across, comes back after an edit on the other phone, and is the original again.
- A name that's unknown never loses the habit or its names.

## Until the rewrite

The current iPhone app still links the shared core, and passes `symbolNames: nil` when it saves (`RecordMapping.swift`). That
keeps it building, but **saving a habit there clears its names.** No released app does this, and the rewrite replaces this code.
