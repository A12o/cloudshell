# vim:ft=zsh ts=2 sw=2 sts=2 et fenc=utf-8
################################################################

## fzf
test -e "$HOME/profile.d/zsh/custom_plugin/arnold.fzf.zsh" && source "$HOME/profile.d/zsh/custom_plugin/arnold.fzf.zsh"
alias fzf='fzf --multi'                         ## multiline select/deselect via tab/shift-tab
#
## add support for ctrl+o to open selected file in VS Code, ctrl+y to copy to clipboard
##  export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {}),ctrl-y:execute-silent(echo {} | pbcopy)'"   ## add +abort to quit after VS code is launched
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
#
alias _fzf_view="\fzf --preview 'bat --color \"always\" {}'" ## the \fzf implies ignore fzf aliases
alias _viA='vim "$(_fzf_view)"'                              ## edit fzf files using vim
#
function fzf-view () { local FZF_PWD="$(pwd)"; cd "$1"; _fzf_view; cd "$FZF_PWD" ;}   ## run _fzf_view in dir $1
function fzf-vi () { local FZF_PWD="$(pwd)"; cd "$1"; _viA; cd $FZF_PWD ;}          ## run _viA in dir $1
alias fze='fzf-vi'
alias fzv='fzf-view'
## fzf

source "$HOME/profile.d/zsh/custom_plugin/arnold.custom_abbreviations.zsh"
#
setopt prompt_subst
source "$HOME/profile.d/zsh/custom_plugin/arnold-shrink-path.plugin.zsh"
#
source "$HOME/profile.d/zsh/custom_plugin/zsh-autosuggestions.zsh"

###############################################################
## Test using ruby -e "require 'yaml';YAML.load_file(\"./using_when_in_import.yml\")"
source "$HOME/profile.d/zsh/custom_plugin/zsh-syntax-highlighting.plugin.zsh"
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=magenta,bold'
ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red') # To have commands starting with `rm -rf` in red:
################################################################
