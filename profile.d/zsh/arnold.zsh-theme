# vim:ft=zsh ts=2 sw=2 sts=2
#
# [Powerline-patched font](https://github.com/Lokaltog/powerline-fonts).
# Make sure you have a recent version: the code points that Powerline
# uses changed in 2012, and older versions will display incorrectly,
# in confusing ways.
#
# # Goals
#
# The aim of this theme is to only show you *relevant* information. Like most
# prompts, it will only show git information when in a git working directory.
# However, it goes a step further: everything from the current user and
# hostname to whether the last call exited with an error to whether background
# jobs are running in this shell will all be displayed automatically when
# appropriate.

### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

CURRENT_BG='NONE'

# Special Powerline characters and nerdfont
#escape seq %42{…%} tells zsh assume inside braces is 42 characters wide

() {
  local LC_ALL="" LC_CTYPE="en_US.UTF-8"
  MASTER_SEPARATOR=$'\ue0c0' # fire echo $'\ue0c0' to view in terminal
  # END_SEPARATOR=$'\ue0b0' #  echo $'\ue0b0' to view in terminal
  END_SEPARATOR=$'\ue0b4' # semicircle echo $'\ue0b4' to view in terminal
  GIT_SEPARATOR=$'\ue725' #  echo $'\ue725' to view in terminal
  # LOCK_SEPARATOR=$'\ue0a2' # 
}

prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$MASTER_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  echo -n " %{%k%F{$CURRENT_BG}%}$END_SEPARATOR"
  echo -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)
prompt_context() {
  if [[ -n "$SSH_CLIENT" ]]; then
    prompt_segment magenta white "%{$fg_bold[white]%(!.%{%F{white}%}.)%}$USER@%m%{$fg_no_bold[white]%}"
  # else
  #   prompt_segment yellow magenta "%{$fg_bold[magenta]%(!.%{%F{magenta}%}.)%}@$USER%{$fg_no_bold[magenta]%}"
  fi
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    # prompt_segment cyan default "%m"
    # prompt_segment default default "%{ム(ツ)マ%}"
    prompt_segment red white "%{$fg_bold[white]%}ム(ツ)マ%{$fg_no_bold[white]%}"
  fi
}

# Git: branch/detached head, dirty status
prompt_git() {
# ♨ ➟ ☁ ☠ ·… ● ‡‡ ↓↑  📁   ↑↑ ↓   ↑ ↑ 🐍
# ム(ツ)マ om ॐ  ankh 𓋹 jupiter ♃
# «»±˖˗‑‐‒ ━ ✚‐↔←↑↓→↭⇎⇔⋆━◂▸◄►◆☀★☗☊✔✘✖❮❯⚑⚙

# ↑
# UPWARDS ARROW
# Unicode: U+2191, UTF-8: E2 86 91
# ↓
# DOWNWARDS ARROW
# Unicode: U+2193, UTF-8: E2 86 93

# ⬆︎
# UPWARDS BLACK ARROW
# Unicode: U+2B06 U+FE0E, UTF-8: E2 AC 86 EF B8 8E
# ⬇︎
# DOWNWARDS BLACK ARROW
# Unicode: U+2B07 U+FE0E, UTF-8: E2 AC 87 EF B8 8E


# - Local Status Symbols
#   - ``✔``: repository clean
#   - ``●n``: there are ``n`` staged files
#   - ``✖n``: there are ``n`` files with merge conflicts
#   - ``✖-n``: there are ``n`` staged files waiting for removal
#   - ``✚n``: there are ``n`` changed but *unstaged* files
#   - ``…n``: there are ``n`` untracked files
#   - ``⚑n``: there are ``n`` stash entries
# - Upstream branch
#   - Shows the remote tracking branch
#   - Disabled by default
#   - Enable by setting GIT_PROMPT_SHOW_UPSTREAM=1
# - Branch Tracking Symbols
#   - ``↑n``: ahead of remote by ``n`` commits
#   - ``↓n``: behind remote by ``n`` commits
#   - ``↓m↑n``: branches diverged, other by ``m`` commits, yours by ``n`` commits
#   - ``‡‡``: local branch, not remotely tracked
  # local PL_BRANCH_CHAR
  # () {
  #   local LC_ALL="" LC_CTYPE="en_US.UTF-8"
  #   PL_BRANCH_CHAR=$'\ue0a0'         # 
  # }

  local ref dirty mode repo_path clean has_upstream remote_update
  local modified untracked added deleted tagged stashed
  local ready_commit git_status bgclr fgclr
  local commits_diff commits_ahead commits_behind has_diverged to_push to_pull

  repo_path=$(\git rev-parse --git-dir 2>/dev/null)
  # remote_update=$(\git remote update >/dev/null 2>&1)   # gets remote status , but slow prompt

  if $(\git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    # dirty=$(parse_git_dirty)
    # dirty=$(command git status --porcelain --ignore-submodules=dirty --untracked-files=no | \egrep -c '[MADRCU]{2,}')
    dirty=$(command git status --porcelain --ignore-submodules=dirty --untracked-files=all | \egrep -c '[MADRCU?]{2,}')    # Considering presence new untracted files as dirty repo state
    git_status=$(\git status --porcelain 2> /dev/null)
    ref="$GIT_SEPARATOR $(\git symbolic-ref HEAD 2> /dev/null)" || ref=":$(\git rev-parse --short HEAD 2> /dev/null)"
    if [[ $dirty -gt 0 ]]; then
      clean=' ✘'
      bgclr='yellow'
      fgclr='magenta'
    else
      clean=' ✔'
      bgclr='green'
      fgclr='blue'
    fi

    local upstream=$(\git rev-parse --symbolic-full-name --abbrev-ref @{upstream} 2> /dev/null)
    if [[ -n "${upstream}" && "${upstream}" != "@{upstream}" ]]; then has_upstream=true; fi

    local upstream_prompt=''
    if [[ $has_upstream == true ]]; then
      commits_diff="$(\git log --pretty=oneline --topo-order --left-right ${current_commit_hash}...${upstream} 2> /dev/null)"
      commits_ahead=$(\grep -c "^<" <<< "$commits_diff")
      commits_behind=$(\grep -c "^>" <<< "$commits_diff")
      # upstream_prompt=""       # Disabled as integrated with GIT_SEPARATOR in ref below
    else
      # upstream_prompt=" ‡‡"
      upstream_prompt="(L)"
      ref="$upstream_prompt $(\git symbolic-ref HEAD 2> /dev/null)" || ref=":$(\git rev-parse --short HEAD 2> /dev/null)"
    fi

    local current_commit_hash=$(\git rev-parse HEAD 2> /dev/null)
    local number_of_untracked_files=$(\grep -c "^??" <<< "${git_status}")
    if [[ $number_of_untracked_files -gt 0 ]]; then untracked="…$number_of_untracked_files"; fi

    local number_added=$(\grep -c "^A" <<< "${git_status}")
    if [[ $number_added -gt 0 ]]; then added="●$number_added"; fi

    local number_modified=$(\grep -c "^.M" <<< "${git_status}")
    if [[ $number_modified -gt 0 ]]; then
      modified="✚$number_modified"
      bgclr='red'
      fgclr='white'
    fi

    local number_added_modified=$(\grep -c "^M" <<< "${git_status}")
    local number_added_renamed=$(\grep -c "^R" <<< "${git_status}")
    if [[ $number_modified -gt 0 && $number_added_modified -gt 0 && $number_added_renamed -gt 0 ]]; then
      modified="✚$((number_modified+number_added_modified+number_added_renamed))"
    elif [[ $number_added_modified -gt 0 && $number_added_renamed -gt 0 ]]; then
      modified="✚$((number_added_modified+number_added_renamed))"
    fi

    local number_deleted=$(\grep -c "^.D" <<< "${git_status}")
    if [[ $number_deleted -gt 0 ]]; then
      deleted="━$number_deleted"
      bgclr='red'
      fgclr='white'
    fi

    local number_added_deleted=$(\grep -c "^D" <<< "${git_status}")
    if [[ $number_deleted -gt 0 && $number_added_deleted -gt 0 ]]; then
      deleted="━$((number_deleted+number_added_deleted))"
    elif [[ $number_added_deleted -gt 0 ]]; then
      deleted="━$number_added_deleted"
    fi

    local tag_at_current_commit=$(\git describe --exact-match --tags $current_commit_hash 2> /dev/null)
    if [[ -n $tag_at_current_commit ]]; then tagged="☗ $tag_at_current_commit|"; fi

    local number_of_stashes="$(\git stash list -n1 2> /dev/null | wc -l)"
    if [[ $number_of_stashes -gt 0 ]]; then
      stashed="⚑${number_of_stashes##*(  )}"
      bgclr='magenta'
      fgclr='white'
    fi

    if [[ $number_added -gt 0 || $number_added_modified -gt 0 || $number_added_deleted -gt 0 ]]; then ready_commit='|♨'; fi   # What's the point ?

    ## escape seq %42{…%} tells zsh assume inside braces is 42 characters wide

    has_diverged=false
    if [[ $commits_ahead -gt 0 && $commits_behind -gt 0 ]]; then has_diverged=true; fi

    if [[ $has_diverged == false && $commits_ahead -gt 0 ]]; then
      if [[ $bgclr == 'red' || $bgclr == 'magenta' ]] then
        to_push="%2{$fg_bold[white]↑$commits_ahead$fg_bold[$fgclr]%}"
      else
        to_push="%2{$fg_bold[black]↑$commits_ahead$fg_bold[$fgclr]%}"
      fi
    fi

    if [[ $has_diverged == false && $commits_behind -gt 0 ]]; then
      if [[ $bgclr == 'red' || $bgclr == 'magenta' ]] then
        to_pull=" %2{$fg_bold[white]↓$commits_behind$fg_bold[$fgclr]%}"
      else
        to_pull=" %2{$fg_bold[black]↓$commits_behind$fg_bold[$fgclr]%}"
      fi
    fi

    if [[ $has_diverged == true && $commits_ahead -gt 0 ]]; then
      if [[ $bgclr == 'red' || $bgclr == 'magenta' ]] then
        to_push="%2{$fg_bold[white]↾$commits_ahead$fg_bold[$fgclr]%}"
      else
        to_push="%2{$fg_bold[black]↾$commits_ahead$fg_bold[$fgclr]%}"
      fi
    fi

    if [[ $has_diverged == true && $commits_behind -gt 0 ]]; then
      if [[ $bgclr == 'red' || $bgclr == 'magenta' ]] then
        to_pull=" %2{$fg_bold[white]$commits_behind⇃$fg_bold[$fgclr]%}"
      else
        to_pull=" %2{$fg_bold[black]$commits_behind⇃$fg_bold[$fgclr]%}"
      fi
    fi

    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
      mode=" <B>"
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
      mode=" >M<"
    elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
      mode=" >R>"
    fi

    prompt_segment $bgclr $fgclr
##
    local current_commit_state=$(command git status --porcelain | egrep -c "^[ ]{1}")
    local current_commit_process=$(command git status --porcelain | egrep -c "^[MADRCU]{1,1}")
    unset prompt_stash_clean_commit
    if [[ $dirty -gt 0 ]]; then                       # if not clean mark dirty
      prompt_stash_clean_commit="$clean"
    elif [[ $current_commit_state -eq 1 ]]; then      # CRUD Files
      prompt_stash_clean_commit="$ready_commit"
    elif [[ $current_commit_process -gt 0 ]]; then    # is commit in process?
      prompt_stash_clean_commit="$ready_commit"
    else prompt_stash_clean_commit="$clean"           # I guess I'm clean
    fi
    if [[ $number_of_stashes -gt 0 ]]; then           # list any stashes present
      prompt_stash_clean_commit+=" $stashed"
    fi
##
    git_status_segment="$tagged$added$modified$deleted$untracked"
    if [[ -n $git_status_segment ]]; then git_status_segment="|${git_status_segment}"; fi
    # echo -n "%{$fg_bold[$fgclr]%}${ref/refs\/heads\//}${mode}$upstream_prompt$to_pull$to_push$git_status_segment$prompt_stash_clean_commit%{$fg_no_bold[$fgclr]%}"  #Arnold TODO
    echo -n "%{$fg_bold[$fgclr]%}${ref/refs\/heads\//}${mode}$to_pull$to_push$git_status_segment$prompt_stash_clean_commit%{$fg_no_bold[$fgclr]%}"  #Arnold TODO
  fi
}

# Dir: current working directory
prompt_dir() {
  prompt_segment blue white "%{$fg_bold[white]%}$(al_shrink_path -a)%{$fg_no_bold[white]%}"
}

# prompt_muxenv() {
#   if [[ ! -z "${TMUX}" ]]; then
#     local INFO=$(tmux display-message -p "#S")
#     prompt_segment green black "%{$fg_bold[black]%}$INFO%{$fg_no_bold[black]%}"
#   fi
# }

# Virtualenv: current working virtualenv 🐍
prompt_virtualenv() {
  local virtualenv_path="$VIRTUAL_ENV"
  local virtualenv_dir="$VIRTUAL_ENV_DIR_NAME"
  if [[ -n $virtualenv_path && -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
    prompt_segment black green "%{$fg_bold[green]%}(🐍) $virtualenv_dir%{$fg_no_bold[green]%}"
  fi
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local symbols
  symbols=()
  # [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}$RETVAL✘"
  [[ $UID -eq 0 ]] && symbols+="⚡ "
  # [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙ "
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="⚙ "
  [[ -n "$symbols" ]] && prompt_segment black default "$symbols"
}

## Main prompt
build_prompt() {
  # RETVAL=$?
  prompt_status
  prompt_context
  # prompt_muxenv
  prompt_virtualenv
  prompt_dir
  prompt_git
  prompt_end
  CURRENT_BG='NONE'
}

PROMPT='$(build_prompt) '
