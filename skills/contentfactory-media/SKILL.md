---
name: contentfactory-media
description: Inspect, process and validate ContentFactory media, audio, video, vectors, presentations, webpage captures, and camera or motion data, including voice-sample checks.
---

# contentfactory media

Use the connected ContentFactory MCP server and stay within the user's selected projects and authorization. Search `operations_list` for the needed operations, following continuation anchors when present; use `operations_describe` to obtain the full input schema and current contract revision. Schema descriptions do not install new native tools. Invoke read operations with `operations_read` and effectful operations with `operations_execute`, supplying the exact revision and full arguments. If the contract changed, rediscover it before proceeding. Check the MCP error indicator and typed result status; a transport success alone does not prove the operation succeeded. Preserve native media or resource blocks when returned.

Inspect the selected owned source with the relevant probe and capability operations before choosing profiles, timestamps, formats or processing settings. Submit only the requested transformation and preserve original files. For durable work, retain the receipt and poll `media_processing_job_get` or `media_processing_job_wait` until terminal; check the requested output and quality. A timeout does not prove cancellation; recover the existing receipt before attempting a replacement. Use the authoritative capabilities for limits and available native features.
