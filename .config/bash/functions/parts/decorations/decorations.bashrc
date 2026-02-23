source "$HOME/.config/bash/functions/style/colors.bashrc"

DECORATION_FIRST_LINE="$(color_text '┬─┬─' "$COLOR_LINK")"
DECORATION_HALF_LINE="$(color_text  '  │  ' "$COLOR_LINK")"
PROMPT_LINE="$(color_text '  ╰─> λ ' "$COLOR_LINK")"
OPEN_TITLE_DECORATION="$(color_text '  ├─────┤ ' "$COLOR_LINK")"
CLOSE_TITLE_DECORATION="$(color_text ' ├─────' "$COLOR_LINK")"

function title_decoration() {
    local title="$1"

    printf "%s%s%s" "$OPEN_TITLE_DECORATION" "$title" "$CLOSE_TITLE_DECORATION"
}