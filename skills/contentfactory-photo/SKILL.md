---
name: contentfactory-photo
description: Process existing ContentFactory photos and edit, render or interchange layered photo documents and recipes. For model-generated images, use the generation skill.
---

# contentfactory photo

Use the connected ContentFactory MCP server and stay within the user's selected projects and authorization. Search `operations_list` for the needed operations, following continuation anchors when present; use `operations_describe` to obtain the full input schema and current contract revision. Schema descriptions do not install new native tools. Invoke read operations with `operations_read` and effectful operations with `operations_execute`, supplying the exact revision and full arguments. If the contract changed, rediscover it before proceeding. Check the MCP error indicator and typed result status; a transport success alone does not prove the operation succeeded. Preserve native media or resource blocks when returned.

Inspect the project-owned original and discover the relevant photo or layered-document capabilities. Preserve immutable file pins, document revisions, layer ordering and the user's originals. Use the expected revision and exact idempotency key when the contract requires them. Poll the durable job and inspect requested results; PSD/PSB interchange is limited to the advertised subset. A returned file ID is not an image ID; pass the exact source identity supported by the current `media_image_view` schema.
