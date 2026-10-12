# ContentFactory Skill

Connect your agent to ContentFactory and create videos, images, narration, music
and compositions using only tools served by https://content-factory.art.

- English setup guide: [docs/en.md](docs/en.md)
- Инструкция на русском: [docs/ru.md](docs/ru.md)
- Installable skill: [contentfactory-video](skills/contentfactory-video/SKILL.md)

One Streamable HTTP connection covers Media, Generate and Compose:

```text
https://content-factory.art/mcp
```

The public package contains one self-contained skill and a separate Codex setup
helper. The helper configures the official client and installs instructions; it
does not generate media or handle OAuth credentials. The skill's dialogue and
creative output follow the user's language. English and Russian guides are
included; the same skill supports requests in other languages.

The unified endpoint requires the corresponding ContentFactory server release.
The helper checks public discovery metadata before adding a connection and stops
if the endpoint is unavailable. It does not silently add three legacy connections.

## Maintainers

Python 3.11 or later; no third-party Python packages are needed for the helper:

```sh
python -m unittest discover -s tests -v
python scripts/connect.py --client codex --workspace . --dry-run
```

The skill preserves the preparation, screenplay, visuals, audio, composition,
reference-video and Blender workflows formerly packaged in the application
repository. There are no media-processing scripts, upload transports, model
launchers or client bridges in this public creative skill. Local media must be
uploaded through ContentFactory before its owned asset IDs can be used.

Skill instructions are not a security sandbox. The client must retain tool
approval controls; ContentFactory enforces OAuth scopes, project membership,
expiry, revocation and spending authorization. A matching tool name alone does
not prove that its server is ContentFactory.
