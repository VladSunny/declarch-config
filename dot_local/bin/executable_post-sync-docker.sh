#!/usr/bin/env bash
set -euo pipefail

# ───────────────────────────────────────────────
# post-sync-docker.sh
# Runs after metapac sync — handles docker service + group
# Idempotent & safe to run multiple times
# ───────────────────────────────────────────────

SERVICE="docker.service"
SOCKET="docker.socket"
GROUP="docker"
USER="$USER"

echo "→ Ensuring docker group exists..."
if ! getent group "${GROUP}" > /dev/null; then
    sudo groupadd "${GROUP}"
    echo "Created ${GROUP} group"
else
    echo "${GROUP} group already exists"
fi

echo "→ Adding user ${USER} to group ${GROUP} (if not already)..."
if ! id -nG "${USER}" | grep -qw "${GROUP}"; then
    sudo usermod -aG "${GROUP}" "${USER}"
    echo "✓ User added to ${GROUP} group"
    echo "  Note: Log out & back in (or run 'newgrp ${GROUP}') for changes to take effect."
else
    echo "✓ User already in ${GROUP} group"
fi

echo "→ Ensuring docker socket is enabled and running..."
sudo systemctl enable --now "${SOCKET}" 2>/dev/null || {
    echo "Note: ${SOCKET} already enabled or not needed"
}

echo "→ Ensuring docker service is enabled and running..."
if sudo systemctl is-enabled "${SERVICE}" >/dev/null 2>&1; then
    sudo systemctl restart "${SERVICE}" 2>/dev/null || true
    echo "✓ Docker service restarted"
else
    sudo systemctl enable --now "${SERVICE}" 2>/dev/null || {
        echo "Warning: Failed to enable ${SERVICE}" >&2
    }
fi

# Verify docker is working (optional)
echo "→ Testing docker permissions..."
if command -v docker >/dev/null 2>&1; then
    if docker ps >/dev/null 2>&1; then
        echo "✓ Docker is working correctly"
    else
        echo "⚠ Docker command failed - you may need to log out and back in"
        echo "  Temporary fix: run 'newgrp docker' in your current shell"
    fi
fi