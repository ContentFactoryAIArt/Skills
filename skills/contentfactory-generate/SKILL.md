---
name: contentfactory-generate
description: Generate or model-edit images and video, synthesize speech, music or sound effects, and recover ContentFactory generation receipts.
---

# ContentFactory generation

Follow the [shared workflow](../contentfactory/SKILL.md) for project state and permissions. A standalone image or sound uses its own brief. New films and substantial recuts use the screenwriter and director handoff before production.

- **Video** needs observable movement in the subject or scene and an explicit result for each essential shot. Default to the best compatible premium route. Read [video model selection, submission and take review](references/video.md). Generate motion only after the user approves the [inspected reference frames, storyboard and blocking](../contentfactory/references/director-approval.md).
- **Image or generative edit** uses `generation_models_list`, `generation_models_describe`, `generation_preflight` and `generation_create`. Discover the requested modality and intent. Use the chosen model's exact `modelContractRevision`, schema and source slots as well as the MCP operation's `contractRevision`. Check downstream alpha, mask, layer and interchange support before spending when the user needs an editable result. A generative white background is a flattened result. Use [Photo](../contentfactory-photo/SKILL.md) for deterministic masks and editable layers.
- **Speech, music or SFX** uses the live voice/model/product choices and `content_operation_preflight`. Discover `speech_synthesize`, `music_compose` or `sound_effects_generate` as applicable. Set duration, intent and its signal to the viewer from the actual edit. For a cloned voice or likeness, use the authorized source and verify the output's fidelity and intelligibility.

Recover the durable operation and selected owned outputs before using them downstream. Use [execution and recovery](../contentfactory/references/execution.md) for quotes, spending, uncertain acceptance and import failures. Return the asset/file pins and receipt for the exact generation consumed by the edit.
