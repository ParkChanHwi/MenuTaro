#!/bin/bash
set -euxo pipefail

# 리포지토리 루트에서 프로젝트 폴더로 이동
cd "$(dirname "$0")/MenuTaro"

if ! command -v mise >/dev/null 2>&1; then
  curl -fsSL https://mise.run | sh
  export PATH="$HOME/.local/bin:$PATH"
fi

# mise 설정이 신뢰되지 않아 실패하는 것을 방지
mise trust --yes mise.toml

# mise가 PATH에 노출되도록 활성화
export PATH="$HOME/.local/bin:$PATH"
eval "$(mise activate bash --shims)"

echo "❗️Current PATH: $PATH"

echo "❗️mise version"
mise --version

echo "❗️mise install"
mise install --yes  # .mise.toml 기반으로 설치

echo "❗️mise doctor"
mise doctor

echo "❗️tuist install"
if ! command -v tuist >/dev/null 2>&1; then
  mise x -- tuist install
fi

echo "❗️tuist generate"
mise x -- tuist generate  # 여기서 MenuTaro.xcworkspace, MenuTaro.xcodeproj 생성/갱신

# 워크스페이스가 실제로 존재하는지 확인해 조기에 실패를 감지
if [ ! -d "MenuTaro.xcworkspace" ]; then
  echo "MenuTaro.xcworkspace not found after tuist generate" >&2
  exit 1
fi

ls -la MenuTaro.xcworkspace
