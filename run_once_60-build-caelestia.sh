#!/usr/bin/env bash

set -euo pipefail

cd ".config/quickshell"

cd caelestia
cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/
cmake --build build
sudo cmake --install build

echo "✅ Caelestia shell installed successfully!"
