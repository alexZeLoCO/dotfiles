source "$HOME/.config/bash/functions/style/colors.bashrc"

function __message_venv_status() {
	if [[ -z "${VIRTUAL_ENV:-}" ]]; then
		return 1
	fi

	local venv_name="${VIRTUAL_ENV##*/}"
	if [[ -z "$venv_name" ]]; then
		return 1
	fi

	printf "V:%s" "$venv_name"
}

function __update_venv_status() {
	local venv_state
	venv_state="$(__message_venv_status)"

	if [[ -n "$venv_state" ]]; then
		VENV_STATUS="$(link '' "$(bracket "$(color_text "$venv_state" "$COLOR_VENV")")")"
	else
		VENV_STATUS=""
	fi
}

function __prompt_command_venv_status() {
	local previous_status="$?"
	__update_venv_status
	return "$previous_status"
}

if [[ -z "${__VENV_STATUS_PROMPT_HOOKED:-}" ]]; then
	if [[ -n "$PROMPT_COMMAND" ]]; then
		PROMPT_COMMAND="__prompt_command_venv_status; ${PROMPT_COMMAND}"
	else
		PROMPT_COMMAND="__prompt_command_venv_status"
	fi
	__VENV_STATUS_PROMPT_HOOKED=1
fi
