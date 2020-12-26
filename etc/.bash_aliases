# Default paramters
alias ls='ls -l --color=always --group-directories-first --human-readable'
alias la='ls -A'

# todo bash
alias t='$HOME/dotfiles/scripts/todo.sh -d ~/dotfiles/.todo/todo.cfg'
alias tproj='t listproj'
alias tcont='t lsc'
alias trm='t del'
alias tadd='t a'

# git
alias commits='git log --author="$(git config user.name)" --oneline'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# miscs
alias colors='bg-colors;echo;fg-colors'
alias pomodoro='countdown 1200 &'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


