---
name: contentfactory-assets
description: Find, import, upload, download or organize creative project assets and persist creative task state through ContentFactory. Not for general databases or application source files.
---

# contentfactory assets

Start with the [ContentFactory workflow](../contentfactory/SKILL.md), which defines the required MCP execution, storage, authorization and recovery boundary. Use this specialist for creative project assets and state; local files are exports or authorized ingress, not a substitute project store.

List selected projects and assets first; use only the project chosen by the user. An empty selection requires a project or an updated grant, not an invented ID. Discover upload capabilities and the specific transfer operation before preparing a transfer; follow its ticket, size, digest and authorization requirements. Upload preparation returns a transfer URL, not a completed asset; use the documented transfer and status contract to establish completion. A local path is not an owned asset ID, and a download URL is not proof that a file was saved. Keep asset IDs, file IDs and immutable pins distinct. Inspect dependencies and user retention instructions before deleting assets.

Each MCP endpoint has its own audience and selected-project grant. If a specialist endpoint returns `PROJECT_NOT_GRANTED` while an already authorized unified connection can use the project, continue through that authorized connection; repair the specialist connection by selecting the project in fresh consent. Do not treat another endpoint's grant as permission to expand this one. Copy source IDs and immutable pins from the actual owned result instead of retyping them. Before replacing an apparently timed-out download, verify its existing file size and digest.

Pass `operation.contractRevision` from the description directly into the matching invocation; do not retype or shorten it, or substitute an asset/file revision. On `CONTRACT_CHANGED`, refresh that operation's description and check its current arguments before invoking it again. A failed read is not a reason to recreate the asset or repeat its generation/import.

For an authorized local file, the packaged Node.js 22+ transport is `scripts/upload.mjs`. Run `node scripts/upload.mjs --help` for inspect/send arguments. Inspect using the live `maximumBytes`, prepare that exact returned request through MCP, then send with `{ "ticket": <prepared result>, "request": <inspect result> }` on a private stdin pipe. Tickets must never enter command arguments, shell history, files or logs; the script requires piped input and pins the public unified/Media MCP endpoints. It streams exact bytes and verifies the owner's checksum receipt. After an uncertain result, recover through `asset_upload_get` before retrying the identical key and command. Partial transfers require a full resend; there is no byte-offset resume. This transfer exception does not authorize local media processing.
