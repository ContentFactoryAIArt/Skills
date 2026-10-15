# Native Calls, Authorization and Recovery

The tool boundary in `../SKILL.md` applies throughout these references. Tool and
operation names below refer only to operations discovered on the verified
`https://content-factory.art/mcp` connection. They are examples of capability
names, not permission to call another server that advertises them.

## Discovery and State

The connection exposes four envelope tools: `operations_list`,
`operations_describe`, `operations_read` and `operations_execute`. Names such as
`photo_process` below are operation IDs inside those envelopes, not additional
client tools. Page relevant list results with the returned continuation anchor.
Read `inputSchema.documentJson` and `outputSchema.documentJson` from a description;
send `operationId`, its exact `contractRevision` and schema-valid `arguments`
through the read or execute envelope indicated by `invocationKind`.
Describe related operations in an ordered batch when supported. A selected
schema subtree does not replace the full operation schema or its requirements.

For first use, discover and read `projects_list`, then select an authorized
project. An empty project list needs a project created/selected in ContentFactory
or an updated grant; do not invent an ID. Confirm relevant capabilities with a
read before proposing paid work. A configured server and a successful login
alone do not prove that project membership, a worker or a provider is available.

Discover relevant operations and describe only the next required contracts.
Use their exact revisions and schemas. Discover supported models, voices, fonts
and profiles rather than guessing. Refresh affected discovery when contracts
change. Batch independent reads and generation sets within the authorized budget.

Read the MCP envelope before its payload: inspect `isError`, prefer object-valued
`structuredContent`, and only then decode individual text JSON blocks when needed.
Plain-text errors are valid results; a JSON parse failure must not erase them.
Retain native image/audio/resource blocks. `isError=false` still requires typed
success/status checks. Never interpret a transport timeout as cancellation.

Use `composition_get` overviews, filtered reads and `composition_edit` for small
changes. A projection is not a complete replacement document. One author writes
shared task/composition state with `expectedRevision` and idempotency keys.
Recover pending receipts before restarting or generating replacements.

Save the brief, selected assets, composition revision, operation IDs, actual
spend and review limitations with `creative_task_save` when resumption is useful.
`selectedResults` holds indexed generation outputs only. Speech/music/effects
belong in `operationIds`, with their exact owned `assetId/fileId` in the timeline.
A creative task is current compare-and-swap state, not an append-only journal.
Keep requested reporting in the conversation and server-supported task fields.

## Spending and Retries

Use existing task authorization, including routine corrections with known terminal
outcomes. Stay within the total budget, counting spent, reserved and uncertain
amounts. Do not invent per-stage approval gates. Clarify actions outside the
authorized scope and preserve client approvals and server access checks.

Use matching read-only preflight when exposed: `generation_preflight` for
generation, `content_operation_preflight` for research/speech/music/effects,
and `media_inspect_preflight` for the compatible inspection request. Discover
whether each analysis/review operation has its own quote; a quote for one
operation does not price another. Never submit paid work merely to probe whether
configuration, pricing or permissions work. Use an explicitly authorized
`maxChargeCents` ceiling and honor any narrower user limit.

An available catalog model can still lack a billing tariff. A pricing-unavailable
preflight is not an absent tool, and raising the ceiling cannot create a tariff.
Try another compatible catalog model's free preflight only when consistent with
the brief. Distinguish missing pricing, insufficient balance and an over-budget
quote. Do not silently substitute a different creative technique.

Retain each mutation's exact idempotency key and receipt immediately. Poll or
batch-wait that receipt. Recover uncertain outcomes before replacements and
reconcile charges before retries. Do not repeat a media job because a later
task-state save failed. A changed request requires an intentional new key.

## Editing and Evidence

Routine cleanup may remove unsuitable generated assets in the working project
within the user's task, retention choices and dependency rules. Update timeline
references first when required. Preserve supplied originals and unrelated
projects. Deleting an asset does not refund its charge or resolve an uncertain
operation; keep its receipt and spending record.

View stills once and ordinary clip beginnings/endings, expanding checks for an
observed issue or a requested property. This sampling does not establish full
motion, lip sync or listening quality. Apply the specific generated-frame and
final-video checks in `visuals.md`, reference fidelity in `reference-video.md`,
and contact/motion checks in `blender.md` where relevant. All analysis uses
ContentFactory tools, even when the server delegates to an external model.

Separate render success, sampled visual acceptance, model-assisted findings and
actual listening coverage. If the current client cannot perceive returned media,
state that limitation. Do not open another tool or send artifacts to another
provider to complete a missing check. Model findings need comparison against
the exact media; inference success is not artistic certainty.
