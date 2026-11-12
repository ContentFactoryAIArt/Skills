---
name: contentfactory-media
description: Inspect, transcode, trim, process or validate media through ContentFactory, including audio, video, vectors, presentations, webpage captures, voice-sample checks and speech transcription or timing.
---

# contentfactory media

Start with the [ContentFactory workflow](../contentfactory/SKILL.md), which defines the required MCP execution, storage, authorization and recovery boundary. Use this specialist for processing and analysis; failed or missing operations do not authorize local transcoding, ASR or an external analysis service.

Inspect the selected owned source with the relevant probe and capability operations before choosing profiles, timestamps, formats or processing settings. Submit only the requested transformation and preserve original files. For durable work, retain the receipt and poll `media_processing_job_get` or `media_processing_job_wait` until terminal; check the requested output and quality. A timeout does not prove cancellation; recover the existing receipt before attempting a replacement. Use the authoritative capabilities for limits and available native features.

When only preparing arguments, describe the operation with `schemaSelection: {includeOutput: false}`, including for `media_audio_preview`. Fetch the output schema separately when needed to interpret the result; select `inputPath` or `outputPath` for a specific subtree. Keep the returned canonical `operation.contractRevision` and invoke with the full request, since schema selection changes documentation only.

For speech content or timing, discover `speech_analysis_models_list`, `speech_timing_preflight`, `speech_transcribe` and `speech_timing_result_get`. Use the current catalog's model selection and the same source pin and spending ceiling for preflight and execution. If discovery omits these operations, report the addressed endpoint's current exposure; do not conclude that the product has no transcription implementation. A technical voice-sample check measures sample properties, not words, identity or intelligibility. ASR, waveform levels and correlation do not establish human listening quality.

For timed visual inspection, use the operation's actual timestamp and frame-selection semantics. A seek followed by delayed playback is not an exact frame sample. Record the inspected artifact, times and coverage; sampled stills cannot prove motion smoothness or lip sync. Diagnose a provider failure from its durable receipt and error, keeping failed analysis distinct from a failed render or an unavailable source.
