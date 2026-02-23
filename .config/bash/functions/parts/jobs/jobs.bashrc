source "$HOME/.config/bash/functions/parts/decorations/decorations.bashrc"

function __message_jobs_status() {
	local running_jobs
	running_jobs="$(jobs -r -l 2>/dev/null)"

	if [[ -z "$running_jobs" ]]; then
		return 1
	fi

	local rendered=""
	local line

	while IFS= read -r line; do
		[[ -z "$line" ]] && continue
		rendered+=$'\n'"${DECORATION_HALF_LINE}$(color_text "$line" "$COLOR_JOBS")"
	done <<< "$running_jobs"

	if [[ -z "$rendered" ]]; then
		return 1
	fi

	printf '%s' "$rendered"
}

function __update_jobs_status() {
	local jobs_state
	jobs_state="$(__message_jobs_status)"

	if [[ -n "$jobs_state" ]]; then
		JOBS_STATUS="$jobs_state"
	else
		JOBS_STATUS=""
	fi
}

function __prompt_command_jobs_status() {
	local previous_status="$?"
	__update_jobs_status
	return "$previous_status"
}

if [[ -z "${__JOBS_STATUS_PROMPT_HOOKED:-}" ]]; then
	if [[ -n "$PROMPT_COMMAND" ]]; then
		PROMPT_COMMAND="__prompt_command_jobs_status; ${PROMPT_COMMAND}"
	else
		PROMPT_COMMAND="__prompt_command_jobs_status"
	fi
	__JOBS_STATUS_PROMPT_HOOKED=1
fi
