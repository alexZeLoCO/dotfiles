source "$HOME/.config/bash/functions/style/colors.bashrc"

HOSTNAME="$(color_text "${HOSTNAME%%.*}" "$COLOR_HOSTNAME")"