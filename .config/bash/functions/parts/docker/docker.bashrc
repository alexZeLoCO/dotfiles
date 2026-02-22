source "$HOME/.config/bash/functions/parts/decorations/decorations.bashrc"

function __message_docker_status() {
	command -v docker >/dev/null 2>&1 || return 1

	local running_containers
	running_containers="$(docker ps --format '{{.ID}}\t{{.Names}}\t{{.State}}' 2>/dev/null)"

	if [[ -z "$running_containers" ]]; then
		return 1
	fi

	local rendered=""
	local -a container_ids
	local -a container_names
	local -a container_states
	local max_id_width=0
	local max_name_width=0
	local max_state_width=0
	local container_id
	local container_name
	local container_state
	local index
	local row

	while IFS=$'\t' read -r container_id container_name container_state; do
		[[ -z "$container_id" ]] && continue

		container_ids+=("$container_id")
		container_names+=("$container_name")
		container_states+=("$container_state")

		(( ${#container_id} > max_id_width )) && max_id_width=${#container_id}
		(( ${#container_name} > max_name_width )) && max_name_width=${#container_name}
		(( ${#container_state} > max_state_width )) && max_state_width=${#container_state}
	done <<< "$running_containers"

	if (( ${#container_ids[@]} == 0 )); then
		return 1
	fi

	for ((index = 0; index < ${#container_ids[@]}; index++)); do
		printf -v row '%-*s  %-*s  %-*s' \
			"$max_id_width" "${container_ids[$index]}" \
			"$max_name_width" "${container_names[$index]}" \
			"$max_state_width" "${container_states[$index]}"
		rendered+=$'\n'"${DECORATION_HALF_LINE}$(color_text "$row" "$COLOR_LIGHT_BLUE")"
	done

	if [[ -z "$rendered" ]]; then
		return 1
	fi

	
    printf '\n%s' "${DECORATION_HALF_LINE}$(color_text "─────DOCKER CONTAINERS─────" "$COLOR_LIGHT_BLUE")"
	printf '%s' "$rendered"
}

function __update_docker_status() {
	local docker_state
	docker_state="$(__message_docker_status)"

	if [[ -n "$docker_state" ]]; then
		DOCKER_STATUS="$docker_state"
	else
		DOCKER_STATUS=""
	fi
}

function __prompt_command_docker_status() {
	local previous_status="$?"
	__update_docker_status
	return "$previous_status"
}

if [[ -z "${__DOCKER_STATUS_PROMPT_HOOKED:-}" ]]; then
	if [[ -n "$PROMPT_COMMAND" ]]; then
		PROMPT_COMMAND="__prompt_command_docker_status; ${PROMPT_COMMAND}"
	else
		PROMPT_COMMAND="__prompt_command_docker_status"
	fi
	__DOCKER_STATUS_PROMPT_HOOKED=1
fi
