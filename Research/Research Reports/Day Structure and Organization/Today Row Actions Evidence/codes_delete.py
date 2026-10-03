# Hand codes for delete reviews (delete.txt). Codes:
# H deleted a habit/goal/entry by mistake and couldn't get it back (wants undo, restore, archive)
# E deleting is too easy / wants a confirmation · F can't find how to delete (habit, task or entry) or no delete at all
# P where delete lives (a weird place, only inside edit, wants swipe) · A wants archive/hide instead of delete
# O off topic (deleted the app, subscriptions, accounts)
codes = {}
def add(s):
    for part in s.split(','):
        i, c = part.split(':'); codes[int(i)] = c
def fill(a, b):
    for i in range(a, b + 1): codes.setdefault(i, 'O')
add("0:F,1:F,48:H,50:P,51:H,52:F,55:F,59:P,61:H,62:H,63:H,64:EH,66:HA,70:H,76:F,78:F,79:F,80:F,81:F,82:F,85:F,90:F,91:F,92:F,93:F,95:F,96:F,97:F,98:F,99:F,101:H,102:E,103:E,104:P,105:F,107:H,108:H,112:E,113:F,114:F,117:F,118:F,119:E,120:P,121:H")
fill(0, 124)
# U = undo or restore after a delete (wanted or praised) · C = asks for a confirmation
add("126:E,128:PE,129:P,130:F,134:U,135:H,136:E,137:E,138:H,141:E,143:EH,144:E,145:EHC,146:E,147:E,149:E,153:E,155:E,157:E,158:HU,159:E,161:H,162:P,163:E,164:E,165:E,166:EC,167:U,168:H,169:EF,170:C,171:F,172:H,174:E,175:E,177:HU,179:E,180:HU,181:E,182:C,184:H,188:F,191:HA,193:F,194:F,196:F,197:F,198:H,201:F,202:CE,204:F,205:P,206:F,207:F,208:P,209:F,210:F,211:F,212:F,214:C,216:HA,218:P,221:P,222:H,223:H,225:H,226:F,227:E,232:FP,233:E,234:HU,235:H,236:F,241:F,243:P")
fill(125, 244)
add("248:F,249:F,250:H,251:F,252:F,253:F,254:F,257:P,258:F,259:F,260:F,262:F,265:F,266:E,267:CE,268:E,269:HU,270:HA,271:E,272:HA,273:HU,274:PE,275:E,276:E,277:F,278:F,279:A,280:E,281:E,282:E,283:P,284:E,285:F,286:E,287:E,288:EC,289:E,290:EC,291:EH,292:PE,293:F,294:E,295:HU,297:HU,298:H,299:F,300:PE,301:E,302:E,303:H,304:E,305:E,306:ECHA,307:HA,308:H,309:E,310:E,311:EH,312:HU,313:H,314:E,315:HA,316:F,317:HA,318:E,319:EH,320:E,321:ECH,322:U,323:E,324:E,327:P,328:E,329:H,330:EH,331:H,332:HA,333:H,334:F,335:HA,336:C,337:H,338:EC,340:E,342:E,343:H,344:E,345:E,346:CH,347:HA,348:H,349:E,350:PE,351:H,352:HA,353:CHA,354:HU,356:H,357:E,358:H,359:E,360:P,361:ECA")
fill(245, 361)
