"""Cards for report 41 — kind-sweep additions (audience, anti-pattern) found on re-read of §3.2.4, §5.4, §5.5."""
import sys; sys.path.insert(0, "Tools/prd_ledger/41")
from _lib import c, table, save

c(181, "§3.2.4 perfectionism and binary thinking — the percentage ring as the reason a perfectionist bought", "audience",
  "Perfectionists and binary thinkers are a distinct audience served by partial credit: 'as someone who suffers from perfectionism and binary thinking it means that accomplishment becomes far more nuanced and relative - you're never thinking about the cliff edge of losing a streak' — the reason they 'bought over the hundreds of habit apps i browsed'",
  "% ring", "purchase-driver", "n=1 (the most analytically useful review)", "build-free", "anecdotal", "yes", ["13969274929"])
c(182, "§5.5 Affordability — 'Im a highschool student… cant you guys add like a student deal somehow?'; §3.3.2 purchasing power", "audience",
  "Students and lower-purchasing-power users want to pay but cannot at current prices: 'Im a highschool student… cant you guys add like a student deal somehow?' (3★); 'the one time purchase fee is a bit too much, at least in my country' (TR, 5★); 'I love the app but I can't afford to pay' (AU, 4★)",
  "no student / regional price", "blocked-conversion", "3 reviews", "research", "anecdotal", "yes", ["8278322299","13528830783","11580359210"])
c(183, "§5.4 / §5.5 — lifetime SKU intermittently invisible and a Home Screen widget sold in screenshots before it shipped", "anti-pattern",
  "Two self-inflicted revenue mistakes with a measured cost: the lifetime SKU the audience buys for became intermittently invisible (3–4 would-be buyers unable to pay, 2023–2024, one with no purchase entry at all), and a Home Screen widget was shown in listing screenshots while still 'coming soon', producing a 2★ from a payer and a 'this is a scam' review",
  "lifetime hidden; screenshots ahead of product", "blocked-conversion", "3–4 blocked; 2 widget-purchase failures", "dont", "segment", "yes",
  ["12128314444","11360590820","10195683230","10901569398","7074903245","13276009260"])
save("a")
