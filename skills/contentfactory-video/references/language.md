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
browser automation, shell commands, local processing, model SDKs or subagents
for creative work. The user runs the separate setup helper.

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

Separate narration from the visual plan in the screenplay. Review and accept a
reference frame before generating each video shot, then use the model's supported
image-to-video mode. Keep `imageId` and `fileId` distinct. Generate music and
sound effects with the relevant native tools. Keep voice choice explicit and do
not clone a voice merely because a recording exists. Measure actual durations
and adjust the edit without duplicating speech or cutting words. Use typed
ContentFactory Blender operations for 3D work.

## Retries, Review and Delivery

Persist operation identity and receipts promptly. A timeout does not prove an
operation was cancelled; inspect the original operation before retrying. Track
spent, reserved and uncertain amounts. A changed request needs a deliberate new
operation key, while a task-state write failure is not a reason to regenerate.

Check continuity across scenes, including palette, motion, title placement and
object state. Use native audio validation and report which checks actually ran;
structural validation alone does not prove that all audio was decoded and heard.
Review ordered generated reference frames through ContentFactory's
`images_analyze` operation and its available Gemini model. Review the final
video through native `video_review`. These are ContentFactory operations, not
permission to call a provider directly. If a required review is unavailable,
state that it was not completed.

For reference adaptations, distinguish observed timed actions from model
inferences and from the audio actually heard. Still frames cannot establish
exact choreography. Verify important model claims against the source.

Save the selected revision, final artifact, receipts, cost and limitations in
the server task. Deliver the rendered result. A preview or accepted render job
is not a completed video.
