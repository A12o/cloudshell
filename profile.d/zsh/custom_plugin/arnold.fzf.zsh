# Setup fzf

if [[ $(uname) == "Darwin" ]] then
  if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
    export PATH="$PATH:/usr/local/opt/fzf/bin"
  fi
  # Auto-completion
  # ---------------
  [[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null
fi

if [[ $(uname) == Linux ]] then
  export PATH="$PATH:/home/linuxbrew/.linuxbrew/opt/fzf/bin"
  # Auto-completion
  # ---------------
  [[ $- == *i* ]] && source "/home/linuxbrew/.linuxbrew/opt/fzf/shell/completion.zsh" 2> /dev/null
fi

# Key bindings
# ------------
source "$HOME/profile.d/zsh/custom_plugin/fzf-key-bindings.zsh"

