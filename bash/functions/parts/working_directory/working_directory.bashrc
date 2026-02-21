source "$HOME/.config/bash/functions/style/colors.bashrc"

function __collapse_working_directory() {
    local working_directory="$1"
    local home_path="/home/$USER"
    local prefix=""
    local normalized_path
    local result=""
    local index

    if [[ -z "$working_directory" ]]; then
        working_directory="$PWD"
    fi

    if [[ "$working_directory" == "$home_path" ]]; then
        normalized_path="~"
    elif [[ "$working_directory" == "$home_path/"* ]]; then
        normalized_path="~/${working_directory#"$home_path/"}"
    else
        normalized_path="$working_directory"
    fi

    if [[ "$normalized_path" == /* ]]; then
        prefix="/"
        normalized_path="${normalized_path#/}"
    fi

    local -a path_parts
    IFS='/' read -r -a path_parts <<< "$normalized_path"

    for ((index = 0; index < ${#path_parts[@]}; index++)); do
        local part="${path_parts[$index]}"

        if [[ -z "$part" ]]; then
            continue
        fi

        if (( index == ${#path_parts[@]} - 1 )); then
            result+="$part"
            continue
        fi

        if [[ "$part" == "~" ]]; then
            result+="~/"
        elif [[ "$part" == .* && ${#part} -ge 2 ]]; then
            result+="${part:0:2}/"
        else
            result+="${part:0:1}/"
        fi
    done

    if [[ -n "$prefix" && "$result" != ~* ]]; then
        result="$prefix$result"
    fi

    if [[ -z "$result" && -n "$prefix" ]]; then
        result="$prefix"
    fi

    printf '%s\n' "$result"
}

function __update_working_directory() {
    WORKING_DIRECTORY="$(bracket "$(color_text "$(__collapse_working_directory "$PWD")" "$COLOR_CYAN")")"
}

function __prompt_command_working_directory() {
    local previous_status="$?"
    __update_working_directory
    return "$previous_status"
}

if [[ -z "${__WORKING_DIRECTORY_PROMPT_HOOKED:-}" ]]; then
    if [[ -n "$PROMPT_COMMAND" ]]; then
        PROMPT_COMMAND="__prompt_command_working_directory; ${PROMPT_COMMAND}"
    else
        PROMPT_COMMAND="__prompt_command_working_directory"
    fi
    __WORKING_DIRECTORY_PROMPT_HOOKED=1
fi