# https://blog.jonlu.ca/posts/speeding-up-zsh
# Uncomment for speed debug
# zmodload zsh/zprof

# Enable shell integration in tmux
export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# export ZSH_THEME="powerlevel9k/powerlevel9k"
# export ZSH_THEME="robbyrussell"

# Powerlevel9k Settings
# if you want to use this, change your non-ascii font to Droid Sans Mono for Awesome
# POWERLEVEL9K_MODE='awesome-patched'
# POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
# https://github.com/bhilburn/powerlevel9k#customizing-prompt-segments
# https://github.com/bhilburn/powerlevel9k/wiki/Stylizing-Your-Prompt
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir nvm vcs)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status history time)
#
# colorcode test
# for code ({000..255}) print -P -- "$code: %F{$code}This is how your text would look like%f"
# POWERLEVEL9K_NVM_FOREGROUND='000'
# POWERLEVEL9K_NVM_BACKGROUND='072'
# POWERLEVEL9K_SHOW_CHANGESET=true

# Set to this to use case-sensitive completion
export CASE_SENSITIVE="false"

export DISABLE_UPDATE_PROMPT="true"

# disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# disable autosetting terminal title.
export DISABLE_AUTO_TITLE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
# ZSH_CUSTOM=$HOME/oh-my-zsh-custom

# Which plugins would you like to load? (plugins can be found in ~/oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)
plugins+=(gpg-agent)
plugins+=(ssh-agent)
plugins+=(gnu-utils)
plugins+=(pass)
plugins+=(k)
plugins+=(yarn)
# plugins+=(gitfast) # heavy load
plugins+=(fasd)
plugins+=(git-extras)
plugins+=(brew)
plugins+=(sudo)
# plugins+=(composer)
plugins+=(docker)
plugins+=(docker-machine)
plugins+=(laravel5)
plugins+=(sublime)
plugins+=(httpie)
plugins+=(ansible)
plugins+=(compleat)
plugins+=(dirpersist)
plugins+=(dircycle) # cycle your directory stack {left,right} using Ctrl+Shift+Left/Right.
plugins+=(copyfile)
plugins+=(colorize)
plugins+=(history)
plugins+=(osx)
plugins+=(cp)
plugins+=(tmuxinator)
plugins+=(zsh-z)
plugins+=(zsh-autosuggestions)
plugins+=(zsh-completions)
plugins+=(zsh-syntax-highlighting)
if [[ "$OS" == "Linux" ]]; then
	plugins+=(archlinux)
fi

[ -r $ZSH/oh-my-zsh.sh ] && source $ZSH/oh-my-zsh.sh
[ -r $ZSH/custom/.colored_man_pages.zsh ] && source $ZSH/custom/.colored_man_pages.zsh
[ -r $ZSH/custom/tmuxinator.zsh ] && source $ZSH/custom/tmuxinator.zsh

# npx as default fallback command
# source <(npx --shell-auto-fallback zsh)


# User configuration
# fastolx autocomplete:script zsh > $MY_TEMP/temp && chmod +x $MY_TEMP/temp && source $MY_TEMP/temp && rm $MY_TEMP/temp

# Advanced Tab completion
autoload -Uz compinit && compinit
# Now can be use code that calls compdef
# [ -z "$TMUX" ] && { exec /usr/local/bin/tmux -CC new-session -A -s main && exit;}
# The -A flag makes new-session behave like
	# attach-session if session-name already exists

# tmux -CC attach || tmux -CC

# if [[ -z $TMUX ]]; then
# 	echo 'no tmux'
# else
# 	echo "yes tmux: ${TMUX}"
# fi
# Is this needed?
# if [[ -z $TMUX ]]; then
	[ -r $HOME/.profile ] && source $HOME/.profile
# fi

export MANPATH="$USR_PATH/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

if [[ "$OS" == "Linux" ]]; then
	# Compilation flags
	export ARCHFLAGS="-arch x86_64"
fi

setopt list_ambiguous

# if (command which -s yarn) npm () {
#   case $@ in
#     *-g*|root*) command npm $@;;
#     install*) (($# > 1)) && yarn add ${@[2,#]} || yarn install;;
#     *) yarn $@;;
#   esac
# }
# [ $ZSH_EVAL_CONTEXT = toplevel ] && npm $@


if test -z $GOPASSCMD; then
   # allows to source zshrc twice
   export GOPASSCMD=$(which gopass)

	[ -n $GOPASSCMD ] && [ -d PASSWORD_STORE_DIR ] && source <($GOPASSCMD completion zsh | head -n -1 | tail -n +2)
	compdef _gopass gopass
fi

alias zsh_is_loading="zsh -o SOURCE_TRACE"

# make rbenv load automatically when open Terminal
eval "$(rbenv init -)"

# eval "$(pyenv init -)"

eval "$(starship init zsh)"

# source $(dirname $(gem which colorls))/tab_complete.sh

if [[ "$OS" == "Linux" ]]; then
	test -d \~/.linuxbrew && eval $(\~/.linuxbrew/bin/brew shellenv)
	test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
	test -r \~/.bash\_profile && echo "eval \\$($(brew --prefix)/bin/brew shellenv)" >>\~/.bash\_profile
	echo "eval \\$($(brew --prefix)/bin/brew shellenv)" >>\~/.profile
fi

# https://github.com/nvbn/thefuck#manual-installation
# eval $(thefuck --alias)
# Uncomment for speed debug
# zprof
