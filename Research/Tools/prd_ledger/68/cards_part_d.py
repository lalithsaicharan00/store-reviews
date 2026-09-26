# -*- coding: utf-8 -*-
import sys; sys.path.insert(0, "Tools/prd_ledger/68")
from _lib import c, table, save

c(53, "§8.1; §8.2; §8.5 immediate fixes", "do", "Immediate fixes the corpus supports, as things to do: point 'Manage subscription' at wherever the subscription is actually billed (web, Apple Pay, PayPal, card) and add in-app cancellation for web subscriptions; show the renewal price and date on the intro-plan screen and in a receipt email; declare and localise Ukrainian and Kazakh if those storefronts are targeted — ua and kz are the second- and third-largest storefronts and neither language is declared", "none of these shipped", "1★-burst", "MANAGE_SUB 60; RENEWAL_SHOCK 227; RECEIPT 17; Ukrainian 261 + Kazakh 47 reviews", "do", "high-priority", "generalisable", ["12588412857","14361404522","12284974864"])
save("a")
