# Execute, store and recover through ContentFactory

## Live discovery and receipts

Use the configured ContentFactory connection, not an unrelated server with a similar tool name. Use available trusted connection metadata; never expose credentials while checking it. The connected Media, Compose and Generate surfaces share owned project/asset IDs. An opaque client label alone is not evidence of a different backend or permission to bypass it.

Search `operations_list`, follow its continuation anchor, then `operations_describe` for the needed operation. Read only relevant schema definitions; avoid dumping a complete shared schema graph into model context. Invoke `operations_read` or `operations_execute` with that exact `operation.contractRevision` and typed arguments. Check `isError` and the typed result/terminal status. Schema discovery does not install another native tool. On `CONTRACT_CHANGED`, refresh the description; never substitute an asset revision for a contract revision.

Recover `creative_task_get` or locate the task through `creative_tasks_list` in the selected project. `creative_task_save` stores the explicit brief, scenes, composition pin and operation/render references; it is creative task state, not a personal memory system. Keep unrelated conversation and private raw research out of it. Use `operationIds` for direct speech/music artifacts; `selectedResults` is for indexed generation outputs, per its live schema. One agent owns mutable task/composition updates. Parallel agents may research or review bounded, non-conflicting material.

## Sources and local transfer

List selected projects/assets; do not invent IDs or create another project to avoid a missing grant. Probe immutable source pins and actual stream indices before using them. A silent video has no audio stream: omit its optional audio reference rather than attaching a nonexistent muted stream.

For a user-authorized local file, discover `asset_upload_capabilities` and the transfer contract, then prepare with exact byte count and lowercase SHA-256. `asset_upload_prepare` returns a short-lived POST ticket for the MCP client's documented file-transfer transport or the packaged [asset upload script](../../contentfactory-assets/scripts/upload.mjs) (Node.js 22+; see the asset specialist for inspect/send). It is not an owned asset or proof of transfer. Do not put bytes in MCP JSON, forward OAuth headers, expose tickets in arguments/logs/files, build alternative network upload helpers, or assume a raw local path can be rendered by the server. If neither supported transfer path can run, explain that precise gap and use ContentFactory's upload UI/user upload path; continue independent planning. Recover the completed transfer with the original receipt/key and confirm the owned immutable file before composing. Partial uploads require a full resend after receipt recovery; there is no byte-offset resume. The same distinction applies to download tickets versus completed local downloads.

These storage limits apply to creative media and its project state. Creative media, derived assets, source pins, timelines, generated results and durable creative task state belong to ContentFactory. A local workspace may contain instructions and user-requested human documentation; it must not become the only creative project history or render source of truth. Do not delete a source asset merely to remove one timeline occurrence.

An upload UI changes transport, not privacy scope. Audio-only permission for a local video does not permit uploading its full container. If no authorized audio-only source and no permitted extraction/transfer path exists, report that ingress limitation and request a suitable audio-only source or a specific scope change. Do not extract locally or upload visuals under the label "audio-only analysis."

## Edit and render

Read exact composition revision and relevant stable layer/scene IDs. Discover capabilities and supported profiles. Prefer one atomic `composition_edit` for related commands, `expectedRevision` CAS and an idempotency key. Use a compact/changed-layer response for small edits if supported. A filtered projection is not a complete replacement document. Use `composition_save` only with the complete required document; do not drop unreturned layers.

Before audio-enabled rendering, validate the intended revision with `inspectAudioMix=true`; inspect the mix inspection status as well as general validation. Resolve clipping explicitly; do not silently limit or claim a valid document proves headroom. Request `composition_render` for the exact saved revision with the live `profileId` and `capabilityRevision`. This starts a durable ContentFactory job; it is separate from saving/editing the timeline. Report worker/executor identity only if returned. A local/native renderer mentioned by server capability text is server execution, not authorization to run a desktop renderer.

Poll `composition_jobs_get` (or supported batch status) on the same job handle until terminal. A slow poll/timeout is not a failed job and does not justify resubmission. Fetch `composition_artifact_get` and the exact output asset after success; compare the job's saved composition/source revisions with the requested correction before treating a recovered artifact as current. Native preview/validation, rendered artifact checks and user creative acceptance are distinct proof layers.

## Failures, cost and bounded recovery

For paid work, discover models/capabilities and run the relevant preflight for readiness, source selection and price. A catalog entry is not proof that a provider can execute. Retain idempotency key, operation ID, reservation, settled charge, output/import identity and error code. Reservation is not spending; a failure can still have a settled charge. Do not invent Codex token costs from tool-call counts.

Keep production, import and review budgets distinct. A zero-dollar review budget forbids paid review; it neither authorizes music generation nor sets the entire production budget. Read live charging effects/quotes rather than assuming that a native validation or render is free. Reuse existing authorized ceilings without requesting them again.

After uncertainty, recover the original receipt before retrying. Reuse a key only for an identical command. For completed provider output with failed import, use the discovered import-only recovery operation when eligible; do not pay to regenerate the result. For deterministic request/schema failures, fix the proven cause before another submission. Stop repeated identical retries and report the unresolved limitation. For analysis errors, record the exact code and controls; do not label every parsing/token-limit/provider error as a disconnected Gemini account. If the user asks to pause review and diagnose an error, stop review submissions until that direction changes.

Do not hide lengthy local troubleshooting behind status messages. Report the actual failed step, the next evidence needed, and whether a live job still exists. Save concise safe receipts and progress in the creative task; honor requested logs without raw private sources or secrets.

Keep orchestration proportional: one editor normally handles a small revision and its native checks. Delegate independent work when it reduces uncertainty, not three repeated reviews of the same caption. Prefer compact responses and the existing job/result instead of repeated discovery, polling already-completed handles, full contact sheets or repeated unchanged-audio analysis. Tool-call volume is overhead to minimize, not progress evidence.
