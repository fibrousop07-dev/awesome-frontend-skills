# Open Design workflow adoption

This package is an independent Weave implementation informed by inspection of Open Design 0.15.0 installed at `F:/Softwares/Open Design` (bundled web/host packages 0.14.2).

Upstream: https://github.com/nexu-io/open-design (Apache-2.0).

Inspected references: `craft/README.md`, `craft/anti-ai-slop.md`, `craft/typography.md`, `plugins/_official/scenarios/od-new-generation/SKILL.md`, `plugins/_official/atoms/critique-theater/SKILL.md`, and `plugins/_official/atoms/diff-review/SKILL.md` under `resources/open-design`.

Adopted concepts: opt-in craft loading, brand-system separation, artifact-first iteration, state coverage, bounded critique/fix cycles, and honest evidence. The original Go code and concise reference text here were authored for Weave; no Open Design source code, templates, illustrations or craft prose were copied. Its documentation attributes portions of its craft material to Refero Design's refero_skill (MIT); that material was not vendored here.

Deliberate differences: no mandatory todo stage, no fixed visual style, no color blacklist, no auto-generated claim of human approval, and no visual pass inferred solely from a model's numeric score. Maximum four unique craft sections per skill invocation; unknown names are reported.
