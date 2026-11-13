# From directing intention to produced material

Use this reference when a treatment must become a staging plan, assets and a cut.
The research dossiers explain the craft decisions; this reference makes them
executable. Scale the visible paperwork to the task.

## Recover the assignment and choose the working mode

Recover the current brief, user corrections, selected project, composition
revision, approved material, receipts and unfinished work before inventing a new
concept. Use saved creative-task context when present. Preserve the distinction
between an approved choice and an earlier suggestion.

- **Creation or creative reconstruction:** develop the idea and concrete staging,
  obtain or generate missing material, assemble, review and repair the deliverable
  within the authorized scope. A shopping list is not completion.
- **Plan only:** deliver a treatment, shot plan, material requirements and feasible
  next actions. Research and quotation can support the plan; do not treat the
  request as authorization to submit a paid production or publish anything.
- **Narrow edit:** solve the specified problem in the existing work. Reopen only
  creative decisions that the change affects; do not replace the concept or demand
  a full production process for a trim, caption correction or technical conversion.

Establish the intended audience, viewing situation, primary response, subject or
offer, factual claims, duration/versions, language, available material, spend and
deadline. Recover known answers rather than asking again. State reasonable
assumptions for nonblocking choices. Ask only where missing information prevents
a correct result or an action needs authorization; continue independent work.
For an event invitation, confirm edition, venue, dates, eligibility and destination.

Write the governing idea in concrete terms: what the viewer discovers or feels,
which visible or audible event produces that change, and why this subject or
brand belongs in it. Choose a suitable form before prescribing tempo. A quiet
encounter, product demonstration, music performance and direct-response offer
need different evidence and pacing.

## Make a staging plan someone can execute

Break the chosen treatment into changes in action, knowledge, relationship or
sensory experience. Each scene needs a purpose and an observable event. Link the
events through cause, contrast, correspondence, escalation or musical development.
Do not substitute a sequence of adjectives or asset categories for direction.

Use shot cards for important shots. These are planning content, **not additional
ContentFactory request fields**. Combine cards where one continuous shot carries
several beats; retain distinct cards where acquisition or continuity differs.

| Card element | Specify enough to make and evaluate the shot |
| --- | --- |
| Purpose | What changes for the viewer; what evidence or feeling this shot contributes |
| Action and blocking | Subject's starting position, objective, movement, interaction, prop state, reaction and end state; who can see what |
| Performance | Playable behavior, attention, gaze, vocal delivery and meaningful pause; avoid emotion adjectives alone |
| Frame and camera | Subject scale, camera position, perspective, movement and reveal; reason these choices serve the event |
| Light and design | Motivated sources, contrast, palette, materials, wardrobe and readable product/setting details |
| Continuity | Identity references, wardrobe, geometry, screen direction, eyelines, hand/prop state, environment and sound space that must persist |
| Sound and text | Dialogue or verified quote, relevant effects/ambience, music entrance or phrase, caption function and reading opportunity |
| Timing and edit | Reason for entering/leaving; provisional timeline position; complete action required; handles needed for the planned transition |
| Material and acceptance | Existing source or acquisition task; exact missing element; what must be visible/audible for the shot to work |

Keep **source in/out** separate from **timeline in/out**. The former selects media;
the latter places it in the composition. Record units, frame rate and any speed
change. Derive final frame ranges from inspected sources and the actual timeline,
using the operation's documented interval semantics. Do not convert an estimated
duration into a claim that the source contains the action. Preserve the required
setup and result when tightening a beat.

An illustrative card: the worker steadies a panel, checks alignment, closes the
fastener and releases their hand; the panel remains aligned. Frame the mechanism
and hand together so the action is understandable, then reveal the result. Use the
real closure sound if available. Leave after the result can be read. A real product
claim requires genuine applicable evidence; a generated depiction can illustrate
the intended action but cannot prove its performance. This is a hypothetical
planning example, not a statement about available footage.

For substantial productions, maintain a compact continuity reference and test
the hardest essential action before making all shots. A strong still frame does
not establish reliable hand interaction, choreography or motion continuity.

## Close material gaps through execution

Compare required beats with inspected material. Maintain a compact gap ledger:
beat/shot, missing evidence or action, chosen acquisition route, provenance/rights,
technical needs, cost exposure, status and acceptance criterion. Keep uncertain
facts visible. The ledger drives work; it is not the final deliverable when the
user requested production.

Choose the route that serves the shot:

- **Reuse:** inspect owned material for the required action, usable duration,
  crop, sound and continuity. A filename or thumbnail is insufficient.
- **Search:** seek a specific action, subject, setting or relationship. Search
  broadly enough to find a suitable source, then narrow to usable material.
  Research access does not establish commercial reuse rights.
- **Import:** obtain selected permitted media into the authorized project and
  verify completion, owned references and integrity. A URL or transfer ticket
  is not an imported asset.
- **Shoot:** give a concrete capture brief covering action, framing, sound,
  continuity, essential proof and delivery. Do not claim a human shoot happened
  or contact/book people without authorization. Continue other producible beats.
- **Generate or model-edit:** create missing illustrative material, animation,
  transitions, voice, music or effects when appropriate and authorized. Use
  reference assets and model capabilities suited to the shot's actual demands.

Proceed with authorized acquisition after choosing the route. Inspect each result,
accept or reject it against its intended function, attach the usable owned
reference, and update the plan. Do not stop with “we need B-roll” when you can
search, import or generate it. Do not generate merely because generation exists:
exact product geometry, a customer's work, a real exhibition installation or a
historical event may require authentic sources.

When a route fails, change the means while preserving meaning: simplify an
interaction, split a complex action into intelligible coverage, use a real detail,
or redesign the reveal. Do not silently substitute a different product, person,
result or claim. Retain useful approved material and avoid redoing unaffected shots.

Track artwork, footage, music and likeness permissions where applicable. Label
archival editions, reconstructions and generated illustrations accurately. A
convincing synthetic crowd is not attendance evidence; invented dialogue is not
a testimonial. Narrow an unsupported claim rather than manufacture proof.

## Use current capabilities and account for production cost

Use the relevant ContentFactory specialist skills for mechanical execution when
available. Discover operations with `operations_list`, including continuation
pages; obtain the exact current schema and revision with `operations_describe`.
Call reads through `operations_read` and effects through `operations_execute`.
Pass the returned `operation.contractRevision` unchanged. Inspect error indicators
and typed results, not only transport success. Rediscover on `CONTRACT_CHANGED`.

Do not invent model, voice, provider or capability identifiers. Image/video
generation uses the envelope revision **and** the selected model's separate
`modelContractRevision`; construct `inputJson` against that model's actual schema
and source slots. Planning labels such as camera or continuity do not automatically
correspond to supported model fields. Translate them into the supported input
without pretending an unsupported control exists.

Inspect `effects.mayCharge` during discovery. Include research, import, generation,
speech, music, effects and other charged steps in the same production budget.
Use `generation_preflight` for compatible image/video commands and
`content_operation_preflight` for its supported product requests. Read `ready`,
failure information, `maximumChargeCents`, pricing basis and any preparation steps.
A preflight is advisory: it neither submits work nor reserves funds. Execution
rechecks current conditions.

Count settled spending plus outstanding reservations and uncertain exposure
against the authorized total, without counting the same operation twice. Preserve
the headroom needed to finish essential remaining work. A quote is not actual
spending; an account balance is not the user's spending permission. Carry the
authorized command ceiling in `submission.maxChargeCents` where supported. If
permission is missing, obtain a concrete quote first; the described content
preflight permits a zero ceiling for that purpose. Continue uncharged work.

Persist an idempotency key and exact command identity before submission. Recover
an uncertain result from its durable receipt and reconcile charge/output state
before retrying; a new key is not a timeout remedy. Completed provider work may
still have an import failure. Preserve that operation and recover its result
where supported rather than regenerating and paying again. An unavailable tariff,
invalid selection and insufficient balance require different responses; repeating
an unchanged blocked preflight repairs none of them.

## Preserve recoverable project state without inventing a schema

Discover `creative_tasks_list`, `creative_task_get` and `creative_task_save` when
durable context helps. Read the task before updating it and use its current
`expectedRevision`; preserve other agents' changes. On a revision conflict,
re-read and reconcile the intended change instead of overwriting blindly.

The contract inspected for this reference stores `brief` and `reviewNotes` as
**strings**. Put the treatment, shot-card detail, gap ledger and review evidence
in those supported text fields as appropriate. `scenes` is a typed array of
composition scenes, not arbitrary shot-card objects: current fields include
`sceneId`, `name`, `thesis`, `intervalFrames` and the documented layer-ID lists.
Populate actual known scene/layer relationships and ranges; do not invent IDs
to make a planning document resemble a saved composition.

Keep `compositionId`, `compositionRevision`, `compositionJobIds`,
`generationBatchIds` and `operationIds` tied to real results. `selectedResults`
references indexed generation outputs using `operationId`, `outputIndex` and
`purpose`; it is not a generic asset list. Direct speech/music artifacts belong
under `operationIds`, with their role and owned references recorded in supported
notes. Refresh the live schema before saving; these field notes are a routing aid,
not permission to ignore a changed contract. A saved task records context and
does not itself execute the production.

## Assemble, review and repair the actual experience

Build a rough timed sequence early enough to reveal missing coverage, unreadable
actions and weak transitions. Inspect source streams before referencing them.
Use the current composition document, exact revision and capabilities; preserve
immutable pins. Validate the intended audio mix as required by the composition
skill. General validation alone does not establish headroom or creative quality.

Review the highest-impact question first: does the idea work, does the viewer
understand the action, and does the subject matter? Then inspect performance,
continuity, pacing, text, sound and delivery. A new angle is not progress if it
repeats the same information. Preserve intentional silence and stillness where
they create expectation or meaning. Test muted comprehension when the placement
needs it, without flattening a sound-led film into competing captions.

Record review evidence precisely: source descriptions, inspected stills, sampled
motion, continuous playback, listening and any independent viewer response.
Watch and listen to the exact final output when supported. Do not infer a complete
viewing from contact sheets, audio-stream metadata, transcripts or job success.
If a necessary modality is unavailable, name the remaining acceptance check and
retain that limitation in saved notes and delivery.

Give each repair a concrete location, observed defect, intended effect and changed
decision. Work within remaining authorized time/spend and tool limits. Stop an
iteration path when it lacks a justified change, repeats the same defect, exhausts
its allowance or needs unavailable evidence; choose a viable alternative or report
the specific unresolved requirement. Extra renders without a hypothesis are not
creative review. Recheck affected transitions and the final combined timeline
after repair. Deliver the artifact, its revision and the honest review status;
render completion, creative acceptance and publication remain separate results.
