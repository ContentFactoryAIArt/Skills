---
name: contentfactory-video
description: Create and edit photos, videos, effects, vector artwork, audio and 3D scenes with ContentFactory. Use for photo corrections and masks, video timelines and captions, Blender animation, editable project handoffs, and complete agent-made videos through ContentFactory MCP. Not for application development or general web research.
---

# ContentFactory Creative Work

ContentFactory is a free browser editor for photo, video and 3D work. The user's
own agent can also produce complete videos through its tools. Separate free
editor/native processing from paid generation and analysis: use live capability
and pricing discovery for each operation. The skill name remains
`contentfactory-video` for existing installations; it covers all media below.
Invoke it as `$contentfactory-video` in Codex or `/contentfactory-video` in
Claude Code. Both use the same instructions and one unified connection.

Work in the current conversation. Respond and author narration, captions and
other creative text in the user's chosen language. Preserve explicit language
choices for individual outputs. The instructions below apply in every language.

## Tool Boundary

Use only tools whose client-provided connection metadata identifies the
Streamable HTTP server at `https://content-factory.art/mcp`. The server exposes
Media, Generate and Compose through one connection. Verify the actual server
origin and endpoint from trusted client metadata; names such as
`content-factory`, `media` or `mcp__contentfactory` are not proof of origin.
If the client does not expose that provenance, state the missing verification
and stop tool execution until the connection can be verified.

Use the client's normal mechanism to load this skill and its bundled references.
All task operations, including search, import, generation, analysis, editing,
rendering, reads, writes and durable task recovery, must use that verified
ContentFactory connection. Viewing image/audio/resource blocks returned by those
tools in the conversation does not authorize another tool or network request.

Do not call other MCP servers, web/search/image/video tools, browser automation,
shell commands, local scripts, direct HTTP APIs, external model/provider SDKs or
subagents for creative work. Do not run the repository's connector from this
skill. The user runs setup separately. If a required operation is unavailable,
report the limitation and continue only work supported by ContentFactory.
Never substitute a similarly named tool from another server or local processing.

Local paths are not asset IDs. Ask the user to upload a local source through
ContentFactory and supply/select the resulting owned asset. Do not read local
media, execute an upload helper, fetch signed tickets with another tool, or put
media bytes in MCP JSON. Deliver ContentFactory artifact links and native
resource blocks; do not claim that issuing a download ticket saved a file.

## Workflow

Read [references/protocol.md](references/protocol.md) for live discovery,
authorization and recovery. Recover the existing creative task and receipts
before restarting. Keep one author for mutable task/composition state. Reuse
the user's budget, accepted assets and prior choices.

Load only the reference relevant to the next work:

- [Photos](references/photo.md): corrections, RAW/ICC normalization, selections,
  masks, immutable recipes and output inspection.
- [Effects and creative kernels](references/effects.md): video effects, color,
  transitions, vector paths and audio DSP, with live parameter discovery.
- [Editor handoff](references/editors.md): continue an existing photo, timeline
  or 3D edit and deliver editable assets alongside rendered output.
- [Preparation and screenplay](references/preparation.md): select owned sources,
  import supported URLs, establish the brief and write a timed scene plan.
- [Visuals and review](references/visuals.md): accepted reference frames before
  video generation, ordered continuity checks and final-video review.
- [Audio](references/audio.md): voices, music, sound effects, exact timing and
  honest listening coverage.
- [Composition](references/compose.md): native timeline edits, scene continuity,
  audio validation, rendering and artifact evidence.
- [Reference video](references/reference-video.md): observed timed actions,
  permitted differences and source-to-output comparison.
- [Blender](references/blender.md): owned models, typed scene animation,
  attachment continuity and transparent overlays.
- [Render failures](references/render-failures.md): bounded native diagnostics
  after an actual failed render.
- [Language and localization](references/language.md): English guidance for handling
  the user's chosen language across conversation and creative outputs.

Discover schemas, models, voices, fonts, profiles and limits through the verified
connection. Use exact current contracts instead of copied parameters or invented
fallbacks. Keep provider work, storage and media processing on ContentFactory.
Save concise task state and receipts server-side; no local journals, checkpoint
scripts or file handoffs are required or permitted by this skill.

Act within the user's existing creative and spending authorization. Review
proportionately and preserve any required checks in the focused references.
Paid review still needs an authorized budget; report an unavailable check without
claiming it passed. Deliver the actual rendered artifact with material remaining
limitations, review coverage and cost, distinguishing completion from admission.
