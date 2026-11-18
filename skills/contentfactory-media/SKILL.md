---
name: contentfactory-media
description: Inspect, transcode or process ContentFactory media, including standalone audio cleanup, transcription, vector and video diagnostics.
---

# ContentFactory media

Follow the [shared workflow](../contentfactory/SKILL.md). Probe the owned source and discover qualified operations, parameter limits and output profiles. Preserve the original and pin the exact input revision. See [operation routes](../contentfactory/references/operation-routes.md).

- **Audio cleanup and processing:** probe streams, listen or measure the relevant passage, then discover the ordered DSP chain with `creative_capabilities` and `audio_process`. Choose only supported controls for the observed problem. Keep the source, ordered settings, output and receipt together for repeatable processing. Compare the before/after audio, speech intelligibility and levels. Use [Composition](../contentfactory-composition/SKILL.md) for timeline mixing.
- **Speech:** discover `speech_analysis_models_list`, `speech_timing_preflight`, `speech_transcribe` and `speech_timing_result_get`. Keep the pin and spending ceiling consistent between preflight and execution. Transcription, waveform and levels provide different evidence from listening.
- **Video/effects processing, vectors and technical delivery:** find the supported kernel or media profile before changing formats, timestamps or controls. Use actual timestamp and frame-selection semantics. Include the inspected artifact, times and review coverage with findings. A still frame can reveal a visual defect. Use actual playback for smoothness, continuity and lip sync.

Poll `media_processing_job_get` or `media_processing_job_wait` on the same job until terminal and verify the owned outputs. Use [execution](../contentfactory/references/execution.md) for schema selection and recovery. Every final or revised video, including a transcode, requires the [Gemini audit](../contentfactory/references/quality-audit.md).
