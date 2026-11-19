---
name: fibrous-sites
description: Builds a finished concept website from one line. FREEFORM - "make me a website about <business>" (optionally "as good as N sites"): researches the category, benchmarks against the best real sites, builds, scores itself against that benchmark, then shows 3-5 design directions with a recommendation to steer. PROMPT - picks an unbuilt prompt in F:\START-UPS\web.fibrous\portfolio\prompts and builds it. Also writes copy-paste prompts for ChatGPT/Google Flow assets and specs for 3D models. Use for /fibrous-sites, "next portfolio site", "make me a website about...", or any end-to-end concept site build.
argument-hint: "<business description> [like N sites] [build=sonnet|opus] | [NN|brand] [astra|glm] [list] [skip-research] [polish] [next N]"
---

# Fibrous Sites

Input: whatever the user typed after the skill name (Claude Code: `$ARGUMENTS`; Codex: the rest of the message after `$fibrous-sites`). Root: `F:\START-UPS\web.fibrous\portfolio` (if it does not exist on this machine, ask the user for the path once). Never push to a remote; repos are local-only by choice.

Typical use: `/fibrous-sites a family-run olive oil estate in Margaret River` or `/fibrous-sites 15`. Nothing else is required.

## Runtime adaptation (Claude Code and Codex)

This skill is written for Claude Code but must also work in Codex. Detect what the runtime offers and adapt; never fail because a feature is missing.
- **Sub-agents with a model/effort setting** (Claude Code Agent tool): follow the routing table exactly.
- **No per-agent model control** (Codex or a plain session): run every stage inline, one after another, in the main thread, still writing the same files and honouring each contract. Parallel stages become sequential. Keep the effort policy as guidance: tell the user, once, which stages are meant to be cheap vs. hard, and for the build question (Step 5) offer the closest equivalents the runtime has (for example a stronger model vs. a faster model, or high vs. low reasoning effort).
- **Asking the user**: use AskUserQuestion in Claude Code; elsewhere ask a short numbered question in chat and wait.
- **Other skills** named below (`de-ai-copy`, `impeccable`, `site-glow-up`, `ui-ux-pro-max`, ...) are optional. Check what is installed; if one is missing, apply its principle yourself (specific copy, a locked aesthetic anchor, no generic AI look) and continue. Never invent a skill name.
- **Browser / screenshots**: use the built-in browser, Playwright or Chrome tooling, whichever exists. **Lighthouse**: `npx lighthouse <url> --form-factor=mobile --output=json` works anywhere.
- All state lives in files under the portfolio root, so a run can be resumed from any runtime.

## Mode selection

- **Freeform** (default when the arguments are prose, e.g. "a family-run olive oil estate in Margaret River"): no prompt file exists. Go to "Freeform intake".
- **Prompt** (arguments are a number/brand, `list`, `next N`, or empty): scan `prompts/` and follow Steps 1-2.
- Flags: `list` stops after Step 1; `astra`/`glm` forces the variant; `skip-research` skips Step 4 (4b then runs on `concept.md` alone); `polish` runs Step 8; `next N` loops the pipeline sequentially N times (never in parallel, one writer per folder).

## Freeform intake (one line in, no questions out)

Do not interview the user. Infer and state assumptions in one short block, then proceed:
- **Brand**: invent a fictional, believable name unless the user supplied a real one. Pick the next free number `NN` (highest existing folder number + 1) and slug: folder `portfolio/NN-brand/`.
- **Category, audience, location** (default Australia, AUD), **tier** (default: premium $10k standard unless the user said cheaper), **N** (default 10: "as good as the best 10 sites in its category").
- Write `portfolio/prompts/NN-brand-freeform.md`: the synthesized brief (brand, niche, audience, tier, conversion goal, signature-interaction hypothesis, acceptance checks copied from Step 5). This file is the "prompt" for every later stage and keeps freeform runs resumable.
- Variant: apply the Step 2 variant rule.

## Model routing (Claude Code: set `model` and `effort` on every Agent call)

Policy: Sonnet low is the default. Sonnet medium only for genuinely hard stages. Opus is used only for design thinking and never above low effort. Haiku only for mechanical extraction.

| Stage | Agent | Model | Effort |
|---|---|---|---|
| 1 Scan | main thread (inline, no agent) | - | - |
| 2 Pick / intake | main thread | - | - |
| 3 Concept + copy + content | general-purpose | sonnet | low |
| 4 Category research + benchmark scoring | general-purpose | sonnet | medium (hard: judgment and scoring) |
| 4b Design directions + design plan | general-purpose | opus | low (cap: never higher) |
| 4c-i Asset inventory | general-purpose | haiku | low |
| 4c-ii Asset prompts (ChatGPT / Google Flow) + 3D specs | general-purpose | sonnet | low |
| 5 Build (the direction the user picks) | general-purpose | **user's choice**: sonnet medium or opus low (asked before the build) | see Step 5 |
| 5b Option heroes (only if the user asks to preview directions) | general-purpose, one per requested direction | sonnet | low |
| 6 Gate | main thread (+ impeccable-finish-reviewer if needed) | - | - |
| 7 Showcase and recommend | main thread | - | - |
| 8 Revise, wire assets, polish | build agent on the user's chosen model; Opus low for a new design direction | - | - |

Build model is the user's call (see Step 5). If a build fails the Step 6 gate twice on the same signature interaction, say so and ask whether to switch the build model; never switch silently.

Stages 3 and 4 are independent: launch in the same message. 4b waits for both; 4c waits for 4b; 5 waits for 4b (it may start before 4c ends, using placeholders); 5b runs only on request. Keep every sub-agent connected to this chat: pass the full brief and output path, require a summary of 150 words or fewer, and relay one line per result as it lands. Failure rule: if a stage fails or returns thin output, say so and rerun it once; if it fails again, stop and tell the user. Never fabricate a stage's result.

## Step 1: Scan (inline)

Read `prompts/00-index.md` and list `portfolio/`. Classify each prompt number:
- **done**: folder `NN-*` exists (ignore `-backup-*`, `_research`, `_templates`, `_options`) AND it passes the minimum check: has `index.html` or `package.json`, and if it has `package.json` the build script exits 0 (skip the build check when only listing).
- **partial**: folder exists but fails the check. Offer to resume, never silently skip.
- **not started**: no folder.
Skip `_retired/` and numbers 10-12 (built directly, no prompt). Return a table: number, brand, tier, variants (astra/glm), status. Do not hardcode or trust any remembered state; this scan is the only source of truth. Write it to `_research/status.md` so later runs can diff.

Resume rule: before running any stage, check `_research/NN-brand/` for that stage's output file; if it exists and meets its contract (below), reuse it instead of regenerating.

## Step 2: Pick (prompt mode)

Choose the one unbuilt (or partial) prompt where the build can do its best work: clear brand and category, a strong signature interaction, no dependence on assets that cannot be prompted or supplied as 3D. Prefer premium tiers first, following the index's suggested order. Give a two-sentence justification and proceed; ask only if the user gave no hint and two prompts are genuinely tied.

**Variant rule**: choose **astra** only if an image-generation path is confirmed available this session (test it with a real call, e.g. an available image-generation tool responds); otherwise **glm** (placeholders against exact filenames, real files drop in later). State which and why.

## Step 3: Concept and copy (Sonnet low)

Brief: read the prompt file in full. Write `_research/NN-brand/concept.md` with: 3 concept angles and a recommended one, voice and tone, full site copy (every page and section: headlines, subheads, body, CTAs, microcopy, footer, meta titles/descriptions, alt text), and realistic content (team, services, prices, testimonials, case studies, FAQ). Specific over generic: invented but plausible detail, no lorem ipsum, no "unlock / elevate / seamless / cutting-edge". Follow `de-ai-copy`.
**Contract**: headings `Angles`, `Voice`, `Copy` (one subsection per page), `Content`; at least 5 pages/sections with full copy.

## Step 4: Research and benchmark (Sonnet medium)

Brief: find the **N** best real sites in the category and adjacent categories (default 10; WebSearch/WebFetch or built-in browser). Write `_research/NN-brand/research.md`: per site, URL, what it does best (layout, hierarchy, motion, trust signals, conversion path, copy), then a synthesis: patterns worth adopting, clichés to avoid, and a ranked "load into the build" list of 8-10 decisions. Cite URLs; copy no text or assets.
Also write the **benchmark scorecard** in the same file: 8 criteria (hierarchy, typography, motion craft, imagery/art direction, trust and proof, conversion path, mobile, performance/accessibility), each scored 1-5 for every benchmark site, with the median and the best-in-set per criterion. This is the bar the build is scored against in Step 6.
**Contract**: N sites with URLs, synthesis, ranked list, scorecard table.

## Step 4b: Design plan and directions (Opus, effort low, after 3 and 4)

Needs `concept.md` and `research.md`. This is the only Opus stage; keep it at effort low and keep the output tight. Load via the Skill tool only this core set (read `awesome-frontend-skills` SKILL.md for exact names; never invent any): `ui-ux-pro-max`, `design-taste-frontend`, `anti-ai-glowup` (to lock the Aesthetic Anchor), `impeccable` shape mode, `design-system`, `ui-animation`. Animation library: default is vendored GSAP + ScrollTrigger; choose Anime.js (load `animejs`) when the direction is reveal/text/SVG-led, wants a tiny bundle, or is a simple tier, and name the library in Part B and the README. One library per site. Load others (`ui-design:*`, `gsap-scrolltrigger`, `high-end-visual-design`, `minimalist-ui`/`industrial-brutalist-ui`, `theme-factory`) only if the chosen direction needs them. No unrelated skills. If two skills disagree, the Aesthetic Anchor wins.

Produce `_research/NN-brand/design-plan.md` in two parts.

**Part A, directions**: 4 distinct options by default (3 for a simple tier, 5 for premium when the category is wide). They must differ in anchor, palette, type pairing, and signature interaction, not just colour. Each: name, one-sentence pitch, anchor, palette (hex + contrast ratios), type pairing, signature interaction, who it appeals to, risk. Then a **recommendation**: one or two directions, or an explicit mix ("A's palette and type with C's interaction"), with the reason tied to the research.

**Part B, full plan for the recommended direction**: anchor and why, palette with contrast, type pairing and scale (never Fibrous Display; each concept gets its own), spacing and grid tokens, section-by-section layout with hierarchy, signature interaction motion spec (easing, durations, reduced-motion and mobile fallbacks), image/video art direction, and an explicit "what would make this look AI-generated, and what we do instead" list.
**Contract**: Part A (3-5 options + recommendation), Part B with hex values, a motion spec, and the anti-AI list.

## Step 4c: Assets (Haiku inventory, then Sonnet low prompts)

Assets are generated by the user outside this pipeline (ChatGPT for images, Google Flow for video) or supplied as 3D models. The build never waits on them: it uses placeholders at the exact final filenames.

**4c-i, inventory (Haiku, low)**: read `design-plan.md` Part B and `concept.md`. Write `_research/NN-brand/assets.md`, a table of every asset the site needs: filename, type (image / video / 3D), where it is used, aspect ratio and pixel size, duration (video), must-have or nice-to-have, and a `3D?` flag. Flag 3D only where a real model beats a flat image or video: a hero object that rotates, tears down, or is scroll-scrubbed; anything needing consistent multi-angle views. Cap at what the design plan truly uses; no speculative extras.
**Contract**: every image/video/3D reference in the plan appears in the table exactly once, with unique filenames.

**4c-ii, prompts (Sonnet, low)**: write `_research/NN-brand/assets-prompts.md`. Start with one shared **style block** (palette in plain words, lighting, lens/camera language, grain, materials, mood, what to avoid) that is pasted at the front of every prompt so the set looks like one shoot. Then per asset: filename, target tool (ChatGPT image or Google Flow video), the prompt, an avoid-list, aspect ratio, duration, and any continuity note (same subject, same lighting as asset X). Video prompts specify camera move, start and end frame, loop or not. Prompts are self-contained: copy-paste ready, no references to the plan. Where an asset is flagged 3D, write a **3D spec** instead of a prompt: object and silhouette, units and scale, orientation and origin, poly and texture budget, format (GLB preferred), materials, the camera angles or animation the site will use, and the exact drop path `portfolio/NN-brand/assets/models/<filename>.glb`.
Why Sonnet and not Haiku here: Haiku is fine for extracting a list, but consistent, high-quality generative prompts across a whole set are a writing-craft task where a weaker model produces generic prompts, and the cost at low effort is negligible.

## Step 5: Build (user-chosen direction and model) and 5b: option heroes (on request only)

**Never build all directions.** After 4b, present the Part A directions as text (name, pitch, palette, type, signature interaction, risk) with your recommendation, and ask which one to build (or a mix) via AskUserQuestion, recommendation first. Build only that. Do not build option heroes unless the user asks to preview some.

**Ask first (model).** When 4b (and 4c) finish and before launching the build, ask the user once (AskUserQuestion, or a numbered chat question): "Which model should build the site?" Options: **Sonnet, medium effort** (cheaper, faster; fine for most sites) and **Opus, low effort** (stronger design and motion judgment; better for premium scroll-driven or teardown sites). Put your recommendation first, marked "(Recommended)", based on the plan: Opus low when the signature interaction is pinned/scrubbed/3D-driven or the tier is premium; Sonnet medium otherwise. One line of reasoning in the option description. Skip the question if the arguments include `build=sonnet` or `build=opus`. Reuse the answer for revisions in Step 8 unless the user changes it. Ask the direction and model questions together in one AskUserQuestion call.

**Build brief**: full prompt file, `concept.md`, `research.md`, `design-plan.md` Part B (these refine, never contradict, the prompt). Target `portfolio/NN-brand/`. Stack: follow `PROJECT_PROMPT.md` and `_templates/` (currently `docket-news-template`); read them first and state the stack chosen. Each site ships a README (stack, how to run, what is deliberately fake, tier). Acceptance targets (measured, not assumed):
- Lighthouse mobile: Performance >= 90, Accessibility >= 95, Best Practices >= 95, SEO >= 95. Premium sites aim for 95+ performance.
- Real-browser check at 1440 and 390; no console errors; no horizontal scroll at 390.
- Reduced-motion respected; focus states visible; contrast per the plan.
- Mobile fallback for any pinned or video hero; 60fps scrub on the signature interaction.
- Report what was verified and what was not.
Assets: reference every image/video/3D file by its `assets.md` filename; ship placeholders (a neutral gradient or poster frame at the correct aspect ratio, a primitive proxy for 3D) so the layout and Lighthouse are valid before real files land; the site must not break if a file is missing.
Before overwriting anything, back up an existing folder as `NN-brand-backup-YYYYMMDD` (removed in Step 9 once the user approves the new version).

**Option heroes (5b, only when the user asks to preview a direction)**: one Sonnet-low agent per requested direction builds a single-file one-screen hero (`portfolio/_options/NN-brand/<option-slug>/index.html`): real copy from `concept.md`, that direction's palette, type, and a lightweight version of its signature interaction. No full site; this is a proof of direction, labelled as such. Mixed recommendations use the primary option as base.

## Step 6: Gate (hard pass/fail, main thread)

Open the built site in the browser (Claude Code: `preview_start`); do NOT take screenshots here (screenshots happen only in Step 8 polish); check at 1440 and 390 via DOM, console and Lighthouse. Check: zero console errors; no horizontal scroll at 390; reduced-motion honoured; Lighthouse meets the Step 5 targets (real numbers); README present. Write `portfolio/NN-brand/REPORT.md` with the numbers.

**Benchmark score**: score the build on the same 8 criteria and 1-5 scale as the research scorecard. Pass = at or above the benchmark **median on every criterion** and at or above the best-in-set on at least two (for "as good as N sites", this is what N means). On any failure: send the build agent one revision with the specific failing criteria and fixes, re-run the gate once. If it still fails, report honestly with the scores; do not claim it met the bar.

Run `site-glow-up` audit ideas (if installed) only if the build looks templated. Do not edit the index to mark done unless the user asks.

## Step 7: Showcase and recommend (end of every run)

Show the user, in the chat, 3-5 options (the Part A directions): for each, name, one-line pitch, and the local path/URL (no screenshots; those belong to polish). Then:
- **Recommend one or two, or a mix**, with a two-sentence reason each, and say which is currently built.
- State the gate result and benchmark score, Lighthouse numbers, anything unverified, and the next unbuilt prompt in line (prompt mode).
- **Assets you need to supply**: a short checklist from `assets.md` grouped by tool, with the path to `assets-prompts.md`, which assets are must-have, and which are 3D (with the drop folder). Ask whether you will use 3D models for the flagged ones, or whether to fall back to image/video.
- End with a direct invitation: pick one, mix elements ("A's type, C's interaction"), or describe a design direction or change in your own words; also offer `polish`.
Keep it skimmable; no long prose. Wait for the user.

## Step 8: Revise and polish

**Assets landed**: when the user says files are ready, check `portfolio/NN-brand/assets/` against `assets.md`, optimize (images to WebP/AVIF at the planned sizes, videos compressed to web MP4/WebM with a poster, GLB with Draco/meshopt if large), wire them in, swap out the placeholders, and re-run the Step 6 gate. Report any missing, wrong-ratio or oversized files by name. 3D models: confirm orientation, scale and origin match the spec before building the interaction on them.

**Direction change**: when the user picks, mixes or redirects, update `design-plan.md` Part B to the new decision (note what changed), then run one revision (the user's chosen build model; Opus low for the design decision if it is a new direction) on `portfolio/NN-brand/` (backup first), re-run the Step 6 gate, and re-show with Step 7's format (before/after screenshots). Repeat until the user is satisfied. Only the build agent writes to `portfolio/NN-brand/`.

**Polish layers** (when `polish` is given, or the user asks). This is the ONLY step that takes screenshots: before/after each layer; backup first. In order, one at a time:
1. `site-glow-up` on the folder and local URL (covers `design-theory-pass`, `de-ai-design`, `hand-redraw`, `motion-pass`, `de-ai-copy`); pass `anchor=<anchor from design-plan.md>`.
2. `impeccable` critique, then polish; apply only changes that fit the anchor.
3. `design-ops:design-critique` and `visual-critique:critique-screen` on the screenshots; fix the prioritized list, skip anything contradicting the anchor.
4. `de-ai-copy` once more if layers 1-3 changed text.
5. `designer-toolkit:design-rationale` writes `portfolio/NN-brand/DESIGN-RATIONALE.md` (also the case-study material).
Finish with a before/after pair and a short list of what each layer changed. Stop and ask if a layer would change the brand, the signature interaction, or the acceptance checks.

## Step 9: Cleanup after approval (delete the scaffolding)
Copies exist to protect the user until they approve; once they do, they are clutter. Never delete anything before an explicit yes in chat for that version; ask once per site: "Happy with this version? I can delete the backups and scratch folders." On yes:
- Delete `NN-brand-backup-*`, `portfolio/_glowup-NN/` (before/after copies and screenshots; first copy the final Lighthouse numbers into `REPORT.md`), and `_options/NN-brand/` (unchosen hero proofs).
- Fold what the site still needs out of `_research/NN-brand/` into the site folder, then delete the rest: keep `assets.md` and `assets-prompts.md` (needed to generate real assets) as `portfolio/NN-brand/ASSETS.md` until the assets have landed; keep the chosen design plan as `DESIGN-RATIONALE.md`. `concept.md` (copy is now in the site), `research.md` and the rejected directions are deleted.
- List exactly what will be deleted before deleting, delete only paths inside `portfolio/` that this skill created, and report what was removed. Never touch a backup the user made themselves. If the user says not yet, leave everything and ask again after the next revision.

## Guardrails
- Studio Fibrous brand rules (Fibrous Display, navy homepage) apply to fibrous.online only; each concept gets its own identity. Do not edit `websites/fibrous-online`.
- One writer per folder: the build agent owns `portfolio/NN-brand/`; option agents write only to `_options/`; research agents write only to `_research/`.
- Fictional brands only; no real client data, no copied text or assets from benchmark sites.
- Keep sub-agent summaries to 150 words or fewer. Record rough time per stage in `REPORT.md` so the routing table can be tuned.
