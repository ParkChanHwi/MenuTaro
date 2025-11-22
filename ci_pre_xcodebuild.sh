#!/bin/bash
set -euxo pipefail

cd "$(dirname "$0")/MenuTaro"

# 최대한 동일한 PATH 재구성 (post-clone에서 설치한 mise/tuist 사용)
export PATH="$HOME/.local/bin:$HOME/.tuist-bin:$HOME/.tuist/bin:$PATH"

# mise가 있다면 tuist shim 활성화 시도 (실패해도 계속 진행)
if command -v mise >/dev/null 2>&1; then
  mise trust --yes mise.toml || true
  eval "$(mise activate bash --shims)" || true
fi

# tuist가 없으면 마지막으로 공식 인스톨러 실행
if ! command -v tuist >/dev/null 2>&1; then
  curl -Ls https://install.tuist.io | bash
  export PATH="$HOME/.tuist/bin:$PATH"
fi

if ! command -v tuist >/dev/null 2>&1; then
  echo "tuist is unavailable before xcodebuild" >&2
  exit 1
fi

echo "❗️tuist generate (pre-xcodebuild)"
tuist generate

if [ ! -d "MenuTaro.xcworkspace" ]; then
  echo "MenuTaro.xcworkspace missing after tuist generate" >&2
  exit 1
fi

ls -la MenuTaro.xcworkspace
