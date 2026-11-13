---
name: contentfactory-video
description: Create and edit photos, videos, effects, vector artwork, audio and 3D scenes with ContentFactory. Use for photo corrections and masks, video timelines and captions, Blender animation, Telegram channel/group/forum source collection, editable project handoffs, and complete agent-made videos through ContentFactory MCP. Not for application development or general web research.
---

# ContentFactory Creative Work (compatibility entrypoint)

For a current installation, start with the installed `contentfactory` skill
and its domain specialists. This legacy standalone folder remains usable by the
older connector; if the sibling entrypoint is absent, use the boundary below
and this folder's references. Prefer the versioned installer for the full current
advertising and timecode-edit workflow. Do not silently switch to local media
tools because either installation is incomplete.

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

Use the configured ContentFactory connection, using trusted endpoint metadata
when exposed. The service endpoint is `https://content-factory.art/mcp` and its
Media, Generate and Compose surfaces share projects and assets. Do not expose
credentials, substitute an unrelated server with a similar name, or infer a
different backend solely from opaque client labels.

Use the client's normal mechanism to load this skill and its bundled references.
All task operations, including search, import, generation, analysis, editing,
rendering, reads, writes and durable task recovery, must use that verified
ContentFactory connection. Viewing image/audio/resource blocks returned by those
tools in the conversation does not authorize another tool or network request.

Do not call other MCP servers, web/search/image/video tools, browser automation,
shell media scripts, direct HTTP APIs or external model/provider SDKs for
creative execution. Independent research/review may be delegated within the
same boundary; one agent owns mutable composition/task state. Local instruction
and skill maintenance or requested reports are allowed. Do not run the repository's connector from this
skill. The user runs setup separately. If a required operation is unavailable,
report the limitation and continue only work supported by ContentFactory.
Never substitute a similarly named tool from another server or local processing.

Local paths are not asset IDs. Honor the user's privacy policy and exact upload
authorization. Discover ContentFactory's upload capability and use its documented
MCP client file-transfer transport when available; a prepared ticket is not a
completed asset. If that transport is missing, explain the limitation and use
the ContentFactory upload UI/user path. Do not execute a network upload helper,
forward OAuth headers, or put media bytes in MCP JSON. Deliver ContentFactory artifact links and native
resource blocks; do not claim that issuing a download ticket saved a file.

## Workflow

The default orchestrator owns the complete production and coordinates these
roles in order: **screenwriter first, director second, execution specialists
afterward**. For a new video/ad/film or substantial creative recut, use the
installed `contentfactory` orchestrator, `contentfactory-screenwriter` and
`contentfactory-director` when present. Reuse their saved handoffs when resuming.
If only this compatibility folder is installed, perform the same roles in
sequence here: the screenwriter establishes meaning, audience response, story
beats and general scenes; the director turns those scenes into filming choices,
visible action, performance, camera, sound and acquisition tasks. Keep the roles
distinct even when one agent performs both. A narrow correction or standalone
photo/audio/3D request does not require a new screenplay or production campaign.

Before generated video, the director prepares/selects and inspects actual owned
reference frames, then presents a rough storyboard and proposed object/character
placement to the user for explicit approval. Show viewable frames and concrete
scene order, approximate timing, action, camera and spatial layout; prompts alone
are not reference frames. Wait for that package's approval before video jobs,
paid motion tests or newly authored 3D/2D animation rendering. Authorized research
and preparatory reference stills can proceed first. Reuse explicit approval of
the identical reviewed version; material changes need approval of the affected
beat. A general budget or silence is not approval of unseen scenes. Narrow edits
without new generated footage do not restart this gate.

Prefer Seedance 2.5 when live model discovery exposes a configured, compatible,
priced route supporting the approved reference conditioning and budget. Discover
the actual model/provider and current model contract; a familiar name is not
proof of image-input support. Explain necessary alternatives rather than silently
switching models or generating text-only video without the approved references.

For moving-picture work, purposeful movement is the default. Do not assemble
static pictures with text and narration as the normal production strategy.
Static holds need a specific creative reason; a predominantly static treatment
requires an explicit user request or agreed exception. Existing authentic
footage is suitable. Where only still sources exist and illustration is
appropriate, animate them with a compatible discovered video model. If models
are unavailable, unsuitable or fail within the authorized attempt/budget limit,
use supported authored 3D/2D animation through ContentFactory, including drawing
or object action where available. Pan/zoom, moving flat picture planes, title
animation and transitions alone do not fulfill that fallback. Recover uncertain
paid receipts before changing routes; report unavailable animation instead of
silently falling back to a slideshow. Never use generated movement as proof of
real product behavior, an event or customer work.

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
  collect Telegram channel/group/forum history, import supported URLs, establish
  the brief and write a timed scene plan.
- [Visuals and review](references/visuals.md): inspected reference frames before
  video generation, supported conditioning, continuity checks and the mandatory
  final Gemini quality audit.
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

For advertisements, recover the goal/CTA and verified source context, then
keep a timed shot rationale: what each moving scene shows and changes, what its text/voice means,
and its provenance/quality. Let opening actions complete before cutting, preserve
full spoken clauses, keep captions stable and away from mouths, and avoid
repeated or meaningless still inserts. For a timecode correction, resolve the
whole clip interval, choose fill versus ripple, and inspect the changed interval
and joins. Keep editing narrow, then perform the final Gemini audit even after
a tiny edit. Prefer the current
entrypoint's advertising and small-edits references when installed.

Every final video requires a completed Gemini quality audit through ContentFactory.
Send the whole exact final video when its duration is at most three minutes
(180 seconds); for longer videos send continuous ordered sections covering the
complete timeline with boundary context. Read the actual completed report,
timed findings and visual/audio coverage, fix material defects and audit the new
final artifact. See [visuals](references/visuals.md) for the standalone procedure.
Frames, transcripts and successful exports do not replace this audit.

Act within the user's existing creative, privacy and spending authorization.
Paid review still needs an authorized budget; if the required Gemini audit is
blocked, report it incomplete with the exact prerequisite instead of skipping it
or calling the video finished. Deliver the actual rendered artifact with material remaining
limitations, review coverage and cost, distinguishing completion from admission.
