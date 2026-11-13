# Working with Codex and ContentFactory

Use a normal request. You do not need to name every technical operation or complete a form. The skills route creation, editing, generation, media analysis, project assets and rendering through ContentFactory. Naming `$contentfactory` makes that choice explicit when starting a fresh conversation; installation and a responding MCP still need to be verified in that environment.

## Start with the outcome and your material

The most useful inputs are the desired action, audience, destination, source material, facts that must be correct and a few creative preferences. Provide whichever are known. Codex should retrieve existing project decisions and make routine choices rather than asking you to repeat them. A question is needed when a missing fact changes the result or an external upload lacks authorization.

For an advertisement, useful detail includes:

- What to promote: an event, membership, service or product; its confirmed date/offer and call to action.
- Who should respond and where the ad will appear: for example, installers watching a vertical Telegram video.
- Which supplied material matters: an existing ContentFactory project/asset ID, a public source, or local files you authorize for import. Say which sources must be used or avoided.
- Style constraints: language, approximate duration, pace, examples you like, and concrete dislikes such as bulky captions or repetitive speaker angles.
- Review and spending constraints: whether you want to judge a preview yourself, the budget for the mandatory final Gemini audit, and any additional analysis limits.

For example:

```text
$contentfactory
Сделай вертикальную рекламу встречи «<название мероприятия>» <дата>.
Цель — чтобы <аудитория> перешли в группу и узнали, как участвовать.
Используй проект <project-id> и приглашения <asset-ids>; контекст бери из
<ссылка на публичную группу>. Надписи на русском. Живой темп, разные люди и действия,
без повторов одного спикера. В начале законченное движение, а не обрывок.
Речь не обрывай, текстом рот не закрывай. Финальную версию отправь
в Gemini на аудит качества, затем покажи мне ролик и итог проверки.
```

This example uses an already authorized project and assets. For local private files, add a concrete import scope if you want them transferred:

```text
Файлы <конкретные пути> можно загрузить в выбранный проект ContentFactory
для монтажа. Во внешнюю модель для анализа разрешаю отправить только аудио
из <файл>; изображения и видео туда не отправляй.
```

An import into ContentFactory and sending material onward to a model provider are distinct permissions. Public-source collection, source reuse and publication are also separate matters. Codex should preserve earlier authorization rather than ask again for the same allowed action. If the platform cannot perform the requested operation, it should state that limitation instead of silently switching to local media tools.

If only audio transfer is authorized, uploading the full video container is still outside that scope. When there is no permitted audio-only extraction/transfer path, Codex must explain that limitation and request an appropriate audio-only source or a specific scope change. An upload UI does not override the privacy restriction.

## What a useful first draft should contain

The default ContentFactory orchestrator uses the screenwriter first to connect the brief and verified sources to a meaning and general scene sequence, then the director to plan filming, action, performance, camera and sound. For generated scenes, the director prepares and inspects actual reference frames first, then shows you a rough storyboard and proposed object placement. Video generation, including paid motion tests and new 3D/2D animation, waits for your explicit approval of that concrete package. Reuse accepted scripts and approval of identical frames/staging. The storyboard should explain why each shot is present and what the viewer is meant to understand. It should not invent names, venue details, attendance or customer-work claims.

Video should primarily contain moving scenes. Still sources are animated through supported models; if that cannot deliver, the director stages supported 3D/2D animation. Static pictures with narration, text, pan/zoom or transitions are not the default fallback. Retained stills need a specific purpose, such as an intact evidence image or legible end card. A request for a photo or poster remains a still-image task.

You can ask for the board before rendering when you want creative control:

```text
Сначала покажи короткую раскадровку: время, источник, смысл кадра,
надпись/речь и переход. Отдельно отметь фото, прошлые события и генерацию.
После согласования собери ролик в ContentFactory.
```

Even when you ask to produce the ad directly, generated video waits for your approval of the actual reference frames, rough storyboard and proposed object placement. An initial production budget alone is not approval of an unseen package. After approval Codex proceeds through production and the final Gemini audit without repeating the same question; material changes to the affected beat are shown again. Seedance 2.5 is preferred when a live configured route supports the approved references and authorized quote; unavailable or incompatible choices are disclosed. Caption edits and technical conversions without new generated scenes do not restart storyboard approval.

## Ask for a correction by timecode and desired result

Use the current output or composition ID/revision when several versions exist. Say what feels wrong and what the viewer should see or understand instead. You do not need to know a layer ID: Codex should find it.

```text
В текущей версии на 00:10 убери всю вставку с фото котла.
Продли предыдущий живой кадр, если там есть продолжение, и сохрани речь.
В остальном оставь согласованный монтаж. Проверь только эту склейку.
```

```text
На 00:08 пусто и непонятно, зачем показан зал.
Добавь короткую русскую строку о смысле этой сцены в свободной области,
не поверх людей. Сделай читабельно на телефоне.
```

```text
Интро обрывается до завершения движения. Дай ему закончиться,
на мгновение покажи итог и плавно перейди дальше. Начало речи сохрани;
когда спикер появится в кадре, губы должны совпадать с голосом.
```

Removing an insert, deleting one frame and shortening the whole timeline are different edits. If the surrounding conversation establishes the intended behavior, Codex should use it. If the difference has a material consequence that cannot be inferred, it should clarify that specific point.

For episodic work, name the episode/scene and whether the timestamp is inside that episode or the complete video. Codex should recover the saved scene IDs and clock offsets, preserve neighboring episodes and save the revised plan in the same ContentFactory task. You do not need to invent an episode-specific API or name internal layer IDs.

## Keep the project continuous

Use one ContentFactory project for the brief, imported sources, generated assets, composition and render outputs. Revisions should refer to that project's asset IDs and saved composition revisions. A downloaded MP4 is a delivery copy; it should not replace the editable project as the source of truth. If returning in a new chat, supply the project ID and current composition or output ID so Codex can resume instead of recreating local scripts.

Importing an old flattened MP4 does not restore its original layers or hidden source content. Codex must check whether reconstruction is feasible before promising an editable continuation. Installing skills does not migrate an existing local project.

For repeated campaigns, a dedicated working directory with an `AGENTS.md` is useful. It can set the ContentFactory-only execution rule, link the skill, record the selected project ID and specify language/review preferences. Keep credentials, raw private conversations and personal data out of that file. Store project creative records in ContentFactory using supported project/creative-task operations; local instructions and user-requested reports are coordination documents.

An `AGENTS.md` helps Codex choose the right workflow. It is not a runtime security boundary, and it cannot prove that a heavy worker ran. Ask for the composition revision, job/receipt and output asset when that proof matters.

For Codex, the template is `~/.agents/skills/contentfactory/assets/AGENTS.template.md` (Windows: `%USERPROFILE%\.agents\skills\contentfactory\assets\AGENTS.template.md`). Other clients use their installed skills root. Copy it into a dedicated campaign directory as `AGENTS.md` and open that directory in the agent. Leave unknown project IDs blank until live discovery. Restart/reload skill discovery after installation; a workspace can also explicitly instruct the agent to read the installed entrypoint when the catalog is stale.

## Mandatory final Gemini quality audit

Every final or revised video must be sent to Gemini through ContentFactory for a quality audit. If it is up to and including three minutes long, submit the complete video. For longer videos, submit ordered video sections covering the whole export, retaining context around joins. This applies after small caption edits too; focused checks of the changed interval supplement the final audit.

Plan the required review cost early and keep review and production budgets separate. A $0 review ceiling forbids paid review and leaves the mandatory audit incomplete unless an authorized no-charge route exists. Codex should check actual quotes/effects rather than assume an operation is free, reuse existing authorization, and state the exact blocker when access, privacy scope or spend prevents the audit.

```text
После финального рендера отправь видео в Gemini на аудит качества через
ContentFactory: до трёх минут включительно целиком, более длинное — частями
с покрытием всего ролика и контекстом склеек. Исправь существенные замечания
и проверь исправленный результат. Покажи мне ролик и краткий итог аудита.
```

Read the completed Gemini report and its video/audio coverage, address material defects and audit the corrected final export. Keep the output revision, section time map, receipts, findings and limitations in the ContentFactory task. A queued request, contact sheet or transcript does not complete the audit. Model-reported full coverage is not a guarantee of frame-by-frame inspection or the user's creative acceptance.

Expect a concise delivery: exact output, what changed, the Gemini audit outcome and any unresolved limitation. Confirmed receipt charges support cost reporting; reservations, guesses and Codex token use are not the same as settled operation cost.

You can simply say “continue in the same project.” The assistant is responsible for reading the instructions, retaining accepted choices, challenging its own shot choices and using the authorized platform workflow.
