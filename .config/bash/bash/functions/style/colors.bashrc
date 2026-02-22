COLOR_RESET='\033[0m'

# GENERIC COLORS

P_COLOR_RED='\033[0;31m'
P_COLOR_GREEN='\033[0;32m'
P_COLOR_YELLOW='\033[0;33m'
P_COLOR_BLUE='\033[0;34m'
P_COLOR_PURPLE='\033[0;35m'
P_COLOR_CYAN='\033[0;36m'
P_COLOR_WHITE='\033[0;37m'

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
    printf '\033[38;2;%d;%d;%dm' "$red" "$green" "$blue"
}

function color_text() {
    local text="$1"
    local color="$2"

    if [[ "$color" == \#* ]]; then
        color="$(color_from_hex "$color")" || color="$COLOR_RESET"
    fi

    printf '%b%s%b\n' "$color" "$text" "$COLOR_RESET"
}
