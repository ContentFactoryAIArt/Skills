# ContentFactory 시작하기

ContentFactory와 AI 에이전트로 동영상, 이미지, 내레이션, 음악, 편집 가능한 컴포지션을 만드세요. 스킬 내부 지침은 영어이며, 한국어로 요청하고 한국어 콘텐츠를 만들 수 있습니다.

## 4단계로 시작하기

1. Python 3.11 이상과 최신 Codex CLI를 설치하고, 이미 존재하는 프로젝트 폴더를 준비하세요.
2. [이 저장소의 ZIP 파일을 다운로드](https://github.com/ContentFactoryAIArt/Skills/archive/refs/heads/main.zip)해 압축을 풀거나 다음 명령을 실행하세요.

   ```sh
   git clone https://github.com/ContentFactoryAIArt/Skills.git
   cd Skills
   ```

3. 압축을 풀었거나 복제한 저장소 폴더에서 설정 도우미를 실행하고 경로를 기존 프로젝트 폴더로 바꾸세요.

   ```powershell
   python scripts/connect.py --workspace "C:\Projects\MyVideo"
   ```

   macOS 또는 Linux에서는 `python3`와 `~/projects/my-video` 같은 기존 경로를 사용하세요. 브라우저에서 ContentFactory에 로그인하고 프로젝트, 권한, 접근 기간을 선택하세요.

4. Codex에서 해당 프로젝트를 열거나 다시 로드한 뒤 다음과 같이 요청하세요.

   > $contentfactory-video를 사용해 한국어 30초 제품 소개 동영상을 만들어 주세요. 선택한 프로젝트에서 작업하고 유료 작업 전에 계획과 예상 비용을 보여 주세요.

## 다른 MCP 클라이언트

클라이언트가 OAuth를 사용하는 원격 Streamable HTTP MCP를 지원한다면 `https://content-factory.art/mcp`를 서버 하나로 추가하고 브라우저에서 승인하세요. 그런 다음 클라이언트의 스킬 기능으로 `skills/contentfactory-video` 폴더 전체를 설치하세요.

## 연결에 문제가 있나요?

통합 엔드포인트를 사용할 수 없다는 메시지가 나오면 해당 ContentFactory 서버 릴리스가 필요합니다. `--install-only`는 스킬만 준비하며, 실제 제작에는 작동하는 연결이 필요합니다. 기존 연결이 정상이라면 다시 로그인하지 않아도 됩니다.

자세한 해결 방법은 [영어 안내서](en.md)를 참고하세요.
