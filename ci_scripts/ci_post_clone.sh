#!/bin/sh
set -euo pipefail

# Install Tuist if it is not already available in the CI environment.
if ! command -v tuist >/dev/null 2>&1; then
  echo "Installing Tuist..."
  curl -Ls https://install.tuist.io | bash
  export PATH="$HOME/.tuist/bin:$PATH"
fi

cd MenuTaro

echo "Fetching Tuist dependencies..."
tuist fetch

echo "Generating Xcode workspace..."
tuist generate --no-open
