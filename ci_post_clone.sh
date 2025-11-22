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

tuist_available() {
  command -v tuist >/dev/null 2>&1
}

# tuist 설치용 mise 플러그인이 없으면 추가 (실패해도 이후 단계에서 대응)
if ! mise plugins ls | grep -q '^tuist\b'; then
  if ! mise plugins install tuist https://github.com/mise-plugins/asdf-tuist.git; then
    echo "mise plugin install for tuist failed (will fallback later)" >&2
  fi
fi

echo "❗️Current PATH: $PATH"

echo "❗️mise version"
mise --version

echo "❗️mise install"
mise install --yes  # .mise.toml 기반으로 설치

echo "❗️mise doctor (non-fatal)"
# mise doctor can return non-zero when it finds advisory issues (e.g., duplicate shims)
# but we still want the pipeline to continue to Tuist generation.
if ! mise doctor; then
  echo "mise doctor reported issues, continuing build" >&2
fi

echo "❗️tuist install"
if ! tuist_available; then
  if ! mise x -- tuist install; then
    echo "mise x tuist install failed, trying official installer" >&2
    if ! curl -Ls https://install.tuist.io | bash; then
      echo "official tuist installer failed, falling back to direct download" >&2
    fi
  fi
fi

TUIST_BIN_DIR="$HOME/.tuist-bin"
TUIST_VERSION="$(grep -E '^tuist\s*=\s*"' mise.toml | sed -E 's/^[^"]+"([^"]+)"/\1/')"

# 공식 설치 스크립트가 실패한 경우를 대비해 직접 바이너리 다운로드
if ! tuist_available; then
  mkdir -p "$TUIST_BIN_DIR"
  curl -fL "https://github.com/tuist/tuist/releases/download/${TUIST_VERSION}/tuist.zip" -o "$TUIST_BIN_DIR/tuist.zip"
  unzip -o "$TUIST_BIN_DIR/tuist.zip" -d "$TUIST_BIN_DIR"
  chmod +x "$TUIST_BIN_DIR/tuist"
  export PATH="$TUIST_BIN_DIR:$PATH"
fi

# tuist 설치 위치를 PATH에 추가하고 최종 확인
export PATH="$HOME/.tuist/bin:$PATH"
if ! tuist_available; then
  echo "tuist is still unavailable after install attempts" >&2
  exit 1
fi

echo "❗️tuist generate"
mise x -- tuist generate  # 여기서 MenuTaro.xcworkspace, MenuTaro.xcodeproj 생성/갱신

# 워크스페이스가 실제로 존재하는지 확인해 조기에 실패를 감지
if [ ! -d "MenuTaro.xcworkspace" ]; then
  echo "MenuTaro.xcworkspace not found after tuist generate" >&2
  exit 1
fi

ls -la MenuTaro.xcworkspace
