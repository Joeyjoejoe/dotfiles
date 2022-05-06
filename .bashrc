########################################
########### UBUNTU  DEFAULTS ###########
########################################

# if command -v tmux>/dev/null; then
#   [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux
# fi

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

########################################
######### PROMPT CUSTOMIZATION #########
########################################

	#################################
	# Determine colors capabilities #
	#################################

	# set a fancy prompt (non-color, unless we know we "want" color)
	case "$TERM" in
			xterm-color|*-256color) color_prompt=yes;;
	esac

	if [ -n "$force_color_prompt" ]; then
			if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
			else
		color_prompt=
			fi
	fi

	##################
	# MISC FUNCTIONS #
	##################

	# Define a new color from the xterm-256-color
	# chart (https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg)
	color(){
		echo -e "\\033[38;5;$1m"
	}

	# Add a dot at the end of line, except
	# For $HOME and / directories.
	set_prompt_end() {
	if [ $HOME = $PWD -o $PWD = / ]; then
			echo ""
		else
			echo "⸱"
		fi
	}

	#################
	# GIT FUNCTIONS #
	#################

	# Get current branch name
	parse_git_branch() {
		git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
	}

	# Display current branch, and colorize it
	# if uncomitted changes are present.
	check_git_local_changes() {
		if [[ `git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'` ]]; then
			if [[ `git status --porcelain` ]]; then
				echo -e "\001\\033[38;5;166m\002𝈦 $1* "
			else
				echo -e "\001\\033[38;5;129m\002𝈦 $1 "
			fi
		fi
	}

	###################
	# COLORS & STYLES #
	###################

	# Colors
	light_blue="$(color 69)"
	bordeaux="$(color 125)"
	dark_gray="$(color 244)"

	# Styles for strings
	bold="$(tput bold)"

	# Reset all styles
	reset="$(tput sgr0)"

	#################
	# PROMPT STRING #
	#################

	if [ "$color_prompt" = yes ]; then
		PS1='${debian_chroot:+($debian_chroot)}\[$bold$bordeaux\](λ)\[$light_blue\] \W $(check_git_local_changes $(parse_git_branch))$(set_prompt_end)\[$reset$dark_gray\]'

		# Clear prompt styles before executing a command (command color hack)
		trap 'printf \\e[0m' DEBUG
	else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
	fi
	unset color_prompt force_color_prompt

	# If this is an xterm set the title to user@host:dir
	case "$TERM" in
	xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
	*)
    ;;
	esac

########################################
########### MAN PAGES COLORS ###########
########################################

man() {
	env \
	LESS_TERMCAP_mb=$(color 120) \
	LESS_TERMCAP_md=$(echo -e "$BOLD$(color 118)") \
	LESS_TERMCAP_me=$(color 122) \
	LESS_TERMCAP_so=$(color 123) \
	LESS_TERMCAP_se=$(color 201) \
	LESS_TERMCAP_us=$(color 151) \
	LESS_TERMCAP_ue=$(color ) \
	LESS_TERMCAP_mr=$(color 22) \
	LESS_TERMCAP_mh=$(color 88) \
	LESS_TERMCAP_ZN=$(color 88) \
	LESS_TERMCAP_ZV=$(color 88) \
	LESS_TERMCAP_ZO=$(color 88) \
	LESS_TERMCAP_ZW=$(color 88) \
	man "$@"
}

########################################
############## LS  CONFIG ##############
########################################


# Colors
LS_COLORS='di=1;34:fi=0:ln=32;5:pi=5:so=5:bd=5:cd=5:or=31:ex=35:*.rpm=90:mi=34:st=37:ow=2'

################
# BASH HISTORY #
################

shopt -s cmdhist
export HISTIGNORE="ls:ps:history"

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

########################################
################# MISC #################
########################################


# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export VISUAL=vim
export EDITOR="$VISUAL"
export TMUX_BOX="/tmp/tmux-box.log"
export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which javac))))

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
