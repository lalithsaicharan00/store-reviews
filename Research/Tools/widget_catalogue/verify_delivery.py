"""Verify the committed widget handoff without changing source evidence or manifests."""
from pathlib import Path
import hashlib
import json
import re
import struct
import zlib

ROOT = next(parent for parent in Path(__file__).resolve().parents if (parent / "RULEBOOK.md").exists())
BASE = ROOT / "Research/Research Reports/Home Screen and Visual Design/Home Screen Cards and Widgets/Widget Catalogue Study — 5 October 2026"


def check_png(path, metadata):
    blob = path.read_bytes()
    assert blob[:8] == b"\x89PNG\r\n\x1a\n", path
    width, height = struct.unpack(">II", blob[16:24])
    assert (width, height) == (metadata["width"], metadata["height"]), path
    assert len(blob) == metadata["bytes"], path
    assert hashlib.sha256(blob).hexdigest() == metadata["sha256"], path
    offset = 8
    saw_end = False
    while offset < len(blob):
        length = struct.unpack(">I", blob[offset:offset + 4])[0]
        chunk = blob[offset + 4:offset + 8 + length]
        expected_crc = struct.unpack(">I", blob[offset + 8 + length:offset + 12 + length])[0]
        assert zlib.crc32(chunk) & 0xffffffff == expected_crc, path
        offset += length + 12
        if chunk[:4] == b"IEND":
            saw_end = True
            break
    assert saw_end and offset == len(blob), path


def main():
    boards = json.loads((BASE / "Export Manifest.json").read_text(encoding="utf-8"))
    individuals = json.loads((BASE / "Images/Manifest.json").read_text(encoding="utf-8"))["exports"]
    assert len(boards) == 2 and len(individuals) == 26
    named = set()
    for directory, entries in [(BASE, boards), (BASE / "Images", individuals)]:
        for row in entries:
            path = directory / row["file"]
            assert path not in named, path
            named.add(path)
            check_png(path, row)
    assert named == set(BASE.rglob("*.png")), "Unlisted or missing PNG export"

    documents = list(BASE.rglob("*.md")) + [
        ROOT / "Research/Tools/widget_catalogue/README.md",
        ROOT / "iOS/Docs/Checklists/Widgets — Research and Figma Brief — 5 October 2026.md",
        ROOT / "iOS/Docs/iPhone Widgets.md",
    ]
    links = 0
    for document in documents:
        text = document.read_text(encoding="utf-8-sig")
        for match in re.finditer(r"\]\((?:<([^>]+)>|([^\)]+))\)", text):
            target = match[1] or match[2]
            if target.startswith(("https:", "http:", "#", "codex:")):
                continue
            relative = target.split("#")[0]
            if relative:
                assert (document.parent / relative).resolve().exists(), (document, target)
                links += 1

    sources = json.loads((BASE / "Verified Review Sources.json").read_text(encoding="utf-8"))
    known = {row["ref"] for row in sources}
    assert len(sources) == len(known) == 181
    report = (BASE / "iPhone Widgets — Types, Native Setup and Free vs Plus.md").read_text(encoding="utf-8")
    cited = set(re.findall(r"[AP]\d+#\d+", report))
    assert cited <= known, cited - known
    assert len(cited) == 54

    audit = json.loads((BASE / "Figma Audit.json").read_text(encoding="utf-8"))
    # Manifest stores stable IDs, not expiring image URLs. The full Figma
    # structural audit is separate from this immutable export check.
    assert all(re.fullmatch(r"\d+:\d+", row["node_id"]) for row in boards + individuals)
    print(json.dumps({
        "documents_checked": len(documents),
        "local_links_checked": links,
        "broken_local_links": 0,
        "pngs_verified": len(named),
        "cited_review_refs": len(cited),
        "unknown_cited_refs": 0,
        "review_records": len(sources),
        "figma_audit_loaded": isinstance(audit, dict),
    }, indent=2))


if __name__ == "__main__":
    main()
