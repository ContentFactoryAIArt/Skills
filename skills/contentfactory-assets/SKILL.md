---
name: contentfactory-assets
description: Manage ContentFactory projects, owned assets, relations and media transfers. Use when finding, uploading, downloading or organizing project material.
---

# contentfactory assets

Use the connected ContentFactory MCP server and stay within the user's selected projects and authorization. Search `operations_list` for the needed operations, following continuation anchors when present; use `operations_describe` to obtain the full input schema and current contract revision. Schema descriptions do not install new native tools. Invoke read operations with `operations_read` and effectful operations with `operations_execute`, supplying the exact revision and full arguments. If the contract changed, rediscover it before proceeding. Check the MCP error indicator and typed result status; a transport success alone does not prove the operation succeeded. Preserve native media or resource blocks when returned.

List selected projects and assets first; use only the project chosen by the user. An empty selection requires a project or an updated grant, not an invented ID. Discover upload capabilities and the specific transfer operation before preparing a transfer; follow its ticket, size, digest and authorization requirements. Upload preparation returns a transfer URL, not a completed asset; use the documented transfer and status contract to establish completion. A local path is not an owned asset ID, and a download URL is not proof that a file was saved. Keep asset IDs, file IDs and immutable pins distinct. Inspect dependencies and user retention instructions before deleting assets.
