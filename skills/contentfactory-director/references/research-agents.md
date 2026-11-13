# Creative agents and portable director skills

Research checked on 2026-11-13. Read this reference when maintaining the skill,
choosing a host adaptation, or checking why a workflow decision was made. It is
evidence for the skill design, not a requirement to read every source on every job.

## Scope and evidence

The comparison covers three research systems and three commercial production
workflows. Research papers, public implementation files, and vendor documentation
were opened. None of these systems was installed or run for this research; their
showreels were not continuously watched or listened to. Published benchmark claims
and product descriptions therefore remain attributed claims, not our acceptance
results. The sources do not establish a current popularity ranking of models or
agents. Codex, Claude Code, and Grok are the requested targets; Gemini CLI and
OpenCode are additional documented portable hosts.

## What comparable systems actually contribute

| System | Observed design | Useful decision for this skill | Limit of the evidence |
| --- | --- | --- | --- |
| FilmAgent | Crew roles develop ideas, dialogue/actions, positioning, and camera annotations; intermediate revisions operate in a predefined Unity environment. Public code has separate bounded review stages. [A1-A3] | Separate dramatic intent, playable action, and camera coverage. Give a reviewer a concrete script or shot plan and the available capabilities. | A bounded virtual environment and a 15-idea study do not prove general directing quality, commercial effectiveness, or unrestricted physical staging. |
| MovieAgent | Script and character references become sub-scripts, scene annotations, shot annotations, generated media, then an assembled video. Intermediate JSON artifacts are saved. [A4-A6] | Keep a traceable hierarchy from story beat to scene to shot to media; preserve character and prop references across shots. | Public orchestration examined is substantially sequential. Its final assembly concatenates files; that is not an observed creative editing or listening pass. |
| MovieDreamer | Multimodal scripts condition a hierarchy of narrative/keyframe generation and rendering, with character and style information. [A7-A8] | Use a continuity bible and anchor frames where a shot depends on identity, geography, or the end state of an earlier shot. | This is a generation architecture, not a general-purpose producer agent or a portable skill. Reported coherence does not establish performance, taste, or marketing results. |
| Google Flow Agent | Conversation can develop boards/mood boards, generate or edit media, batch variations, and organize project assets. Instructions and sessions are project scoped. [A9] | Direction should continue into sourcing and making missing material, with project context and the authorized spend carried into execution. | Official help documents supported actions. It does not provide an independent quality benchmark or prove our ContentFactory access. |
| LTX Studio | Storyboards expose project/board/frame control; Flows connect prompt, image, video, audio, and finishing nodes, with reuse of unchanged work. [A10-A11] | Resolve story and staging in a reviewable board/animatic before expensive finishing. A local change should preserve useful approved material. | Vendor workflow descriptions establish intended controls, not guaranteed shot consistency or cost savings for a particular project. |
| Runway Workflows | Reusable pipelines connect modalities and generation/refinement steps; featured workflows include storyboards and animatics. [A12] | Keep execution reproducible and make intermediates inspectable. Reuse a proven workflow after selecting a suitable concept. | Pipeline automation is not proof that its concept, acting, visual argument, or final rhythm is good. |

### Findings from implementation, not marketing

FilmAgent's inspected `main.py` separates casting, scene planning, dialogue,
position/action annotation, movement, and camera work. It also contains approximate
matching of generated names/actions to available values. Its cinematographer and
shot-review prompts prescribe some camera sequences as rules, including restrictions
on where tracking or zoom shots appear. These are implementation choices for that
environment; they must not become universal directing rules. [A2-A3]

MovieAgent's inspected `run.py` creates screenwriting, scene-planning, and shot
agents, persists each stage, generates media, and concatenates resulting clips.
The inspected prompts contain fixed segmentation limits and word-count demands.
Their existence is evidence of how that implementation works, not evidence that
these numbers improve a different production. [A5-A6]

For ContentFactory, borrow the separation of responsibilities and explicit
intermediates. Do not copy upstream runners, tool catalogs, hidden-reasoning output
demands, approximate semantic repair, or arbitrary scene/shot limits. Preserve the
owning operation contracts and strict validation. Ask the model for a short creative
rationale and a usable production artifact, not a transcript of private reasoning.

## Synthesis: what the director-producer layer must add

This is an inference from the comparison, not a measured claim that a particular
prompt will improve every film.

1. **Choose a dramatic or persuasive mechanism.** A treatment must explain what the
   viewer discovers, feels, or comes to believe, and which visible or audible event
   causes that change. A list of attractive shots is insufficient.
2. **Design observable staging.** Identify the subject's objective, action,
   obstacle, interaction, spatial relationship, and resulting change. Specify why
   the camera position and movement reveal that action. Stillness can be active;
   a moving camera can be empty.
3. **Produce the needed material.** Compare required beats with available assets.
   For each gap, choose an authorized real-source search/import, a shoot brief, or
   generated material. Record provenance and whether it can substantiate a claim.
   Generate missing illustrative material when tools, rights, and budget permit;
   do not stop at a shopping list when execution is part of the user's request.
4. **Carry continuity through execution.** Track identity, wardrobe, props,
   geography, eyelines, screen direction, lighting, action state, and sound space
   where they matter. Deliberate discontinuity needs a perceptible purpose.
5. **Review time, not merely images.** Boards support composition decisions;
   animatics support timing; continuous playback and listening support motion,
   performance, edit, and sound judgments. One proof level cannot substitute for
   another. Fix the highest-impact defect before decorating the cut.
6. **Use bounded disagreement.** A producer checks feasibility and evidence; a
   director owns the coherent choice; an independent critic checks a specific
   draft against the brief. Extra personas alone are not a quality mechanism.

For existing footage, the material inventory constrains the treatment. For new
production, the treatment drives a sourcing/generation plan. In both cases the
director remains responsible for the resulting viewing experience rather than
ending the assignment after successful tool calls.

## Host compatibility verified from current documentation

The same instruction-only skill folder can carry the creative core. Host-specific
discovery and tool availability belong in small adapters; they must not cause
different artistic standards or silently switch the user's chosen model.

| Host | Documented packaging and invocation | Adaptation boundary |
| --- | --- | --- |
| Codex | `SKILL.md` with `name` and `description`; repository/user `.agents/skills/<name>/`; metadata first, full instructions when selected; explicit `$name` or skill selector and implicit matching. Optional `agents/openai.yaml`. [H1] | Keep description precise and body compact; load genre/reference files when relevant. File presence is not evidence of actual invocation. |
| Claude Code | `.claude/skills/<name>/SKILL.md` or `~/.claude/skills/<name>/SKILL.md`; YAML frontmatter and supporting files; `/name` and description-based selection. [H2] | Use the shared portable fields. Do not force `context: fork`, grant tools, or pin a model merely to install a creative skill. Local installation does not automatically make it available in every cloud/Cowork surface. |
| Grok Build | `.grok/skills/<name>/SKILL.md` in project/user scope; slash commands and automatic selection. Official docs also describe Claude compatibility and user `.agents/skills`. [H3-H4] | Native skill support is established. Avoid claiming that Grok chat and the raw API use the same folder discovery. Keep permissions in the host, not prose. |
| Grok chat / xAI API | API function calling uses explicit tool definitions, host execution, and returned results; remote MCP is a separately documented integration. [H5-H6] | Supply the core and selected references as instructions/context in the actual surface. A prompt alone does not install tools, authenticate ContentFactory, or prove access to project files. |
| Gemini CLI | Native `.gemini/skills/<name>/` and `.agents/skills` aliases; metadata discovery, `activate_skill`, then resource loading. [H7] | Observe the host's activation consent. Do not add an artificial approval gate to every subsequent creative step. |
| OpenCode | `.opencode/skills/<name>/SKILL.md`; user `~/.config/opencode/skills`; `.claude/skills` and `.agents/skills` compatibility locations; on-demand `skill` loading. [H8] | Keep the folder name and identifier aligned. Avoid multiple divergent installations with the same identifier. Model provider selection remains a host setting. |

### Grok documentation discrepancy

The official web page says `model` and `effort` are accepted but not applied and
`allowed-tools` does not grant or restrict tools. The public repository guide calls
`model` and `effort` overrides and describes `user-invocable: false` differently.
Both were read on the check date. Use only `name` and `description` for the common
package; do not depend on those disputed fields. Test the installed Grok Build
version before documenting behavior beyond the common format. [H3-H4]

### Model adaptation without invented rankings

Select from the models actually offered by the host/account. Record the selected
model and host version in evaluation evidence. Do not embed a supposedly permanent
"best" model name, context limit, temperature, or popularity claim in the core.

Use a strong reasoning model for comparing treatments, resolving conflicting
constraints, and reviewing story causality. Use a cheaper/faster model for bounded
inventory or formatting only after checking its output. This is a proposed work
allocation, not a benchmark result. The director keeps responsibility for the
whole cut regardless of delegation.

Modality is a capability of the actual model-plus-tool path. Codex documents image
input [H9]; this does not prove continuous video playback or audio listening.
Grok Imagine's video-generation interface [H10] is likewise not proof that a chat
model reviewed an exported video's motion and sound. Discover the current
ContentFactory inspection operations and supported inputs at runtime. If only
frames or transcripts are available, label the review accordingly and retain the
unverified motion/audio checks. Never convert a sampled review into a claim of a
complete viewing.

## Evaluation consequences

OpenAI's skill-evaluation guidance separates explicit, implicit, contextual, and
negative invocation cases. Its newer prompting guidance favors concise routing
and progressive disclosure over bloated recipes. [H11-H12] Apply those ideas to
creative outcomes, not just to matching headings in the generated document.

An appropriate behavioral set should include a restrained film scene, a practical
product demonstration, a sound-led music montage, a short social ad, and a repair
of repetitive existing footage. Include insufficient media, unavailable audio
review, a missing shot that can be generated, budget exhaustion, a false marketing
claim, and a simple technical transcode that should not trigger full directing.

Score whether the output provides a specific mechanism, executable staging,
intentional pacing, a feasible material plan, evidence-aware claims, and honest
review coverage. Require a concrete repair when a critic finds a defect. A
successful Markdown/frontmatter check establishes package integrity only.

Record validation separately: package checks; behavior in the evaluating agent;
native host discovery/invocation; actual model runs; rendered-media viewing and
listening; and user acceptance. Passing one must not be reported as passing all.

## Source register

All entries below were opened or fetched on 2026-11-13. Dates are publication or
update dates visible in the source; "undated" means no reliable date was captured.
The notes are short original summaries, not copied instructions or source code.

- **A1 — FilmAgent: A Multi-Agent Framework for End-to-End Film Automation in
  Virtual 3D Spaces.** Submitted 2025-01-22. Research paper abstract and project
  page: crew roles and intermediate feedback; evaluation is limited to its stated
  study and environment. https://arxiv.org/abs/2501.12909 and
  https://filmagent.github.io/
- **A2 — FilmAgent public orchestration.** Undated moving `main` branch; inspected
  implementation, not executed. Casting, actions, movement, bounded review, and
  approximate value matching are visible in the owner code.
  https://github.com/ailabteam/FilmAgent/blob/main/FilmAgent/main.py
- **A3 — FilmAgent cinematography prompts.** Undated moving `main`; inspected
  production prompts expose environment-specific camera prescriptions. Their
  limits are why this skill should use motivated choices instead of copying rules.
  https://github.com/ailabteam/FilmAgent/blob/main/FilmAgent/Prompt/cinematographer.txt
  and https://github.com/ailabteam/FilmAgent/blob/main/FilmAgent/Prompt/shot_review.txt
- **A4 — Automated Movie Generation via Multi-Agent CoT Planning.** Submitted
  2025-03-10. Paper and project description: hierarchical planning and a character
  bank; quality claims are the authors' reported results.
  https://arxiv.org/abs/2503.07314 and https://weijiawu.github.io/MovieAgent/
- **A5 — MovieAgent public orchestration.** Undated moving `main`; inspected
  `run.py` (blob `8e302e4b66eccb895113133ab9530598348b516a`). Script/scene/shot
  artifacts, media generation, and final concatenation were read, not executed.
  https://github.com/showlab/MovieAgent/blob/main/movie_agent/run.py
- **A6 — MovieAgent system prompts.** Undated moving `main`; inspected initial
  sections (blob `f34afe949cf4b5da5b9c3d02f1d780467034bcd5`). Fixed segmentation
  requirements illustrate implementation policy, not universal craft evidence.
  https://github.com/showlab/MovieAgent/blob/main/movie_agent/system_prompts.py
- **A7 — MovieDreamer: Hierarchical Generation for Coherent Long Visual Sequence.**
  Submitted 2024-07-23, revision 2025-11-25. Abstract establishes the proposed
  hierarchy and multimodal-script approach, not our reproduction of results.
  https://arxiv.org/abs/2407.16655
- **A8 — MovieDreamer project/methodology.** Undated project page. Describes
  keyframes as anchors and character/style conditioning; demonstration videos
  were not continuously reviewed. https://aim-uofa.github.io/MovieDreamer/
- **A9 — Use the Google Flow Agent.** Undated live help. Documents planning,
  generation, editing, asset organization, project sessions, instructions, and
  configurable confirmation before credit-consuming actions.
  https://support.google.com/flow/answer/17093911
- **A10 — LTX AI Storyboard Generator.** Undated vendor page. Documents controls at
  project, board, and frame levels; marketing quality claims were not independently
  accepted. https://ltx.io/studio/platform/ai-storyboard-generator
- **A11 — How to Build Your First Flow in LTX Studio.** 2026-05-07. Vendor tutorial
  describes connected production nodes, brand-kit references, and cached unchanged
  nodes. https://ltx.io/blog/ltx-studio-flows
- **A12 — Runway Workflows.** Undated vendor page. Describes connected generation
  pipelines and reusable storyboard/animatic templates; it does not establish
  creative superiority. https://runway.com/workflows
- **H1 — Build skills, official OpenAI documentation.** Undated live documentation;
  the former Codex skills URL redirected here. Portable format, discovery paths,
  progressive disclosure, and invocation were checked.
  https://learn.chatgpt.com/docs/build-skills
- **H2 — Extend Claude with skills.** Undated live Claude Code documentation.
  Checked local paths, frontmatter, supporting files, invocation, and distinctions
  between local and cloud/account skill availability.
  https://code.claude.com/docs/en/skills
- **H3 — Skills, Plugins & Marketplaces, Grok Build.** Updated 2026-08-11. Native
  skills and field behavior are documented; retain the discrepancy noted above.
  https://docs.x.ai/build/features/skills-plugins-marketplaces
- **H4 — Grok Build public user guide: Skills.** Undated moving `main`; fetched blob
  `1c8d6734f8d529a22eb46b43150e7f0b28876019`. Confirms native skill layout and
  inspection command, but differs from H3 on optional fields.
  https://github.com/xai-org/grok-build/blob/main/crates/codegen/xai-grok-pager/docs/user-guide/08-skills.md
- **H5 — xAI Function Calling.** Undated live API documentation. The caller defines
  tools and executes returned function requests; instructions alone do not create
  an executor. https://docs.x.ai/developers/tools/function-calling
- **H6 — xAI Remote MCP Tools.** Undated live API documentation. Establishes a
  separate MCP integration surface; no ContentFactory connection was tested here.
  https://docs.x.ai/developers/tools/remote-mcp
- **H7 — Gemini CLI Agent Skills.** Undated live documentation. Checked discovery
  tiers/aliases, activation, consent, and conditional resource access.
  https://geminicli.com/docs/cli/skills/
- **H8 — OpenCode Skills.** Undated live documentation. Checked native and
  compatibility locations, relative references, identifiers, and on-demand loading.
  https://opencode.ai/docs/skills
- **H9 — Image inputs, official OpenAI documentation.** Undated live documentation.
  Describes image inputs to Codex; it does not establish a complete video/audio
  review capability. https://learn.chatgpt.com/docs/image-inputs?surface=cli
- **H10 — Grok Imagine Video API overview.** Undated live API documentation.
  Describes video generation/editing modes; generation support is distinct from
  inspection of the result. https://docs.x.ai/developers/model-capabilities/video/overview
- **H11 — Testing Agent Skills Systematically with Evals.** 2026-01-22. Official
  OpenAI guidance on explicit, implicit, contextual, and negative tests and
  observable execution evidence. https://developers.openai.com/blog/eval-skills
- **H12 — Rethinking skills and prompts for GPT-6 Astra.** 2026-09-11. Official
  OpenAI guidance on precise descriptions, progressive disclosure, and avoiding
  over-prescriptive recipes. This is design guidance, not a creative-quality
  benchmark. https://developers.openai.com/blog/rethinking-skills-and-prompts-for-gpt-6-astra
