# Builds the self-contained pages: inlines the project skin, the shared page CSS and the demo script into each source.
from pathlib import Path
here = Path(__file__).parent
parts = {"/*SKIN*/": (here.parent.parent / ".lavish-shared/lavish-skin.css").read_text(), "/*PAGECSS*/": (here / "page.css").read_text(), "/*DEMOS*/": (here / "demos.js").read_text()}
for src in here.glob("*.src.html"):
    s = src.read_text()
    for k, v in parts.items():
        s = s.replace(k, v)
    (here / src.name.replace(".src", "")).write_text(s)
