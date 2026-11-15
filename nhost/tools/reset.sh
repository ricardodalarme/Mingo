#!/usr/bin/env bash
# Proves a clean replay: wipes the local database and starts again from migrations, metadata and seeds.
set -euo pipefail
cd "$(dirname "$0")/../.."
nhost down --volumes
exec nhost/tools/up.sh --apply-seeds "$@"
