source "$HOME/.config/bash/functions/parts/git_status/git_prompt_lib.bashrc"
source "$HOME/.config/bash/functions/style/colors.bashrc"

function __message_git_status() {
	git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return 1

	local branch_name
	branch_name="$(git symbolic-ref --quiet --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)"
	[[ -z "$branch_name" ]] && return 1

	local relation='='
	local upstream_counts
	upstream_counts="$(git rev-list --left-right --count @{upstream}...HEAD 2>/dev/null)"

	if [[ -n "$upstream_counts" ]]; then
		local behind_count ahead_count
		read -r behind_count ahead_count <<< "$upstream_counts"

		if (( behind_count > 0 && ahead_count == 0 )); then
			relation='<'
		elif (( ahead_count > 0 && behind_count == 0 )); then
			relation='>'
		fi
	fi

	printf '%s %s' "$branch_name" "$relation"
}

function __update_git_status() {
	local git_state
	git_state="$(__message_git_status)"

	if [[ -n "$git_state" ]]; then
		GIT_STATUS="$(link '' "$(bracket "$(color_text "$git_state" "$COLOR_CYAN")")")"
	else
		GIT_STATUS=""
	fi
}

function __prompt_command_git_status() {
	local previous_status="$?"
	__update_git_status
	return "$previous_status"
}

if [[ -z "${__GIT_STATUS_PROMPT_HOOKED:-}" ]]; then
	if [[ -n "$PROMPT_COMMAND" ]]; then
		PROMPT_COMMAND="__prompt_command_git_status; ${PROMPT_COMMAND}"
	else
		PROMPT_COMMAND="__prompt_command_git_status"
	fi
	__GIT_STATUS_PROMPT_HOOKED=1
fi
