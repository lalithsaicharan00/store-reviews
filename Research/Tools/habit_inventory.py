#!/usr/bin/env python3
"""Public-store discovery and size evidence; never equates ratings with downloads.

Run from the repository root. Scratch/resumable responses go to Research/Temp.
Existing review corpora and existing scan caches are read-only.
"""
import argparse
import concurrent.futures as cf
import datetime as dt
import html
import json
from pathlib import Path
import re
import sys
import threading
import time
import urllib.error
import urllib.parse
import urllib.request

ROOT = Path(__file__).resolve().parents[2]
TOOLS = ROOT / 'Research/Tools'
sys.path.insert(0, str(TOOLS))
import markets

SCRATCH = ROOT / 'Research/Temp/habit_inventory_2026_10_13'
SCRATCH.mkdir(parents=True, exist_ok=True)
UA = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/130.0.0.0 Safari/537.36'
LOCK = threading.Lock()
LAST = {'apple': 0, 'play': 0, 'lookup': 0}

def read(path):
    return json.loads(Path(path).read_text(encoding='utf-8'))

def save(path, value):
    Path(path).parent.mkdir(parents=True, exist_ok=True)
    Path(path).write_text(json.dumps(value, ensure_ascii=False, indent=2), encoding='utf-8')

def get(url, kind):
    provider = 'sensortower.com' in url
    for attempt in range(1 if provider else 3):
        with LOCK:
            delay = 2.6 if kind == 'apple' else (1.4 if kind == 'lookup' else 0.45)
            time.sleep(max(0, LAST[kind] + delay - time.monotonic()))
            LAST[kind] = time.monotonic()
        try:
            req = urllib.request.Request(url, headers={'User-Agent': UA, 'Accept-Language': 'en-US,en;q=0.9'})
            with urllib.request.urlopen(req, timeout=10 if provider else 35) as response:
                return response.read().decode('utf-8', 'replace')
        except urllib.error.HTTPError as error:
            if error.code == 404:
                return None
            if error.code in (403, 429, 503):
                time.sleep(8 * (attempt + 1))
            else:
                return {'error': str(error)}
        except Exception as error:
            if provider or attempt == 2:
                return {'error': str(error)}
            time.sleep(2)
    return {'error': 'retry limit'}

def request(url, kind, cache):
    if cache.exists():
        result = read(cache)
        if not isinstance(result, dict) or 'error' not in result:
            return result
    result = get(url, kind)
    save(cache, result)
    return result

def discover():
    queries = [
        ('us', 'en', 'habit tracker'), ('us', 'en', 'habit tracking'),
        ('us', 'en', 'daily habits'), ('us', 'en', 'routine tracker'),
        ('us', 'en', 'habit builder'), ('us', 'en', 'streak tracker'),
        ('us', 'en', 'habit calendar'), ('us', 'en', 'habit RPG'),
        ('us', 'en', 'habit goals'), ('us', 'en', 'quit habits'),
        ('in', 'en', 'habit tracker'), ('gb', 'en', 'habit tracker'),
        ('jp', 'ja', '習慣 トラッカー'), ('kr', 'ko', '습관 관리'),
        ('cn', 'zh', '习惯 打卡'), ('tw', 'zh', '習慣 追蹤'),
        ('de', 'de', 'Gewohnheiten Tracker'), ('fr', 'fr', 'suivi habitudes'),
        ('br', 'pt', 'rastreador de hábitos'), ('mx', 'es', 'seguimiento hábitos'),
        ('ru', 'ru', 'трекер привычек'), ('id', 'id', 'pelacak kebiasaan'),
        ('tr', 'tr', 'alışkanlık takip'), ('vn', 'vi', 'theo dõi thói quen'),
    ]
    def one(job):
        index, (country, language, term), kind = job
        if kind == 'play' and country == 'cn':
            return kind, index, []
        params = ({'term': term, 'country': country, 'entity': 'software', 'limit': 200}
                  if kind == 'apple' else {'q': term, 'gl': country, 'hl': language, 'c': 'apps'})
        base = 'https://itunes.apple.com/search?' if kind == 'apple' else 'https://play.google.com/store/search?'
        url = base + urllib.parse.urlencode(params)
        result = request(url, kind, SCRATCH / f'{kind}_search_{index}.json')
        if isinstance(result, str):
            if kind == 'apple':
                result = json.loads(result).get('results', [])
            else:
                result = list(dict.fromkeys(re.findall(r'/store/apps/details\?id=([A-Za-z0-9_.]+)', result)))
        return kind, index, result
    results = {'queries': queries, 'apple': {}, 'play': {}}
    jobs = [(index, query, kind) for index, query in enumerate(queries) for kind in ('apple', 'play')]
    with cf.ThreadPoolExecutor(max_workers=4) as pool:
        for kind, index, result in pool.map(one, jobs):
            results[kind][str(index)] = result
            print('search', kind, index, len(result) if isinstance(result, list) else 'failed', flush=True)
    save(SCRATCH / 'discovery.json', results)

def play_details():
    discovery = read(SCRATCH / 'discovery.json')
    known = read(TOOLS / 'play_scans/_details.json')
    packages = set(known)
    packages.update(('com.finch.finch', 'com.funnmedia.habitminder', 'com.ziggycrane.time', 'com.rstudioz.habits'))
    packages.update(r['package'] for r in read(TOOLS / 'play_curation.json')['include'])
    for results in discovery['play'].values():
        if isinstance(results, list):
            packages.update(results)
    def one(package):
        url = 'https://play.google.com/store/apps/details?' + urllib.parse.urlencode({'id': package, 'gl': 'US', 'hl': 'en'})
        result = request(url, 'play', SCRATCH / f'play_{package}.json')
        if not isinstance(result, str):
            return package, {'package': package, 'url': url, 'error': result}
        def grab(pattern):
            match = re.search(pattern, result)
            return html.unescape(match.group(1)) if match else None
        title = grab(r'<title[^>]*>([^<]+?)(?:\s*-\s*Apps on Google Play)?</title>')
        developer = grab(r'/store/apps/dev(?:eloper)?\?id=[^"]*"[^>]*>\s*<span>([^<]{1,100})</span>') or known.get(package, {}).get('developer')
        ratings = grab(r'"ratingCount"\s*:\s*"?(\d+)')
        shown = grab(r'<div class="ClM7O">([^<]+)</div><div class="g1rdde">Downloads</div>')
        lower = None
        if shown:
            number = re.fullmatch(r'([\d,.]+)([KMB]?)\+', shown)
            if number:
                lower = int(float(number[1].replace(',', '')) * {'': 1, 'K': 1000, 'M': 1000000, 'B': 1000000000}[number[2]])
        desc = grab(r'<meta itemprop="description" content="([^"]+)"')
        if not desc:
            desc = grab(r'<meta name="description" content="([^"]+)"')
        data = {'package': package, 'title': title, 'developer': developer, 'downloads_shown': shown,
                'downloads_lower_bound': lower, 'url': url, 'description': desc,
                'global_ratings': int(ratings) if ratings else None,
                'checked_at_utc': dt.datetime.now(dt.timezone.utc).isoformat()}
        return package, data
    output = {}
    with cf.ThreadPoolExecutor(max_workers=5) as pool:
        for index, (package, data) in enumerate(pool.map(one, sorted(packages)), 1):
            output[package] = data
            if index % 25 == 0:
                save(SCRATCH / 'play_details.json', output)
                print('play details', index, '/', len(packages), flush=True)
    save(SCRATCH / 'play_details.json', output)

def apple_candidates():
    discovery = read(SCRATCH / 'discovery.json')
    metadata = {}
    for results in discovery['apple'].values():
        if not isinstance(results, list):
            continue
        for row in results:
            metadata[str(row['trackId'])] = row
    included = {row['app_id'] for row in read(TOOLS / 'curation.json')['include']}
    markers = r'habit|streak|routine|習慣|习惯|打卡|습관|привыч|Gewohn|habitude|hábit|kebiasaan|alışkan|thói quen'
    for app_id, row in metadata.items():
        if re.search(markers, row.get('trackName', ''), re.I):
            included.add(app_id)
    # Name supplied by user: retain as an identity candidate, without equating it with HabitKit.
    included.add('6754049782')
    discovered = sorted(included)
    curation = read(TOOLS / 'habit_inventory_curation.json')
    old = {row['app_id'] for row in read(TOOLS / 'curation.json')['include']}
    # Review priority only; low-rating discoveries remain in the discovery queue,
    # with their download qualification unverified, never declared below cutoff.
    reviewed = old | {app_id for app_id in included if app_id not in curation['apple_new_exclusions']
                      and metadata.get(app_id, {}).get('userRatingCount', 0) >= 500}
    reviewed.update(('6754049782', '1494584871', '1048191045', '950247830', '994882113'))
    save(SCRATCH / 'apple_candidates.json', {'ids': sorted(reviewed), 'discovered_ids': discovered,
                                           'metadata': metadata, 'curation_excluded_ids': sorted(curation['apple_new_exclusions'])})
    print('apple candidates', len(discovered), 'prioritized for worldwide lookup', len(reviewed), flush=True)

def apple_ratings():
    candidates = read(SCRATCH / 'apple_candidates.json')
    ids = candidates['ids']
    chunks = [ids[i:i + 100] for i in range(0, len(ids), 100)]
    countries = list(dict.fromkeys(markets.ALL))
    def one(job):
        country, index, chunk = job
        url = 'https://itunes.apple.com/lookup?' + urllib.parse.urlencode({'id': ','.join(chunk), 'country': country})
        result = request(url, 'lookup', SCRATCH / f'apple_lookup_{country}_{index}.json')
        if isinstance(result, str):
            result = json.loads(result)
        return country, index, result
    output = {'requested_storefronts': countries, 'ids': ids, 'storefront_batches': {}, 'apps': {}}
    jobs = [(country, index, chunk) for country in countries for index, chunk in enumerate(chunks)]
    with cf.ThreadPoolExecutor(max_workers=3) as pool:
        for done, (country, index, result) in enumerate(pool.map(one, jobs), 1):
            ok = isinstance(result, dict) and 'results' in result
            output['storefront_batches'][f'{country}:{index}'] = 'ok' if ok else result
            if ok:
                for row in result['results']:
                    app_id = str(row.get('trackId'))
                    app = output['apps'].setdefault(app_id, {'by_storefront': {}})
                    app['by_storefront'][country] = row.get('userRatingCount', 0)
                    if country == 'us' or 'name' not in app:
                        app.update({'name': row.get('trackName'), 'developer': row.get('sellerName'),
                                    'bundle_id': row.get('bundleId'), 'release_date': row.get('releaseDate'),
                                    'url': row.get('trackViewUrl'), 'description': row.get('description')})
            if done % 20 == 0:
                save(SCRATCH / 'apple_ratings.json', output)
                print('apple lookup', done, '/', len(jobs), flush=True)
    output['checked_at_utc'] = dt.datetime.now(dt.timezone.utc).isoformat()
    save(SCRATCH / 'apple_ratings.json', output)

def apple_estimates():
    ids = read(SCRATCH / 'apple_candidates.json')['ids']
    def one(app_id):
        url = f'https://app.sensortower.com/overview/{app_id}?page=1&page_size=25'
        result = request(url, 'play', SCRATCH / f'sensortower_{app_id}.json')
        output = {'app_id': app_id, 'url': url, 'provider': 'Sensor Tower',
                  'metric': 'estimated downloads', 'period': 'last month (provider label)',
                  'checked_at_utc': dt.datetime.now(dt.timezone.utc).isoformat()}
        if not isinstance(result, str):
            output['error'] = result
            return app_id, output
        schema = re.search(r'<script type="application/ld\+json">\s*(.*?)\s*</script>', result, re.S)
        if schema:
            try:
                data = json.loads(schema[1])
                output['name'] = data.get('name')
                output['operating_system'] = data.get('operatingSystem')
            except ValueError:
                pass
        match = re.search(r'Last month(?:&#39;|\x27|’|&apos;)s estimates were ([^<".]{1,35}?) downloads', result, re.I)
        if match:
            shown = html.unescape(match[1]).strip()
            output['downloads_shown'] = shown
            numeric = re.fullmatch(r'([\d,.]+)\s*([kmb]?)', shown, re.I)
            if numeric:
                output['downloads_estimate'] = int(float(numeric[1].replace(',', '')) * {'':1,'k':1000,'m':1000000,'b':1000000000}[numeric[2].lower()])
        return app_id, output
    output = {}
    with cf.ThreadPoolExecutor(max_workers=4) as pool:
        jobs = [pool.submit(one, app_id) for app_id in ids]
        for done, future in enumerate(cf.as_completed(jobs), 1):
            app_id, row = future.result()
            output[app_id] = row
            if done % 20 == 0:
                save(SCRATCH / 'apple_estimates.json', output)
                print('apple estimates', done, '/', len(ids), flush=True)
    save(SCRATCH / 'apple_estimates.json', output)

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('phase', choices=['discover', 'play', 'apple_candidates', 'apple', 'estimates'])
    args = parser.parse_args()
    {'discover': discover, 'play': play_details, 'apple_candidates': apple_candidates, 'apple': apple_ratings, 'estimates': apple_estimates}[args.phase]()
