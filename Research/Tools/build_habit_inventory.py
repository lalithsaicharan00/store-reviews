#!/usr/bin/env python3
"""Build auditable, platform-specific inventory from dated public-store evidence."""
import csv
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[2]
TMP = ROOT / 'Research/Temp/habit_inventory_2026_10_13'
OUT = ROOT / 'Research/Research Reports/Market Discovery'
DATA = OUT / 'Habit App Inventory Data'
DATA.mkdir(parents=True, exist_ok=True)

def read(path):
    return json.loads(path.read_text(encoding='utf-8'))

def save(name, value):
    (DATA / name).write_text(json.dumps(value, ensure_ascii=False, indent=2), encoding='utf-8')

def write_csv(name, rows):
    if not rows:
        return
    with (DATA / name).open('w', encoding='utf-8-sig', newline='') as stream:
        writer = csv.DictWriter(stream, fieldnames=list(rows[0]))
        writer.writeheader()
        writer.writerows(rows)

cur = read(ROOT / 'Research/Tools/habit_inventory_curation.json')
apple = read(TMP / 'apple_ratings.json')
play = read(TMP / 'play_details.json')
discovery = read(TMP / 'discovery.json')
candidates = read(TMP / 'apple_candidates.json')
estimates = read(TMP / 'apple_estimates.json')
download_sources = read(ROOT / 'Research/Tools/habit_inventory_download_evidence.json')
assert apple.get('checked_at_utc'), 'Apple collection must finish before building'
assert len(apple['storefront_batches']) == len(apple['requested_storefronts']) * 2
failed_batches = {key: val for key, val in apple['storefront_batches'].items() if val != 'ok'}
fully_read = [cc for cc in apple['requested_storefronts'] if all(apple['storefront_batches'][f'{cc}:{i}'] == 'ok' for i in (0, 1))]
rows = []
for app_id, app in apple['apps'].items():
    estimate = estimates.get(app_id, {})
    evidence = download_sources.get(app_id)
    category = 'identity lead' if app_id == '6754049782' else 'primary habit/routine'
    status = 'unverified'
    figure = None
    shown = ''
    evidence_type = 'no qualifying public download evidence'
    source = ''
    period = ''
    scope = ''
    note = 'Ratings support audience assessment; they do not substitute for downloads.'
    if evidence:
        figure = evidence['downloads']
        shown = f'{figure:,}'
        evidence_type = evidence['download_evidence_type']
        source = evidence['source']
        period = evidence['period']
        scope = evidence['scope']
        note = evidence['note']
        status = 'supported by founder inference' if 'inference' in evidence_type else 'supported by estimate'
    elif estimate.get('downloads_estimate', 0) >= 10000 and estimate.get('operating_system') == 'iOS':
        figure = estimate['downloads_estimate']
        shown = estimate['downloads_shown']
        evidence_type = 'provider_estimate'
        source = estimate['url']
        period = estimate['period']
        scope = 'Apple App Store; metadata lacks explicit geography; provider standard overview uses Worldwide'
        note = 'Inference: the monthly estimate supports the lifetime 10,000 threshold. Public HTML metadata; not an official Apple count.'
        status = 'supported by estimate'
    else:
        shown = estimate.get('downloads_shown', '')
        source = estimate.get('url', '')
        period = estimate.get('period', '')
        note += ' A monthly figure below 10,000 does not establish fewer than 10,000 lifetime downloads.'
    rows.append({'platform': 'Apple App Store', 'store_id': app_id, 'name': app['name'],
                 'developer': app['developer'], 'category': category, 'download_threshold_status': status,
                 'download_figure': figure, 'download_figure_shown': shown,
                 'download_evidence_type': evidence_type, 'download_period': period,
                 'download_geography': scope, 'download_source_url': source,
                 'global_ratings_observed': sum(app['by_storefront'].values()),
                 'rating_storefronts_with_listing': len(app['by_storefront']),
                 'rating_storefronts_requested': len(apple['requested_storefronts']),
                 'rating_storefronts_successfully_read': len(fully_read),
                 'store_url': app['url'], 'first_release_date': app['release_date'],
                 'checked_at_utc': apple['checked_at_utc'], 'notes': note})

play_review = []
for package, app in play.items():
    if package in cur['play_exclude']:
        membership, reason = 'out of scope', cur['play_exclude'][package]
    elif package in cur['play_adjacent']:
        membership, reason = 'adjacent', cur['play_adjacent'][package]
    elif (app.get('downloads_lower_bound') or 0) >= 10000:
        membership, reason = 'primary habit/routine', 'Habit/routine tracking described in the listing or the attributed existing curation'
    else:
        membership, reason = 'discovery queue', 'Below current displayed download band or category not independently reviewed'
    play_review.append({'store_id': package, 'name': app.get('title', ''), 'developer': app.get('developer', ''),
                        'category_status': membership, 'category_reason': reason,
                        'download_band': app.get('downloads_shown', ''),
                        'download_lower_bound': app.get('downloads_lower_bound'),
                        'page_readable': bool(app.get('title')), 'source_url': app['url']})
    if membership not in ('primary habit/routine', 'adjacent') or (app.get('downloads_lower_bound') or 0) < 10000:
        continue
    rows.append({'platform': 'Google Play', 'store_id': package, 'name': app['title'],
                 'developer': app['developer'], 'category': membership, 'download_threshold_status': 'verified store band',
                 'download_figure': app['downloads_lower_bound'], 'download_figure_shown': app['downloads_shown'],
                 'download_evidence_type': 'Google Play worldwide download lower-bound band',
                 'download_period': 'Cumulative public store band at observation', 'download_geography': 'Worldwide',
                 'download_source_url': app['url'], 'global_ratings_observed': app.get('global_ratings'),
                 'rating_storefronts_with_listing': '', 'rating_storefronts_requested': '',
                 'rating_storefronts_successfully_read': '', 'store_url': app['url'], 'first_release_date': '',
                 'checked_at_utc': app['checked_at_utc'], 'notes': reason})

rows.sort(key=lambda row: (row['platform'], row['name'].casefold(), row['store_id']))
assert len({(row['platform'], row['store_id']) for row in rows}) == len(rows)
assert all(row['download_figure'] >= 10000 for row in rows if row['download_threshold_status'] != 'unverified')
assert all(row['global_ratings_observed'] == sum(apple['apps'][row['store_id']]['by_storefront'].values())
           for row in rows if row['platform'] == 'Apple App Store')
qualified = [row for row in rows if row['download_threshold_status'] != 'unverified' and row['category'] != 'identity lead']
apple_rows = [row for row in rows if row['platform'] == 'Apple App Store']
play_rows = [row for row in rows if row['platform'] == 'Google Play' and row['category'] == 'primary habit/routine']
adjacent = [row for row in rows if row['category'] == 'adjacent']

apple_discoveries = []
for app_id in candidates['discovered_ids']:
    metadata = candidates['metadata'].get(app_id, {})
    found = apple['apps'].get(app_id)
    observed = {}
    for index, results in discovery['apple'].items():
        if isinstance(results, list):
            country = discovery['queries'][int(index)][0]
            for result in results:
                if str(result['trackId']) == app_id:
                    observed[country] = result.get('userRatingCount', 0)
    apple_discoveries.append({'store_id': app_id, 'name': found['name'] if found else metadata.get('trackName', ''),
                              'developer': found['developer'] if found else metadata.get('sellerName', ''),
                              'review_status': 'prioritized inventory' if found else ('out of scope' if app_id in cur['apple_new_exclusions'] else 'unreviewed discovery'),
                              'ratings_seen_in_search_storefronts': sum(observed.values()),
                              'search_storefronts_with_listing': len(observed),
                              'store_url': f'https://apps.apple.com/app/id{app_id}'})
write_csv('inventory.csv', rows)
write_csv('download_threshold_supported.csv', qualified)
write_csv('apple_discovery_queue.csv', apple_discoveries)
write_csv('play_discovery_audit.csv', play_review)
save('apple_rating_evidence.json', {'checked_at_utc': apple['checked_at_utc'], 'requested_storefronts': apple['requested_storefronts'],
                                   'successfully_read_storefronts': fully_read, 'failed_batches': failed_batches,
                                   'apps': {app_id: {'name': app['name'], 'by_storefront': app['by_storefront']} for app_id, app in apple['apps'].items()}})
save('apple_download_estimates.json', estimates)
save('additional_download_evidence.json', download_sources)
summary = {'date': '2026-10-13', 'inventory_rows': len(rows), 'play_primary_verified': len(play_rows),
           'play_adjacent_verified': len(adjacent), 'apple_prioritized': len(apple_rows),
           'apple_download_supported': sum(row['platform'] == 'Apple App Store' for row in qualified),
           'apple_download_unverified': sum(row['download_threshold_status'] == 'unverified' for row in apple_rows),
           'apple_discovery_candidates': len(apple_discoveries), 'play_discovered_packages': len(play),
           'apple_storefronts_requested': len(apple['requested_storefronts']), 'apple_storefronts_read': len(fully_read),
           'failed_apple_storefronts': sorted({key.split(':')[0] for key in failed_batches}),
           'apple_search_cells': len(discovery['apple']), 'play_search_cells': len(discovery['play']),
           'validation': 'Unique platform/ID keys, download evidence separate from ratings, threshold-supported rows >=10,000, Apple sums match per-country evidence'}
save('summary.json', summary)

def esc(value):
    return str(value or '').replace('|', '\\|').replace('\n', ' ')

def table(group, columns):
    labels = [label for label, field in columns]
    lines = ['| ' + ' | '.join(labels) + ' |', '| ' + ' | '.join('---' for _ in labels) + ' |']
    for row in group:
        cells = []
        for label, field in columns:
            value = row.get(field)
            if field == 'name':
                value = f'[{esc(value)}]({row["store_url"]})'
            elif field == 'global_ratings_observed' and isinstance(value, int):
                value = f'{value:,}'
            elif field == 'download_evidence':
                shown = row['download_figure_shown'] or 'Unavailable'
                value = f'[{esc(shown)}]({row["download_source_url"]})' if row['download_source_url'] else shown
            cells.append(esc(value) if field not in ('name', 'download_evidence') else value)
        lines.append('| ' + ' | '.join(cells) + ' |')
    return '\n'.join(lines)

text = f'''# Habit App Inventory — 13 October 2026

Written by Codex, 13 October 2026.

The inventory contains **{len(play_rows)} primary habit/routine apps on Google Play with a verified 10K+ download band**, plus **{len(adjacent)} adjacent apps with habit or routine features**. Apple has **{len(apple_rows)} prioritized listings**: **{summary['apple_download_supported']} have qualifying download evidence from estimates or a founder report**, while **{summary['apple_download_unverified']} still have unverified download qualification**. Apple ratings are supporting evidence only. The download cutoff stays at **10,000 worldwide downloads on each platform**, exactly as the user confirmed.

This is a search-based discovery inventory, not a certified exhaustive census. Local listings absent from the searches, delisted apps and apps whose download figures are private may be missing. The additional **{len(apple_discoveries):,} Apple discovery candidates** are preserved in the discovery queue, including small apps; category review and download verification are incomplete there. Do not describe all of them as qualifying habit trackers.

## Files to use

- [Complete prioritized inventory, CSV](<Habit App Inventory Data/inventory.csv>): both platforms, developer, stable store ID, store/source links, ratings, dates, qualification and evidence scope.
- [Download threshold supported, CSV](<Habit App Inventory Data/download_threshold_supported.csv>): verified Google Play bands and separately labeled Apple estimates/founder inference. Apple estimates and founder inference are evidence types distinct from official download counts.
- [Apple discovery queue, CSV](<Habit App Inventory Data/apple_discovery_queue.csv>): all {len(apple_discoveries):,} name-matching discoveries, with review status; its search-only rating column is a partial observed total, not a global total.
- [Play discovery audit, CSV](<Habit App Inventory Data/play_discovery_audit.csv>): all {len(play)} packages checked, including unrelated matches, small bands and unreadable pages.
- [Apple ratings by country, JSON](<Habit App Inventory Data/apple_rating_evidence.json>): recomputable totals and failed-country coverage.
- [Download estimate observations](<Habit App Inventory Data/apple_download_estimates.json>) and [additional attributed evidence](<Habit App Inventory Data/additional_download_evidence.json>).

## Scope and collection

Included as primary: configurable habits, recurring routine completion, gamified habit tracking, and configurable bad-habit tracking. Broader task/mood apps with habit features are adjacent. Single-purpose smoking, fasting, fitness, reading and finance trackers, calendars, generic task managers and keyword collisions are outside the primary category. Dedicated habit features are why TickTick and Daylio remain in the adjacent list. This category boundary is an explicit research choice; it is not a product decision.

Started from the repository's attributed curation/ranking files (90 Apple and 146 Play entries); did not apply their search-position, market-reach or rating cutoffs. Added fresh discovery with 24 keyword/market cells per store (Play China skipped), covering English, Japanese, Korean, Chinese, German, French, Portuguese, Spanish, Russian, Indonesian, Turkish and Vietnamese. Apple requests use the maximum 200 results; a finite result limit still misses the long tail. Existing scans cover eight terms across 53 markets. Public search ordering establishes discovery only, not eligibility.

For Apple, existing curated listings, explicit named leads, and newly discovered name-matching apps with at least 500 ratings in the last returned search storefront were prioritized for description review and all-country lookup. That 500 figure is a **work-priority heuristic**, not the inclusion/download cutoff: lower-rating apps remain in the full discovery queue with unresolved status. No low-rating app is asserted to have fewer than 10,000 downloads. This prioritization limits completeness.

Apple's existing `fetch_meta.py`/`habit_rank.py` pattern was reused: batch iTunes lookup by country, then sum `userRatingCount` once per app/country. Requested **{len(apple['requested_storefronts'])} distinct storefront codes**, successfully read **{len(fully_read)}**, and received HTTP 400 for **{', '.join(summary['failed_apple_storefronts'])}**. These codes come from the repository's `markets.py`; this does not prove every code is a currently supported Apple storefront. A successful lookup without a listing is recorded as absence, while a failed request is never counted as zero. The totals below are observed across the successfully read storefronts, with two country-code gaps. They are ratings (including star-only ratings), not written reviews or downloads. See [Apple's ratings guidance](https://developer.apple.com/app-store/ratings-and-reviews/) and [view ratings by country](https://developer.apple.com/help/app-store-connect/monitor-ratings-and-reviews/view-ratings-and-reviews/).

Google Play bands were read from live English/US detail pages on 13 October 2026. The displayed band is a worldwide cumulative lower bound; availability was checked only through that storefront. The complete audit contains {len(play)} packages. Observations were cached in `Research/Temp` and the original review corpora/scan caches were not overwritten.

Apple download evidence uses public provider estimates separately from ratings. A month's estimate of 10,000 or more supports passing a 10,000 lifetime threshold **on an estimated basis**. A monthly estimate below 10,000 cannot prove lifetime downloads below 10,000. Provider estimates are rounded and may be stale; preserve the stated period. Some Sensor Tower HTML exposes only the estimate metadata, while its standard overview labels those badges Worldwide/Last Month; the geographic inference is explicit in the CSV. Numerous provider requests were rejected; collection stopped and unresolved statuses were retained. No authentication or paid dashboard was bypassed.

HabitKit's founder reports over 300,000 combined downloads and roughly twice as many on Google Play as App Store on 10 March 2024. Approximately 100,000 iOS downloads follows from that self-report; it is an inference, not an exact Apple count. [Founder's post](https://www.linkedin.com/pulse/weekly-indie-log-22-sebastian-r%C3%B6hl-sjgne). Cross-platform totals on their own, such as [Timecap's 500,000+ claim](https://timecap.app/), were not assigned to Apple.

## Google Play: primary habit and routine tracking, verified 10K+ band

Names and store IDs are separate: apps with identical titles are not merged. The rows are alphabetized; this is not a popularity ranking.

{table(play_rows, [('App / store link', 'name'), ('Developer', 'developer'), ('Downloads', 'download_figure_shown'), ('Package ID', 'store_id')])}

## Google Play: adjacent apps, verified 10K+ band

{table(adjacent, [('App / store link', 'name'), ('Downloads', 'download_figure_shown'), ('Why separate', 'notes')])}

## Apple: download threshold supported by estimate or founder inference

These rows have download evidence independent of their rating totals. Evidence quality and time/geography are stated in the CSV. An estimate is not an official Apple measurement.

{table([row for row in qualified if row['platform'] == 'Apple App Store'], [('App / store link', 'name'), ('Download evidence / source', 'download_evidence'), ('Evidence type', 'download_evidence_type'), ('Period', 'download_period'), ('Observed global ratings', 'global_ratings_observed')])}

## Apple: prioritized listings with download qualification unverified

These remain candidates for the user's requested list; their download threshold is not asserted. They are retained even when ratings are low. Each observed total is independently recomputable from the country JSON.

{table([row for row in apple_rows if row['download_threshold_status'] == 'unverified'], [('App / store link', 'name'), ('Developer', 'developer'), ('Observed global ratings', 'global_ratings_observed'), ('App ID', 'store_id')])}

## Historical listing and the user's identity lead

**HabitHub — Habit & Goal Tracker**, package `com.rstudioz.habits`: its current US Play detail page did not return a listing. [AndroidRank's historical record](https://www.androidrank.org/application/habithub_habit_goal_trackr/com.rstudioz.habits) attributes 1,000,000+ installs to Google Play. This is historical secondary evidence, separate from the current verified-band list; current availability and the removal date are not independently established. A different current app named Habit Hub is not automatically the same product.

The user corrected the example's name to **“App Stick.”** Possible names encountered are **STICK: Routine Accountability**, Apple ID `6754049782`, and **Habit Tracker - Habstick**, Play package `com.habit.habstick` (50K+ band). Their resemblance to the spoken name does not establish identity. HabitKit is also retained as its own product. The Reddit post and multilingual-page explanation are unverified user-supplied leads; they are not research findings here. The user will direct growth-year, download-surge and founder-story investigation after reviewing the list.

## Validation and remaining gaps

Validated unique platform/store-ID keys, qualifying download figures at least 10,000, exact agreement between Apple sums and per-country evidence, and distinct statuses for official store bands, estimates, founder inference and unknown downloads. All local deliverable links resolve. `git diff --check` and `iOS/Tools/perf/check_rules.sh` passed. No app code changed and no CI was dispatched (Rulebook T7/W2/W4).

Remaining: establish lifetime download qualification for the {summary['apple_download_unverified']} prioritized Apple candidates; review the unprioritized discovery queue; broaden historical/delisted coverage; verify the identity of App Stick. The list is ready for review with these gaps visible. Exhaustive coverage and download qualification for the remaining candidates are not established.
'''
report = OUT / 'Habit App Inventory — 13 October 2026.md'
report.write_text(text, encoding='utf-8')
print(json.dumps(summary, indent=2))
