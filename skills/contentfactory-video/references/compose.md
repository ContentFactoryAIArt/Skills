# Composition and Delivery

Recover the task and current composition revision. Read
`composition_capabilities` for current profiles, fonts, features, limits and
`audioPolicy`. Save new documents with `composition_save`; make focused changes
with `composition_edit`, compare-and-swap revisions and idempotency keys.
Prefer overviews and changed-layer projections; a projection is not a complete
replacement. Keep stable scene/layer IDs and exact owned source references.

Use measured source/audio intervals and explicit frame/sample units. Parent
groups do not shift child timing. Preserve continuous media across layout
changes and avoid cut words or duplicate narration. Native video audio is
supported; extracting every soundtrack is not a prerequisite for rendering.

## Motion and Editorial Continuity

For authored movement, use native `motionSequence` when exposed. Supply ordered
rational-second poses, explicit time rounding, full transforms and easing.
Use exact rounding when a time lands on a frame; inspect returned resolved
times for other rounding modes. Never pass fractional frame indexes or repair
invalid output with hidden rounding. The duration boundary is exclusive: the
last valid frame of a 576-frame document is 575, not 576.

Provide complete transforms, including scale, opacity and flips. Zero values
are not inferred defaults. Preserve source, trim, crop and mask geometry. A
motion sequence replaces numeric tracks; it does not append to an old route or
restart media. Group times remain global. Move related parts together where
appropriate and follow the current native contract.

Design adjacent scenes as a sequence with compatible palette, brightness,
framing and motion rhythm. Deliberate contrast can serve a story beat. Avoid
unintended jumps from active animation to unrelated motionless layouts; a
dissolve alone does not solve a mismatch. Use purposeful source/layer motion.

Keep recurring headline anchor, alignment, margins and scale stable. Reserve
space around browser captures or source footage. Change headline placement
only for a clear compositional reason with a legible transition. Review a
reported boundary issue in motion on both sides; stills establish placement
but do not establish smooth movement.

## Audio and Rendering

Validate against the exact profile and capability revision. For immutable FILE
audio sources, use `composition_validate` with `inspectAudioMix=true` when
supported, then read `valid`, violations and `preflight.audioMixInspected`.
`valid=true` alone does not prove headroom or full stream inspection.

Read `audioPolicy.maxSampleAmplitude` and `overflowPolicy`. Overlaps, automation,
fades and embedded video audio all contribute. Compressed audio can decode above
full scale even at nominal zero gain. Fix appropriate gains or duplicate tracks
and validate the changed mix. Clipping is not evidence that embedded video audio
is unsupported. For actual render failures, use `render-failures.md`.

Render the saved immutable revision with `composition_render` and follow its
existing job through native wait/batch reads. Verify the exact exported artifact's
duration, format and relevant opening/ending or transitions. Complete generated
scene-frame/final-video checks from `visuals.md`, reference comparisons from
`reference-video.md` and listening coverage from `audio.md` as applicable.

Save revision, job, output ordinal, owned asset/file, digest, receipts, actual
cost and review limitations in the creative task. Preview evidence belongs to
its preview/revision; a new export does not inherit an old artifact's inspection.
Report sampled, model-assisted and actually perceived motion/audio separately.

Deliver `composition_artifact_get`'s authorized artifact link. A pending job or
preview is not a final export. A `file_download` ticket is not a completed local
download; let the user use ContentFactory's artifact page. Report material
remaining checks directly and do not claim exhaustive fidelity from a few stills.
