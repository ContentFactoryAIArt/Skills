# Preparation and Screenplay

Recover `creative_task_get` or locate the existing task with
`creative_tasks_list`. Select suitable project-owned assets before generating
replacements. Use `media_probe` when duration, dimensions or format affects the
edit. For local material, the user uploads through ContentFactory; this skill
never reads or uploads local files through another tool.

For a supplied video reference, read `reference-video.md` before adaptation.
A supplied URL selects source material; it does not call for unrelated search.
Use native `research_search` only for genuinely missing material. Discover a
supported native import path for the given URL type. YouTube
`research_collect.youtubeDownload` imports playable media; `youtubeVideos`
returns metadata. Preflight paid collection, retain provenance and exact owned
asset/file IDs, and recover its receipt. A search URL is not an imported asset.

For Telegram sources, discover the operation appropriate to the chat:

- `telegram_messages_collect` reads bounded oldest-first history from one public
  group, forum or channel. Select `chat`, `maxMessages` and optional `startDate`
  from its current schema. Preflight the equivalent
  `research.telegramMessages` request. Read `research.telegramMessages` from the
  completed receipt; retain message URLs/IDs and any returned `threadId`,
  `topicName`, `replyToMessageId` and `replyQuote` so forum conversations stay
  distinguishable. Missing topic/reply fields are unknown; do not invent them.
- `telegram_posts_collect` reads public channel web previews with its documented
  text/date/media filters. It does not read group or forum history. A group
  landing page or an empty successful dataset is not proof that its messages
  were inspected; use the messages operation for group/forum sources.
- `telegram_post_media_download` imports visible preview media from exact public
  post or topic URLs. Supply `input.postUrls`; no history scan limit is needed.
  It supports photos, voice audio and videos up to 60 seconds, without claiming
  original quality or complete albums. Preflight `research.telegramPostMedia`.
  Submit Telegram post links only; direct file URLs and provider credentials
  are resolved internally and are not caller inputs.
- `telegram_media_download` imports attachments from selected message/post URLs
  into owned assets. Describe its current URL and bounded-scan contract before
  submitting. Text collection alone does not import or verify playable media.
  A settled `FAILED` receipt may retain complete independent files in
  `research.media` and `artifacts`; inspect `research.telegramMediaFailures`
  before selecting footage. An incomplete album returns no partial album.
  For a historical settled `source_media_resolution` rejection, describe
  `content_operation_result_recover` to recover available files from the existing
  completed source run without another provider submission or charge. Poll the
  separate recovery receipt and preserve the original receipt and charge;
  unavailable files remain unavailable. Never repeat the paid run automatically.

Message limits bound returned rows, not complete chat or topic coverage. Preserve
the requested source and history boundary, poll the existing paid receipt, and
report actual returned coverage and charge before increasing a scan or retrying.

Keep a concise brief: audience, output language, duration, aspect ratio, factual
claims, selected sources, creative choices and total budget. Resolve essential
unknowns while continuing independent authorized work. Do not silently shorten
the requested runtime, replace a chosen voice or change reference fidelity.

Check readiness only for the chosen path: current contract revision, composition
capabilities, selected model/voice, exact preflight and client viewing/listening
abilities. Discovery, permission, pricing, admission and completed execution are
different facts. Do not pay merely to discover whether a route works.

Perform the screenwriter role first: establish the meaning, intended viewer
response, story beats and general scenes, using stable planning labels. Reuse
actual server scene IDs only when recovered from the project; do not invent IDs
for a draft screenplay. Then perform
the director role: turn those scenes into observable action, performance,
filming, camera, sound and acquisition choices. Reuse the installed specialist
handoffs when available. Keep spoken text separate from stage direction and
send exact chosen words to speech synthesis. Draft timings remain estimates
until audio is measured; adjust the edit or rewrite within the authorized task.

For references, carry observed timed actions and required fidelity into the
scene plan. Resolve unobserved actions before spending on dependent scenes.
Plan neighboring scenes and recurring headline anchors together, following
`compose.md`. Keep captions legible and leave time to read them. When a product's
source catalog changes, prefer a flexible quantity claim unless an exact count
is requested and verified.

For generated video scenes, select a supported route that delivers the intended
action. Select or generate and inspect owned reference frames before video
submission, as described in `visuals.md`; reuse accepted references. A still is
preparation, not the finished
scene. Animate still sources with compatible video models when appropriate,
then use supported authored 3D/2D action if models cannot deliver within the
authorized limits. Do not substitute a slideshow. Suitable independent audio/visual requests
can run concurrently. If runtime exceeds a discovered composition limit,
preserve total duration and story order in the fewest consecutive parts that
fit. If one file is explicitly required, discover a native assembly path and
report an actual limitation before changing that requirement.
