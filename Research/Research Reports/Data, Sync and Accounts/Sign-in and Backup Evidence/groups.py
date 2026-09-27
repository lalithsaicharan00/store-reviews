"""Roll the codes up into the groups the report uses (a review counts once per group)."""
import json, os
HERE = os.path.dirname(os.path.abspath(__file__))
rows = json.load(open(f'{HERE}/coded.json'))
G = {
 'Repeated prompts of any kind (upsell, sign-in, backup, iCloud, referral)': ['UP_NAG', 'SN_NAG', 'BK_NAG', 'IC_NAG', 'NAG_OTHER', 'SN_NO_SKIP'],
 '  of which: sign-in, iCloud or backup prompts': ['SN_NAG', 'BK_NAG', 'IC_NAG', 'SN_NO_SKIP'],
 'Praise for not nagging / no account needed': ['NONAG_PRAISE', 'NOUP_PRAISE', 'NOACC_PRAISE', 'LOCAL_PRAISE', 'IC_OPTIONAL_PRAISE'],
 'Accounts that broke: stuck at sign-up, can\'t log in, logged out, friction': ['SN_STUCK', 'SN_LOGIN_FAIL', 'SN_LOGOUT', 'SN_FRICTION', 'SN_FORCED'],
 'Lost data with no off-phone copy (reinstall, new/lost/broken phone, iCloud off or full)': ['LOSS_NO_BACKUP', 'LOSS_REINSTALL', 'LOSS_MOVE', 'IC_OFF_LOSS', 'IC_FULL_LOSS', 'LOSS_NO_ACCOUNT'],
 'Ask for automatic backup to their own cloud (Drive, iCloud, any)': ['GD_WANT', 'IC_WANT', 'BK_WANT'],
 'Manual backup forgotten or a burden': ['BK_MANUAL'],
 'Backup or restore behind a paywall': ['BK_PAID'],
 'iCloud backup/restore failed (error, empty, stale, crash, overwrote)': ['IC_BK_FAIL', 'IC_BK_STALE', 'IC_SILENT_FAIL', 'IC_CRASH', 'IC_BK_OVERWRITE'],
 'Google Drive backup/restore failed': ['GD_BK_FAIL'],
 'Google Drive backup works (praise)': ['GD_BK_OK'],
 'iCloud backup works (praise)': ['IC_BK_OK'],
 'iCloud sync failed (none, partial, slow, duplicates, reverts, wipes)': ['IC_SYNC_FAIL', 'IC_SYNC_SLOW', 'IC_SYNC_CORRUPT', 'IC_SYNC_DUP', 'IC_SYNC_FLICKER', 'IC_SYNC_REVERT', 'IC_SYNC_WIPE', 'SYNC_PARTIAL'],
 'iCloud sync works (praise)': ['IC_SYNC_OK'],
 'Backup file used as sync: manual, stale, lost edits': ['XDEV_MANUAL', 'LOSS_XDEV', 'RESTORE_REPLACE'],
 'iCloud not usable for them (full, off, refused, corporate, confusing setup)': ['IC_FULL', 'IC_FULL_LOSS', 'IC_OFF_LOSS', 'IC_NOT_USED', 'IC_REFUSE', 'IC_SETUP_CONFUSE'],
 'Uninstalled or leaving because of it (LEFT)': ['LEFT'],
}
out = [f"{'group':92}{'n':>4}{'apps':>5}{'mean':>6}{'1★%':>6}{'payers':>7}"]
for g, codes in G.items():
    v = [r for r in rows if set(r['codes']) & set(codes)]
    if not v: continue
    out.append(f"{g:92}{len(v):4}{len({r['app'] for r in v}):5}{sum(r['rating'] for r in v)/len(v):6.2f}"
               f"{100*sum(r['rating']==1 for r in v)/len(v):6.0f}{sum('X_PAYER' in r['codes'] for r in v):7}")
nag = [r for r in rows if set(r['codes']) & set(G['Repeated prompts of any kind (upsell, sign-in, backup, iCloud, referral)'])]
out.append(f"\nrepeated-prompt reviews that say they left or will leave: {sum('LEFT' in r['codes'] for r in nag)} of {len(nag)}")
relevant = [r for r in rows if r['codes'] != ['NR']]
out.append(f"read {len(rows)}, relevant {len(relevant)}, apps {len({r['app'] for r in relevant})}, stores A {sum(r['store']=='A' for r in relevant)} P {sum(r['store']=='P' for r in relevant)}")
open(f'{HERE}/groups.txt', 'w').write('\n'.join(out) + '\n'); print('\n'.join(out))
