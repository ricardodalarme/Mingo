#!/usr/bin/env bash
# Compares two SDL dumps, normalizing the one thing the parser cannot read: an insert input of a table whose
# insert permission grants no client column is dumped without a body by both engines, which is not valid SDL.
# Usage: nhost/tools/schema-diff.sh <a.graphqls> <b.graphqls> [extra nhost schema diff flags]
set -euo pipefail

if [[ $# -lt 2 ]]; then
  echo "usage: $0 <a.graphqls> <b.graphqls>" >&2
  exit 2
fi

normalize() {
  sed -E 's/^(input [A-Za-z0-9_]+)$/\1 { _empty: Boolean }/' "$1"
}

a="$(mktemp)"
b="$(mktemp)"
trap 'rm -f "$a" "$b"' EXIT
normalize "$1" >"$a"
normalize "$2" >"$b"
nhost schema diff -a "$a" -b "$b" "${@:3}"
