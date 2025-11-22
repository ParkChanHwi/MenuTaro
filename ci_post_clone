#!/bin/sh
set -e

# 리포지토리 루트에서 프로젝트 폴더로 이동
cd MenuTaro

curl https://mise.run | sh
export PATH="$HOME/.local/bin:$PATH"

echo "❗️Current PATH: $PATH"

echo "❗️mise version"
mise --version

echo "❗️mise install"
mise install  # .mise.toml 기반으로 설치

eval "$(mise activate bash --shims)"

echo "❗️mise doctor"
mise doctor

echo "❗️tuist install"
tuist install

echo "❗️tuist generate"
tuist generate  # 여기서 MenuTaro.xcworkspace, MenuTaro.xcodeproj 생성/갱신
