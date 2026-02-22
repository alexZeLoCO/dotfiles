#
# On your ~/.bashrc write:
# source "$PATH_TO_THIS_REPO/.bashrc"
# Requires:
#   - bat
#   - eza
#   - Docker
#   - git
#
# Requirements bat and eza can be switched out by changing the aliases in aliases.bashrc
# Requirements docker and git can be disabled by commenting out the relevant lines in load_prompt.bashrc
#
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load blesh autocompletion (only once per shell)
if [[ -z ${BLE_VERSION-} ]]; then
	source -- /usr/share/blesh/ble.sh --attach=none --rcfile "$HOME/.config/bash/.blerc"
fi

# Load aliases and prompt
source "$HOME/.config/bash/aliases.bashrc"
source "$HOME/.config/bash/functions/load_prompt.bashrc"

# Add this line at the end of .bashrc:
if [[ ${BLE_VERSION-} && -z ${_ble_attached-} ]]; then
	ble-attach
fi
