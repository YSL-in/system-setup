# do nothing if not running interactively
case $- in
    *i*) ;;
      *) return;;
esac

shopt -s histappend
HISTCONTROL=ignoreboth
HISTFILESIZE=2000
HISTSIZE=1000

shopt -s checkwinsize

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac



source ~/.gitstatus/gitstatus.prompt.sh

# \[...\]: non-printing chars
# \033[...m: escape sequences
# \e[...m: escape sequences
#
# 00: reset
# 01: bold
#
# 30-37: foreground color
# 40-47: background color accordingly
# 30: black, 31: red,     32: green, 33: yellow
# 34: blue,  35: magenta, 36: cyan,  37: white
#
# \u: username
# \w: working directory
# ➛ 👉 🔥 \$ ✔ ✘
eval_ps1() {
    local _prefix=" "
    local _suffix=" \n"
    if [[ -z $GITSTATUS_PROMPT ]]; then
        _prefix=""
        _suffix=""
    fi
    PS1="\${debian_chroot:+(\$debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]${_prefix}${GITSTATUS_PROMPT}\[\033[00m\]${_suffix}\$ "
}
if [ "$color_prompt" = yes ]; then
    eval_ps1
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt



if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
if [ -f ~/.bashrc-dev ]; then
    . ~/.bashrc-dev
fi
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
