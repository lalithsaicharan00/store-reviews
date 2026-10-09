"""Current Work 75: what each way of backing up a FREE ACCOUNT costs on Cloudflare, per 1,000 such users a month.
Prices: Cloudflare docs, read 9 Oct 2026 (unchanged since the 1 Oct model). Conservative: no included allowance
is counted (Plus and everything else use it first). Sizes are measured in the dev bucket on 9 Oct 2026."""
R2_WRITE, R2_GB = 4.50e-6, 0.015          # per write, per GB-month
WK_REQ = 0.30e-6                           # Worker request beyond 10M
DO_REQ, DO_ROW, DO_GBS, DO_GB = 0.15e-6, 1.00e-6, 12.50e-6, 0.20
# Measured: a checked backup .zip with 888 records = 348,842 B (393 B/record); a Plus nightly json.gz with
# 1,451 records = 128,747 B (89 B/record).
ZIP_B_PER_RECORD, GZ_B_PER_RECORD = 348842 / 888, 128747 / 1451
# A free user: 5 habits, about 4 logs a day on 20 active days a month; a year in, about 1,500 records.
RECORDS = 1500
ACTIVE_DAYS, SESSIONS_WITH_CHANGES, OUTSIDE_APP = 20, 3, 1   # per active day; widget/notification changes
OPS_PER_MONTH = ACTIVE_DAYS * 5
SLOTS = 8                                  # 7 weekday copies + before-shrink

def per_user(kind, b_per_record=ZIP_B_PER_RECORD):
    size = RECORDS * b_per_record
    stored = SLOTS * size / 1e9
    if kind == "today: once a day":
        uploads = ACTIVE_DAYS
    elif kind == "as you go: on leaving the app":
        uploads = ACTIVE_DAYS * (SESSIONS_WITH_CHANGES + OUTSIDE_APP)
    if kind.startswith(("today", "as you go")):
        cost = uploads * (R2_WRITE + WK_REQ) + stored * R2_GB
        return cost, uploads, uploads * size / 1e6
    # free account through the sync engine (push only, one device)
    requests = ACTIVE_DAYS * (SESSIONS_WITH_CHANGES + OUTSIDE_APP)
    rows = OPS_PER_MONTH * 4
    gbs = requests * 0.05 * 0.128
    do_store = RECORDS * 300 / 1e9
    nightly = ACTIVE_DAYS                       # nightly R2 snapshot on changed days, kept 90 days
    nightly_store = 90 * RECORDS * GZ_B_PER_RECORD / 1e9
    cost = requests * (WK_REQ + DO_REQ) + rows * DO_ROW + gbs * DO_GBS + do_store * DO_GB + nightly * R2_WRITE + nightly_store * R2_GB
    return cost, requests, requests * 2e-3

rows = []
for kind in ["today: once a day", "as you go: on leaving the app", "sync engine, push only"]:
    c, n, mb = per_user(kind)
    rows.append((kind, n, mb, c * 1000, c * 12))
c_gz, n_gz, mb_gz = per_user("as you go: on leaving the app", GZ_B_PER_RECORD)
print(f"{'how':34}{'uploads/mo':>11}{'phone MB/mo':>12}{'$ per 1,000/mo':>16}{'$ per user/yr':>15}")
for k, n, mb, c1000, yr in rows:
    print(f"{k:34}{n:11}{mb:12.1f}{c1000:16.3f}{yr:15.5f}")
print(f"{'as you go, file 4.4x smaller (gz)':34}{n_gz:11}{mb_gz:12.1f}{c_gz*1000:16.3f}{c_gz*12:15.5f}")
net_plus = 14.99 * 0.85
for k, n, mb, c1000, yr in rows:
    extra = yr - rows[0][4]
    if extra > 0:
        print(f"{k}: one extra Plus sale (${net_plus:.2f} after Apple's 15%) pays for {net_plus/extra:,.0f} free-account user-years")
for users in [1000, 10000, 100000, 1000000]:
    print(f"{users:>9,} free accounts: today ${rows[0][3]*users/1000:,.2f}/mo · as you go ${rows[1][3]*users/1000:,.2f}/mo · sync engine ${rows[2][3]*users/1000:,.2f}/mo")
