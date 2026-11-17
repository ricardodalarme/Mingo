#!/usr/bin/env bash
# Dumps the GraphQL schema each role is served, as the handoff contract for the app.
# Uses the local stack by default; NHOST_GRAPHQL_URL points it at another endpoint.
set -euo pipefail
cd "$(dirname "$0")/../.."

if [[ -n "${NHOST_ADMIN_SECRET:-}" ]]; then
  admin="$NHOST_ADMIN_SECRET"
else
  admin="$(sed -n "s/^HASURA_GRAPHQL_ADMIN_SECRET[[:space:]]*=[[:space:]]*//p" .secrets | tr -d "'" | tr -d '[:space:]')"
fi
url="${NHOST_GRAPHQL_URL:-http://localhost:8080/v1/graphql}"
out="${NHOST_SCHEMA_DIR:-nhost/schema}"

mkdir -p "$out"
for role in user public; do
  nhost schema dump --url "$url" --role "$role" \
    --header "x-hasura-admin-secret: $admin" --header "x-hasura-role: $role" \
    --output "$out/$role.graphqls"
  echo "wrote $out/$role.graphqls"
done
