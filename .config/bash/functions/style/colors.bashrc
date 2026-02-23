COLOR_RESET=$'\e[0m'

# GENERIC COLORS

G_COLOR_RED='#FF0000'
G_COLOR_ORANGE='#F18701'
G_COLOR_GREEN=$'\e[0;32m'
G_COLOR_YELLOW=$'\e[0;33m'
G_COLOR_BLUE=$'\e[0;34m'
G_COLOR_PURPLE=$'\e[0;35m'
G_COLOR_CYAN=$'\e[0;36m'
G_COLOR_WHITE=$'\e[0;37m'

# COLOR PALETTE

P_COLOR_ERROR="$G_COLOR_RED"
P_COLOR_WARNING="$G_COLOR_ORANGE"

P_COLOR_LINES="#F55536"
P_COLOR_BRACKET="#F55536"
P_COLOR_USERHOST="#FABC3C"
P_COLOR_CONTENTS="#FABC3C"
P_COLOR_JOBS="#FF773D"
P_COLOR_DOCKER="#F19143"

# PROMPT COLORS

COLOR_LINK="$P_COLOR_LINES"
COLOR_BRACKET="$P_COLOR_BRACKET"
COLOR_USERNAME="$P_COLOR_USERHOST"
COLOR_HOSTNAME="$P_COLOR_USERHOST"
COLOR_LINK_USERHOST="$P_COLOR_BRACKET"
COLOR_TIME="$P_COLOR_CONTENTS"
COLOR_PWD="$P_COLOR_CONTENTS"
COLOR_STATUS_OK="$P_COLOR_CONTENTS"
COLOR_GIT="$P_COLOR_CONTENTS"
COLOR_VENV="$P_COLOR_CONTENTS"
COLOR_STATUS_BAD_USE="$P_COLOR_ERROR"
COLOR_STATUS_INTERRUPTED="$P_COLOR_WARNING"
COLOR_STATUS_NOT_EXEC="$P_COLOR_ERROR"
COLOR_STATUS_NOT_FOUND="$P_COLOR_ERROR"
COLOR_STATUS_ERROR="$P_COLOR_ERROR"
COLOR_JOBS="$P_COLOR_JOBS"
COLOR_DOCKER="$P_COLOR_DOCKER"

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
