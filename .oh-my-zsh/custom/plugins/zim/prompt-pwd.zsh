# vim:et sts=2 sw=2 ft=zsh
builtin emulate -L zsh -o EXTENDED_GLOB

local __git_root __current_dir __separator
local -i __tail_len __dir_len
zstyle -s ':zim:prompt-pwd:tail' length '__tail_len' || __tail_len=0
if zstyle -t ':zim:prompt-pwd' git-root; then
  __git_root=${PWD}
  while true; do
    if [[ -e ${__git_root}/.git ]]; then
      __current_dir=${PWD#${__git_root:h}/}
      break
    fi
    if [[ ${__git_root} == / ]]; then
      __current_dir=${(%):-%${__tail_len}~}
      break
    fi
    __git_root=${__git_root:h}
  done
else
  __current_dir=${(%):-%${__tail_len}~}
fi
zstyle -s ':zim:prompt-pwd:__separator' format '__separator' || __separator=/
zstyle -s ':zim:prompt-pwd:fish-style' dir-length '__dir_len' || __dir_len=0
if [[ ${__dir_len} -gt 0 || ${__separator} != / ]]; then
  local __current_dirs=("${(@s:/:)__current_dir}")
  if (( __dir_len > 0 && ${#__current_dirs} > 2 )); then
    __current_dirs[2,-2]=("${(@M)__current_dirs[2,-2]##.#?(#c,${__dir_len})}")
  fi
  __separator=${(e)__separator}
  __current_dir="${(@pj:$__separator:)__current_dirs}"
fi
if (( # )); then
  typeset -g "${^@}=${__current_dir}"
else
  print -Rn ${__current_dir}
fi

