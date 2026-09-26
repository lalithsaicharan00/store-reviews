import sys; sys.path.insert(0, "Tools/prd_ledger/49")
from _lib import c, table, save
for seq, hd, name in [(95,"## 7.2 United States","United States"),(96,"## 7.3 Canada","Canada"),(97,"## 7.4 Germany","Germany"),(98,"## 7.5 United Kingdom","United Kingdom"),(99,"## 7.6 Australia","Australia")]:
    c(seq, hd.replace("## ","§").split(" ")[0] + " " + name + " top-theme table (verbatim)", "market", name + " top themes vs global (code | theme | n | storefront % | global % | deviation | signal): " + table(hd), "n/a", "n/a", name, "none", "corpus-level fact", "app-specific", [])
save("a")
