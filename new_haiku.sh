#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

next=$(ls _posts/ \
    | grep -oE '^[0-9]{4}-[0-9]{2}-[0-9]{2}-haiku[0-9]*\.md$' \
    | sed -E 's/.*haiku([0-9]*)\.md/\1/' \
    | awk '{ if ($1 == "") print 1; else print $1 }' \
    | sort -n \
    | tail -1)
next=$((next + 1))

path="_posts/$(date +%Y-%m-%d)-haiku${next}.md"

if [[ -e "$path" ]]; then
    echo "refusing to overwrite $path" >&2
    exit 1
fi

cat > "$path" <<'EOF'
---
layout: post
category: haiku
---

EOF

echo "$path"
