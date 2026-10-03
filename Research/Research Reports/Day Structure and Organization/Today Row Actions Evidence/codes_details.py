# Hand codes for "a tap opens the habit" reviews (details.txt). Codes:
# V a tap on a habit should show its details (history, stats, notes, schedule) · G it opened the edit form instead
# E a tap should let me edit it · N notes should show on that tap · L long press for edit/options
# X a tap did the wrong thing (logged when I meant to open, opened when I meant to log) · O off topic
codes = {}
def add(s):
    for part in s.split(','):
        i, c = part.split(':'); codes[int(i)] = c
add("0:V,1:O,2:O,3:O,4:X,5:X,6:N,7:V,8:VG,9:N,10:N,11:L,12:E,13:G,14:O,15:O,16:V,17:LX,18:O,19:O,20:O,21:V,22:O,23:O,24:O,25:X,26:X,27:O,28:X,29:O,30:VE,31:N,32:V,33:V,34:V,35:V,36:O,37:O,38:V,39:O,40:O,41:O,42:O,43:O,44:VG,45:VG,46:O,47:O,48:O,49:O,50:O,51:V,52:O,53:O,54:V,55:X,56:V,57:O,58:O,59:X,60:O,61:O,62:O,63:O,64:L")
