# Photo editing

Use ContentFactory's owned immutable assets. A photo correction does not require
a screenplay, video generation or a video review. Preserve the original and
deliver the resulting owned image; use generation only when the requested edit
needs it and its cost is authorized.

1. Discover `creative_capabilities`, `photo_process`, `media_image_view` and
   `media_processing_job_get` / `media_processing_job_wait`. Describe the exact
   operations and revisions before authoring inputs. Capabilities come from the
   installed worker, not the names of libraries used inside ContentFactory.
2. Resolve the project's source asset/file and inspect the original. Define the
   intended crop/framing, output format, alpha and color requirements. Use a
   generation model's live edit schema for generative fills/reference edits;
   do not pretend deterministic processing supports those operations.
3. For native processing, author an ordered operation list with explicit values.
   Available operations may include exposure, RGB gains, curves, levels, blur,
   sharpening, channel mixing, gradient maps and local selections. Discover
   current bounds; preserve authored order, pixel units and zero values.
4. Keep RGB adjustments separate from alpha changes. A selection limits eligible
   corrections; `applyMask` changes alpha. An external mask must be an owned,
   same-size single-channel PNG. Do not silently resize masks or substitute
   subject segmentation for a geometric selection.
5. RAW development and ICC normalization are explicit source choices. Read the
   admitted sensor, demosaic, white-balance and color contracts. Do not claim
   camera-wide RAW support, CMYK proofing, lens correction or denoising from
   generic photo support. PNG/TIFF output bit depth is intentional; retain
   16-bit output when requested and supported.
6. Submit once with an idempotency key; poll the returned durable job. Inspect
   its exact output using `media_image_view`. If output analysis was requested,
   bind its histograms/region/alpha policy to the returned digest. Endpoint
   occupancy alone does not establish clipping, and statistics do not replace
   visual review.

For reusable looks, discover `photo_recipe_save`, `photo_recipe_get`,
`photo_recipe_list`, `photo_recipe_list_revisions` and `photo_recipe_apply`.
Save ordered operations under compare-and-swap revision control. Apply the exact
recipe ID, revision and SHA-256 to each selected source. Recipes do not carry
source/mask, RAW/ICC normalization, encoding or analysis settings; choose those
per application. Reuse the receipt for an identical retry. Tombstoning a recipe
does not erase its immutable history or already admitted results.

Return the edited image and material review limits. For a batch, account for each
source/output pair and failed item; one successful photo does not prove the batch.
