
eval "$(/nix/store/yvzyrsv7fl33zmi2a1nx730hsz7qyyia-coreutils-9.11/bin/dircolors -b )"

if shopt -q progcomp &>/dev/null; then
  . "/nix/store/4j5ac4npgfj9mdcvns5h5x46r6i6zy4g-bash-completion-2.17.0/etc/profile.d/bash_completion.sh"
  nullglobStatus=$(shopt -p nullglob)
  shopt -s nullglob
  for p in $NIX_PROFILES; do
    for m in "$p/etc/bash_completion.d/"*; do
      . "$m"
    done
  done
  eval "$nullglobStatus"
  unset nullglobStatus p m
fi

. ~/.bash_aliases


PS1='\[\033[00;95m\]\[\033[00;01;105m\] \u\[\033[00;95;44m\]\[\033[00;01;44m\] \w \[\033[00;34;47m\]\[\033[37;102m\]\[\033[92;101m\]\[\033[91;41m\]\[\033[00;01;41m\]  \A\[\033[00;31m\] \[\033[00m\] '
