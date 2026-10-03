# Hand codes for tap-again reviews (tapagain.txt). Codes:
# A tap again should take a tick back (toggle), or praise for it · B no way to un-check a mistaken tick
# C a second tap did something unexpected (added again, completed the week, undid) · D double tap to complete (for or against)
# E a tap on the row should open details or edit (or opened the wrong thing) · U take back one check-in of several
# K counters: tapping a count/amount at or past its goal (what people expect) · O off topic
codes = {}
def add(s):
    for part in s.split(','):
        i, c = part.split(':'); codes[int(i)] = c
def fill(a, b):
    for i in range(a, b + 1): codes.setdefault(i, 'O')
add("2:D,7:D,23:C,24:A,25:E,27:B,37:C,38:B,39:B,41:B,42:B,44:B,46:B,48:B,49:B,50:B,51:B,52:B,53:U,55:D,56:D,58:D,59:C,67:D,73:B,74:A,76:BE,81:B,82:B,84:A,85:A,91:C,92:D,93:D,99:E")
fill(0, 109)
# Z = Today's order: a done row moving away (evidence for R1)
add("115:A,121:K,122:K,124:K,129:C,130:K,132:K,133:D,134:D,137:Z,138:Z,141:A,142:A,159:D,161:E,165:C,166:C,167:B,168:BC,170:C,171:C,172:A,174:C,175:C,177:E,178:E,181:B,190:B,197:B,199:B,200:B,201:B,203:B,205:C")
fill(110, 214)
add("222:B,223:Z,224:B,228:D,229:B,234:B,243:C,244:B,250:B,254:A,256:B,257:C")
fill(215, 309)
add("392:D,393:A,397:B")
fill(310, 401)
