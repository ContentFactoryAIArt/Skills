# Install and use the director across agents

Compatibility checked against official documentation on 2026-11-13. The creative
core is the same `SKILL.md` and references for every host. Adapt discovery,
context delivery and available tools; keep staging, production and review
standards intact. Source details and documentation discrepancies are recorded in
[agent research](research-agents.md).

## Install the complete folder safely

The source is `skills/contentfactory-director` in
https://github.com/ContentFactoryAIArt/Skills . It belongs to the versioned
ContentFactory skill bundle, including its manifest and installer.

For a published release, use that repository's installer with the intended
agent (`codex`, `claude`, `grok` or `opencode`). The installer fetches the published
bundle even when launched from a local checkout; it does not install unpublished
working-tree changes. Verify the installed manifest and skill source afterward.

For a manual or unpublished installation, copy the **whole
`contentfactory-director` folder** into one chosen skill root below and install
the referenced ContentFactory sibling skills from the same bundle. Keep
`SKILL.md`, `references/` and any supplied metadata together; copying only the
entrypoint breaks progressive disclosure. Preserve local edits and do not mark a
manually copied subset as a complete managed-bundle update.

| Host | Project installation | Personal installation | Explicit use |
| --- | --- | --- | --- |
| Codex | `.agents/skills/contentfactory-director/` | `~/.agents/skills/contentfactory-director/` | `$contentfactory-director` |
| Claude Code | `.claude/skills/contentfactory-director/` | `~/.claude/skills/contentfactory-director/` | `/contentfactory-director` |
| Grok Build | `.grok/skills/contentfactory-director/` | `~/.grok/skills/contentfactory-director/` | `/contentfactory-director` |
| Gemini CLI | `.gemini/skills/contentfactory-director/` | `~/.gemini/skills/contentfactory-director/` | Ask to use the named skill; the host activates it |
| OpenCode | `.opencode/skills/contentfactory-director/` | `~/.config/opencode/skills/contentfactory-director/` | Ask to load the skill with ID `contentfactory-director` |

Project paths are relative to the intended project root. `~` denotes the current
user's home directory (the user profile on Windows). Choose one scope per
host. Before copying, check whether the target already exists; compare it and
preserve local edits instead of overwriting blindly. Shared `.agents/skills`
compatibility can expose a personal installation to several hosts, so check for
duplicate names before also making vendor-specific copies.

Open the host's skill selector/list in the intended workspace and verify the
loaded source. Restart the session if the new skill does not appear. In Grok
Build, `/skills` lists extensions and the documented `grok inspect` command can
show sources; run CLI checks only in an environment permitted by local policy.

Native discovery and invocation in Codex CLI, Claude Code and Grok Build were
**not exercised in this session**. Behavioral dry-runs and package checks are
separate evidence. Installing files does not configure ContentFactory access,
prove a particular model's behavior, or validate a rendered film.

## Codex with a GPT model

Use normal skill selection or `$contentfactory-director`. The short description
supports automatic discovery; references load only when needed. Optional OpenAI
UI metadata does not replace the portable frontmatter. Keep the user's selected
model unless changing it is authorized and supported by the host.

Example production prompt:

```text
$contentfactory-director Create the 30-second exhibition invitation in the
selected ContentFactory project. Use the confirmed brief and my existing spend
limit. Develop the encounter and concrete staging, inspect available material,
then source or generate missing shots within that authorization. Assemble and
revise the cut. Record the exact export and what you actually watched/listened to.
Ask only for a prerequisite that blocks a correct or authorized action.
```

For a GPT model receiving only text, provide the brief and shot plan for planning;
do not ask it to certify image or sound quality. When image inspection is exposed,
attach labeled frames for visual review. Continuous motion and audio still require
an actual supported inspection path, not a model-family assumption.

## Claude Code with a Claude model

Use the native folder and `/contentfactory-director`. Keep `name` and `description`
portable. Do not add `allowed-tools`, `context: fork`, model overrides or shell
substitutions merely to use this skill. Read references relative to the installed
folder. Claude Code's local, cloud and Cowork skill availability differs; verify
the surface rather than assuming a local copy is account-wide.

Example creative-recut prompt:

```text
/contentfactory-director Rework the selected 20-second ad: repeated presenter
shots make it feel static. Recover accepted choices and inspect the source
material before diagnosing it. Produce an action-led beat plan, acquire missing
coverage through the authorized ContentFactory paths, then make the recut.
Preserve complete purposeful actions. Report concrete repairs and review limits.
```

Claude model capability must be checked in the active host. An image returned by a
tool can support a framing critique; a transcript supports speech-content review.
Neither establishes that the model watched motion or heard the mix. For delegated
review, pass the relevant raw artifacts and constraints rather than only the
author's positive summary.

## Grok Build with a Grok model

Grok Build has native `SKILL.md` support; it is not necessary to pretend a chat
prompt is a native installation. Use the `.grok/skills` path and slash invocation.
Its official web documentation and repository guide disagree about some optional
fields, including model/effort behavior. This package therefore uses the common
`name` and `description` fields. Preserve host permissions; skill frontmatter is
not a dependable permission enforcement mechanism.

Example staging prompt:

```text
/contentfactory-director Produce the approved fictional music-led spot using
the selected ContentFactory project and authorized budget. Design the performer's
action, spatial progression and visual motif around the actual music. Test the
hardest essential movement early, create missing illustrative material, then
assemble and review the result. Use current tool/model contracts and real receipts.
Do not infer a successful generation or listening pass from an intention.
```

Grok web/X search, Grok Imagine generation and ContentFactory operations are
different capabilities. Discover which are actually connected. Generation support
does not prove inspection support, and a public search result does not establish
commercial reuse permission. Keep the selected production system unless the user
authorizes a change.

## Grok chat or an API-hosted agent

These are distinct surfaces from Grok Build. Supply the complete core `SKILL.md`
as workflow instructions, plus the relevant references: `formulas.md` for form,
`production.md` for creation/acquisition, and `review.md` for critique. Attach or
inject their **contents**; a filename or local path alone is not accessible
context. For long tasks, retain the current brief, decisions, artifact identities
and unresolved work between calls. Do not reload every research dossier by default.

Use this initial instruction with the attached material:

```text
Use the attached contentfactory-director instructions and selected references
for this request. First distinguish creation, planning-only and narrow editing.
The capability packet below describes the tools actually exposed in this session.
Execute authorized production through those tools; if a required tool is absent,
complete the usable plan and identify the exact unavailable execution step.
Never invent calls, assets, prices, receipts or review coverage.
```

Include a small capability packet. This is **context for the model**, not an API
request schema or additional ContentFactory fields:

```text
Request and deliverable:
Project and current revision, if verified:
Selected host/model, as actually configured:
Available tools and their actual names:
Supported inputs: text / images / continuous video / audio (verified individually)
Operation discovery and current schemas: attached tool definitions/results
Authorized actions and spending ceiling:
Existing assets, provenance, accepted choices and unresolved receipts:
Review evidence already available, with artifact identity and covered ranges:
Unavailable capabilities:
```

With the xAI API, the host must register tool definitions and execute function
requests, or configure an actual supported remote MCP connection. Return typed
success/error results and durable operation identities to the model. Keep
credentials in the host's secure connection mechanism, never in the packet or
skill text. xAI's current remote MCP documentation says `require_approval` and
`connector_id` are unsupported; do not assume an OpenAI configuration enforces
authorization here. Enforce allowed operations and spend at the executing boundary.

On uncertain execution, provide the recovered receipt before allowing a retry.
If only chat is available, produce the directing plan, sourcing queries,
generation briefs and review questions; label all unexecuted actions. Do not
claim that attaching this skill installed ContentFactory or generated a film.

## Gemini CLI and OpenCode

Gemini CLI supports `.agents/skills` aliases as well as its native roots and uses
`activate_skill` with its own activation consent. OpenCode supports native and
compatibility roots and loads a skill by ID. Respect those host mechanisms without
adding approval pauses to routine work already authorized by the user.

```text
Use contentfactory-director for this production. Load its production reference
and the form relevant to my brief. Use the current connected ContentFactory
capabilities to close material gaps, then assemble and inspect the result.
Preserve the configured model and report unsupported review modalities.
```

A Gemini model behind another harness, or a GPT/Claude/Grok model behind OpenCode,
uses that **harness's** discovery and tool contract. The model name alone does
not determine installation paths, filesystem access or media support.

## Choose the review packet by the actual capability

| Input path available | Provide | Ask for |
| --- | --- | --- |
| Text only | Brief, verified facts, constraints, beat/shot cards, inventory and gap ledger | Causality, specificity, staging feasibility, acquisition decisions; no observed-media verdict |
| Images | Above plus labeled storyboard/frames, source timecodes and intended continuity | Framing, appearance, readable text and visible mismatches at those samples |
| Continuous video | Exact accessible export/revision, intended experience and relevant source comparisons | Observed action, joins, timing and continuity; record ranges and method |
| Audio | Exact accessible mix/music/dialogue and relevant timing context | Audible delivery, masking, transitions and musical development; distinguish listening from transcript analysis |

Combine available packets for the final review. Do not infer missing modalities.
Use a capable reasoning model for treatment selection and conflicting constraints;
delegate bounded inventory or formatting only when its output can be checked.
This is task allocation, not a measured ranking of GPT, Claude, Grok or Gemini.
Keep the same output standards and test realistic cases on the actual selected
host/model before claiming compatibility beyond documented packaging.

Official references: https://learn.chatgpt.com/docs/build-skills ;
https://code.claude.com/docs/en/skills ;
https://docs.x.ai/build/features/skills-plugins-marketplaces ;
https://docs.x.ai/developers/tools/function-calling ;
https://docs.x.ai/developers/tools/remote-mcp ;
https://geminicli.com/docs/cli/skills/ ; https://opencode.ai/docs/skills .
