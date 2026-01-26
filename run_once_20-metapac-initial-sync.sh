#!/usr/bin/env bash
set -euo pipefail

echo "→ Running initial metapac sync to install declared packages"
metapac sync # --noconfirm

echo "→ Initial sync completed"