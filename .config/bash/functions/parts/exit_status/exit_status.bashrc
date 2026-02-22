source "$HOME/.config/bash/functions/style/colors.bashrc"

function __message_exit_status() {
    local exit_status="$1"

    case "$exit_status" in
        0)
            echo "$(color_text "OK.$exit_status" "$COLOR_CYAN")"
            ;;
        2)
            echo "$(color_text "BAD.$exit_status" "$COLOR_RED")"
            ;;
        130)
            echo "$(color_text "INTERRUPTED.$exit_status" "$COLOR_ORANGE")"
            ;;
        126)
            echo "$(color_text "NOT EXEC.$exit_status" "$COLOR_RED")"
            ;;
        127)
            echo "$(color_text "NOT FOUND.$exit_status" "$COLOR_RED")"
            ;;
        *)
            echo "$(color_text "ERR.$exit_status" "$COLOR_RED")"
            ;;
    esac
}

function __update_exit_status() {
    local exit_status="$1"
    EXIT_STATUS="$(bracket "$(__message_exit_status "$exit_status")" "$COLOR_RESET")"
}

function __prompt_command_exit_status() {
    local exit_status

    if [[ -n "${BLE_VERSION-}" && "${_ble_edit_exec_lastexit-}" =~ ^[0-9]+$ ]]; then
        exit_status="$_ble_edit_exec_lastexit"
    else
        exit_status="$?"
    fi

    __update_exit_status "$exit_status"
}

if [[ -z "${__EXIT_STATUS_PROMPT_HOOKED:-}" ]]; then
    if [[ -n "$PROMPT_COMMAND" ]]; then
        PROMPT_COMMAND="__prompt_command_exit_status; ${PROMPT_COMMAND}"
    else
        PROMPT_COMMAND="__prompt_command_exit_status"
    fi
    __EXIT_STATUS_PROMPT_HOOKED=1
fi