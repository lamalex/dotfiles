function set_win_title() {
	echo -ne "\033]0; ⚰️  $(whoami)@$(hostname):$PWD \007"
}

cmd_exists () {
  type $1 &>/dev/null 
}

source_if_exists () {
  [ -f $1 ] && source $1
}

safe_alias () {
  [[ $(cmd_exists $2) -eq 0 ]] && alias $1=$2
}

# Load homebrew autocompletions
if `cmd_exists brew`; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

# Setup zsh autocomplete
source_if_exists /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Setup fzf integrations
source_if_exists ~/.fzf.zsh

# Setup asdf integration
source_if_exists /usr/local/opt/asdf/asdf.sh


if `cmd_exists zoxide`; then
  eval "$(zoxide init zsh)"
fi

# FZF Aliases and exports
if `cmd_exists fzf` && `cmd_exists fd`; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

safe_alias cat bat
safe_alias ls "exa --icons"
safe_alias du dust

precmd_functions+=(set_win_title)
# Initialize starship as prompt, must be last
if `cmd_exists starship`; then
  eval "$(starship init zsh)"
fi


