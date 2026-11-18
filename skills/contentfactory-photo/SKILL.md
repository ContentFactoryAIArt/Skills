---
name: contentfactory-photo
description: Correct and mask photos or edit, render and interchange layered documents through ContentFactory.
---

# ContentFactory photo

Follow the [shared workflow](../contentfactory/SKILL.md). Inspect the owned original with the correct asset/file or asset/image identity from the live schema.

- For deterministic pixel work, discover `creative_capabilities` and `photo_process`. Choose the supported operations, output color/alpha requirements and ordered steps for the actual edit.
- For editable masks, layers or interchange, discover `photo_document_capabilities` and the document operations before editing. Preserve source pins, layer order and expected revision. Check qualified PSD/PSB support if requested. A flattened transparent PNG can satisfy a delivery format, while editable masks require a saved document with masks or layers.
- For model changes, use [Generate](../contentfactory-generate/SKILL.md). Verify how actual alpha, masks and editable layers will be produced before paying for generation. A generated white background carries no mask.

Keep the original, get the durable result and verify the returned image or document revision. Inspect the changed pixels, mask borders, alpha and interchange fidelity where relevant. See [operation routes](../contentfactory/references/operation-routes.md).
