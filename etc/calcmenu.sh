#!/usr/bin/env zsh
expr="$(printf '' | dmenu -p 'calc:' -i)" || exit 0
[[ -z "$expr" ]] && exit 0

result="$(printf 'scale=10; %s\n' "$expr" | bc -l 2>/dev/null || true)"
if [[ -z "$result" || "$result" == *"error"* ]]; then
    setsid -f herbe "calc error: $expr"
    exit 1
fi

# Trim prettily
result="$(printf '%s\n' "$result" | awk '{ sub(/\.0+$/,""); sub(/(\.[0-9]*[1-9])0+$/,"\\1"); print }')"

nohup herbe "$expr = $result" >/dev/null 2>&1 &!
printf '%s' "$result" | xclip -selection clipboard
