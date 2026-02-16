#!/usr/bin/env bash

set -euo pipefail

KEY_TYPE="ed25519"
KEY_FILE="$HOME/.ssh/id_${KEY_TYPE}"
KEY_COMMENT="${USER}@${HOSTNAME:-$(hostname)}   $(date +%Y-%m)"

# ─── Проверки ────────────────────────────────────────────────────────────────

if [[ -f "$KEY_FILE" ]] || [[ -f "${KEY_FILE}.pub" ]]; then
    echo "→ SSH ключ $KEY_FILE уже существует → пропускаем генерацию"
    exit 0
fi

# ─── Генерация ───────────────────────────────────────────────────────────────

echo "→ Генерируем новый SSH ключ ($KEY_TYPE) без passphrase..."

ssh-keygen \
    -t "$KEY_TYPE" \
    -C "$KEY_COMMENT" \
    -f "$KEY_FILE" \
    -N "" \
    -q

chmod 600 "$KEY_FILE"

# ─── Вывод результата ────────────────────────────────────────────────────────

echo ""
echo "Готово! Создан ключ"