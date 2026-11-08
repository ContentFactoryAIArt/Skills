---
name: contentfactory-3d
description: Inspect, author, simulate and render project-owned 3D scenes and animation with ContentFactory Blender operations.
---

# contentfactory 3d

Use the connected ContentFactory MCP server and stay within the user's selected projects and authorization. Search `operations_list` for the needed operations, following continuation anchors when present; use `operations_describe` to obtain the full input schema and current contract revision. Schema descriptions do not install new native tools. Invoke read operations with `operations_read` and effectful operations with `operations_execute`, supplying the exact revision and full arguments. If the contract changed, rediscover it before proceeding. Check the MCP error indicator and typed result status; a transport success alone does not prove the operation succeeded. Preserve native media or resource blocks when returned.

Inspect the owned source and discover each relevant native capability and its runtime revision before constructing a request. Use supported typed scene and animation inputs; preserve exact source hashes and revisions. Choose output format based on discovered support: editable BLEND, evaluated GLB and rendered media have different fidelity. Cloth simulation's sampled GLBs are static deformations, not animated cloth. Poll the durable media job and verify requested outputs. If perception is unavailable, report the unreviewed aspects rather than inferring visual quality from job success.
