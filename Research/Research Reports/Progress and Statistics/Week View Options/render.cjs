const {chromium}=require('playwright');const path=require('path');const fs=require('fs');
(async()=>{const dir=__dirname,browser=await chromium.launch({headless:true,executablePath:"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"});const checks=[];
for(let option=1;option<=5;option++)for(const mode of ['light','dark','large-text']){
 const p=await browser.newPage({viewport:{width:393,height:852},deviceScaleFactor:3});await p.goto('file://'+path.join(dir,'mockups.html')+`?option=${option}&mode=${mode}`);await p.evaluate(()=>document.fonts.ready);
 for(const part of ['top','habits','quit']){await p.evaluate(x=>window.scrollToPart(x),part);await p.screenshot({path:path.join(dir,`option-${option}-${mode}${part==='top'?'':'-'+part}.png`)});}
 const issues=await p.evaluate(()=>Array.from(document.querySelectorAll('.habit,.overview,.key,.state-list')).filter(x=>x.scrollWidth>x.clientWidth+1).map(x=>x.id||x.className));checks.push({option,mode,horizontalOverflow:issues,habitCount:await p.locator('.habit').count(),fullHeight:await p.locator('#content').evaluate(x=>x.scrollHeight)});
 await p.evaluate(()=>{document.getElementById('scroller').scrollTop=0;document.querySelector('.phone').style.height='auto';document.querySelector('.scroll').style.height='auto';document.querySelector('.scroll').style.overflow='visible';document.querySelector('.home').remove();});await p.screenshot({path:path.join(dir,`option-${option}-${mode}-full.png`),fullPage:true});
 if(mode==='light'){
  await p.evaluate(()=>{let x=document.getElementById('habit-4').outerHTML;document.body.innerHTML='<div class="closeup opt'+OPT+'">'+x+'</div>';});await p.locator('.closeup').screenshot({path:path.join(dir,`option-${option}-habit-closeup.png`)});
 }
 await p.close();
}
for(let option=1;option<=5;option++){
 const p=await browser.newPage({viewport:{width:393,height:1200},deviceScaleFactor:3});await p.goto('file://'+path.join(dir,'mockups.html')+`?option=${option}`);await p.evaluate(()=>document.body.innerHTML='<div class="closeup">'+window.legend()+'</div>');await p.locator('.closeup').screenshot({path:path.join(dir,`option-${option}-marks-closeup.png`)});await p.close();
}
fs.writeFileSync(path.join(dir,'render-checks.json'),JSON.stringify(checks,null,2));await browser.close();console.log(JSON.stringify(checks));})();
