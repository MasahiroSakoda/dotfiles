#!/usr/bin/env bash
set -euo pipefail

# Read stdin into a variable
input=$(cat)

if [ -z "$(echo "$input" | tr -d '[:space:]')" ]; then
  echo -e "\033[38;5;196m\033[1m⚠️ Error: stdin is empty. This script requires a JSON payload piped to stdin.\033[0m" >&2
  exit 1
fi

# Verify valid JSON
if ! echo "$input" | jq empty >/dev/null 2>&1; then
  echo -e "\033[38;5;196m\033[1m⚠️ Error parsing JSON from stdin.\033[0m" >&2
  exit 1
fi

# ANSI Palette
RESET="\033[0m"
BOLD="\033[1m"
DIM="\033[2m"

GREEN="\033[38;5;78m"
AMBER="\033[38;5;214m"
BLUE="\033[38;5;39m"
MAGENTA="\033[38;5;170m"
PURPLE="\033[38;5;141m"
RED="\033[38;5;196m"
CYAN="\033[38;5;51m"
GRAY="\033[38;5;244m"

SEPARATOR=" ${DIM}•${RESET} "

# Field 1: State
status=$(echo "$input" | jq -r '.agent_state // .status // "Ready"')
case "$status" in
thinking) state_str="🤔${AMBER}${BOLD}${RESET}" ;;
working) state_str="🚧${BLUE}${BOLD}${RESET}" ;;
initializing) state_str="⏳${GREEN}${BOLD}${RESET}" ;;
tool_use) state_str="🛠️${GREEN}${BOLD}${RESET}" ;;
*) state_str="🟢${GREEN}${BOLD}${RESET}" ;;
esac

# Field 2: Model
model_id=$(echo "$input" | jq -r '.model.id // empty')
model_display=$(echo "$input" | jq -r '.model.display_name // empty')
raw_model_name="${model_display:-$model_id}"

# short_model=""
# if [ -n "$raw_model_name" ]; then
#   if [[ "$raw_model_name" =~ (Opus|Sonnet|Haiku)[[:space:].]*([0-9.]*) ]]; then
#     path_match
#     short_model="${BASH_REMATCH[1]}${BASH_REMATCH[2]:+ ${BASH_REMATCH[2]}}"
#   elif [[ "$raw_model_name" =~ (Gemini)[[:space:]]+([0-9.]+)[[:space:]]+(Pro|Flash|Ultra|Nano|Thinking) ]]; then
#     short_model="${BASH_REMATCH[1]} ${BASH_REMATCH[2]} ${BASH_REMATCH[3]}"
#   else
#     short_name="${raw_model_name##*/}"
#     short_model="${short_name:0:20}"
#   fi
# fi
model_str="🤖 ${MAGENTA}${raw_model_name}${RESET}"

# Field 3: Sandbox Status
sandbox=$(echo "$input" | jq -r 'if .sandbox == false then "false" else "true" end')
if [ "$sandbox" = "true" ]; then
  sandbox_str="${GREEN}🛡️ sandbox${RESET}"
else
  sandbox_str="${RED}${BOLD}⚠️ no-sandbox${RESET}"
fi

# Field 4: Current Directory
abbreviate_segment() {
  local seg="$1"
  if [ -z "$seg" ]; then
    echo ""
    return
  fi
  if [ "$seg" = "~" ]; then
    echo "~"
    return
  fi
  if [[ "$seg" == *.* ]]; then
    if [[ "$seg" == .* ]]; then
      echo "${seg:0:2}"
    else
      local first_char="${seg:0:1}"
      local after_dot="${seg#*.}"
      echo "${first_char}.${after_dot:0:1}"
    fi
  else
    echo "${seg:0:1}"
  fi
}

format_cwd() {
  local path="$1"
  if [ -z "$path" ] || [ "$path" = "null" ]; then
    echo "~"
    return
  fi

  local home="${HOME:-}"
  local formatted="$path"

  if [ -n "$home" ] && [[ "$formatted" == "$home"* ]]; then
    formatted="~${formatted#"$home"}"
  fi

  if [ "$formatted" != "/" ] && [[ "$formatted" == */ ]]; then
    formatted="${formatted%/}"
  fi

  IFS='/' read -ra parts <<<"$formatted"
  local last_idx=$((${#parts[@]} - 1))
  local result=()

  for i in "${!parts[@]}"; do
    if [ "$i" -eq "$last_idx" ]; then
      result+=("${parts[$i]}")
    else
      result+=("$(abbreviate_segment "${parts[$i]}")")
    fi
  done

  local IFS="/"
  echo "${result[*]}"
}

raw_cwd=$(echo "$input" | jq -r '.cwd // empty')
cwd_str="📁 ${CYAN}$(format_cwd "$raw_cwd")${RESET}"

# Field 5: Context Token Usage
format_context() {
  local pct="$1"
  if [ -z "$pct" ] || [ "$pct" = "null" ]; then
    echo "${GRAY}[░░░░░░░░] 0%${RESET}"
    return
  fi

  local pct_round
  pct_round=$(printf "%.0f" "$pct")

  local filled_len=$(((pct_round * 8 + 50) / 100))
  ((filled_len < 0)) && filled_len=0
  ((filled_len > 8)) && filled_len=8
  local unfilled_len=$((8 - filled_len))

  local filled=""
  local unfilled=""
  for ((i = 0; i < filled_len; i++)); do filled+="■"; done
  for ((i = 0; i < unfilled_len; i++)); do unfilled+="░"; done

  local bar_color="$GREEN"
  if [ "$pct_round" -gt 80 ]; then
    bar_color="$RED"
  elif [ "$pct_round" -gt 60 ]; then
    bar_color="$AMBER"
  fi

  echo -e "💬 ${bar_color}[${filled}${unfilled}]${RESET} ${BOLD}${pct_round}%${RESET}"
}

pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
context_str=$(format_context "$pct")

# Field 6: Tasks
tasks_count=$(echo "$input" | jq -r '.tasks | length // 0')
if [ "$tasks_count" -gt 0 ]; then
  tasks_str="${AMBER}📋 ${tasks_count} ${RESET}"
else
  tasks_str="${GRAY}📋 0 ${RESET}"
fi

# Field 7: Artifacts
artifacts_count=$(echo "$input" | jq -r '.artifacts | length // 0')
if [ "$artifacts_count" -gt 0 ]; then
  artifacts_str="${PURPLE}📦 ${artifacts_count} ${RESET}"
else
  artifacts_str="${GRAY}📦 0 ${RESET}"
fi

# Print final status line
echo -e "${state_str}${SEPARATOR}${model_str}${SEPARATOR}${sandbox_str}${SEPARATOR}${cwd_str}${SEPARATOR}${context_str}${SEPARATOR}${tasks_str}${SEPARATOR}${artifacts_str}"
