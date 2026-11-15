#!/usr/bin/env bash
# Writes the .secrets file a fresh checkout needs for a local stack, with development-only values.
# CI and new machines run this once; a developer with a real .secrets keeps it.
set -euo pipefail
cd "$(dirname "$0")/../.."

if [[ -f .secrets ]]; then
  echo ".secrets already exists, keeping it"
  exit 0
fi

work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT
openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -out "$work/private.pem" 2>/dev/null
openssl rsa -in "$work/private.pem" -pubout -out "$work/public.pem" 2>/dev/null
escape() {
  sed -e ':a' -e 'N' -e '$!ba' -e 's/\\/\\\\/g' -e 's/"/\\"/g' -e 's/\n/\\n/g' "$1"
}
kid="$(uuidgen 2>/dev/null || cat /proc/sys/kernel/random/uuid)"

cat >.secrets <<EOF
GRAFANA_ADMIN_PASSWORD = 'grafana-admin-password'
HASURA_GRAPHQL_ADMIN_SECRET = 'nhost-admin-secret'
NHOST_JWT_KID = '$kid'
NHOST_JWT_PRIVATE_KEY = "$(escape "$work/private.pem")"
NHOST_JWT_PUBLIC_KEY = "$(escape "$work/public.pem")"
NHOST_WEBHOOK_SECRET = 'nhost-webhook-secret'
APPLE_CLIENT_ID = ''
APPLE_TEAM_ID = ''
APPLE_KEY_ID = ''
APPLE_PRIVATE_KEY = ''
APPLE_AUDIENCE = ''
GOOGLE_CLIENT_ID = ''
GOOGLE_CLIENT_SECRET = ''
GOOGLE_AUDIENCE = ''
FCM_SERVICE_ACCOUNT = ''
REVENUECAT_WEBHOOK_AUTH = 'local-revenuecat-secret'
CHAT_API_URL = ''
CHAT_API_KEY = ''
CHAT_MODEL = ''
EOF

echo "wrote .secrets with development-only values"
