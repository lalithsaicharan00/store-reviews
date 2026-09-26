"""Cards for report 42 — kind-sweep additions (audience, anti-pattern, contradiction) from re-read of §3.3.2, §6.6, §6.2, Warning 2, §5.2."""
import sys; sys.path.insert(0, "Tools/prd_ledger/42")
from _lib import c, table, save

c(127, "§3.3.2 / §6.6 — price rejection differs by purchasing power: 500₽/yr 'that's nothing' (RU) vs ¥6,900 'expensive' (JP), $39.99 'insane' (US), R$79.90/12 weeks 'muito caro' (BR)", "audience",
  "High-income-market buyers reject the price on substance while a low-local-price market calls it trivial: '500₽ a year, that's nothing' (RU) vs '¥6,900 a year is expensive' (JP, both JP reviews 1★ on price), '$40 a year? … insane!' (US), 'R$79.90 for only 12 weeks' (BR) — the same product priced per storefront produces opposite audiences",
  "per-storefront pricing", "mixed", "RU 1 positive vs JP 2, US 2, BR 1 negative", "research", "limited evidence", "yes", ["10989878670","11948614593","13458230922","6881986270","9479819359"])
c(128, "§5.2 / §6.2 — payers are a Brazil- and Russia-heavy population: BR 10 · US 8 · RU 6 · VN 3; BR payers freezing, RU payers crashing", "audience",
  "Paying customers here are concentrated in Brazil (10 of 29) and Russia (6) — and each market's payers hit a different failure: Brazilian payers freezing on the trophy modal, Russian payers a launch crash and wiped statistics, US payers a capability gap (multi-count)",
  "n/a", "churn", "BR 10 · US 8 · RU 6 · VN 3 · TR 1 · GB 1", "research", "segment", "yes", ["11164675946","11501115720","12160321648","11826835199","7113224515","7669054186"])
c(129, "Warning 2 / §8.5 — a 4.6★ store aggregate from 4.7K ratings coexisting with a 3.136 written-review mean (2.968 burst-adjusted) and a monotonic decline", "contradiction",
  "The store aggregate contradicts the written corpus: 4.6★ from 4.7K ratings vs a 3.136 written-review mean (2.968 without the two bursts) falling every year from 3.96 to 2.69 — the prompted-rating flow and the written-review flow sample different populations; the aggregate must not be read as evidence the product is fine",
  "n/a", "mixed", "4.6 (4.7K) vs 3.136 (206)", "none", "corpus-level fact", "yes", [])
c(130, "§2.2 / §3.3.5 / §5.5 — the whole monetisation design as an anti-pattern: 3-habit cap + paid reminders/time/date + no visible trial + immediate paywall + ~30-screen onboarding quiz + rating prompt before use + auto-selected package charges + promo price not honoured + retroactive paywalling", "anti-pattern",
  "A stacked monetisation design with a measured cost: a 3-habit cap with reminders, time, date and repetition paid; no visible trial and a paywall 'two seconds after downloading'; a ~15–30-screen unskippable onboarding quiz with a rating prompt inside it; packages auto-selected and charged, a promotional price not honoured at checkout, a trial that converts with refunds refused; and free features later paywalled on an installed base — together 87 reviews (42.23%, mean 1.85) and 73.5% of all 1–2★, with 37.9% of writing payers asking for refunds and a written-review mean that fell from 3.96 to 2.69",
  "stacked friction", "1★-burst", "87 (42.23%), 1.85; 73.5% of 1–2★; refunds 11/29", "dont", "high-priority", "yes",
  ["8868385470","11484449412","9489050651","7348111127","13143403370","12815733039","13555244418","12021785730"])
save("a")
