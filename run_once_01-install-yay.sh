#!/usr/bin/env bash
set -euo pipefail

if ! command -v yay >/dev/null 2>&1; then
    echo "→ Installing yay (AUR helper) …"
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd - >/dev/null
    rm -rf /tmp/yay
    echo "→ yay installed"
else
    echo "→ yay already present, skipping"
fi