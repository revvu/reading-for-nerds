// Small live demos of each reading method, all on one shared passage.
// Each demo is a function (el) => {play, stop}; controls are wired by data attributes.
const PASSAGE = "When we read, our eyes do not glide smoothly across the line. They jump from word to word in quick hops, pausing for about a quarter of a second on each stop. Most of the work happens during those pauses, and sometimes the eyes jump back to check a word they passed too quickly.";
const WORDS = PASSAGE.split(/\s+/);
const reduced = matchMedia("(prefers-reduced-motion: reduce)").matches;

// Phrase chunks, split by hand at syntactic boundaries.
const CHUNKS = [
  "When we read,", "our eyes", "do not glide smoothly", "across the line.",
  "They jump", "from word to word", "in quick hops,", "pausing", "for about a quarter of a second", "on each stop.",
  "Most of the work", "happens during those pauses,", "and sometimes", "the eyes jump back", "to check a word", "they passed too quickly."
];
// Cascade: [indent level, phrase], indent follows the sentence's grammar.
const CASCADE = [
  [0, "When we read,"], [1, "our eyes do not glide smoothly"], [2, "across the line."],
  [0, "They jump"], [1, "from word to word"], [1, "in quick hops,"], [2, "pausing for about a quarter of a second"], [3, "on each stop."],
  [0, "Most of the work happens"], [1, "during those pauses,"], [0, "and sometimes the eyes jump back"], [1, "to check a word"], [2, "they passed too quickly."]
];

function pivotIndex(w) {
  const core = w.replace(/^[^\p{L}\p{N}]+|[^\p{L}\p{N}]+$/gu, "");
  const lead = w.length - w.replace(/^[^\p{L}\p{N}]+/u, "").length;
  const n = core.length;
  return lead + (n <= 1 ? 0 : n <= 5 ? 1 : n <= 9 ? 2 : n <= 13 ? 3 : 4);
}
function esc(s) { return s.replace(/[&<>]/g, c => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;" })[c]); }

// Runs step(i) for i = 0, 1, 2…; step returns a delay in ms, or false when done.
function ticker(el, step, ms) {
  let t = null, i = 0;
  return {
    play() { this.stop(); i = 0; const tick = () => { const next = step(i++); if (next === false) return el.dispatchEvent(new Event("demoend")); t = setTimeout(tick, typeof next === "number" ? next : ms()); }; tick(); },
    stop() { clearTimeout(t); t = null; },
  };
}

const DEMOS = {
  // One word at a time, pivot letter fixed under the notch.
  rsvp(el) {
    const stage = el.querySelector(".stage");
    const wpm = () => +el.querySelector("[data-wpm]")?.value || 350;
    return ticker(el, i => {
      if (i >= WORDS.length) return false;
      const w = WORDS[i], p = pivotIndex(w);
      stage.innerHTML = `<span class="rsvp-word"><span class="pre">${esc(w.slice(0, p))}</span><b>${esc(w[p] || "")}</b><span>${esc(w.slice(p + 1))}</span></span>`;
      // Centre the red letter on the notch.
      const word = stage.firstChild;
      word.style.marginLeft = `${-word.querySelector("b").offsetWidth / 2}px`;
      const m = /[.!?]$/.test(w) ? 2 : /[,;:]$/.test(w) ? 1.5 : 1;
      return 60000 / wpm() * m;
    }, () => 0);
  },
  // Same pacing idea, but a phrase at a time.
  chunks(el) {
    const stage = el.querySelector(".stage");
    const wpm = () => +el.querySelector("[data-wpm]")?.value || 350;
    return ticker(el, i => {
      if (i >= CHUNKS.length) return false;
      stage.innerHTML = `<span class="chunk">${esc(CHUNKS[i])}</span>`;
      return 60000 / wpm() * CHUNKS[i].split(" ").length + 120;
    }, () => 0);
  },
  // Text scrolls right to left through a fixed window, like a news ticker.
  leading(el) {
    const strip = el.querySelector(".strip");
    strip.textContent = PASSAGE;
    let raf = null;
    return {
      play() {
        this.stop();
        const wpm = +el.querySelector("[data-wpm]")?.value || 350;
        const pxPerWord = strip.scrollWidth / WORDS.length;
        const start = performance.now();
        const frame = now => {
          const x = el.clientWidth - (now - start) / 60000 * wpm * pxPerWord;
          strip.style.transform = `translateX(${x}px)`;
          if (x > -strip.scrollWidth) raf = requestAnimationFrame(frame); else el.dispatchEvent(new Event("demoend"));
        };
        raf = requestAnimationFrame(frame);
      },
      stop() { cancelAnimationFrame(raf); },
    };
  },
  // A highlight sweeps along each line at a set pace, the eye follows it.
  pacer(el) {
    const box = el.querySelector(".para");
    box.innerHTML = WORDS.map(w => `<span>${esc(w)}</span>`).join(" ");
    const spans = [...box.children];
    const wpm = () => +el.querySelector("[data-wpm]")?.value || 350;
    return ticker(el, i => {
      spans.forEach((s, j) => s.classList.toggle("lit", j === i));
      if (i >= spans.length) return false;
    }, () => 60000 / wpm());
  },
  // Each word is highlighted as the browser's voice says it.
  listen(el) {
    const box = el.querySelector(".para");
    box.innerHTML = WORDS.map(w => `<span>${esc(w)}</span>`).join(" ");
    const spans = [...box.children];
    const starts = []; let o = 0; for (const w of WORDS) { starts.push(o); o += w.length + 1; }
    return {
      play() {
        this.stop();
        if (!("speechSynthesis" in window)) { box.insertAdjacentHTML("beforebegin", "<p class='note'>This browser has no speech voice.</p>"); return; }
        const u = new SpeechSynthesisUtterance(PASSAGE);
        u.rate = +el.querySelector("[data-rate]")?.value || 1;
        u.onboundary = e => {
          if (e.name && e.name !== "word") return;
          let k = 0; while (k + 1 < starts.length && starts[k + 1] <= e.charIndex) k++;
          spans.forEach((s, j) => s.classList.toggle("lit", j === k));
        };
        u.onend = () => { spans.forEach(s => s.classList.remove("lit")); el.dispatchEvent(new Event("demoend")); };
        speechSynthesis.speak(u);
      },
      stop() { if ("speechSynthesis" in window) speechSynthesis.cancel(); spans.forEach(s => s.classList.remove("lit")); },
    };
  },
};

// Static layouts, switched with a toggle between plain and treated text.
const LAYOUTS = {
  cascade: () => CASCADE.map(([d, t]) => `<div style="padding-left:${d * 1.4}em">${esc(t)}</div>`).join(""),
  bionic: () => WORDS.map(w => { const n = Math.ceil(w.replace(/[^\p{L}]/gu, "").length / 2); return `<b>${esc(w.slice(0, n))}</b>${esc(w.slice(n))}`; }).join(" "),
  spacing: () => `<span style="letter-spacing:.12em;word-spacing:.3em">${esc(PASSAGE)}</span>`,
  beeline: (el) => {
    // Colour each word along a gradient that alternates direction per line, so a line's end matches the next line's start.
    const box = el.querySelector(".para");
    box.innerHTML = WORDS.map(w => `<span>${esc(w)}</span>`).join(" ");
    const spans = [...box.children];
    const lines = []; let top = null;
    for (const s of spans) { if (s.offsetTop !== top) { lines.push([]); top = s.offsetTop; } lines.at(-1).push(s); }
    // Ends of the gradient come from the skin: primary blue to the pivot red.
    const rgb = name => { const h = getComputedStyle(document.documentElement).getPropertyValue(name).trim().slice(1); return [0, 2, 4].map(i => parseInt(h.slice(i, i + 2), 16)); };
    const A = rgb("--color-primary"), B = rgb("--color-accent");
    lines.forEach((line, li) => line.forEach((s, k) => {
      let t = line.length > 1 ? k / (line.length - 1) : 0; if (li % 2) t = 1 - t;
      s.style.color = `rgb(${A.map((a, c) => Math.round(a + (B[c] - a) * t)).join(",")})`;
    }));
    return null;
  },
};

for (const el of document.querySelectorAll("[data-demo]")) {
  const demo = DEMOS[el.dataset.demo](el);
  const btn = el.querySelector("[data-play]");
  let playing = false;
  const set = p => { playing = p; btn.textContent = p ? "Stop" : "Play"; btn.setAttribute("aria-pressed", p); };
  btn.addEventListener("click", () => { if (playing) { demo.stop(); set(false); } else { demo.play(); set(true); } });
  el.addEventListener("demoend", () => set(false));
}
for (const el of document.querySelectorAll("[data-layout]")) {
  const box = el.querySelector(".para");
  const toggle = el.querySelector("[data-toggle]");
  const plain = () => { box.innerHTML = esc(PASSAGE); };
  const treated = () => { const html = LAYOUTS[el.dataset.layout](el); if (html !== null) box.innerHTML = html; };
  let on = true;
  const render = () => { on ? treated() : plain(); toggle.textContent = on ? "Show plain text" : "Show treated text"; };
  toggle.addEventListener("click", () => { on = !on; render(); });
  render();
  if (el.dataset.layout === "beeline") addEventListener("resize", () => on && treated());
}
