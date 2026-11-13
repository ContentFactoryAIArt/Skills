# Visuals and Review

Use suitable owned sources. Keep exact source intervals and owned identities.
Deliver purposeful moving scenes for video work. A still with narration,
captions, transitions or pan/zoom is not a substitute for subject/scene action.
Use static holds only for a specific creative reason, and a predominantly static
treatment only when explicitly requested or agreed.

For each generated video scene, choose a compatible route for the director's
intended action. Select or generate an owned reference frame, view it through
ContentFactory, and accept its character, location, composition and continuity
before submitting scene video. Reuse a suitable accepted reference; do not
regenerate it by habit. Use an inspected last frame when the requested ending
requires one. Bind accepted images using the model's discovered conditioning
mode; do not invent incompatible first/last-frame fields or claim an unsupported
model received a reference. Reference images remain production inputs, not final
video scenes.

Discover `generation_models_list` and the selected model schema, preflight the
exact request, then use `generation_create` or independent batch generation.
Retain partial results and uncertain outcomes. Model-specific input restrictions
must remain visible; do not silently switch to text-only generation when the
selected route supports and calls for image conditioning.

When only still sources are available, animate their specified action with a
compatible model. If that route is unavailable, unsuitable or fails within the
authorized attempt/budget limit, recover uncertain receipts and use supported
authored 3D/2D action through ContentFactory. Animated text, flat image-plane
movement and transitions alone do not satisfy that fallback. Preserve authentic
footage for factual proof; synthetic action does not prove real-world behavior.

## Image Identity

Generated and preview PNG/JPEG files can belong to DOCUMENT assets. Preserve
their returned `assetId`, `fileId`, MIME and digest. A `fileId` is not an
`imageId`; do not relabel metadata to force compatibility. Use `media_image_view`
with the exact supported owned source. Native images use `assetId/imageId`;
document files use `assetId/fileId` only where the live schema supports it.

## Ordered Scene-Frame Review

When generated reference frames are needed, inspect them in story order for
continuity. Use ContentFactory `images_analyze` when an unresolved continuity or
identity question justifies model review within the existing authorized budget.
Discover `media_analysis_models_list`, select an image-capable Gemini model
exposed by ContentFactory and honor its current limits. No direct Gemini/Vertex
tool or SDK is permitted. Use exactly one supported identity selector per image.

Include the scene plan and inspect character, wardrobe, props, geography,
door states and neighboring-scene continuity. If the catalog limit requires
batches, overlap adjacent scene pairs and retain their order. Use the exact
matching preflight if available; otherwise admission requires an authorized
ceiling. Poll the receipt and read `media_analysis_result_get`.

Compare material findings with the actual frames before changing them. After
a confirmed correction, recheck affected frames with unchanged neighbors.
Save the model, receipts, findings and unresolved limitations when model review
is used. A listed model or the author's spot inspection does not establish that
model review ran. If a needed check is blocked by access, compatibility, pricing
or authorization, report that check as incomplete.
Still-frame analysis cannot establish final-video motion or choreography.

## Final Video

For a new production or substantial recut, review the exact complete owned final
render in motion and listen where supported. Use ContentFactory `video_review`
when model-assisted review answers an unresolved question within the existing
authorized budget; do not buy a full paid review for a small caption/timecode
correction by habit. Discover its exact contract, source shape, pricing controls
and server-selected model. Use a unique idempotency key and the exact final
asset/file. Do not purchase review beyond authorized spend or silently change
providers.

Ask about requested actions, choreography, transitions, character/prop continuity
and audio. Poll the receipt and read timed findings, coverage and limitations.
Check material findings against the actual render. Inspect the intended actions
for unintended freezes or replacement by static layouts. A changed final render
needs its affected review repeated. Disclose actual review coverage and
unavailable continuous motion/audio or model review explicitly; stills, a
successful render and `video_analyze` are not the same evidence.

For rejected analysis, retain safe diagnostic stage/reason, receipt and charge
state. Preparation failure precedes inference; submission failures can indicate
access, quota or native request errors. Schema constraint failures need a
ContentFactory correction, not a larger budget or an invented media workaround.
Reconcile charged/released/unknown state before any retry and stop unchanged
attempts when the underlying cause remains unresolved.
