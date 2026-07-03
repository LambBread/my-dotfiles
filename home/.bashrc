case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    color_prompt=yes
else
    color_prompt=
fi
if [ "$color_prompt" = yes ]; then
    PS1='\[\033[00;38;2;156;139;167m\]\[\033[00;01;48;2;156;139;167m\] \u\[\033[00;38;2;156;139;167m\033[48;2;36;91;151m\]\[\033[00;01;48;2;36;91;151m\] \w \[\033[00;38;2;36;91;151m\033[101m\]\[\033[91;42m\]\[\033[32;104m\]\[\033[94;105m\]\[\033[00;01;105m\]  \A\[\033[00;95m\] \[\033[00m\] '
else
    PS1='\u@\h:\w\$ '
fi
unset color_prompt

case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export XDG_DATA_DIRS="/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share:/root/.local/share/flatpak/exports/share:/usr/share/gnome:/usr/local/share:/usr/share"
export PATH="$PATH:$HOME/.local/bin"
source /opt/emsdk/emsdk_env.sh &> /dev/null
source ~/.venv/bin/activate
