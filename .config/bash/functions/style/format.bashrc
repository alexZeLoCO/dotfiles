source "$HOME/.config/bash/functions/style/colors.bashrc"

function bracket() {
    text="$1"
    printf '%s%s%s\n' "$(color_text '┤' "$COLOR_BRACKET")" "$text" "$(color_text '├' "$COLOR_BRACKET")"
}

function link() {
    text_a="$1"
    text_b="$2"
    # Link symbol defaults to  '─'
    link_symbol="${3:-"$(color_text '─' "$COLOR_LINK")"}"

    printf '%s%s%s\n' "$text_a" "$link_symbol" "$text_b"
}

