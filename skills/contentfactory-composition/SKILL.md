---
name: contentfactory-composition
description: Create, edit, render and interchange ContentFactory compositions and timelines, including captions and saved creative tasks.
---

# contentfactory composition

Use the connected ContentFactory MCP server and stay within the user's selected projects and authorization. Search `operations_list` for the needed operations, following continuation anchors when present; use `operations_describe` to obtain the full input schema and current contract revision. Schema descriptions do not install new native tools. Invoke read operations with `operations_read` and effectful operations with `operations_execute`, supplying the exact revision and full arguments. If the contract changed, rediscover it before proceeding. Check the MCP error indicator and typed result status; a transport success alone does not prove the operation succeeded. Preserve native media or resource blocks when returned.

Read the composition and exact revision before editing. Discover capabilities, supported formats and profiles for the intended edit, preview, render or interchange. Apply edits by stable IDs and the required revision; preserve source pins and existing content outside the request. A filtered layer projection is not a complete replacement document. Before rendering with audio enabled, validate with `inspectAudioMix=true`; check both validation and the returned inspection status, since a general valid result alone does not prove mix headroom.

Poll durable jobs through completion and inspect the exact final output, not merely job admission or a preview. `composition_artifact_get` provides the authorized artifact page for a completed job. State what visual and audio review was actually possible; sampled stills do not establish full motion or listening quality. Import/export and relink have exact pin, policy and transfer requirements; discover their schemas. Save the brief, chosen sources, revision and receipts with creative-task operations when recovery is useful.
