#!/usr/bin/env zsh
hist="${XDG_STATE_HOME:-$HOME/.local/state}/dmcalc.history"
mkdir -p "${hist:h}"
lastansfile="${XDG_STATE_HOME:-$HOME/.local/state}/dmcalc.last"

# Build input list with history (most recent first)
input=""
[[ -f "$hist" ]] && input="$(tac -- "$hist" 2>/dev/null || tail -r "$hist")"

expr="$(printf '%s\n' "$input" | dmenu -p 'calc:' -i)"
[[ -z "$expr" ]] && exit 0

# Provide 'ans' from last time
ans="0"
[[ -f "$lastansfile" ]] && ans="$(cat "$lastansfile" 2>/dev/null)"

result="$(printf 'scale=10; ans=%s; %s\n' "$ans" "$expr" | bc -l 2>/dev/null || true)"
if [[ -z "$result" || "$result" == *"error"* ]]; then
  herbe "calc error: $expr" >/dev/null 2>&1 &!
  exit 1
fi

result="$(printf '%s\n' "$result" | awk '{ sub(/^-?0\./,"0."); sub(/\.0+$/,""); sub(/(\.[0-9]*[1-9])0+$/,"\\1"); print }')"

# Notify + clipboard
herbe "$expr = $result" >/dev/null 2>&1 &!
if command -v xclip >/dev/null 2>&1; then
  printf '%s' "$result" | xclip -selection clipboard
elif command -v xsel >/dev/null 2>&1; then
  printf '%s' "$result" | xsel -b
fi

# Save history + last answer
printf '%s\n' "$expr" >> "$hist"
printf '%s\n' "$result" > "$lastansfile"
