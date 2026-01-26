#!/usr/bin/env bash
set -euo pipefail

if ! command -v metapac >/dev/null 2>&1; then
    echo "→ Installing metapac …"
    yay -S --needed --noconfirm metapac
    echo "→ metapac installed"
else
    echo "→ metapac already present, skipping"
fi