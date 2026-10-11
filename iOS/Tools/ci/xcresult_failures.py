#!/usr/bin/env python3
"""Prints each failed test and its failure messages, one line each, from `xcresulttool get test-results tests` JSON
(stdin). With two simulators at once, xcodebuild keeps the messages only in the result bundle (T14)."""
import json, sys

data = json.load(sys.stdin)

def walk(node, test=None, device=None):
    kind = node.get("nodeType", "")
    name = node.get("name", "")
    if kind == "Device":
        device = name
    if kind == "Test Case":
        test = name
    if kind == "Failure Message":
        print(f"{test} [{device or ''}]: {name}".replace("\n", " ")[:400])
    for child in node.get("children", []) or []:
        walk(child, test, device)

for node in data.get("testNodes", []):
    walk(node)
