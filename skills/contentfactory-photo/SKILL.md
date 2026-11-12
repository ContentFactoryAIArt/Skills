---
name: contentfactory-photo
description: Correct or edit existing photos, masks and layered image documents, then render or interchange them through ContentFactory. For model-generated images, use contentfactory-generate.
---

# contentfactory photo

Start with the [ContentFactory workflow](../contentfactory/SKILL.md), which defines the required MCP execution, storage, authorization and recovery boundary. Use this specialist for deterministic photo work; do not replace it with a local image library or another editor when capabilities are unavailable.

Inspect the project-owned original and discover the relevant photo or layered-document capabilities. Preserve immutable file pins, document revisions, layer ordering and the user's originals. Use the expected revision and exact idempotency key when the contract requires them. Poll the durable job and inspect requested results; PSD/PSB interchange is limited to the advertised subset. A returned file ID is not an image ID; pass the exact source identity supported by the current `media_image_view` schema.

For generation followed by background removal/editable delivery, verify the complete masking, true-alpha export and editable-document persistence path before paying for generation. Retain the original and saved mask/layer/document revision where supported. A white background, returned file ID or flattened transparent PNG is not proof of an editable mask; report unsupported parts explicitly.
