COLOR_RESET=$'\e[0m'

# GENERIC COLORS

P_COLOR_RED=$'\e[0;31m'
P_COLOR_GREEN=$'\e[0;32m'
P_COLOR_YELLOW=$'\e[0;33m'
P_COLOR_BLUE=$'\e[0;34m'
P_COLOR_PURPLE=$'\e[0;35m'
P_COLOR_CYAN=$'\e[0;36m'
P_COLOR_WHITE=$'\e[0;37m'

# PROMPT SPECIFIC COLORS

COLOR_RED='#FBA0A0'
COLOR_CYAN='#75b5aa'
COLOR_BLUE='#0000FF'
COLOR_LIGHT_BLUE='#3A9AFF'
COLOR_ORANGE='#FB9F1A'
COLOR_YELLOW='#E0E000'
COLOR_WHITE='#FFFFFF'

function color_from_hex() {
    local hex="${1#\#}"

    if [[ ! "$hex" =~ ^[0-9A-Fa-f]{6}$ ]]; then
        return 1
    fi

    local red=$((16#${hex:0:2}))
    local green=$((16#${hex:2:2}))
    local blue=$((16#${hex:4:2}))
    local r6=$(((red * 5 + 127) / 255))
    local g6=$(((green * 5 + 127) / 255))
    local b6=$(((blue * 5 + 127) / 255))
    local index=$((16 + 36 * r6 + 6 * g6 + b6))
    printf '\e[38;5;%dm' "$index"
}

function color_text() {
    local text="$1"
    local color="$2"
    local non_printing_start=$'\001'
    local non_printing_end=$'\002'

    if [[ "$color" == \#* ]]; then
        color="$(color_from_hex "$color")" || color="$COLOR_RESET"
    fi

    printf '%s%b%s%s%s%b%s\n' \
        "$non_printing_start" "$color" "$non_printing_end" \
        "$text" \
        "$non_printing_start" "$COLOR_RESET" "$non_printing_end"
}
