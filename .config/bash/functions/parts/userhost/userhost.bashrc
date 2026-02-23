source "$HOME/.config/bash/functions/style/colors.bashrc"
source "$HOME/.config/bash/functions/parts/userhost/username.bashrc"
source "$HOME/.config/bash/functions/parts/userhost/hostname.bashrc"

USERHOST="$(link $USERNAME $HOSTNAME "$(color_text '@' "$COLOR_LINK_USERHOST")")"