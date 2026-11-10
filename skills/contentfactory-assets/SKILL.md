---
name: contentfactory-assets
description: Manage ContentFactory projects, owned assets, relations and media transfers. Use when finding, uploading, downloading or organizing project material.
---

# contentfactory assets

Use the connected ContentFactory MCP server and stay within the user's selected projects and authorization. Search `operations_list` for the needed operations, following continuation anchors when present; use `operations_describe` to obtain the full input schema and current contract revision. Schema descriptions do not install new native tools. Invoke read operations with `operations_read` and effectful operations with `operations_execute`, supplying the exact revision and full arguments. If the contract changed, rediscover it before proceeding. Check the MCP error indicator and typed result status; a transport success alone does not prove the operation succeeded. Preserve native media or resource blocks when returned.

List selected projects and assets first; use only the project chosen by the user. An empty selection requires a project or an updated grant, not an invented ID. Discover upload capabilities and the specific transfer operation before preparing a transfer; follow its ticket, size, digest and authorization requirements. Upload preparation returns a transfer URL, not a completed asset; use the documented transfer and status contract to establish completion. A local path is not an owned asset ID, and a download URL is not proof that a file was saved. Keep asset IDs, file IDs and immutable pins distinct. Inspect dependencies and user retention instructions before deleting assets.

Each MCP endpoint has its own audience and selected-project grant. If a specialist endpoint returns `PROJECT_NOT_GRANTED` while an already authorized unified connection can use the project, continue through that authorized connection; repair the specialist connection by selecting the project in fresh consent. Do not treat another endpoint's grant as permission to expand this one. Copy source IDs and immutable pins from the actual owned result instead of retyping them. Before replacing an apparently timed-out download, verify its existing file size and digest.

Pass `operation.contractRevision` from the description directly into the matching invocation; do not retype or shorten it, or substitute an asset/file revision. On `CONTRACT_CHANGED`, refresh that operation's description and check its current arguments before invoking it again. A failed read is not a reason to recreate the asset or repeat its generation/import.
