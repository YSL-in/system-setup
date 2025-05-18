
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias c='clear'
alias e='exit'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -halF'
alias tree='tree -CL'
alias pbcopy='xsel -b'
alias reboot='sync && reboot'
alias poweroff='sync && shutdown now'
alias shutdown='sync && shutdown now'

alias bashrc='vim ~/.bashrc && source ~/.bashrc'
alias bashrc-dev='vim ~/.bashrc-dev && source ~/.bashrc-dev'
alias tmux-conf='vim ~/.tmux.conf'
alias vimrc='vim ~/.vimrc'

alias play-on-linux='flatpak run com.playonlinux.PlayOnLinux4'

cd() {
    builtin cd $@
    gitstatus_prompt_update
    eval_ps1
}

cdd() {
    mkdir -p "$1"
    cd "$1"
}

timeit() {
    starttime=`date`
    ${argv[@]}
    echo $starttime
    date
}

tmux-up() {
    local name="${@:-$(basename "$PWD")}"
    tmux new -s "$name" -n "worksp-0"
    tmux attach -t "$name"
}
