# Language and Localization

The user chooses the conversation language and may specify a different language
for individual outputs. Answer in the requested language. Keep scripts, captions,
narration, subtitles, prompts and final copy in their explicitly requested
languages. The instructions in this skill are written in English and apply to
every language.

## ContentFactory Tools Only

Use only the connection whose trusted client metadata identifies
`https://content-factory.art/mcp`. A familiar tool name or server alias does not
establish provenance. If the client cannot verify the endpoint, pause tool use
until that connection is verified. Do not use other MCP servers, web search,
browser automation, shell commands, local processing or model SDKs for creative
execution. Delegated roles follow the same boundary; one agent owns mutable
composition/task state. The user runs the separate setup helper.

Local file paths are not ContentFactory asset IDs. Ask the user to upload sources
through ContentFactory and select the resulting owned assets. Do not read local
source files, run an upload script or send media bytes in MCP JSON. Return native
media blocks and ContentFactory artifact links; a download ticket alone does not
mean a file was saved on the user's computer.

## Preparation and Production

Recover the current task, accepted assets, receipts, language choices, format,
duration and budget before starting new work. Keep one author for mutable task
and composition state. Discover current operations, schemas, models, voices,
fonts and limits through the verified connection. Get a current cost estimate
when available before a paid operation; missing pricing is not fixed by raising
the budget. Do not spend money to test connectivity.

For new productions and substantial creative recuts, the default orchestrator
uses the screenwriter first for meaning and general scenes, then the director
for filming, action, camera and sound, then execution specialists. Separate
narration from visual action. Select or generate and inspect an owned reference
frame before each generated video scene; reuse an accepted reference when
suitable and bind it using the model's supported conditioning mode. Do not
invent unsupported reference slots. Keep `imageId` and `fileId` distinct. Animate still sources
with supported video models; when that route cannot deliver within authorized
limits, use supported authored 3D/2D action. Static pictures with text/audio,
pan/zoom and transitions alone are not the fallback. Retained stills need a rare,
specific purpose and interval. Preserve factual evidence instead of animating
unverified behavior into it.

Generate music and sound effects with the relevant native tools. Keep voice
choice explicit and do not clone a voice merely because a recording exists.
Measure actual durations and adjust the edit without duplicating speech or
cutting words. Use typed ContentFactory Blender operations for supported 3D/2D
work. Standalone static outputs and narrow edits keep their requested scope.

## Retries, Review and Delivery

Persist operation identity and receipts promptly. A timeout does not prove an
operation was cancelled; inspect the original operation before retrying. Track
spent, reserved and uncertain amounts. A changed request needs a deliberate new
operation key, while a task-state write failure is not a reason to regenerate.

Check continuity across scenes, including palette, motion, title placement and
object state. Use native audio validation and report which checks actually ran;
structural validation alone does not prove that all audio was decoded and heard.
Review the exact final video in motion and listen where supported. Always
complete the final Gemini quality audit through ContentFactory `video_review`,
including after a small edit: submit the whole final video at durations up to
and including 180 seconds, or ordered video sections covering the entire longer
timeline with boundary context and original offsets. Follow `visuals.md` for
contract/model discovery, actual media limits, receipt/report completion,
coverage and findings, repairs and re-audit of the resulting final artifact.
Use `images_analyze` for useful reference-frame review; stills cannot replace
the final video audit. These are ContentFactory operations, not permission to
call a provider directly. Preserve privacy and authorized spend. If the Gemini
audit is blocked, state the missing prerequisite and incomplete audit status;
do not silently skip it or call the video finished.

For reference adaptations, distinguish observed timed actions from model
inferences and from the audio actually heard. Still frames cannot establish
exact choreography. Verify important model claims against the source.

Save the selected revision, final artifact, receipts, cost and limitations in
the server task. Deliver the rendered result. A preview or accepted render job
is not a completed video.
