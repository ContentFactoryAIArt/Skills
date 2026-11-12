# Working with Codex and ContentFactory

Use a normal request. You do not need to name every technical operation or complete a form. The skills route creation, editing, generation, media analysis, project assets and rendering through ContentFactory. Naming `$contentfactory` makes that choice explicit when starting a fresh conversation; installation and a responding MCP still need to be verified in that environment.

## Start with the outcome and your material

The most useful inputs are the desired action, audience, destination, source material, facts that must be correct and a few creative preferences. Provide whichever are known. Codex should retrieve existing project decisions and make routine choices rather than asking you to repeat them. A question is needed when a missing fact changes the result or an external upload lacks authorization.

For an advertisement, useful detail includes:

- What to promote: an event, membership, service or product; its confirmed date/offer and call to action.
- Who should respond and where the ad will appear: for example, installers watching a vertical Telegram video.
- Which supplied material matters: an existing ContentFactory project/asset ID, a public source, or local files you authorize for import. Say which sources must be used or avoided.
- Style constraints: language, approximate duration, pace, examples you like, and concrete dislikes such as bulky captions or repetitive speaker angles.
- Review and spending preferences: whether you want to judge the preview yourself, which problem warrants paid analysis, and any budget limit.

For example:

```text
$contentfactory
Сделай вертикальную рекламу встречи «<название мероприятия>» <дата>.
Цель — чтобы <аудитория> перешли в группу и узнали, как участвовать.
Используй проект <project-id> и приглашения <asset-ids>; контекст бери из
<ссылка на публичную группу>. Надписи на русском. Живой темп, разные люди и действия,
без повторов одного спикера. В начале законченное движение, а не обрывок.
Речь не обрывай, текстом рот не закрывай. Черновик покажи мне;
платное визуальное ревью пока не нужно.
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

Codex should first connect the brief to the actual sources and build a compact story: a clear opening, relevant evidence/context, then the invitation or action. The storyboard should explain why each shot is present and what the viewer is meant to understand. It should not invent names, venue details, attendance or customer-work claims.

You can ask for the board before rendering when you want creative control:

```text
Сначала покажи короткую раскадровку: время, источник, смысл кадра,
надпись/речь и переход. Отдельно отметь фото, прошлые события и генерацию.
После согласования собери ролик в ContentFactory.
```

If you ask to produce the ad directly, the board is an execution aid; it is not a mandatory approval stop. Codex should preserve complete spoken thoughts, use a coherent selection of shots, choose source quality suitable for the placement, and inspect the final render. A skill improves those decisions but cannot guarantee subjective creative quality.

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

## Review without unnecessary cost

For a tiny correction, request a check of the changed interval and its joins. For a new edit, ask to see the complete sequence. Paid model analysis should answer a named unresolved question; it need not run after every caption change. For example:

Keep review and production budgets separate: a $0 review ceiling forbids paid review but does not authorize a new music-generation charge or set the whole campaign budget. Codex should check actual quotes/effects rather than assume a native operation is free.

```text
Покажи готовый ролик мне. Проверь технически экспорт и только изменённый
участок. Не делай большой контактный лист и платное ревью без конкретной
необходимости; если оно потребуется, объясни, какой вопрос оно решит.
```

Expect a concise delivery: exact output, what changed, what was checked, and any material limitation. Sampled frames prove selected visual properties, not continuous pacing or listening quality. A matching audio comparison supports unchanged sound content; it does not establish lip sync. Confirmed receipt charges support cost reporting; reservations, guesses and Codex token use are not the same as settled operation cost.

You can simply say “continue in the same project.” The assistant is responsible for reading the instructions, retaining accepted choices, challenging its own shot choices and using the authorized platform workflow.
