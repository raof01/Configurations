# Antigen: https://github.com/zsh-users/antigen
source ${HOME}/.fonts/*.sh
[[ -s /home/raof01/.autojump/etc/profile.d/autojump.sh ]] && source /home/raof01/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u
ANTIGEN="$HOME/.local/bin/antigen.zsh"

# Install antigen.zsh if not exist
if [ ! -f "$ANTIGEN" ]; then
	echo "Installing antigen ..."
	[ ! -d "$HOME/.local" ] && mkdir -p "$HOME/.local" 2> /dev/null
	[ ! -d "$HOME/.local/bin" ] && mkdir -p "$HOME/.local/bin" 2> /dev/null
	[ ! -f "$HOME/.z" ] && touch "$HOME/.z"
	URL="http://git.io/antigen"
	TMPFILE="/tmp/antigen.zsh"
	if [ -x "$(which curl)" ]; then
		curl -L "$URL" -o "$TMPFILE"
	elif [ -x "$(which wget)" ]; then
		wget "$URL" -O "$TMPFILE"
	else
		echo "ERROR: please install curl or wget before installation !!"
		exit
	fi
	if [ ! $? -eq 0 ]; then
		echo ""
		echo "ERROR: downloading antigen.zsh ($URL) failed !!"
		exit
	fi;
	echo "move $TMPFILE to $ANTIGEN"
	mv "$TMPFILE" "$ANTIGEN"
fi


# Initialize command prompt
#export PS1="%n@%m:%~%# "
# Initialize antigen
source "$ANTIGEN"

# Load local bash/zsh compatible settings
#[ -f "$HOME/.local/etc/init.sh" ] && source "$HOME/.local/etc/init.sh"

# visit https://github.com/unixorn/awesome-zsh-plugins
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle svn-fast-info
# antigen bundle command-not-find

antigen bundle colorize
antigen bundle github
antigen bundle python
antigen bundle z

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle supercrabtree/k

# check login shell
#if [[ -o login ]]; then
#	[ -f "$HOME/.local/etc/login.sh" ] && source "$HOME/.local/etc/login.sh"
#	[ -f "$HOME/.local/etc/login.zsh" ] && source "$HOME/.local/etc/login.zsh"
#fi

# syntax color definition
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

typeset -A ZSH_HIGHLIGHT_STYLES

# load local config
#[ -f "$HOME/.local/etc/config.zsh" ] && source "$HOME/.local/etc/config.zsh"
#[ -f "$HOME/.local/etc/local.zsh" ] && source "$HOME/.local/etc/local.zsh"

# enable syntax highlighting
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply

export DEFAULT_USER="raof01"
export TERM="xterm-256color"
export ZSH=${HOME}/.oh-my-zsh

ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE="nerdfont-complete"

source ${HOME}/.oh-my-zsh/custom/themes/powerlevel9k/functions/icons.zsh
source ${HOME}/.oh-my-zsh/custom/themes/powerlevel9k/functions/utilities.zsh
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_FOLDER_ICON=""
POWERLEVEL9K_HOME_ICON=""
POWERLEVEL9K_HOME_SUB_ICON="$(print_icon "HOME_ICON")"
POWERLEVEL9K_DIR_PATH_SEPARATOR=" $(print_icon "LEFT_SUBSEGMENT_SEPARATOR") "

POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0

POWERLEVEL9K_DIR_OMIT_FIRST_CHARACTER=true

POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND='black'
POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND='178'
POWERLEVEL9K_NVM_BACKGROUND="238"
POWERLEVEL9K_NVM_FOREGROUND="green"
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="blue"
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="015"

POWERLEVEL9K_TIME_BACKGROUND='255'
#POWERLEVEL9K_COMMAND_TIME_FOREGROUND='gray'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='245'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='black'

POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon root_indicator context virtualenv dir dir_writable vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status history background_jobs command_execution_time time)
POWERLEVEL9K_SHOW_CHANGESET=true
POWERLEVEL9K_OS_ICON_BACKGROUND="white"
POWERLEVEL9K_OS_ICON_FOREGROUND="black"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{014}\u2570%F{cyan}\uF460%F{073}\uF460%F{109}\uF460%f "
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"
POWERLEVEL9K_DIR_HOME_FOREGROUND="white"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="white"
POWERLEVEL9K_DIR_ETC_FOREGROUND="white"
POWERLEVEL9K_VIRTUALENV_BACKGROUND="cyan"

HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
# /!\ do not use with zsh-autosuggestions

plugins=(tig gitfast colorize command-not-found cp dirhistory autojump sudo)
# /!\ zsh-syntax-highlighting and then zsh-autosuggestions must be at the end

source $ZSH/oh-my-zsh.sh


ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_STYLES[cursor]='bold'

ZSH_HIGHLIGHT_STYLES[alias]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=green,bold'


rule () {
	print -Pn '%F{blue}'
	local columns=$(tput cols)
	for ((i=1; i<=columns; i++)); do
	   printf "\u2588"
	done
	print -P '%f'
}

function _my_clear() {
	echo
	rule
	zle clear-screen
}
zle -N _my_clear
bindkey '^l' _my_clear


# Ctrl-O opens zsh at the current location, and on exit, cd into ranger's last location.
ranger-cd() {
	tempfile=$(mktemp)
	ranger --choosedir="$tempfile" "${@:-$(pwd)}" < $TTY
	test -f "$tempfile" &&
	if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
	cd -- "$(cat "$tempfile")"
	fi
	rm -f -- "$tempfile"
	# hacky way of transferring over previous command and updating the screen
	VISUAL=true zle edit-command-line
}
zle -N ranger-cd
bindkey '^o' ranger-cd
alias h='history'
