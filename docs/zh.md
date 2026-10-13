# 开始使用 ContentFactory

使用 ContentFactory 和 AI 助手创建视频、图像、配音、音乐及可编辑的合成作品。技能内部指令使用英语；你可以用中文交流并生成中文内容。

## 四步开始

1. 安装 Python 3.11 或更新版本，以及最新版 Codex CLI。准备一个已存在的项目文件夹。
2. [下载此仓库的 ZIP 文件](https://github.com/ContentFactoryAIArt/Skills/archive/refs/heads/main.zip)并解压，或运行以下命令：

   ```sh
   git clone https://github.com/ContentFactoryAIArt/Skills.git
   cd Skills
   ```

3. 在解压或克隆的仓库文件夹中运行安装程序，并将路径改为你自己的现有项目文件夹：

   ```powershell
   python scripts/connect.py --workspace "C:\Projects\MyVideo"
   ```

   在 macOS 或 Linux 上使用 `python3`，并指定类似 `~/projects/my-video` 的现有路径。 在浏览器中完成 ContentFactory 登录，选择项目、权限和访问期限。

4. 在 Codex 中打开或重新加载该项目，然后输入：

   > 使用 $contentfactory-video 制作一段 30 秒的中文产品视频。在我选定的项目中工作，执行付费操作前先说明计划和预计费用。

## 其他 MCP 客户端

如果你的客户端支持带 OAuth 的远程 Streamable HTTP MCP，请添加一个服务器：`https://content-factory.art/mcp`，并通过浏览器授权。然后使用客户端的技能功能安装完整的 `skills/contentfactory-video` 文件夹。

## 连接遇到问题？

如果安装程序提示统一端点不可用，需要等待相应的 ContentFactory 服务器版本。`--install-only` 只能预先安装技能；真正开始创作仍需可用的连接。已有正常连接时无需重新登录。

详细排查步骤见[英文指南](en.md)。
