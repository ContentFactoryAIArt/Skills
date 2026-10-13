# ContentFactory を使い始める

ContentFactory と AI エージェントで、動画、画像、ナレーション、音楽、編集可能なコンポジションを制作できます。スキル内の指示は英語ですが、日本語で依頼し、日本語の成果物を作れます。

## 4 ステップで始める

1. Python 3.11 以降と最新の Codex CLI をインストールし、既存のプロジェクトフォルダーを用意します。
2. [このリポジトリを ZIP でダウンロード](https://github.com/ContentFactoryAIArt/Skills/archive/refs/heads/main.zip)して展開するか、次を実行します。

   ```sh
   git clone https://github.com/ContentFactoryAIArt/Skills.git
   cd Skills
   ```

3. 展開またはクローンしたリポジトリのフォルダーでセットアップを実行し、パスを既存のプロジェクトフォルダーに変更します。

   ```powershell
   python scripts/connect.py --workspace "C:\Projects\MyVideo"
   ```

   macOS または Linux では `python3` と `~/projects/my-video` のような既存のパスを使います。 ブラウザーで ContentFactory にサインインし、プロジェクト、権限、アクセス期間を選びます。

4. Codex でプロジェクトを開くか再読み込みし、次のように依頼します。

   > $contentfactory-video を使って、日本語の 30 秒の商品紹介動画を作成してください。選択したプロジェクトで作業し、有料操作の前に計画と見積もりを示してください。

## その他の MCP クライアント

OAuth 対応のリモート Streamable HTTP MCP を使えるクライアントでは、`https://content-factory.art/mcp` を 1 つのサーバーとして追加し、ブラウザーで認証します。続いて、クライアントのスキル機能で `skills/contentfactory-video` フォルダー全体をインストールします。

## 接続できない場合

統合エンドポイントを利用できないと表示された場合、対応する ContentFactory サーバーのリリースが必要です。`--install-only` ではスキルだけを準備できますが、制作には稼働中の接続が必要です。既存の接続が正常なら再ログインは不要です。

詳しい対処方法は[英語ガイド](en.md)をご覧ください。
