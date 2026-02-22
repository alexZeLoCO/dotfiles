# Reset prompt command chain to avoid stale inherited prompt printers
PROMPT_COMMAND=""
unset __EXIT_STATUS_PROMPT_HOOKED __WORKING_DIRECTORY_PROMPT_HOOKED __GIT_STATUS_PROMPT_HOOKED __VENV_STATUS_PROMPT_HOOKED __JOBS_STATUS_PROMPT_HOOKED __DOCKER_STATUS_PROMPT_HOOKED

# Let our custom prompt render venv state (disable default "(.venv)" prefix)
export VIRTUAL_ENV_DISABLE_PROMPT=1

# KEEP EXIT_STATUS AT THE TOP
source "$HOME/.config/bash/functions/parts/exit_status/exit_status.bashrc"

source "$HOME/.config/bash/functions/style/format.bashrc"
source "$HOME/.config/bash/functions/parts/decorations/decorations.bashrc"

source "$HOME/.config/bash/functions/parts/userhost/userhost.bashrc"
source "$HOME/.config/bash/functions/parts/working_directory/working_directory.bashrc"
source "$HOME/.config/bash/functions/parts/time/time.bashrc"
source "$HOME/.config/bash/functions/parts/venv/venv.bashrc"
source "$HOME/.config/bash/functions/parts/git_status/git_prompt.bashrc"
source "$HOME/.config/bash/functions/parts/docker/docker.bashrc"
source "$HOME/.config/bash/functions/parts/jobs/jobs.bashrc"

# ┬─┬─[nim@Hattori:~/w/dashboard]─[11:37:14]─[V:django20]─[G:master↑1|●1✚1…1]─[B:85%, 05:41:42 remaining]
#   │ 2    15054    0%    arrêtée    sleep 100000
#   │ 1    15048    0%    arrêtée    sleep 100000
#   ╰─>$ echo t

PS1="\n"
PS1="$PS1$DECORATION_FIRST_LINE"
PS1="$PS1$USERHOST"
PS1="$(link "${PS1}" "\${WORKING_DIRECTORY}" "$(color_text ':' "$COLOR_CYAN")")"
PS1="$(link "${PS1}" "${TIME}")"
PS1="$(link "${PS1}" "\${EXIT_STATUS}")"
PS1="${PS1}\${VENV_STATUS}"
PS1="${PS1}\${GIT_STATUS}"
PS1="${PS1}\${JOBS_STATUS}"
PS1="${PS1}\${DOCKER_STATUS}"
PS1="${PS1}\n${PROMPT_LINE}"
