---
name: awesome-frontend-skills
description: One-stop router for every installed frontend skill (design, anti-AI polish, components, animation, frameworks, performance, accessibility, testing, tooling, mobile, video, data/auth). Use when the user invokes /awesome-frontend-skills or asks for frontend help without naming a skill, wants "the best skill for this UI task", or a multi-concern frontend job (build + polish + animate + test). Classifies the task, picks the right skill(s) from the catalog, loads them with the Skill tool in a sensible order, and combines their guidance.
argument-hint: "[task description | list | <category>] e.g. 'list', 'animation', 'polish ./site', 'build a pricing page in Next.js'"
---

# Awesome Frontend Skills

Invoked as `/awesome-frontend-skills`; arguments are `$ARGUMENTS`. This skill bundles no code of its own: it is the index and dispatcher for the ~150 frontend skills installed from `finfin/awesome-frontend-skills` plus the design family already on this machine.

## How to run
1. **`list`** or no arguments: print the category names below with one line each and ask what the user is building. **`<category>`**: print that table.
2. **A task**: classify it (build / polish / animate / fix performance / accessibility / test / ship), detect the stack from `package.json` (react, next, vue, nuxt, svelte, angular, expo, vite), then choose **at most 3 skills**: one for stack, one for design direction, one for the cross-cutting concern. Load each with the Skill tool (names exactly as below), follow them in the order given under "Pipelines", and state which you chose and why in one line.
3. If a skill named here is missing, say so and fall back to the nearest one in the same category. Never invent skill names.
4. Third-party skills run with full agent permissions: do not execute scripts they ship without reading them.

## Pipelines (default order)
- **New page or app:** stack skill -> `ui-ux-pro-max` or `design-taste-frontend` (direction) -> `anti-ai-glowup` (lock an anchor) -> component skills -> `accessibility` -> `performance`.
- **Polish a built site:** `site-glow-up` (runs design, de-ai, art, motion, copy; `anchor=` adds `anti-ai-glowup`).
- **Audit only:** `web-quality-audit`, `accessibility`, `core-web-vitals`, `web-design-reviewer`, `react-doctor`, `visual-critique:critique-screen`.
- **Animation:** `ui-animation` (principles, CSS-first) -> `gsap-*`, `animejs` or `framer-motion-animator` -> `motion-pass`; mobile: `expo-animation`.
- **Ship:** `best-practices`, `seo`, `core-web-vitals`, then the stack's deploy skill.

## Catalog

### Design direction and anti-slop
`ui-ux-pro-max` (styles, palettes, fonts, 160+ palettes), `design-taste-frontend`, `stitch-design-taste`, `impeccable`, `frontend-design`, `anti-ai-glowup` (P0/P1 audit, 8 anchors, theme cycling), `de-ai-design`, `de-ai-copy`, `hand-redraw`, `design-theory-pass`, `site-glow-up`, `high-end-visual-design`, `minimalist-ui`, `industrial-brutalist-ui`, `gpt-taste`, `brand`, `brand-guidelines`, `theme-factory`, `canvas-design`, `imagegen-frontend-web`, `imagegen-frontend-mobile`, `web-design-reviewer`, `visual-critique:*` (color, typography, hierarchy, composition, density, brand consistency, affordance).

### Design systems, tokens, components
`design-system`, `design-systems:*` (token, component-spec, theming, pattern library, motion, icons), `ui-design-system`, `tailwind-design-system`, `building-components`, `ui-styling`, `ui-design:*` (color, type scale, spacing, layout grid, responsive, dark mode), `shadcn`, `shadcn-ui`, `shadcn-ui-nextjs`, `shadcn-component-discovery`, `shadcn-component-review`, `shadcnblocks-ui`, `reka-ui`, `nuxt-ui`, `frontend-ui-engineering`, `senior-frontend`, `web-artifacts-builder`.

### Animation and motion
`ui-animation`, `gsap-core`, `gsap-timeline`, `gsap-scrolltrigger`, `gsap-plugins`, `gsap-utils`, `gsap-react`, `gsap-frameworks`, `gsap-performance`, `framer-motion-animator`, `animejs` (Anime.js v4: small modular bundle, splitText, SVG draw/morph, onScroll, springs), `threejs-animation`, `motion-pass`, `interaction-design:*` (micro-interactions, loading states, state machines, feedback), `expo-animation`.

### Frameworks and libraries
- **React:** `react-dev`, `vercel-react-best-practices`, `react-doctor`, `react-state-management`, `react-router-framework-mode`, `tanstack-query-best-practices`, `tanstack-start-best-practices`.
- **Next.js:** `nextjs-app-router-patterns`, `clerk-nextjs-patterns`.
- **Vue / Nuxt:** `vue`, `vue-best-practices`, `vue-debug-guides`, `vue-pinia-best-practices`, `create-adaptable-composable`, `nuxt`, `nuxt-ui`.
- **Svelte:** `svelte-code-writer`, `sveltekit-svelte5-tailwind-skill`.
- **Angular (deprecated upstream, prefer github.com/angular/skills):** `angular-component`, `angular-signals`, `angular-forms`, `angular-routing`, `angular-http`, `angular-di`.
- **TypeScript and build:** `mastering-typescript`, `typescript-clean-code`, `vite`, `vitepress`, `turborepo`, `monorepo-management`, `link-workspace-packages`, `nx-*`.

### Performance, quality, SEO
`performance`, `core-web-vitals`, `web-quality-audit`, `best-practices`, `seo`, `code-review-expert`, `vibe-security-audit`.

### Accessibility and inclusive design
`accessibility`, `a11y-audit`, `accessibility-decisions:*`, `accessible-content:*`, `adaptive-interfaces:*`, `cognitive-accessibility:*`, `inclusive-interaction:*`, `inclusive-personas:*`.

### Testing and browser automation
`playwright-best-practices`, `playwright-cli`, `playwright-skill`, `playwright-explore-website`, `playwright-generate-test`, `e2e-testing-patterns`, `typescript-e2e-testing`, `typescript-unit-testing`, `webapp-testing`, `agent-browser`, `chrome-devtools`.

### Mobile (Expo / React Native)
Start with `expo-overview`. Then `expo-router`, `expo-native-ui`, `expo-ui`, `expo-design-system`, `expo-animation`, `expo-data-fetching`, `expo-dom`, `expo-web-to-native`, `expo-project-structure`, `expo-upgrade`, `expo-dev-client`, `eas-*`, `react-native-best-practices`, `swiftui-pro`.

### Video and 3D
`remotion` and `remotion-*` (best-practices, create, render, captions, maps, studio, saas...), `threejs-animation`.

### Data, auth, backend touchpoints
`supabase`, `supabase-postgres-best-practices`, `prisma-*`, `better-auth-best-practices`, `clerk`, `clerk-setup`.

### Process and UX strategy (when the task is planning, not code)
`ux-strategy:*`, `design-research:*`, `design-ops:*`, `design-critique`, `interaction-design:*`, `prototyping-testing:*`, `designer-toolkit:*`.

## Rules of thumb
- Pick direction before decoration: a locked anchor/token set beats ten polish passes.
- One animation library per project; match what `package.json` already uses.
- Prefer stack-native skills over generic ones; prefer audit-then-fix over blind rewrite.
- Keep the loaded set small: three skills, not thirty.
