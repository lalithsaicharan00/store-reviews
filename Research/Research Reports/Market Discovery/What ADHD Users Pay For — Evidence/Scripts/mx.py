import re,collections
from tally import *
main=[r for r in rows if not r['sus'] and not r['ch']]
full=[r for r in main if r['i']<5000]
R={'gr':r'\broutines?\b','rem':r'\b(reminders?|notifications?|alerts?)\b','tmr':r'\b(timers?|countdown|pomodoro)\b','vis':r'\b(visual|timeline)\b','est':r'time blind|how long|how much time|sense of time','list':r'\b(to-?do|task list|checklists?|lists?)\b','simple':r'\b(simple|easy to use|intuitive|overwhelm\w*|clean|minimal\w*)\b','rew':r'\b(rewards?|game\w*|coins?|points|gamif\w*|dopamine)\b','pet':r'\b(pet|birb|bird|finch)\b','wid':r'\bwidgets?\b','cal':r'\bcalendars?\b','brk':r'\b(break\w* (it|them|things|tasks?|down)|subtasks?|sub-tasks?|smaller steps)\b','learn':r'\b(lessons?|modules?|learn\w*|course)\b','body':r'body.?doubl\w*','blk':r'\b(block\w*|lock\w*)\b','snd':r'\b(music|sounds?|audio)\b','ai':r'\bAI\b','gentle':r'\b(gentle|kind|guilt\w*|shame\w*|judg\w*|forgiving)\b','track':r'\b(track\w*|stats?|statistics|graphs?)\b','cust':r'\b(custom\w*|personali[sz]\w*)\b','once':r'\b(one.?time|lifetime|lifelong|forever|once)\b','wake':r'\b(alarms?|wake up)\b','nag':r'\b(nag\w*|persistent|keeps? reminding|until i)\b','recur':r'\b(recurring|repeat\w*)\b'}
out=[]
for k,p in R.items():
    rx=re.compile(p,re.I if k!='ai' else 0)
    n=sum(bool(rx.search(r['o']['t'])) for r in main); nf=sum(bool(rx.search(r['o']['t'])) for r in full)
    h=sum(k in r['B']+r['H'] for r in full)
    hit=sum(1 for r in full if k in r['B']+r['H'] and rx.search(r['o']['t']))
    out.append((n,k,nf,h,hit))
print('machine all %d | machine full %d | hand full | hand also matched'%(len(main),len(full)))
for x in sorted(out,reverse=True): print(x[1],x[0],f'{100*x[0]/len(main):.1f}%',x[2],x[3],x[4])
