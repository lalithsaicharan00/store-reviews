"""Monthly Cloudflare cost for free (safety copy) and Plus (sync) users. Prices: Cloudflare docs, 1 Oct 2026."""
P = dict(base=5.0, wreq_incl=10e6, wreq=0.30/1e6, cpu_incl=30e6, cpu=0.02/1e6,
         doreq_incl=1e6, doreq=0.15/1e6, gbs_incl=400e3, gbs=12.5/1e6,
         rr_incl=25e9, rr=0.001/1e6, rw_incl=50e6, rw=1.0/1e6, dost_incl=5, dost=0.20,
         r2st_incl=10, r2st=0.015, r2a_incl=1e6, r2a=4.50/1e6, r2b_incl=10e6, r2b=0.36/1e6)
GBS_PER_CALL = 0.05 * 0.128   # 50 ms wall time x 128 MB (conservative; HTTP-only objects hibernate when idle)

def free_user(days_changed=20, copy_kb=100, copies=7):
    # one upload on each day with changes: 1 Worker request + 1 R2 write. Nothing else.
    return dict(wreq=days_changed, cpu=days_changed*3, r2a=days_changed, r2st=copy_kb*copies/1e6)

def plus_user(devices=1.5, days=25, syncs_per_device_day=10, ops_month=300, records=3000, nightly=True, last_seen_write=True):
    syncs = devices*days*syncs_per_device_day
    refresh = devices*days                      # about one token refresh a device a day
    rows_w = ops_month*4 + (syncs if last_seen_write else 0)   # record upsert + op_log insert, with their indexes
    rows_r = syncs*6 + ops_month*3
    u = dict(wreq=syncs+refresh, cpu=(syncs+refresh)*3, doreq=syncs+refresh, gbs=(syncs+refresh)*GBS_PER_CALL,
             rw=rows_w, rr=rows_r, dost=records*400/1e9)   # ~400 bytes per record incl. op_log
    if nightly:   # 06 §9: one R2 snapshot per changed account per night
        u['r2a'] = days; u['rr'] += days*records; u['r2st'] = 0.2*90/1000  # 200 KB x 90 nightlies, GB
        u['doreq'] += days
    return u

def bill(n_free, n_plus, f=free_user(), p=plus_user()):
    tot = {}
    for k in set(f) | set(p):
        tot[k] = n_free*f.get(k, 0) + n_plus*p.get(k, 0)
    c = P['base']
    c += max(0, tot.get('wreq',0)-P['wreq_incl'])*P['wreq'] + max(0, tot.get('cpu',0)-P['cpu_incl'])*P['cpu']
    c += max(0, tot.get('doreq',0)-P['doreq_incl'])*P['doreq'] + max(0, tot.get('gbs',0)-P['gbs_incl'])*P['gbs']
    c += max(0, tot.get('rw',0)-P['rw_incl'])*P['rw'] + max(0, tot.get('rr',0)-P['rr_incl'])*P['rr']
    c += max(0, tot.get('dost',0)-P['dost_incl'])*P['dost']
    c += max(0, tot.get('r2st',0)-P['r2st_incl'])*P['r2st'] + max(0, tot.get('r2a',0)-P['r2a_incl'])*P['r2a']
    return c, tot

if __name__ == '__main__':
    print('per free user / month:', free_user()); print('per Plus user / month:', {k: round(v, 3) for k, v in plus_user().items()})
    # marginal cost per user (well past free allowances)
    big = 10_000_000
    cf, _ = bill(big, 0); cp, _ = bill(0, big)
    print(f"marginal: free ${ (cf-5)/big*1000:.3f} per 1,000 users/month; Plus ${(cp-5)/big*1000:.2f} per 1,000 users/month")
    print(f"\n{'free users':>11} {'Plus users':>11} {'$/month':>9}  biggest lines")
    for nf, np_ in [(10_000,500),(50_000,2_500),(100_000,5_000),(250_000,12_500),(500_000,25_000),(1_000_000,50_000),(1_000_000,100_000)]:
        c, t = bill(nf, np_)
        print(f"{nf:>11,} {np_:>11,} {c:>9.2f}  Worker req {t['wreq']/1e6:.1f}M, DO req {t['doreq']/1e6:.1f}M, rows written {t['rw']/1e6:.1f}M, R2 writes {t['r2a']/1e6:.1f}M, R2 {t['r2st']:.0f} GB")
    # Workers FREE plan daily capacity
    print('\nWorkers Free plan (per day): 100k Worker req, 100k DO req, 100k rows written, 13k GB-s')
    f, p = free_user(), plus_user()
    print(f"  free users alone fit:  {100_000/(f['wreq']/30):,.0f} (Worker requests)")
    print(f"  Plus users alone fit: {min(100_000/(p['wreq']/30), 100_000/(p['doreq']/30), 100_000/(p['rw']/30)):,.0f} (rows written / DO requests)")
    # sensitivity: what the current 60 s poll + last_seen write costs
    for label, pu in [('as built (10 syncs/device/day, last_seen write)', plus_user()),
                      ('heavy: app open a lot, 60 s poll -> 60 syncs/device/day', plus_user(syncs_per_device_day=60)),
                      ('lean: no last_seen write on empty polls', plus_user(last_seen_write=False))]:
        c, t = bill(0, 50_000, p=pu)
        print(f"  50k Plus, {label}: ${c:.2f}/month, rows written {t['rw']/1e6:.1f}M, DO req {t['doreq']/1e6:.1f}M")
