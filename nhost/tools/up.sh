#!/usr/bin/env bash
# Starts (or reloads) the local stack with every service on a localhost port, so tools and tests need no DNS.
# Seeds are applied on every start; they are idempotent and restore reference data and buckets after a fresh volume.
set -euo pipefail
cd "$(dirname "$0")/../.."
args=("$@")
case " ${args[*]-} " in
  *" --apply-seeds "*) ;;
  *) args+=(--apply-seeds) ;;
esac
exec nhost up --hasura-port 8080 --auth-port 4000 --storage-port 8484 --functions-port 3030 "${args[@]}"
