# Research

What the literature says about reading faster and learning from what you read, and what it means for this app.
Read the pages in this order; each builds on the one before.

| Page | What it answers | Waiting on you |
|---|---|---|
| `reading-methods.html` | Methods for faster screen reading (RSVP, phrases, listening and others), ranked by speed at equal comprehension, with live demos. | D1: default speed 300 wpm. D2: a phrase toggle. |
| `beyond-reading.html` | How to learn from a selected passage (recall, explain-back, predicting, concept maps and others), whether richer media beat text, a test of Apple's on-device model, and a sketch of a learning key. | First: a learning key at all. Second: which feature first. |
| `adaptive-text.html` | How a text written for everyone could shrink to what one reader doesn't know, at the right challenge, with the ideas that matter, and a demo of testing out of chunks. | Whether compression joins the learning key, and when; only if Beyond reading's first answer is yes. |

`adaptive-text.md` is the full review behind the third page: every study, its verification tag and its link.

## Where this stands (Nov 7)

- Nothing on these pages is built; the app is still the reader alone.
- The decisions above are open; each page's decision section has a recommended default.

## Rebuilding

The HTML pages are built from the `*.src.html` sources, `page.css`, `demos.js` and the project skin at `.lavish-shared/lavish-skin.css`.
Rebuild them with `python3 docs/research/build.py`.
