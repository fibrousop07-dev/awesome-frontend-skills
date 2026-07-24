#!/usr/bin/env bash
# claude-skills-bootstrap
#
# Reinstalls a known-good set of Claude Code skills on a new machine or
# session by pulling each one directly from its original author's repo.
# This intentionally does NOT bundle anyone else's skill code — it just
# re-runs the same `npx skills add <repo>` install commands so you get
# each author's current version, not a stale mirror.
#
# Usage: bash install.sh

set -e

repos=(
  "https://github.com/anthropics/skills"
  "https://github.com/nextlevelbuilder/ui-ux-pro-max-skill"
  "https://github.com/leonxlnx/taste-skill"
  "https://github.com/greensock/gsap-skills"
  "https://github.com/shadcn-ui/ui"
  "https://github.com/hamen/material-3-skill"
  "https://github.com/alirezarezvani/claude-skills"
  "https://github.com/twostraws/swiftui-agent-skill"
  "https://github.com/felipechaux/kmp-compose-multiplatform-skill"
  "https://github.com/rebelytics/one-skill-to-rule-them-all"
  "https://github.com/vercel-labs/skills"
  "https://github.com/obra/superpowers"
  "https://github.com/pbakaus/impeccable"
  "https://github.com/Graphify-Labs/graphify"
  "https://github.com/DietrichGebert/ponytail"
  "https://github.com/fibrousop07-dev/lazy-skills"
)

echo "Installing ${#repos[@]} skill sources..."
for repo in "${repos[@]}"; do
  echo
  echo "=== $repo ==="
  npx skills add "$repo" || echo "!! Failed: $repo (continuing with the rest)"
done

echo
echo "Done. Run 'ls ~/.claude/skills/.agents/skills/' to see everything installed."
