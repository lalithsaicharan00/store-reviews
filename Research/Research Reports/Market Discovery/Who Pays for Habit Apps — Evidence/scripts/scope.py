# Apps in the corpus that are not habit/routine trackers, so their buyers are not habit-app buyers.
EXCLUDE_PLAY={'100.','126.','84.','85.','97.','95.','111.','122.','127.','96.','121.','131.'}
def in_scope(r):
    if r['s']=='play' and r['app'].split(' ')[0] in EXCLUDE_PLAY: return False
    return True
