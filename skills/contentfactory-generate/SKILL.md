---
name: contentfactory-generate
description: Generate or model-edit images and video, synthesize speech, music or sound effects through ContentFactory, and recover generation receipts. For deterministic photo or layered-document edits, use contentfactory-photo.
---

# contentfactory generate

Start with the [ContentFactory workflow](../contentfactory/SKILL.md), which defines the required MCP execution, storage, authorization and recovery boundary. Use this specialist for generative work; unavailable pricing, models or imports do not authorize a direct provider or other generation tool.

When generating material for a video or advertisement, use the [director's plan](../contentfactory-director/SKILL.md) for shot purpose, staged action, continuity and acceptance criteria. Proactively fill identified production gaps within existing authorization and budget, inspect the result against those criteria, and return owned asset references to the production. Standalone generation does not require a full directing workflow.

Check feasibility of any required downstream editable format, alpha/mask or timeline handoff with the relevant specialist before paid generation; a generated flattened image alone does not fulfill a layered-editing request.

List and describe current model or voice selections for the requested modality; do not invent provider IDs, supported parameters or prices. Image/video requests require both the envelope operation's `contractRevision` and the selected model's separate `modelContractRevision`; build `inputJson` against that model's schema and source slots. `image_foreground_extract` generates a person on a plain white background; it is not a pixel-exact alpha mask and does not provide transparency. Use `generation_preflight` for compatible image/video requests and `content_operation_preflight` for compatible speech, music and effects. A preflight validates and quotes; it does not submit or reserve funds. Count spent, reserved and uncertain amounts against the user's budget. Preserve the idempotency key for an identical command; if execution is uncertain, poll its durable receipt and reconcile charges before retrying. Reuse returned owned file references in later workflows. Distinguish an unavailable tariff, insufficient balance and an over-budget quote.

`PRICING_UNAVAILABLE` or `NOT_CONFIGURED` is an admission blocker, not evidence that funds were spent or that the account balance is insufficient. Repeating an unchanged preflight does not repair it; recheck after a relevant tariff, selection or deployment change. On an idempotency conflict, recover the earlier command and compare its exact inputs before choosing whether this is recovery or a new command. A failed result import may follow completed provider work and a settled charge; reconcile receipt, charge and output state before retrying. For a requested person's likeness or cloned voice, retain the authorized original source and reject a generated candidate that fails likeness or intelligibility review.
