#!/bin/bash
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $(basename "$0") <folder> [output.podium]"
  echo "  Creates a .podium file from a folder containing document.md"
  exit 1
fi

SRC="${1%/}"

if [ ! -d "$SRC" ]; then
  echo "Error: '$SRC' is not a directory" >&2
  exit 1
fi

if [ ! -f "$SRC/document.md" ]; then
  echo "Error: '$SRC/document.md' not found" >&2
  exit 1
fi

OUT="${2:-$(basename "$SRC").podium}"

tar -cf - -C "$SRC" . | zstd -19 -o "$OUT" --force

echo "Created $OUT"
