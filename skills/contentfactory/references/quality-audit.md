# Mandatory final Gemini quality audit

Every final or revised video requires a Gemini quality audit through ContentFactory before it is presented as finished. This includes small caption/timecode changes and technical conversions. Narrow edits keep their narrow implementation scope; the final audit is still required. Plan-only work, static images and intermediate previews do not create a final-video audit obligation.

## Submit the final video, whole or in sections

Probe the exact owned final export and recover its immutable asset/file pin, render receipt, composition revision where applicable, duration and audio streams. Review that export, not an earlier preview or pre-edit render.

- **Duration <= 180 seconds (three minutes):** send the complete video, including its audio when present, to Gemini. Do not substitute sampled clips, a contact sheet or a transcript.
- **Duration > 180 seconds:** submit ordered temporal video sections that together cover the entire final timeline without gaps. Use sections no longer than 180 seconds, or a stricter discovered input limit. Keep context around cut boundaries, actions and speech, with overlaps where useful. Record each section's exact original start/end and its owned source pin so Gemini's section-relative findings can be mapped back to the film. Include whole-film scene order/context in the audit criteria without inventing observations of unseen sections.

The three-minute threshold is this workflow's review policy, not an assumed provider limit. Discover live duration, byte, codec and transport limits. If the full short video cannot be admitted, resolve a supported full-video route or report the audit as incomplete; do not quietly replace it with sparse samples. Preserve visible detail, timing and sound in review media instead of degrading away the defects being checked.

Discover `video_review` and its exact current contract through `operations_list` and `operations_describe`. Use the supported Gemini route and confirm the actual configured/returned provider identity where exposed. A server-selected model is not a client-selectable `modelId`; never invent model controls. If Gemini cannot be selected or verified, state that limitation rather than claiming a Gemini audit from another provider's result.

The current owner contract accepts one video source and criteria, with no review interval fields. For long-video sections, discover a supported ContentFactory media clip/trim operation to create owned video clips, then submit each source separately; do not invent `startMs`/`endMs` fields in `video_review`. Re-check the live schema in case this changes. All clipping, transfer, analysis and durable evidence stay in ContentFactory. Do not use a local renderer, direct Gemini SDK or another service as a hidden fallback.

## Ask for an actual quality audit

Give Gemini the intended meaning, ordered scenes, director's action/continuity requirements, accepted constraints, intentional still exceptions and relevant confirmed facts. Ask for timestamped issues with severity, visible/audible evidence and concrete corrections, covering:

- whether intended actions develop and finish, unintended freezes, repeated/static filler and motion artifacts;
- narrative clarity, pacing, shot continuity, identities, geometry, interactions and misleading synthetic/factual claims;
- captions and typography, reading time, language, crop, occlusion, transitions, black/blank frames and visible output defects;
- speech completeness and intelligibility, audible glitches, synchronization/lip sync, music/effect balance and purposeful silence where relevant.

Request explicit video/audio coverage and limitations. An intentionally silent source has no audio to review. Do not supply invented comparison audio or call source identity from a name alone. Native technical validation and exact timestamp checks still apply; Gemini's timing estimates are not sample-accurate measurements.

## Read the report, repair and close the loop

Submit within the existing authorization and price ceiling, retain each operation identity and poll `media_analysis_result_get` through completion. Read the typed report, timed issues, coverage, audio/video flags and limitations; admission, transport success or a queued operation does not complete the audit. Full timeline coverage reported by a model is not proof of frame-by-frame inspection. Record missing coverage and obtain the necessary review rather than labeling a partial result a pass.

Address material defects in the owned editable project. Check a finding against the actual artifact before changing it; retain a reason when evidence contradicts a recommendation. Render corrections, then apply the same whole-video/sections rule to the corrected final export. A report on an older artifact does not audit a new render. Reuse a completed report without another charge only for the same exact pinned final artifact/section and criteria; preserve the full section map. Do not repeatedly analyze unchanged media without a concrete reason.

Persist the final pin/revision, duration, submitted section map, Gemini operation/report identities, coverage, findings, repairs and remaining limitations in supported creative-task fields. Deliver the artifact with a concise audit outcome and unresolved issues. Gemini review does not constitute the user's creative acceptance.

## Budget, privacy and blocked review

Plan and quote the mandatory audit early, keeping review, production and import costs distinct. This standing workflow requests Gemini audit; do not ask again whether it should run when its source scope and spending authority already exist. It does not authorize unlimited charges or sending private visuals under an audio-only grant. Reconcile uncertain receipts, reservations and settled charges before retrying; preserve idempotency for identical requests and bound repair/review attempts by the established budget and terminal errors.

If tool exposure, Gemini availability, source/transfer capability, privacy scope or authorized spend prevents the audit, continue useful independent work and report the exact missing prerequisite. Mark the output as a draft with the required audit incomplete, not a finished quality-checked video. Do not silently waive the requirement or spend past an explicit ceiling.
