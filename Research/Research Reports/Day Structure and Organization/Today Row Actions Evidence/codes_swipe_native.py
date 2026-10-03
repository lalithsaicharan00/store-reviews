# Hand codes for the native list apps' swipe reviews (swipe_native_lists.txt). Codes:
# G expects the iPhone's own gestures (swipe back, Mail-style swipes) · D swipe to delete · A swipe to archive
# C swipe to complete · X accidental swipe action · N other row action by swipe (My Day, move, flag, menu)
# R wants to choose what each direction does / direction confusion · U undo after a swipe · S buggy · O off topic
codes = {}
def add(s):
    for part in s.split(','):
        i, c = part.split(':'); codes[int(i)] = c
add("0:GD,1:O,2:G,3:D,4:S,5:O,6:G,7:G,8:G,9:O,10:O,11:O,12:O,13:G,14:D,15:O,16:DAR,17:G,18:O,19:O,20:G,21:G,22:G,23:G,24:G,25:G,26:O,27:G,28:G,29:S,30:G,31:AR,32:G,33:G,34:G,35:G,36:G,37:G,38:G,39:G,40:G,41:G,42:G,43:D,44:G,45:G,46:G,47:AG,48:G,49:G,50:G,51:G,52:G,53:G,54:G,55:G,56:G,57:DA,58:N,59:A,60:O,61:G,62:G,63:D,64:S,65:G,66:G,67:O,68:O,69:DG,70:D,71:G,72:O,73:A,74:DG,75:N,76:D,77:G,78:G,79:G,80:D,81:G,82:G,83:S,84:XS,85:G,86:S,87:SX,88:G,89:G,90:G,91:O,92:G,93:XA,94:G,95:O,96:G,97:O,98:O,99:O,100:O,101:O,102:O,103:O,104:O,105:O,106:XC,107:X,108:O,109:O,110:O,111:O,112:O,113:O,114:O,115:O,116:O,117:N,118:O,119:O,120:O,121:O,122:O,123:N,124:O,125:CG,126:O,127:O,128:O,129:O")
# T accidental tap on a checkbox while scrolling (the reason some ask for swipe-to-complete)
def fill(a, b):
    for i in range(a, b + 1): codes.setdefault(i, 'O')
add("130:G,131:G,133:D,137:T,138:S,159:T,160:T,182:U,200:D,229:TC,235:XG,236:CTR,237:CTU,239:TD,240:T,241:XG,242:TU,243:N,244:XG,245:N,246:N,247:XG,250:S,252:D,253:TC,254:CN,255:D,256:TUC,257:C,258:XT,259:X")
fill(130, 259)
add("260:XD,261:D,263:XC,264:D,265:XTD,266:D,267:TC,268:X,269:XG,271:D,273:DU,274:R,276:D,279:N,282:N,283:N,285:N,292:N,307:T,310:T,313:XD,318:XD,324:N,325:XDU,328:N,331:N,332:N,333:N,334:X,335:XU,337:DS,338:N,339:D,340:N,341:DS,343:XDU,345:D,346:N,347:T,348:N,350:N,351:N,352:N,353:N,361:N,366:D,367:D,372:N,383:CN,384:G,385:D,390:ND")
fill(260, 390)
