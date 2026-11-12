---
name: contentfactory
description: Create, generate, inspect or edit creative media and keep its assets and project state in ContentFactory. Use for advertisements, photos, video, audio, 3D, captions, storyboards, scenes, episodes and timecode revisions, even when the user does not name the service. Not for software development, ordinary prose or general filesystem administration.
---

# ContentFactory creative workflow

Use ContentFactory as the execution and storage system for creative work. Read this shared entrypoint even when a specialist skill was selected first. Its presence in a skill catalog is not evidence that it was followed.

## Execution boundary

- Use the connected ContentFactory MCP operations for creative research/imports, generation, inspection, processing, editing, rendering, and durable creative assets/state. Do not silently substitute local FFmpeg, WinRT/MediaComposition, Python, browser editors, other generation tools, direct provider SDKs, or other services. This applies to a one-caption change or one clip removal too.
- Discover the live supported operation and contract before deciding that a feature is unavailable. A missing capability, grant, transfer transport or provider is a specific limitation to report and resolve within ContentFactory. It is not permission to build a local rendering pipeline. Follow an explicit user override when one is actually given; disclose the changed execution path before using it.
- Local instruction files, skill maintenance and user-requested reports are permitted. User-authorized transfer of an exact file through ContentFactory's documented client transfer transport, or viewing a returned artifact, is permitted. These exceptions do not authorize local media processing, an alternate asset store or a hidden HTTP upload helper. See [execution](references/execution.md) for transfer and recovery details.
- Respect existing project grants, spending ceilings and privacy restrictions. Authorization to edit a local file is not automatically authorization to upload it or send its pixels/audio to an external model. Reuse an existing explicit authorization for its exact scope; ask only for missing authorization. Do not copy private media, transcripts, credentials or raw messages into logs, memories or issue trackers.

## Route only the work needed now

Load the relevant specialist; do not load all seven for a small revision.

| Requested work | Specialist |
| --- | --- |
| Locate/select a project, import/upload/download, organize media or asset relations | [assets](../contentfactory-assets/SKILL.md) |
| Research external creative sources; collect Telegram channels, groups or forums | [research](../contentfactory-research/SKILL.md) |
| Generate/edit with a model; synthesize speech, music or sound | [generate](../contentfactory-generate/SKILL.md) |
| Edit a timeline, scene/episode, caption, transition or audio mix; render/handoff | [composition](../contentfactory-composition/SKILL.md) |
| Probe/process media, transcribe/analyze, inspect exact frames or audio | [media](../contentfactory-media/SKILL.md) |
| Deterministic photo corrections, masks or layered photo documents | [photo](../contentfactory-photo/SKILL.md) |
| Author/simulate/render 3D scenes | [3D](../contentfactory-3d/SKILL.md) |

For a new advertisement or substantial creative rewrite, read [advertising](references/advertising.md) before choosing shots. For a timecode/scene revision, read [small edits](references/small-edits.md). Ordinary low-impact edits do not need a new research campaign, storyboard approval or full paid review.

For Grok Build requests involving video on the user's PC, read [Grok local-video intake](references/grok.md). It defines the user-authorized native intake/review path and the subsequent ContentFactory transfer.

## Begin and resume with owned state

Recover the selected project and existing creative task/composition before creating replacements. Keep the brief, shot purpose, source pins, episode/scene IDs, accepted choices, revisions, operation/job receipts and review limits in ContentFactory (`creative_task_save/get`, discovered live). Local filenames and version numbers are not the authoritative timeline. A rendered MP4 does not by itself provide editable layer IDs. If only a flattened local video exists, state that migration/reconstruction is needed rather than implying it is already editable server-side.

Before a mutation, establish which project, saved revision, target interval/layer and live operation will carry it. For generation, confirm the source/model controls and authorized price. For rendering, discover the supported profile/worker capabilities; do not claim a particular heavy worker ran unless the receipt proves it. Read [execution](references/execution.md) when submitting, transferring or recovering work.

## Review proportionately and deliver evidence

Challenge the choice at planning, after the changed interval, and before delivery: does this fulfill the user's actual request; why is this shot here; what evidence would disprove the quality claim? Resolve concrete defects, not hypothetical ones. Preserve earlier accepted corrections.

Use native validation first, then a small set of relevant artifact frames/intervals. A still does not prove motion or lip sync; an audio hash does not prove intelligibility. Check decoded timestamp/PTS rather than assuming a seek plus playback lands at the requested frame. Do not re-run paid full-video analysis for an unchanged soundtrack or a small caption edit. Use paid review only within existing authorization and when it answers an unresolved question. Offer the rendered result for the user's visual judgment without calling it creatively accepted.

Save final revision, job and output IDs plus concise review coverage server-side. Deliver the actual authorized artifact and editable composition reference, with what changed, verified limitations, and settled cost when known. Do not report a queued job as a finished render or local output as a ContentFactory result.
