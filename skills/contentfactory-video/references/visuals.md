# Visuals and Review

Use suitable owned sources. Keep exact source intervals and owned identities.
For each generated video scene, select or generate an owned reference frame,
view it through ContentFactory, and accept its character, location, composition
and continuity before submitting scene video. Use an inspected last frame when
the requested ending requires one. Bind the accepted images using the model's
discovered conditioning mode; do not invent incompatible first/last-frame fields.

Discover `generation_models_list` and the selected model schema, preflight the
exact request, then use `generation_create` or independent batch generation.
Retain partial results and uncertain outcomes. Model-specific input restrictions
must remain visible; do not silently switch to text-only generation when the
selected route supports and calls for image conditioning.

## Image Identity

Generated and preview PNG/JPEG files can belong to DOCUMENT assets. Preserve
their returned `assetId`, `fileId`, MIME and digest. A `fileId` is not an
`imageId`; do not relabel metadata to force compatibility. Use `media_image_view`
with the exact supported owned source. Native images use `assetId/imageId`;
document files use `assetId/fileId` only where the live schema supports it.

## Ordered Scene-Frame Review

After generated scene frames are ready, review them in story order through
ContentFactory `images_analyze`. Discover `media_analysis_models_list`, select
an image-capable Gemini model exposed by ContentFactory and honor its current
limits. No direct Gemini/Vertex tool or SDK is permitted. Use exactly one
supported identity selector per image.

Include the scene plan and inspect character, wardrobe, props, geography,
door states and neighboring-scene continuity. If the catalog limit requires
batches, overlap adjacent scene pairs and retain their order. Use the exact
matching preflight if available; otherwise admission requires an authorized
ceiling. Poll the receipt and read `media_analysis_result_get`.

Compare material findings with the actual frames before changing them. After
a confirmed correction, recheck affected frames with unchanged neighbors.
Save the model, receipts, findings and unresolved limitations. A listed model
or the author's spot inspection does not complete this review. If access,
compatibility, pricing or authorization prevents it, report it as incomplete.
Still-frame analysis cannot establish final-video motion or choreography.

## Final Video

Review the complete owned final render with ContentFactory `video_review`
before reporting full creative completion. Discover its exact contract,
source shape, pricing controls and server-selected model. Use the existing
authorized budget, a unique idempotency key and the exact final asset/file.
Do not purchase review beyond authorized spend or silently change providers.

Ask about requested actions, choreography, transitions, character/prop continuity
and audio. Poll the receipt and read timed findings, coverage and limitations.
Check material findings against the actual render. A changed final render needs
its affected review repeated. Disclose unavailable full-video review explicitly;
stills, a successful render and `video_analyze` are not the same evidence.

For rejected analysis, retain safe diagnostic stage/reason, receipt and charge
state. Preparation failure precedes inference; submission failures can indicate
access, quota or native request errors. Schema constraint failures need a
ContentFactory correction, not a larger budget or an invented media workaround.
Reconcile charged/released/unknown state before any retry and stop unchanged
attempts when the underlying cause remains unresolved.
