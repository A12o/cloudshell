# vim:ft=zsh ts=2 sw=2 sts=2 et fenc=utf-8
################################################################

##################
# the %{...%} means that the content will be interpreted as a literal escape sequence, so the cursor wont move while printing the sequence. If you dont use this, the color codes can actually move the cursor and produce undesired effects. This is documented in the Visual Effects section in zshmisc man page –
# http://linux.die.net/man/1/zshmisc

## zsh abbreviations. They allow you to enter an "abbreviation" which automatically gets replaced with its full form when you hit a magic key such as space.

## So you can create one which changes  ...<SPACE> to ../.. etc

# typeset -A abbrevs
# abbrevs=(
#         "..." "../.."
#         "...." "../../.."
# )

# #create aliases for the abbrevs too
# for abbr in ${(k)abbrevs}; do
#    alias -g $abbr="${abbrevs[$abbr]}"
# done

# my-expand-abbrev() {
#     local MATCH
#     LBUFFER=${LBUFFER%%(#m)[_a-zA-Z0-9]#}
#     LBUFFER+=${abbrevs[$MATCH]:-$MATCH}
#     zle self-insert
# }

# zle -N my-expand-abbrev
# bindkey " " my-expand-abbrev
# bindkey -M isearch " " self-insert

# binds C-u to emacs style backward-kill-line rather than kill-whole-line
# see man zshzle
bindkey \^U backward-kill-line
