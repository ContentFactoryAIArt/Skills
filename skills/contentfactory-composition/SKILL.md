---
name: contentfactory-composition
description: Create or edit video and audio timelines, scenes, episodes, ads, captions and transitions, then save revisions and render through ContentFactory. Use for timestamp-specific changes to an existing video.
---

# contentfactory composition

Start with the [ContentFactory workflow](../contentfactory/SKILL.md), which defines the required MCP execution, storage, authorization and recovery boundary. Use this specialist for timeline work; do not rebuild an edit in local scripts when a render or operation fails.

For a new production or substantial creative recut, establish or reuse the [director's staging plan](../contentfactory-director/SKILL.md) before assembly. Obtain missing coverage through research/import or generation within existing authorization and budget instead of filling gaps with repeated shots. Narrow caption, timecode and technical edits stay scoped to the requested change.

Read the composition and exact revision before editing. Discover capabilities, supported formats and profiles for the intended edit, preview, render or interchange. Apply edits by stable IDs and the required revision; preserve source pins and existing content outside the request. A filtered layer projection is not a complete replacement document. Before rendering with audio enabled, validate with `inspectAudioMix=true`; check both validation and the returned inspection status, since a general valid result alone does not prove mix headroom.

Resolve a timestamp request to the actual clip, layer or title ID and its full interval before changing it. Removing a photo clip is not deleting one encoded frame: decide whether to fill the interval or ripple the timeline from the user's request and preserve accepted speech, audio sync and surrounding captions. Read the current revision again after another writer changes it; keep one author for mutable composition state. For a narrow revision, inspect the affected interval and its joins before expanding review. Render the saved revision through the discovered profile and verify the returned job and artifact; do not claim a heavy worker ran from an MCP transport response alone.

Probe each pinned media source before adding stream references. Use the reported stream kind and original index; a silent video has no audio reference, so omit its optional `video.audio` settings. Setting `muted=true` does not make a missing audio stream valid. When several streams of the requested kind exist, select one explicitly from the probe instead of guessing an index.

Poll durable jobs through completion and inspect the exact final output, not merely job admission or a preview. `composition_artifact_get` provides the authorized artifact page for a completed job. State what visual and audio review was actually possible; sampled stills do not establish full motion or listening quality. Import/export and relink have exact pin, policy and transfer requirements; discover their schemas. Save the brief, chosen sources, revision and receipts with creative-task operations when recovery is useful.

Large composition schemas can be read with `operations_describe.schemaSelection`, selecting the required `inputPath` or omitting output documentation with `includeOutput=false`; the returned revision still belongs to the full canonical request. Keep the operation contract revision, composition document revision and renderer capability revision separate. Preflight success does not guarantee that execution will fit worker limits. If a render fails, retain that job's exact composition/source revisions and failure evidence, inspect its diagnostics and current capabilities, and make only a justified change. Mark a revised successful draft as a workaround until the original failed case is verified.
