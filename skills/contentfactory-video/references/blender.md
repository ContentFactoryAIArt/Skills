# Blender Through ContentFactory

Use native Media operations for authored 3D models, animated objects/cameras,
editable `.blend` outputs and transparent overlays. They submit typed jobs to
server-installed Blender. Do not run desktop Blender, Python or local renderers.

Use project-owned self-contained GLBs. Discover `blender_primitive_create` for
supported simple models; supply complete centers, sizes and colors, including
zero channels. For custom geometry, select an existing asset or ask the user
to upload a GLB in ContentFactory. A local path is not a model source.

Inspect rigged models with `blender_model_inspect` and reuse stable node IDs for
part tracks and animation IDs for action clips. Do not replace usable skeletal
animation with separate limb models. Discover scene and instance limits instead
of copying historical counts. `blender_scene_render` produces a still;
`blender_scene_export` exports a static scene. Do not manufacture animation by
submitting one still job per frame.

## Scenes and editor features

Describe the current scene contracts for material overrides, UV editing,
lighting, distributions and Grease Pencil. Preserve source materials unless the
user requests a change. An override replaces all mesh slots with the supported
opaque, texture-free material; it is not arbitrary shader authoring. Colors use
the contract's linear RGB values. UV authoring supports admitted static triangle
sources and explicit planar/affine primary-UV changes; it is not automatic unwrap
or packing. Inspect eligibility and texture-coordinate restrictions first.

Use discovered point, spot, sun or rectangular area lights with explicit units
and unique IDs. GLB interchange rejects area lights; use BLEND when they must
remain editable. Static unskinned sources can use discovered linear/radial/grid
distributions and seeded variation; per-copy rig animation is not implied.

Typed Grease Pencil layers carry drawing frames and strokes; object tracks can
animate them. Choose BLEND to retain editable drawings. Do not request GLB export
or mesh diagnostics for a scene containing Grease Pencil when unsupported.
`blender_scene_inspect` provides evaluated pose, topology, weights, UV or instance
evidence; `blender_collision_check` checks a bounded set of geometry/time samples.
Unknown/truncated findings are limitations, and finite samples never prove
collision-free continuous motion.

## Animate and Inspect

Describe `blender_animation_render` and submit one typed job for the complete
animation with exact rational frame rate, full frame count, model/camera tracks,
output format and idempotency key. Poll the returned native job. A timeout does
not cancel it; reuse the key only for the identical request.

Use embedded action clips with explicit source time, timeline interval,
repetition, influence and fades. Node tracks override the corresponding clip
transforms, not automatic inverse kinematics. Keys use Blender's discovered
frame contract; where frames are one-based, include full poses at frame 1 and
the final frame. Use available smooth interpolation and inspect current bounds.

Use discovered preview rendering for motion checks before a costly final.
Preview lighting/materials are draft evidence. Final rendering needs the final
mode and an intentional new key. Review pickup, handoff, release, collision
and landing over their actual motion intervals, not only start/end stills.

Bind held props to the discovered rig node with explicit grip offsets. Current
timed attachments use inclusive start and exclusive end frames. `KEEP_WORLD`
preserves the pickup pose; `LOCAL_OFFSET` applies an explicit grip and may move
the prop. Inspect consecutive pickup/release frames and free motion after release.
Attached roots must obey track restrictions and valid positive scales;
do not fake continuity with a prop that only happens to align in one still.

## Output and Composition

Select output by purpose and the live catalog: opaque MP4 is not a transparent
overlay; a PNG sequence supplies ordered immutable RGBA frames; a packed BLEND
file provides an editable native scene. If both overlay and editable scene are
requested, use separate format jobs with distinct keys for the same animation.
An exported scene does not automatically contain footage from the timeline.

For a transparent overlay, verify every expected PNG is present and ordered.
Put the footage on the lower composition layer and the sequence above it.
Map Blender frame 1 to timeline interval `[0,1)`, then `[1,2)`, preserving exact
rational frame rate, alpha and source/entry limits. Use zero frame dissolve.
The final composited MP4 is the composition render, not an opaque Blender render.

Validate, save and render the exact timeline revision. Inspect actual motion,
duration and frame rate. Rendered PNG animation frames are not generated video
reference frames; do not buy image analysis per PNG. Apply generated-scene and
final-video review requirements where relevant. Deliver native artifact links
and resource blocks; a file download ticket does not itself save a `.blend`.
