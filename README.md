# ContentFactory Skills

Create videos, images, voiceovers, music, and editable compositions with your AI
agent through [ContentFactory](https://content-factory.art). The agent can speak
and create in your preferred language; the installable skill's instructions are
written in English.

## Start here: Codex

1. Install [Python 3.11+](https://www.python.org/downloads/) and the current
   [Codex CLI](https://developers.openai.com/codex/cli). Choose an **existing**
   folder for the project where you want to use the skill.
2. [Download this repository as a ZIP](https://github.com/ContentFactoryAIArt/Skills/archive/refs/heads/main.zip)
   and extract it, or clone it:

   ```sh
   git clone https://github.com/ContentFactoryAIArt/Skills.git
   cd Skills
   ```

3. From the extracted or cloned repository folder, run the setup helper with
   your project folder:

   ```powershell
   python scripts/connect.py --workspace "C:\Projects\MyVideo"
   ```

   On macOS or Linux, use `python3` and an existing path such as
   `~/projects/my-video`. The helper installs the skill in that project and
   connects Codex to the single ContentFactory MCP endpoint. Finish sign-in in
   the browser, then choose your projects, permissions, and access lifetime.
4. Open or reload that project in Codex and try:

   > Use $contentfactory-video to make a 30-second product video in English.
   > Work in my selected ContentFactory project. Show the plan and expected cost
   > before paid operations.

You can ask in your preferred language. Replace the example with your own brief,
language, duration, sources, and spending limit. If you have local footage, upload
it in ContentFactory first and select the resulting asset in your request.

**If setup says the unified endpoint is unavailable:** the server release for
`https://content-factory.art/mcp` is required. You can prepare the skill with
`python scripts/connect.py --workspace "C:\Projects\MyVideo" --install-only`,
but creative work needs the live connection. The helper does not switch to older
endpoints automatically.

## Choose your language

Each guide starts with the setup steps. The skill instructions remain in English;
your conversation and creative output can use the language you choose.

| Language | What you can do | Start guide |
| --- | --- | --- |
| English | Create videos, images, narration, music, and editable compositions with ContentFactory. | [Get started](docs/en.md) |
| 简体中文 | 使用 ContentFactory 创建视频、图像、配音、音乐和可编辑的合成作品。 | [开始使用](docs/zh.md) |
| Русский | Создавайте видео, изображения, озвучку, музыку и редактируемые композиции в ContentFactory. | [Начать работу](docs/ru.md) |
| हिन्दी | ContentFactory से वीडियो, चित्र, वॉइसओवर, संगीत और संपादन योग्य कम्पोज़िशन बनाएँ। | [शुरू करें](docs/hi.md) |
| 日本語 | ContentFactory で動画、画像、ナレーション、音楽、編集可能なコンポジションを制作できます。 | [使い始める](docs/ja.md) |
| Español | Crea videos, imágenes, narraciones, música y composiciones editables con ContentFactory. | [Empezar](docs/es.md) |
| 한국어 | ContentFactory로 동영상, 이미지, 내레이션, 음악, 편집 가능한 컴포지션을 만드세요. | [시작하기](docs/ko.md) |
| Українська | Створюйте відео, зображення, озвучення, музику й композиції з можливістю редагування в ContentFactory. | [Почати](docs/uk.md) |
| Deutsch | Erstelle Videos, Bilder, Sprachaufnahmen, Musik und bearbeitbare Kompositionen mit ContentFactory. | [Loslegen](docs/de.md) |
| Кыргызча | ContentFactory менен видео, сүрөт, үн коштоо, музыка жана түзөтүлүүчү композициялар түзүңүз. | [Баштоо](docs/ky.md) |

## Find what you need

- [Codex setup and troubleshooting](docs/en.md#codex-guided-setup)
- [Other MCP clients, including Claude Code](docs/en.md#other-mcp-clients)
- [Reuse a connection or sign in again](docs/en.md#keep-the-connection)
- [Tools, privacy, and spending controls](docs/en.md#tools-and-privacy)
- [Installable skill](skills/contentfactory-video/SKILL.md)
- [Setup helper](scripts/connect.py)

The helper checks the public OAuth discovery before adding a connection. It
does not receive credentials, process media, or change unrelated MCP servers.
The skill uses only verified tools from `https://content-factory.art/mcp`.

## For maintainers

Python 3.11+ is required; the helper has no third-party Python dependencies.
Run these checks from the repository root:

```sh
python -m unittest discover -s tests -v
python scripts/connect.py --workspace . --dry-run
```

The first command tests the connector. The second previews setup without
changing files, client configuration, or network state. Live OAuth and media
operations require the corresponding ContentFactory server release and a
separate acceptance check.
