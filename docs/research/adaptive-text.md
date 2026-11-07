# Adapting a general text to one reader: what the research supports

Literature review for Reading for Nerds, 2026-11-07.
Question: given a fixed text written for everyone and one reader with particular prior knowledge, what does research say about (a) compressing what he already knows, (b) keeping him at the right level of challenge, (c) surfacing the ideas that matter and the "aha" insights, and (d) how a tool could do this for a selected passage?

Verification key used throughout:
**[verified]** means the figure was checked against the paper's abstract or full text.
**[secondary]** means the figure was found only in a secondary source (blog, press release, citing paper, catalogue record), named in the entry.
**[unverified]** means the claim is plausible but I could not confirm it.
**[untested]** means no study tests it; it is a design inference.

---

## 1. The answer in one paragraph

The research supports the intuition, with a sharp condition attached.
Prior knowledge predicts what a reader ends up knowing (pretest–posttest r ≈ .53), but on average it does not predict how much he gains from a given text (r ≈ −.06), and that gain varies enormously from one study to another; the same text is efficient for some readers and wasteful for others (Simonsmeier et al. 2022).
The expertise-reversal literature shows the waste is systematic: supports that help novices (cohesive explanations, worked examples, signalling, redundant restatement) stop helping or start hurting knowledgeable learners (Kalyuga 2003, 2007; Tetzlaff et al. 2025).
Cutting a text down works when the cut keeps the main ideas: human-written summaries matched or beat full chapters, even at 6–12 months (Reder & Anderson 1980), and pretest-gated "curriculum compacting" removed 40–50% of material for able students with no loss on achievement tests (Reis et al. 1998).
The condition is that the decision to skip must rest on a *measured* answer, not the reader's feeling of knowing, because people's judgments of their own understanding are weak (self-evaluation r ≈ .29; comprehension judgments r ≈ .27) and most inflated for explanatory knowledge, which is exactly what textbooks teach (Zell & Krizan 2014; Dunlosky & Lipko 2007; Rozenblit & Keil 2002).
The best-evidenced single move is a short generative question asked *before* reading: it teaches the questioned content (g = 0.54) and doubles as the knowledge probe, but it does not help the rest of the text (g = 0.04), so the questions must target the passage's central ideas (St. Hilaire, Chan & Ahn 2024).
"Right level of challenge" has strong theory (zone of proximal development, region of proximal learning, desirable difficulties, the information gap behind curiosity, which peaks when you *almost* know) but no validated number for reading; the famous 85% figure comes from simulated binary classifiers, not people (Wilson et al. 2019).
"Natural insights" are best served by making the reader *generate* the key connection, not by telling it to him: generating beats reading (d ≈ 0.40), and solutions found with an "aha" are remembered better, though the generation part is the more robust of the two (Bertsch et al. 2007; Danek et al. 2013; Kizilirmak et al. 2016).
No randomized study yet tests an LLM that compresses a text to one reader's measured prior knowledge and measures learning; everything an on-device tool would do here is an inference from adjacent evidence, and the one human RCT of an LLM-adapted textbook (n = 60) cannot separate its parts (Learn Your Way, 2025).

---

## 2. Core mechanisms and their best evidence

### 2.1 Prior knowledge shapes outcomes, but not the gain from a fixed text

- **Simonsmeier, Flaig, Deiglmayr, Schalk & Schneider (2022)**, meta-analysis, 8,776 effect sizes. **[verified, accepted-manuscript abstract and Table]**
  Pretest–posttest correlation rP+ = .534.
  Pretest knowledge vs. *normalized* gains rNG+ = −.059, 95% prediction interval [−.688, .621], roughly normally distributed.
  Pretest vs. *absolute* gains r = −.263 (k = 50 studies).
  The authors say the spread "falsifies general statements such as 'knowledge is power' or 'prior knowledge is negligible'" and call for work on the conditions that make it help or hurt.
  Why it matters here: a fixed text produces wildly different gains across readers and settings; the variance is the opportunity adaptation tries to capture.
  DOI 10.1080/00461520.2021.1939700.
- **Recht & Leslie (1988)**, 2×2 design (reading skill × baseball knowledge), n = 64 seventh and eighth graders. **[secondary: Wikipedia and blog summaries; critique by Seidenberg]**
  Knowledge, not reading skill, drove recall of a baseball passage.
  Seidenberg argues the good/poor reader contrast was weak, so the study says little about knowledge *versus* skill.
  DOI 10.1037/0022-0663.80.1.16.

### 2.2 Expertise reversal: what helps a novice can hurt an expert

- **Kalyuga, Ayres, Chandler & Sweller (2003)** and **Kalyuga (2007)** are the reviews that named and organised the effect: instructional supports that reduce load for novices become redundant for experts, who must reconcile them with what they already know. DOI 10.1207/S15326985EP3801_4; 10.1007/s10648-007-9054-3.
- **Kalyuga, Chandler, Tuovinen & Sweller (2001)**, mechanical trade apprentices. **[abstract]**
  Worked examples beat problem solving for inexperienced learners; the advantage disappeared or reversed as experience grew.
  DOI 10.1037/0022-0663.93.3.579.
- **Tetzlaff, Simonsmeier, Peters & Brod (2025)**, meta-analysis, 60 studies, 176 effect sizes, ≈ 6,000 participants. **[secondary: Learning and the Brain blog; I could not open the open-access paper]**
  High-support instruction beat low-support for low-prior-knowledge learners (d ≈ 0.505); low-support beat high-support for high-prior-knowledge learners (d ≈ −0.428).
  Reported moderators: larger with age, strongest in higher education, smaller in language and humanities.
  DOI 10.1016/j.learninstruc.2025.102142.
- **Richter, Scheiter & Eitel (2016)**, meta-analysis of signalling in text–picture material, 27 studies, 45 comparisons, N = 2,464. **[abstract]**
  Signalling helped comprehension/transfer, r = .17, 95% CI [.11, .22], and prior knowledge moderated it: low-prior-knowledge learners benefited more.
  Implication: highlighting "what matters" is mainly a novice support.
  DOI 10.1016/j.edurev.2015.12.003.

### 2.3 Text cohesion and the "reverse cohesion effect": real, but narrower than its reputation

- **Kintsch (1988)**, construction–integration model; **Kintsch (1998)** *Comprehension*. Readers build a *textbase* (what the text says) and a *situation model* (what it is about, integrated with prior knowledge). Learning in the durable sense lives in the situation model, and building it requires inferences the reader supplies from what he knows. DOI 10.1037/0033-295X.95.2.163.
- **McNamara, Kintsch, Songer & Kintsch (1996)**, two experiments. **[abstract and secondary summaries]**
  Low-knowledge readers did better with a maximally coherent text; high-knowledge readers did better on situation-model (inference) measures with a minimally coherent text, which forced them to fill gaps from their own knowledge.
  DOI 10.1207/s1532690xci1401_1.
- **O'Reilly & McNamara (2007)**, "Reversing the reverse cohesion effect". **[secondary: summaries and citing papers]**
  The reverse cohesion benefit appeared only for high-knowledge readers who were *less skilled* readers; skilled high-knowledge readers benefited from the *high*-cohesion text.
  DOI 10.1080/01638530709336895.
- **Ozuru, Dempsey & McNamara (2009)**. **[secondary]** Benefit from high cohesion depended on reading skill; knowledgeable readers gained from high cohesion only with solid reading skill. DOI 10.1016/j.learninstruc.2008.11.003.
- **McCarthy, O'Reilly, McNamara et al. (2020 preprint)**, high-school students, n = 511. **[secondary, citing summary]** Robust prior-knowledge effects, no overall effect of the cohesion manipulation.

Reading of this cluster: removing connectives and elaborations ("make the expert infer") is *not* a reliable win, and for a skilled, knowledgeable reader the best evidence points the other way.
What reliably helps experts is removing *content* they already hold (2.5), not removing the glue between ideas.

### 2.4 Optimal challenge

- **Zone of proximal development** (Vygotsky 1978): the band of tasks a learner can do with support but not alone. A framing, not a measured quantity.
- **Region of proximal learning**, Metcalfe & Kornell (2005), *J. Memory and Language* 52:463–477, eight experiments. **[abstract]**
  Learners, when they control study, skip what they know, choose unlearned items from easiest to hardest, and stop on an item when the perceived rate of learning drops.
  Undorf & Ackerman (2017) argue part of the pattern is time limits (diminishing-criterion model).
  Implication: the most productive material is the material *just beyond* what the reader has, which is also where he chooses to spend time.
- **Desirable difficulties**, Bjork (1994); Bjork & Bjork (2011). Difficulties that trigger retrieval, generation or spacing slow apparent progress but improve retention.
  The boundary matters: McDaniel & Einstein's *material-appropriate processing* framework holds that a difficulty helps only when it induces processing the material does not already invite, and difficulty beyond an optimum has no or negative effect. **[abstract-level]**
  Not every difficulty is desirable: perceptual disfluency (hard-to-read fonts) had no effect on recall (d = −0.01) or transfer (d = 0.03) across 25 articles, N = 3,135 (Xie, Zhou & Liu 2018). **[secondary: search summary of abstract]** DOI 10.1007/s10648-018-9442-x.
  For an RSVP tool this means "harder to read" is not a lever; "harder to retrieve" is.
- **The eighty-five percent rule**, Wilson, Shenhav, Straccia & Cohen (2019), *Nature Communications* 10:4646. **[verified, full text]**
  For stochastic-gradient learners on *binary classification*, learning is fastest at ≈ 15.87% error (≈ 85% accuracy) under Gaussian noise; ≈ 82% for Laplacian and 75% for Cauchy noise.
  All results are simulations (perceptron, two-layer net on MNIST, a model of monkey perceptual learning); no human experiment.
  The authors note a Bayesian learner with perfect memory would show no sweet spot, and leave multi-class tasks and engagement as open.
  I found no human test of the rule. Use it as an intuition ("mostly right, not always"), not a target.
- **Flow**: Fong, Zaleski & Leach (2015), meta-analysis of 28 studies; challenge–skill balance is a robust correlate of flow, more weakly of intrinsic motivation. **[secondary; coefficients not retrieved]** Correlational, about experience rather than learning.

### 2.5 Compression: shorter texts that keep the main ideas can teach as well or better

- **Reder & Anderson (1980)**, *JVLVB* 19:121–134. **[abstract via secondary record]**
  Readers of short summaries of textbook chapters beat readers of the full chapters at 20 minutes, 1 week and 6–12 months, on both verbatim and inference questions, with better transfer to new related material; the advantage held even when the full text's main points were underlined.
- **Reder & Anderson (1982)**, *Memory & Cognition* 10:97–102. **[abstract via secondary record]** Separated two causes: spaced revisiting of main points and absence of distracting details; both independently improved retention of central ideas.
- **Mayer, Bove, Bryman, Mars & Tapangco (1996)**, "When less is more", *J. Ed. Psych.* 88:64–73. **[title and citing summaries; numbers not retrieved]** A short captioned-illustration summary of a lightning lesson produced better recall of the explanation and better problem-solving transfer than the full text, and adding detail back hurt.
- **Seductive details**: Sundararajan & Adesope (2020), meta-analysis, 58 studies, > 7,500 students. **[secondary: g = −0.33 reported by an ACU teaching page and WSU press release, not checked in paper]** Interesting but irrelevant additions lower learning. DOI 10.1007/s10648-020-09522-4.
- **Curriculum compacting**, Reis, Westberg, Kulikowich & Purcell (1998), *Gifted Child Quarterly*, n = 336 high-ability students, grades 2–6, quasi-experimental. **[secondary: NRC/GT summary and abstract text]**
  Teachers pretested and removed 40–50% of the regular curriculum; compacted students did not differ from controls in math concepts, computation, social studies and spelling, and scored higher in science (next-grade-level tests were used to avoid ceiling effects).
  This is the closest field analogue to "test out, then compress": the skip decision rests on a pretest.
- **Acceleration**, Steenbergen-Hu, Makel & Olszewski-Kubilius (2016), second-order meta-analysis. **[secondary: abstract snippets]** Accelerated students outperformed non-accelerated same-age peers (g = 0.70) and did not differ from older peers (g = 0.09). DOI 10.3102/0034654316675417.
- **Simplified vs. elaborated texts** (L2 reading): Yano, Long & Ross (1994), 483 Japanese students, 13 passages: comprehension highest on simplified, not significantly different from elaborated. Crossley, Yang & McNamara (2014) note many such studies did not control background knowledge. **[secondary]** This literature is about language proficiency, not domain knowledge, and transfers poorly to this question.
- **LLM simplification at scale**: Guidroz et al. (2025, Google, arXiv 2505.01980), randomized, n = 4,563, 31 texts in 6 domains. **[verified, abstract]** LLM-simplified texts raised multiple-choice comprehension by 3.9 percentage points overall (14.6 for PubMed texts) and reduced perceived load. No moderation by reader knowledge was reported, and loss of information was not measured directly. It is evidence that LLMs can lower difficulty without obvious comprehension loss for *general* readers, not that compression helps experts.

The boundary condition from the companion review still applies: LLM summaries that *replace* reading reduce learning (Kreijkes 2025; Bastani 2025).
The difference from Reder & Anderson is that their summaries were the *object of study* (read actively, tested later), while the LLM conditions replaced effortful processing with a ready answer.
A compressing tool has to keep the reader doing the work on what is new.

### 2.6 Refutation: when what the reader "knows" is wrong

- **Schroeder & Kucera (2022)**, meta-analysis, 44 comparisons, N = 3,869. **[abstract via search]** Refutation texts (state the misconception, refute it, explain) beat other texts, g = 0.41. DOI 10.1007/s10648-021-09656-z.
- Relevance: prior knowledge is not only "known / not known"; a confident wrong belief is the case where compression is most harmful, because the passage that would have corrected it is the one a confident reader will skip.

### 2.7 Curiosity as an information gap, with an inverted U

- **Loewenstein (1994)**, *Psych. Bulletin* 116:75–98: curiosity arises when attention is drawn to a gap in knowledge; it requires *some* knowledge to see the gap.
- **Kang, Hsu, Krajbich, Loewenstein, McClure, Wang & Camerer (2009)**, *Psychological Science* 20:963–973. **[verified, full text]** Experiment 1, fMRI, n = 19 Caltech students, 40 trivia questions: curiosity was an inverted U of confidence in one's guess. Higher curiosity predicted better recall of *surprising* answers (initially guessed wrong) 1–2 weeks later; follow-ups n = 10 and n = 20. Small samples.
- **Wade & Kidd (2019)**, *Psychon. Bull. Rev.* 26:1377–1387. **[abstract]** Curiosity peaked when people felt they *almost* knew the answer, and it tracked *perceived*, not objective, prior knowledge; learning was best predicted by objective knowledge, with a small extra boost from curiosity.
- **Gruber, Gelman & Ranganath (2014)**, *Neuron* 84:486–496. **[abstract]** High-curiosity states improved memory for the answers and for unrelated faces shown during the wait, linked to midbrain/hippocampal activity.
- **Dubey & Griffiths (2020)**, *Psych. Review* 127:455–476. **[abstract]** A rational model in which curiosity targets stimuli that most improve future responses; whether that is the novel or the intermediate depends on the environment's structure. This reconciles novelty and inverted-U accounts and warns that the inverted U is not universal.
- **Spitzer et al. (2023)** **[secondary]**: when information is rated important, the curiosity–confidence relation can turn negative (more curiosity for less-known material).

So: yes, there is an inverted U for curiosity against confidence/prior knowledge in trivia paradigms, peaking at "almost knowing"; whether it holds for expository text is not tested.

### 2.8 Measuring what the reader knows, quickly

- **Prequestions / pretests**: St. Hilaire, Chan & Ahn (2024), *Psychon. Bull. Rev.* 31:411–441, preregistered meta-analysis of prose and video studies. **[verified, full text]** Specific effect on prequestioned content g = 0.54 [0.42, 0.66], k = 97; general effect on other content g = 0.04, k = 91 (nearly half the studies show a negative general effect). The best-supported account is attentional: prequestions steer attention toward what they ask about.
  Richland, Kornell & Kao (2009), five experiments with an essay on vision: pretested items were learned better than with extra study time, even counting only items failed on the pretest. **[abstract]** DOI 10.1037/a0016496.
  Pan & Carpenter (2023) review: the effect holds across text, video and lectures despite mostly wrong initial answers. **[abstract]** DOI 10.1007/s10648-023-09814-5.
- **Rapid diagnostic assessment**, Kalyuga & Sweller (2004), *J. Ed. Psych.* 96:558–568, algebra and geometry, grades 9–10. **[secondary: abstract records]** A "first-step" test (show the first step you would take) correlated with full tests up to r = .92, cutting test time by factors of 4.9 and 2.5. Kalyuga & Sweller (2005), *ETR&D*, used such tests plus load ratings to adapt instruction dynamically and reported efficiency gains for the adaptive group **[abstract; numbers not retrieved]**.
  This is the directly relevant precedent: a few seconds of the right kind of question can place a learner well enough to choose what to show.
- **Knowledge tracing**: Bayesian knowledge tracing (Corbett & Anderson 1995) models each skill as a hidden known/unknown state with guess and slip rates. Deep knowledge tracing (Piech et al. 2015) uses an RNN. Khajah, Lindsey & Mozer (2016) showed BKT with standard extensions (forgetting, skill similarity, individual ability) matches DKT. **[abstract]** For a dependency-free tool, a small BKT-style update is sufficient and interpretable.
- **IRT and computerized adaptive testing**: adaptive item selection reaches a fixed precision with roughly half the items of a linear test in classic results (Weiss 1982) **[secondary]**; reported savings range widely by domain. **ALEKS** (knowledge-space theory, Doignon & Falmagne) places students in a combinatorial knowledge state by adaptive questioning **[I could not verify the commonly quoted question count]**.
- **How few questions?** No study answers this for a single passage. **[untested reasoning]** With two binary items and realistic guess/slip rates (say 0.2 and 0.1), two correct answers move a 50% prior to roughly 95% "knows it"; one right and one wrong leaves it near 50%. Two questions can therefore support a *one-way* decision ("he clearly knows this chunk") but not a fine placement. The asymmetric policy follows: compress only after clear success; otherwise show the text.
- **Self-assessment is weak**: Zell & Krizan (2014), metasynthesis of 22 meta-analyses, > 330,000 people: self-evaluations vs. performance M r = .29 (range .09–.63). **[abstract]** Metacomprehension accuracy for texts hovers around r ≈ .27 (Dunlosky & Lipko 2007; Thiede and colleagues) **[secondary]**. The illusion of explanatory depth is strongest for explanatory knowledge of mechanisms (Rozenblit & Keil 2002) **[abstract]**.

### 2.9 Mastery learning, tutoring and the 2 sigma

- **Bloom (1984)**, *Educational Researcher* 13(6):4–16: tutored students ≈ 2 SD above conventional class; mastery-learning class ≈ 1 SD.
- **von Hippel (2024)**, *Education Next*. **[verified, article]** The underlying Anania and Burke dissertations were three-week experiments; about half the effect came from mastery testing and corrective feedback, not tutoring. Of 65 tutoring studies in Cohen, Kulik & Kulik (1982) only one showed 2 SD; of 96 in Nickow, Oreopoulos & Quan (2020), none did. A realistic expectation for good tutoring is ≈ 0.33 SD on broad tests.
- **VanLehn (2011)**, *Educational Psychologist* 46:197–221. **[secondary for exact values]** Human tutoring d ≈ 0.79 and step-based tutoring systems d ≈ 0.76 over no tutoring.
- **Kulik, Kulik & Bangert-Drowns (1990)**, 108 controlled evaluations of mastery learning; positive effects on exams. **[abstract; the often-quoted 0.52 is unverified for this paper]**
- Relevance: the active ingredient that survives scrutiny is *frequent checks with correction*, which a reading tool can supply; "2 sigma from personalization" is not a defensible expectation.

### 2.10 What "ideas that matter" means in the research

- **Threshold concepts** (Meyer & Land 2003, 2005): ideas that are transformative, irreversible, integrative, bounded and troublesome. Useful vocabulary, weak evidence base: reviews find no agreed definition and identification that rests on expert judgment prone to hindsight bias and the curse of knowledge (Correia et al. 2024, review of 60 articles; Liljedahl et al. 2022, scoping review of 59) **[abstracts]**. No study shows that *marking* a threshold concept improves learning.
- **Main ideas**: skimming under time pressure (Duggan & Payne 2009, three experiments) preserved memory for important ideas but not details or inferences, with readers "satisficing", reading until information gain dropped and then jumping **[abstract-level]**. The Reder & Anderson summaries (2.5) also worked because they kept main points.
- **Insight / "aha"**: Kounios & Beeman (2014), *Annu. Rev. Psychol.* 65:71–93, define insight as a sudden reinterpretation yielding a non-obvious interpretation. Danek et al. (2013), *Psychological Research* 77:659–669, magic-trick solutions: solutions with an Aha! were recalled better. Kizilirmak et al. (2016) found generation and aha independently related to later memory in one paper, but in a recognition study only generation predicted memory. Becker, Sommer & Cabeza (2025, *Nature Communications*) report stronger insight ratings predicting memory **[secondary press coverage]**.
- **Generation effect**: Bertsch, Pesta, Wiscott & McDaniel (2007), 86 studies, 445 effect sizes: generated material remembered better, ≈ 0.40 SD **[abstract count verified; effect size secondary]**.
- **Worked examples and fading**: Renkl and colleagues show that gradually removing worked steps helps the transition to independent problem solving (Atkinson, Renkl & Merrill 2003). Salden, Aleven, Schwonke & Renkl (2010), *Instructional Science* 38:289–307: fading that adapted to each student's demonstrated understanding beat fixed fading and pure problem solving on delayed tests, lab and classroom **[abstract; a d = .59 on delayed transfer is from a companion report, secondary]**. This is the cleanest experimental evidence that *adapting the amount of support to measured knowledge* pays off.

### 2.11 Adaptive and intelligent textbooks: what has been measured

| System | What adapts | Best evidence | Status |
|---|---|---|---|
| Adaptive hypermedia (Brusilovsky; ELM-ART, InterBook) | Link annotation and ordering from a user model | Brusilovsky & Eklund 1998, n = 25: annotation initially hurt the group, helped those who followed it | Small, mixed; authors themselves note little experimental work **[abstract]** |
| OpenStax Tutor | Spaced retrieval practice, ML knowledge model (SPARFA) | Butler, Marsh, Slavinsky & Baraniuk 2014, one engineering course, n = 40, better on intervention-taught exam items | Small, developer-run; mechanism is spaced retrieval, not text adaptation **[secondary]** |
| Inquire Biology (Chaudhri et al. 2013) | Question answering over a knowledge base of *Campbell Biology* | Controlled study with community-college students: users outperformed print and e-book | No numbers retrieved **[abstract]** |
| iTELL (Crossley, Morris et al., Vanderbilt) | LLM-scored constructed responses and summaries gate progress | Reported ≈ 5% pre–post gain advantage in one deployment | **[secondary; not verified]** |
| Learn Your Way (Google, arXiv 2509.13348) | Re-levels text to grade level, rewrites passages for one interest, plus quizzes, mind maps, audio | RCT, n = 60, ages 15–18, one chapter; higher immediate (p = .03) and 3-day retention (p = .03) vs. PDF reader; blog reports 78% vs 67% | **[verified design from paper; means only in figures]** Cannot isolate the personalization from the quizzes, which all LYW users took |
| Huynh & McNamara (2025), *Applied Sciences* | LLMs rewrite science texts for profiles differing in prior knowledge and skill | Augmented prompts produced cohesion more in line with theory for high- vs. low-knowledge readers | NLP features only; **no human comprehension measured** |

Bottom line: no published RCT adapts a text to a reader's *measured* prior knowledge with an LLM and measures learning.
The closest experimental evidence is non-LLM (Kalyuga's rapid-assessment adaptation; Salden's adaptive fading; curriculum compacting).

### 2.12 Adjacent fields

- **Surprisal**: Smith & Levy (2013), *Cognition* 128:302–319: reading time scales with −log probability of a word in context over six orders of magnitude, confirmed at larger scale by Shain et al. (2024, *PNAS*) **[abstract]**. In information-theoretic terms, processing cost tracks how unpredictable the next word is *to the reader*. A personal-knowledge version of this ("what is surprising to *him*") is the formal shape of "show me only what's new", but it is **[untested]**.
- **Update summarization / novelty detection** (TAC 2008 update task; TREC novelty track): NLP tasks that summarize only what is new relative to documents the reader has already seen. They are the closest engineering precedent for "compress against what I know", but evaluated on text overlap, not learning.
- **Machine teaching**: Rafferty, Brunskill, Griffiths & Shafto (2016), *Cognitive Science* 40:1290–1332: choosing teaching actions as a POMDP over a learner model sped up concept learning in two tasks **[abstract]**. It shows planning over a Bayesian learner model can beat fixed sequences, in simple concept tasks.
- **LLM difficulty prediction**: a 2025 study of > 20 models found systematic overestimation of human ability and average Spearman correlations with human item difficulty below .50 (arXiv 2512.18880) **[secondary: press coverage]**; simulated-student IRT approaches do better. Implication: do not let the model *judge* how hard something is for the reader; measure it.
- **LLM summaries drop caveats**: Peters & Chin-Yee (2025), *Royal Society Open Science*, 4,900 summaries from 10 LLMs: frequent overgeneralization of scientific conclusions, worse in some newer models **[abstract]**. Compression tends to remove exactly the qualifiers a careful reader needs.

---

## 3. Designs a tool could use on a selected passage

Ranked by strength of evidence for the *mechanism*; none is tested as a whole in this form.
"Model must" lists what the on-device model (≈ 3B parameters per Apple's 2025 tech report; community sources report a ≈ 4,096-token context and weak world knowledge **[secondary]**) would have to get right.

### Rank 1. Prequestion first, on the central ideas
Before RSVP starts, ask one to three short-answer questions about the passage's central claims; the reader types or says an answer (or explicitly guesses); then the passage plays.
Evidence: prequestion meta-analysis g = 0.54 on questioned content, preregistered; holds with wrong answers; generation beats reading only the question (St. Hilaire et al. 2024; Richland et al. 2009).
Cost: g = 0.04 on everything else, so question choice decides what is learned.
Model must: find the two or three ideas the passage is *for* (not the most quotable detail), phrase questions that cannot be answered from general knowledge alone, and not leak the answer. It already writes usable recall questions in 1–9 s.
This is also the cheapest knowledge probe, which is what makes Rank 2 possible.

### Rank 2. Pretest-gated compaction ("test out of a chunk")
Split the passage into idea units.
For each unit, the prequestion answer (or one extra question) decides: clearly correct → collapse to a one-line gist, expandable; wrong, partial or skipped → show in full.
Never compress on self-report.
Evidence: curriculum compacting removed 40–50% with no loss (pretest-gated, n = 336, quasi-experimental); acceleration g = 0.70; expertise reversal (d ≈ ±0.5, secondary); Kalyuga's first-step tests (r up to .92 with full tests); summaries ≥ full text (Reder & Anderson).
Evidence against careless versions: self-assessment r ≈ .29; LLM summaries that replace effort hurt learning.
Model must: segment into units that each carry one claim; grade a free-text answer as right / partial / wrong (the riskiest step: a lenient grader turns into skipping what he does not know); write a gist that keeps qualifiers.
Policy that follows from 2.8: asymmetric. A miss always shows the full text; a hit compresses only that unit; the gist is never the only copy.

### Rank 3. Adaptive support level, not cohesion stripping
For units shown in full, vary support with measured knowledge: for a unit he nearly answered, skip the restated definition and the worked example and go to the new step; for a unit he missed, keep them.
Evidence: adaptive fading beat fixed fading on delayed tests (Salden et al. 2010); expertise reversal.
Do **not** delete connectives or elaborations to "make the expert infer": the reverse-cohesion effect held only for less-skilled readers and failed to replicate at n = 511.
Model must: tell restatement and example apart from new claims within a unit.

### Rank 4. Put the key idea in a question, not a highlight
For the passage's central idea, play the setup, pause, and ask him to predict or explain the next step before revealing it; then reveal and continue.
Evidence: generation effect ≈ 0.40 SD (secondary); insight solutions remembered better (Danek et al. 2013) though generation is the robust part; signalling (highlighting) mainly helps low-knowledge readers (Richter et al. 2016).
Threshold concept labels have no evidence that marking helps; use the idea, not the label.
Model must: pick the right idea (the step where understanding turns), and pause *before* the sentence that gives it away, not after. A wrong pick costs one question; a wrong highlight misdirects attention silently.

### Rank 5. Challenge calibration across sessions
Track his success on the embedded questions over time (a BKT-style per-topic estimate); if he is nearly always right, compress more aggressively and ask deeper (inference, transfer) questions; if often wrong, compress less and ask more basic ones.
Aim for "mostly right, not always", without treating 85% as validated.
Evidence: theory (RPL, ZPD, desirable difficulties), ITS results; the 85% figure is simulation-only; LLM difficulty judgments correlate < .5 with human difficulty.
Model must: little. The calibration should come from his answers, not from the model's opinion of difficulty.

### Rank 6. Curiosity hook
Open with one question whose answer he probably almost knows (from the probe), and let the passage resolve it.
Evidence: trivia-paradigm inverted U (Kang n = 19; Wade & Kidd), memory boost (Gruber 2014); not tested with expository text.
Model must: find a genuine gap the passage closes, not a teaser.

### Rank 7. Misconception check
When his prequestion answer is confidently wrong, switch that unit to refutation form: name his answer, say why it fails, give the correct account.
Evidence: refutation text g = 0.41.
Model must: recognise that a wrong answer reflects a coherent misconception rather than a slip, and write a correct refutation; errors here teach something false with authority.

### Rank 8 (speculative). Personal-surprisal pacing in RSVP
Slow the word rate on sentences that are new to him and speed through ones he demonstrably knows.
Evidence: reading time tracks surprisal (Smith & Levy 2013); no study of personalised pacing. **[untested]**

### What "show me only what's new to me" should mean
It is Rank 1 + Rank 2 together: *new* is defined by his answers, not by what he says he knows or what the model guesses he knows.
A version driven by a self-declared knowledge profile ("I know linear algebra") rests on r ≈ .29 self-assessment and would mostly skip things he only feels he knows.

---

## 4. Risks and failure modes

- **Overestimating what he knows.** Feeling of knowing is weakly related to knowing (r ≈ .27–.29), and the illusion is largest for mechanisms, the core of most technical text. Any self-report gate will over-compress. Mitigation: gate on answers; asymmetric policy.
- **Fluency illusion of compressed text.** A smooth one-line gist feels understood; recognising a gist is not the same as being able to rebuild the reasoning. Mitigation: gists are expandable and his next question tests the reasoning, not recognition.
- **Compression drops the insight or the caveat.** The surprising example, the exception, or the qualifier is what a summariser removes first (Peters & Chin-Yee 2025); the insight often lives there. Mitigation: never compress the unit holding the passage's central idea; keep qualifiers in gists; keep the full text one keystroke away.
- **Prequestions narrow attention.** Content not asked about gains nothing (g = 0.04) and sometimes loses. Mitigation: ask about the central ideas only; don't stack many detail questions.
- **Grader error.** The on-device model grading a free answer is the single point of failure for skipping. A lenient grader silently hides what he doesn't know. Mitigation: require clear correctness to skip; prefer questions with checkable answers; show him the model answer after each question so he can override.
- **Misclassifying him as expert.** Expertise reversal is symmetric: low-support text for someone who lacks the knowledge hurts (d ≈ 0.5 in the other direction).
- **Confident misconceptions get skipped.** A confidently wrong reader is exactly the one who would test out if the gate trusted confidence.
- **Optimising for the questions.** If the model writes the questions and also decides what to show, it can teach to its own test. Delayed questions written *before* adaptation are the honest check.
- **Removing the work.** The companion review's core finding: when the tool does the processing, learning drops. Compression must remove *known* material, never the effort on new material.
- **Context and model limits.** A ≈ 4k-token context (secondary) caps passage length per call; weak world knowledge means the model can misjudge what is "basic". Neither has been measured for this use.
- **Evidence transfer.** Most findings come from students, short lab texts and one-session tests; Reevu is an expert adult reading self-chosen technical material. Expertise reversal is reportedly largest in higher education, which helps; most else is untested for this population.

---

## 5. Open questions and gaps

- No RCT of LLM compression to a reader's *measured* prior knowledge with learning outcomes. Learn Your Way is the nearest and confounds personalization with quizzes; Huynh & McNamara measure text features only.
- How many questions are enough to gate a chunk? No study for passages; Kalyuga's rapid tests are the nearest, in algebra and geometry.
- Does the inverted U of curiosity hold for expository text and for experts? Shown in trivia paradigms with small samples.
- Is there an optimal success rate for human reading comprehension? The 85% rule is untested in people.
- Can a model reliably find the central idea or threshold concept of a passage? Threshold concepts lack a reliable human identification method, so there is no ground truth to score a model against.
- Does inducing an "aha" from text, rather than from puzzles or magic tricks, carry the memory benefit?
- The reverse cohesion effect: when, if ever, does it help skilled knowledgeable readers? Current evidence says rarely.
- Personal surprisal pacing for RSVP: entirely open.
- Unverified figures I could not check in primary sources: Tetzlaff et al. 2025 effect sizes; seductive-details g = −0.33; generation effect 0.40; Kalyuga & Sweller r = .92; VanLehn 0.79/0.76; Salden d = .59; Kulik mastery 0.52; ALEKS question count; Apple model context window.

A study he can run on himself: alternate passages between full and adapted modes, with recall and inference questions written by the model *before* it adapts and answered a week later. With n = 1 this will not generalise, but it is the only evidence that would bear on *his* reading with *this* tool.

---

## 6. Sources

Links I opened or saw in search results are as found.
Some DOIs, page ranges and the Bjork & Bjork PDF URL were filled in from bibliographic memory and not opened in this session; treat any link that fails to resolve as a citation error, not a missing paper.

Prior knowledge and expertise reversal
- Simonsmeier, Flaig, Deiglmayr, Schalk & Schneider (2022). Domain-specific prior knowledge and learning: A meta-analysis. *Educational Psychologist* 57:31–54. https://doi.org/10.1080/00461520.2021.1939700 (accepted manuscript: https://www.uni-trier.de/fileadmin/fb1/prof/PSY/PAE/Team/Schneider/SimonsmeierEtAl_2021.pdf)
- Recht & Leslie (1988). *J. Ed. Psych.* 80:16–20. https://doi.org/10.1037/0022-0663.80.1.16
- Kalyuga, Chandler, Tuovinen & Sweller (2001). *J. Ed. Psych.* 93:579–588. https://doi.org/10.1037/0022-0663.93.3.579
- Kalyuga, Ayres, Chandler & Sweller (2003). The expertise reversal effect. *Educational Psychologist* 38:23–31. https://doi.org/10.1207/S15326985EP3801_4
- Kalyuga (2007). Expertise reversal effect and its implications for learner-tailored instruction. *Ed. Psych. Review* 19:509–539. https://doi.org/10.1007/s10648-007-9054-3
- Tetzlaff, Simonsmeier, Peters & Brod (2025). A cornerstone of adaptivity: a meta-analysis of the expertise reversal effect. *Learning and Instruction* 98:102142. https://doi.org/10.1016/j.learninstruc.2025.102142 (figures via https://www.learningandthebrain.com/blog/one-size-doesnt-fit-all-teaching-experts-and-novices/)
- Richter, Scheiter & Eitel (2016). Signaling text–picture relations: a meta-analysis. *Educational Research Review* 17:19–36. https://doi.org/10.1016/j.edurev.2015.12.003

Text comprehension and cohesion
- Kintsch (1988). The role of knowledge in discourse comprehension: a construction–integration model. *Psych. Review* 95:163–182. https://doi.org/10.1037/0033-295X.95.2.163
- McNamara, Kintsch, Songer & Kintsch (1996). Are good texts always better? *Cognition and Instruction* 14:1–43. https://doi.org/10.1207/s1532690xci1401_1
- O'Reilly & McNamara (2007). Reversing the reverse cohesion effect. *Discourse Processes* 43:121–152. https://doi.org/10.1080/01638530709336895
- Ozuru, Dempsey & McNamara (2009). *Learning and Instruction* 19:228–242. https://doi.org/10.1016/j.learninstruc.2008.11.003

Challenge, difficulty, curiosity
- Metcalfe & Kornell (2005). A region of proximal learning model of study time allocation. *J. Memory and Language* 52:463–477. https://psychology.columbia.edu/sites/default/files/2016-11/Metcalfe.Kornell.2005_0.pdf
- Bjork & Bjork (2011). Making things hard on yourself, but in a good way. In *Psychology and the Real World*. https://bjorklab.psych.ucla.edu/wp-content/uploads/sites/13/2016/04/EBjork_RBjork_2011.pdf
- McDaniel & Einstein (2005). Material appropriate difficulty. In Healy (Ed.), *Experimental Cognitive Psychology and its Applications*.
- Xie, Zhou & Liu (2018). The disfluency effect: a meta-analysis. *Ed. Psych. Review* 30:745–771. https://doi.org/10.1007/s10648-018-9442-x
- Wilson, Shenhav, Straccia & Cohen (2019). The Eighty Five Percent Rule for optimal learning. *Nature Communications* 10:4646. https://doi.org/10.1038/s41467-019-12552-4
- Fong, Zaleski & Leach (2015). The challenge–skill balance and antecedents of flow: a meta-analysis. *J. Positive Psychology* 10:425–446. https://doi.org/10.1080/17439760.2014.967799
- Loewenstein (1994). The psychology of curiosity. *Psych. Bulletin* 116:75–98. https://doi.org/10.1037/0033-2909.116.1.75
- Kang et al. (2009). The wick in the candle of learning. *Psychological Science* 20:963–973. https://doi.org/10.1111/j.1467-9280.2009.02402.x
- Wade & Kidd (2019). The role of prior knowledge and curiosity in learning. *Psychon. Bull. Rev.* 26:1377–1387. https://doi.org/10.3758/s13423-019-01598-6
- Gruber, Gelman & Ranganath (2014). States of curiosity modulate hippocampus-dependent learning. *Neuron* 84:486–496. https://doi.org/10.1016/j.neuron.2014.08.060
- Dubey & Griffiths (2020). Reconciling novelty and complexity through a rational analysis of curiosity. *Psych. Review* 127:455–476. https://doi.org/10.1037/rev0000175

Measuring knowledge
- St. Hilaire, Chan & Ahn (2024). Guessing as a learning intervention: a meta-analytic review of the prequestion effect. *Psychon. Bull. Rev.* 31:411–441. https://doi.org/10.3758/s13423-023-02353-8
- Richland, Kornell & Kao (2009). The pretesting effect. *J. Exp. Psych.: Applied* 15:243–257. https://doi.org/10.1037/a0016496
- Pan & Carpenter (2023). Prequestioning and pretesting effects: a review. *Ed. Psych. Review* 35:97. https://doi.org/10.1007/s10648-023-09814-5
- Kalyuga & Sweller (2004). Measuring knowledge to optimize cognitive load factors during instruction. *J. Ed. Psych.* 96:558–568. https://doi.org/10.1037/0022-0663.96.3.558
- Kalyuga & Sweller (2005). Rapid dynamic assessment of expertise to improve the efficiency of adaptive e-learning. *ETR&D* 53:83–93. https://doi.org/10.1007/BF02504800
- Corbett & Anderson (1995). Knowledge tracing. *User Modeling and User-Adapted Interaction* 4:253–278. https://doi.org/10.1007/BF01099821
- Piech et al. (2015). Deep knowledge tracing. NeurIPS. https://arxiv.org/abs/1506.05908
- Khajah, Lindsey & Mozer (2016). How deep is knowledge tracing? EDM. https://arxiv.org/abs/1604.02416
- Weiss (1982). Improving measurement quality and efficiency with adaptive testing. *Applied Psych. Measurement* 6:473–492. https://doi.org/10.1177/014662168200600408
- Zell & Krizan (2014). Do people have insight into their abilities? *Perspectives on Psych. Science* 9:111–125. https://doi.org/10.1177/1745691613518075
- Dunlosky & Lipko (2007). Metacomprehension: a brief history and how to improve its accuracy. *Current Directions* 16:228–232. https://doi.org/10.1111/j.1467-8721.2007.00509.x
- Rozenblit & Keil (2002). The misunderstood limits of folk science. *Cognitive Science* 26:521–562. https://doi.org/10.1207/s15516709cog2605_1

Compression, summaries, refutation
- Reder & Anderson (1980). A comparison of texts and their summaries. *JVLVB* 19:121–134. https://doi.org/10.1016/S0022-5371(80)90132-0
- Reder & Anderson (1982). Effects of spacing and embellishment on memory for the main points of a text. *Memory & Cognition* 10:97–102. https://doi.org/10.3758/BF03209210
- Mayer, Bove, Bryman, Mars & Tapangco (1996). When less is more. *J. Ed. Psych.* 88:64–73. https://doi.org/10.1037/0022-0663.88.1.64
- Sundararajan & Adesope (2020). Keep it coherent: a meta-analysis of the seductive details effect. *Ed. Psych. Review* 32:707–734. https://doi.org/10.1007/s10648-020-09522-4
- Reis, Westberg, Kulikowich & Purcell (1998). Curriculum compacting and achievement test scores. *Gifted Child Quarterly* 42:123–129. https://doi.org/10.1177/001698629804200206 (summary: https://nrcgt.uconn.edu/research-based_resources/reiswest)
- Steenbergen-Hu, Makel & Olszewski-Kubilius (2016). What one hundred years of research says about ability grouping and acceleration. *Rev. Ed. Research* 86:849–899. https://doi.org/10.3102/0034654316675417
- Yano, Long & Ross (1994). The effects of simplified and elaborated texts on foreign language reading comprehension. *Language Learning* 44:189–219. https://doi.org/10.1111/j.1467-1770.1994.tb01100.x
- Guidroz et al. (2025). LLM-based text simplification and its effect on user comprehension and cognitive load. https://arxiv.org/abs/2505.01980
- Schroeder & Kucera (2022). Refutation text facilitates learning. *Ed. Psych. Review* 34:957–987. https://doi.org/10.1007/s10648-021-09656-z
- Peters & Chin-Yee (2025). Generalization bias in LLM summarization of scientific research. *Royal Society Open Science*. https://doi.org/10.1098/rsos.241776

Mastery, tutoring, adaptive systems
- Bloom (1984). The 2 sigma problem. *Educational Researcher* 13(6):4–16. https://doi.org/10.3102/0013189X013006004
- von Hippel (2024). Two-sigma tutoring: separating science fiction from science fact. *Education Next* 24(2). https://www.educationnext.org/two-sigma-tutoring-separating-science-fiction-from-science-fact/
- VanLehn (2011). The relative effectiveness of human tutoring, intelligent tutoring systems, and other tutoring systems. *Educational Psychologist* 46:197–221. https://doi.org/10.1080/00461520.2011.611369
- Kulik, Kulik & Bangert-Drowns (1990). Effectiveness of mastery learning programs: a meta-analysis. *Rev. Ed. Research* 60:265–299. https://doi.org/10.3102/00346543060002265
- Brusilovsky & Eklund (1998). A study of user model based link annotation in educational hypermedia. *J. Universal Computer Science* 4:429–448. https://www.jucs.org/jucs_4_4/a_study_of_user/Brusilovsky_P.pdf
- Brusilovsky (2001). Adaptive hypermedia. *UMUAI* 11:87–110. https://doi.org/10.1023/A:1011143116306
- Butler, Marsh, Slavinsky & Baraniuk (2014). Integrating cognitive science and technology improves learning in a STEM classroom. *Ed. Psych. Review* 26:331–340. https://doi.org/10.1007/s10648-014-9256-4
- Chaudhri et al. (2013). Inquire Biology: a textbook that answers questions. *AI Magazine* 34(3):55–72. https://doi.org/10.1609/aimag.v34i3.2486
- iTELL, Vanderbilt. https://itell-home.vercel.app/research
- Google LearnLM team (2025). Towards an AI-augmented textbook. https://arxiv.org/abs/2509.13348 ; blog: https://research.google/blog/learn-your-way-reimagining-textbooks-with-generative-ai/
- Huynh & McNamara (2025). GenAI-powered text personalization: NLP validation of adaptation capabilities. *Applied Sciences* 15:6791. https://www.mdpi.com/2076-3417/15/12/6791
- Salden, Aleven, Schwonke & Renkl (2010). The expertise reversal effect and worked examples in tutored problem solving. *Instructional Science* 38:289–307. https://doi.org/10.1007/s11251-009-9107-8
- Atkinson, Renkl & Merrill (2003). Transitioning from studying examples to solving problems. *J. Ed. Psych.* 95:774–783. https://doi.org/10.1037/0022-0663.95.4.774
- Rafferty, Brunskill, Griffiths & Shafto (2016). Faster teaching via POMDP planning. *Cognitive Science* 40:1290–1332. https://doi.org/10.1111/cogs.12290

Ideas that matter, insight, skimming
- Meyer & Land (2005). Threshold concepts and troublesome knowledge (2). *Higher Education* 49:373–388. https://doi.org/10.1007/s10734-004-6779-5
- Correia et al. (2024). Uncovering challenges and pitfalls in identifying threshold concepts. *Knowledge* 4(1):2. https://www.mdpi.com/2673-9585/4/1/2
- Liljedahl et al. (2022). Threshold concepts in health professions education research: a scoping review. *Adv. Health Sci. Educ.* https://doi.org/10.1007/s10459-022-10127-5
- Duggan & Payne (2009). Text skimming: foraging through text under time pressure. *J. Exp. Psych.: Applied* 15:228–242. https://doi.org/10.1037/a0016995
- Kounios & Beeman (2014). The cognitive neuroscience of insight. *Annu. Rev. Psychol.* 65:71–93. https://doi.org/10.1146/annurev-psych-010213-115154
- Danek, Fraps, von Müller, Grothe & Öllinger (2013). Aha! experiences leave a mark. *Psychological Research* 77:659–669. https://doi.org/10.1007/s00426-012-0454-8
- Kizilirmak, Galvao Gomes da Silva, Imamoglu & Richardson-Klavehn (2016). Generation and the subjective feeling of "aha!" are independently related to learning from insight. *Psychological Research* 80:1059–1074. https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5069302/
- Bertsch, Pesta, Wiscott & McDaniel (2007). The generation effect: a meta-analytic review. *Memory & Cognition* 35:201–210. https://doi.org/10.3758/BF03193441

Adjacent
- Smith & Levy (2013). The effect of word predictability on reading time is logarithmic. *Cognition* 128:302–319. https://doi.org/10.1016/j.cognition.2013.02.013
- Shain, Meister, Pimentel, Cotterell & Levy (2024). Large-scale evidence for logarithmic effects of word predictability on reading time. *PNAS*. https://www.ncbi.nlm.nih.gov/pmc/articles/PMC10927576/
- LLM vs. human item difficulty (2025). https://arxiv.org/abs/2512.18880
- Apple (2025). Apple Intelligence Foundation Language Models tech report. https://arxiv.org/abs/2507.13575

Not cited by design: the retracted Wang & Fan ChatGPT meta-analysis.
Companion review findings (Kreijkes 2025; Bastani 2025) are referenced, not repeated.
