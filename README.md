# claude-skills-bootstrap

Reinstall a known-good Claude Code skill set on any new machine or session, without bundling anyone else's code.

## Why this exists, and why it's a script instead of a bundle

Each skill here was originally installed via `npx skills add <repo>` from its own author's GitHub repository. Copy-pasting all of that code into one new repo would mean redistributing other people's work under licenses I haven't individually verified — not something to do casually across ~15 separate third-party repos.

This script does the honest equivalent instead: it re-runs the same install commands against the same original sources. You get:
- Each author's current version (not a stale copy)
- Whatever license terms they actually chose to publish under
- The exact same end result — a populated `~/.claude/skills/.agents/skills/` — without anyone's code passing through a repo they didn't publish it to

## Usage

**macOS/Linux/Git Bash:**
```bash
bash install.sh
```

**Windows PowerShell:**
```powershell
powershell -File install.ps1
```

Either script loops through the source list and runs `npx skills add <repo>` for each one. A failure on any single repo (renamed, deleted, network issue) is logged and skipped — the rest still install.

## What's included

| Skill source | What it adds |
|---|---|
| anthropics/skills | Anthropic's official skill collection (frontend-design, docx/pdf/pptx/xlsx, canvas-design, etc.) |
| nextlevelbuilder/ui-ux-pro-max-skill | UI/UX design intelligence (styles, palettes, font pairings) |
| leonxlnx/taste-skill | Design taste variants — minimalist, brutalist, premium |
| greensock/gsap-skills | Official GSAP animation skills (core, react, scrolltrigger, etc.) |
| shadcn-ui/ui | shadcn component management |
| hamen/material-3-skill | Material Design 3 (Jetpack Compose, Flutter, web) |
| alirezarezvani/claude-skills | Large general-purpose skill collection (300+) |
| twostraws/swiftui-agent-skill | SwiftUI best-practices review |
| felipechaux/kmp-compose-multiplatform-skill | Kotlin Multiplatform + Compose |
| rebelytics/one-skill-to-rule-them-all | Task-pattern observation |
| vercel-labs/skills | Skill discovery helper |
| obra/superpowers | TDD, git worktrees, code review workflows |
| pbakaus/impeccable | Frontend design critique/polish |
| Graphify-Labs/graphify | Codebase-to-knowledge-graph |
| DietrichGebert/ponytail | Code audit, technical debt, review |
| fibrousop07-dev/lazy-skills | Progressive skill-loading orchestrator ([repo](https://github.com/fibrousop07-dev/lazy-skills)) |

## Important limitation

Running this script gets you the **same skills**, not the **same dependency graph**. If you're also using `lazy-skills`, its `references/skill_map.json` may still reference skill names that don't match what ends up installed here (naming drift is exactly the kind of thing that happens across environments) — check `lazy-skills`' own README for the reasoning and how to adapt it.

## License

MIT for the scripts and text in this repo. Each installed skill remains under whatever license its own author published it under — check each source repo individually if that matters for your use case.
