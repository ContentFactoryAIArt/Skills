---
name: contentfactory-composition
description: Edit ContentFactory timelines, scenes, captions, effects, transitions and audio mixes. Preview, render or exchange editable timelines.
---

# ContentFactory composition

Follow the [shared workflow](../contentfactory/SKILL.md). For a new film or substantial recut, assemble from the completed story and directing handoff. Use [small edits](../contentfactory/references/small-edits.md) for a narrow timecode change.

1. Read the exact composition revision and map the timecode to stable layer or clip IDs, intervals and neighboring cuts. Discover supported profiles and capabilities. For an effect, use `composition_effects_list` and inspect the ordered stack, target scope, parameters and keyframes. For a processed standalone source use [Media](../contentfactory-media/SKILL.md).
2. Apply related changes atomically with `composition_edit`, the current expected revision and an idempotency key. Preserve pinned source files, captions, timing and mix outside the requested change. A filtered layer read cannot stand in for a complete save. Keep one author on a mutable composition.
3. Probe the source streams before attaching them. Select the original stream index for the requested track. Omit a missing audio stream. Validate the saved revision with `inspectAudioMix=true` on audio-enabled work and check the mix inspection result. Preview the changed interval and its joins where supported.
4. Use `composition_render` for the saved revision with the current profile and capability revision. Wait for the actual job and recover its artifact. Verify the affected range, motion, sound and continuity in the output. Every final or revised video requires [Gemini audit](../contentfactory/references/quality-audit.md) on the exact final artifact.

See [operation routes](../contentfactory/references/operation-routes.md) for discovery and [execution](../contentfactory/references/execution.md) for large schemas, transfers and recovery. If rendering fails, use the exact job's diagnostics before changing the request.
