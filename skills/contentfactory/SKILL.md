---
name: contentfactory
description: Orchestrate creative media in ContentFactory, with screenwriter then director for new videos, advertisements, films and substantial creative recuts. Also route photos, audio, 3D, captions and timecode edits and retain project state. Not for software development, ordinary prose or general filesystem administration.
---

# ContentFactory default creative orchestrator

Use ContentFactory as the execution and storage system for creative work. Read this shared entrypoint even when a specialist skill was selected first. Its presence in a skill catalog is not evidence that it was followed.

## Lead the roles in order

This is the default orchestrator above the screenwriter, director and execution specialists. It retains the user's goal, project state, authorization and budget, coordinates handoffs, and carries the requested work through delivery. Selecting a child skill directly does not bypass this workflow.

For a new video, advertisement or film, or a substantial creative recut, use this sequence:

1. **Screenwriter first:** read [screenwriter](../contentfactory-screenwriter/SKILL.md). Establish the meaning, audience experience, narrative progression and general scenes: what happens, why it matters, and what changes. Recover an existing accepted script instead of rewriting it unnecessarily.
2. **Director second:** pass that script to [director](../contentfactory-director/SKILL.md). The director owns filming: performance, blocking, subject/scene action, camera, light, sound, shot timing and the acquisition/animation plan. For generated scenes, prepare and inspect actual reference frames, then a rough storyboard and proposed object placement, and obtain the user's approval of that concrete package before video generation. If feasibility changes a scene's meaning, return that scene to the screenwriter before filming its replacement.
3. **Production specialists next:** give research, assets, generation, 3D/2D animation, composition and media inspection the director's concrete tasks. Obtain missing motion, assemble, render and review; the orchestrator integrates results and retains the editable project and receipts.

These are responsibilities, not a requirement for a particular multi-agent tool. Delegate separate roles when available; otherwise perform them explicitly in this order. Role handoffs alone do not require approval, but the user's [reference-frame/storyboard approval](references/director-approval.md) is required before generated video, including newly authored 3D/2D animation. Script-only requests stop after the script; directing-only requests stop after the requested concrete plan. A caption correction, transcode, standalone photo or other narrow task without new generated scenes preserves accepted creative choices and does not restart this approval.

## Motion is the default for video

Build moving scenes, not a sequence of static pictures with text, narration and music. Plan meaningful subject action, performance, physical change or an unfolding demonstration for the main body. Quiet action and a fixed camera are valid; constant cutting or camera shake is not required.

- Prefer suitable authentic moving footage when the scene needs real evidence. For model-generated scenes, select or generate and inspect owned reference frames before video submission; reuse accepted references rather than generating them again. Use the live supported video/image-to-video models to animate the subjects and environment, binding references through supported conditioning fields. Do not invent source slots or claim a model received a reference it cannot accept. Reference frames are intermediate inputs, never completed video scenes. Describe the action's beginning, development and readable result.
- Prefer **Seedance 2.5** for video generation when the live catalog exposes a configured route supporting the approved references, action, duration, output and authorized budget. Discover its actual ID, provider and model contract; the preference does not establish availability or price. Explain a necessary alternative and update the affected approval package when its staging changes; do not silently substitute another model or bypass the user's approval.
- If model animation cannot deliver the scene because of capability, fidelity, rights, authorization, cost or a bounded failed attempt, have the director stage genuine 3D or 2D animation through supported ContentFactory operations. Animate objects, characters, materials or diagram relationships so the scene develops. Discover the actual capabilities; do not invent a model, animation endpoint or free rendering allowance.
- A pan/zoom over a flat image, parallax alone, a moving border, animated captions, transitions and an audio bed do not satisfy a scene's motion requirement. They may support real moving scenes. Never quietly downgrade an unavailable animation route to a slideshow; redesign the beat with a viable route or report the exact remaining limitation.
- Static shots are rare, purposeful exceptions, such as a specifically requested freeze, an archival/evidence image whose integrity matters, or a readable end card. Record the interval and reason in the creative task and keep the rest of the film moving. Lack of footage or failed generation alone is not a creative justification. Do not animate evidence into fictitious events or customer results.

This rule applies to video production, not to a user asking for a still photo, poster or storyboard. Review actual motion in the rendered output where available; thumbnails and a successful export cannot establish it.

## Execution boundary

- Use the connected ContentFactory MCP operations for creative research/imports, generation, inspection, processing, editing, rendering, and durable creative assets/state. Do not silently substitute local FFmpeg, WinRT/MediaComposition, Python, browser editors, other generation tools, direct provider SDKs, or other services. This applies to a one-caption change or one clip removal too.
- Discover the live supported operation and contract before deciding that a feature is unavailable. A missing capability, grant, transfer transport or provider is a specific limitation to report and resolve within ContentFactory. It is not permission to build a local rendering pipeline. Follow an explicit user override when one is actually given; disclose the changed execution path before using it.
- Local instruction files, skill maintenance and user-requested reports are permitted. User-authorized transfer of an exact file through ContentFactory's documented client transfer transport, or viewing a returned artifact, is permitted. These exceptions do not authorize local media processing, an alternate asset store or a hidden HTTP upload helper. See [execution](references/execution.md) for transfer and recovery details.
- Respect existing project grants, spending ceilings and privacy restrictions. Authorization to edit a local file is not automatically authorization to upload it or send its pixels/audio to an external model. Reuse an existing explicit authorization for its exact scope; ask only for missing authorization. Do not copy private media, transcripts, credentials or raw messages into logs, memories or issue trackers.

## Route only the work needed now

Load only the relevant specialists. Reuse already-loaded role instructions and handoffs instead of restarting their routing steps.

| Requested work | Specialist |
| --- | --- |
| Write the meaning, narrative progression and general scenes for a new production or substantial creative recut | [screenwriter](../contentfactory-screenwriter/SKILL.md), first |
| Film the script: stage action, performance and camera; obtain or animate missing content | [director](../contentfactory-director/SKILL.md), after the screenwriter |
| Locate/select a project, import/upload/download, organize media or asset relations | [assets](../contentfactory-assets/SKILL.md) |
| Research external creative sources; collect Telegram channels, groups or forums | [research](../contentfactory-research/SKILL.md) |
| Generate/edit with a model; synthesize speech, music or sound | [generate](../contentfactory-generate/SKILL.md) |
| Edit a timeline, scene/episode, caption, transition or audio mix; render/handoff | [composition](../contentfactory-composition/SKILL.md) |
| Probe/process media, transcribe/analyze, inspect exact frames or audio | [media](../contentfactory-media/SKILL.md) |
| Deterministic photo corrections, masks or layered photo documents | [photo](../contentfactory-photo/SKILL.md) |
| Author, animate, simulate or render 3D/2D scenes with supported capabilities | [3D](../contentfactory-3d/SKILL.md) |

For new productions or substantial creative recuts, complete the screenwriter-to-director handoff before assembly, then proactively obtain missing moving coverage within existing authorization and budget. For advertising, also read [advertising](references/advertising.md) for evidence and edit safeguards. For a timecode/scene revision, read [small edits](references/small-edits.md). Ordinary low-impact edits do not need a new research campaign or storyboard approval; their final video still requires the Gemini audit below.

For Grok Build requests involving video on the user's PC, read [Grok local-video intake](references/grok.md). It defines the user-authorized native intake/review path and the subsequent ContentFactory transfer.

## Begin and resume with owned state

Recover the selected project and existing creative task/composition before creating replacements. Keep the brief, script and role handoffs, shot purpose and motion route, justified still exceptions, source pins, episode/scene IDs, accepted choices, revisions, operation/job receipts and review limits in ContentFactory (`creative_task_save/get`, discovered live). Local filenames and version numbers are not the authoritative timeline. A rendered MP4 does not by itself provide editable layer IDs. If only a flattened local video exists, state that migration/reconstruction is needed rather than implying it is already editable server-side.

Before a mutation, establish which project, saved revision, target interval/layer and live operation will carry it. For generation, confirm the source/model controls and authorized price. For rendering, discover the supported profile/worker capabilities; do not claim a particular heavy worker ran unless the receipt proves it. Read [execution](references/execution.md) when submitting, transferring or recovering work.

## Always audit the final video with Gemini

Challenge the choice at planning, after the changed interval, and before delivery: does this fulfill the user's actual request; why is this shot here; what evidence would disprove the quality claim? Resolve concrete defects, not hypothetical ones. Preserve earlier accepted corrections.

Use native validation and focused inspection of the returned artifact first. Before completing any final or revised video, including a small caption edit or technical conversion, send the actual final video to **Gemini through ContentFactory for a quality audit**. For duration **up to and including 180 seconds, submit the complete video**; for longer videos, submit ordered video sections covering the entire export, including context across joins. Stills, transcripts and the agent's own review do not replace this step. Read [quality audit](references/quality-audit.md) for submission, coverage, repair and receipt requirements. A plan-only or standalone still request has no final video to audit.

Include the required audit in the production/review budget from the start and reuse existing authorization without asking again whether to audit. Respect explicit source privacy and spending ceilings. If Gemini, a supported whole-video/section transfer, access or authorized budget is unavailable, report the audit as incomplete and the precise blocker; do not silently skip it or claim quality completion. Resolve material findings and audit the corrected final output before delivery as finished. A completed Gemini report supports quality review, not user acceptance or guaranteed commercial effectiveness.

Save final revision, job and output IDs plus concise review coverage server-side. Deliver the actual authorized artifact and editable composition reference, with what changed, verified limitations, and settled cost when known. Do not report a queued job as a finished render or local output as a ContentFactory result.
