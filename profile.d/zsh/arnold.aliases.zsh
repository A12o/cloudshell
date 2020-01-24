# vim:ft=zsh ts=2 sw=2 sts=2 et fenc=utf-8
################################################################

export EDITOR=vim
export TERM=xterm-256color
# unset LESS; export LESS="-JFiRe"       # no -X prevents help(print) from working properly in python repl
unset LESS; export LESS="-JFiXeR"        # The -X prevents mouse scroll in man
umask 0022

alias cp='\cp'
alias mv='\mv'
alias rm='\rm'

## Leave unset and default kicks in for each OS
# alias ls='\ls --color' # Linux
# alias ls='ls -G'   # mac color

alias Console='sudo /Applications/Utilities/Console.app/Contents/MacOS/Console'   # mac osX
alias ll='ls -la'
alias llf='ls -laF'
alias l.='ls -d .*'
alias egrep='\egrep --color=auto'
alias fgrep='\fgrep --color=auto'
alias grep='\grep --color=auto'

alias npm='npm -g'
alias mosh='\mosh --ssh="ssh -oStrictHostKeyChecking=no"'
alias ssh='\ssh -oStrictHostKeyChecking=no'
alias scp='\scp -oStrictHostKeyChecking=no'
alias ansible='\ansible --ssh-common-args=-oStrictHostKeyChecking=no'
alias ansible-playbook='\ansible-playbook --ssh-common-args=-oStrictHostKeyChecking=no'
alias bat='bat --theme="Monokai Extended Origin" --style=numbers,changes --color "always"'

alias mtr='sudo mtr'
alias iftop='sudo iftop'
alias htop='sudo htop'
alias azcopy='blobxfer'
alias vboxmanage='VBoxManage'
alias prettyping='prettyping --nolegend'
alias rsa='echo -n $(stoken tokencode) | pbcopy'
alias vi='vim'
# alias less='less -FXi' using enviroment variable LESS instead
alias ping3='/sbin/ping -c3'
alias vscode='code'
# alias jnb='jupyter lab --notebook-dir=$HOME/Arnold/Scripts/Code/python&'
jlab () { jupyter lab --notebook-dir=$HOME/Arnold/Scripts/Code/python ; }
alias jnb='jlab &'

alias screen='screen -e^Vv -h 5000'     # ie use C-v instead of C-a
alias SCR='screen -dRS'
alias SLS='screen -ls'
alias mux='tmuxinator'

alias curl='/usr/local/opt/curl/bin/curl'
alias tf='terraform'

# eval $(thefuck --alias ef)
# \t ef          - aliased to fuck ie thefuck auto-correction

function __speed_zsh() {
        # for i in $(seq 1 10); do /usr/bin/time zsh -i -c exit; done
        repeat 10 {time zsh -i -c exit}
}

function __AL-new() {
    clear
    echo -e "\
    \n
    \t sipcalc     - sipcalc 10.5.0.0/27 -- ip subnet  calculator
    \t wrk         - HTTP benchmarking tool
    \t bench       - Command-line tool to benchmark other programs
    \t hyperfine   - Command-line tool to benchmark other programs
    \t gron        - Transform JSON (from a file, URL, or stdin) make it greppable
    \t exa         - ls replacement
    \t fpp         - PathPicker (fpp), for quickly selecting files
    \t hexyl       - a hex viewer
    "
}

function __AL-tmux() {
  view ~/.tmux.conf
}

function __AL-vi() {
  view ~/.vimrc
}

# convert diff to a func for color invocation via "git diff" and as "diff -Naur"
function diff() {
        colordiff "$@"
}
# alias GITfetchupstream='\git fetch upstream && git checkout master && git merge upstream/master && git push'
# function git_commit() {
#         \git add . ; \git commit -m "$1"; # \git push origin
# }

function gtime() { /gtime -f '\nuser: %Us, sys: %Ss, real: %es, mem: %MkB, cpu: %P, for: %C\n' "$@" }
function shrug() { echo "¯\_(ツ)_/¯ Copied"; echo "¯\_(ツ)_/¯" | pbcopy ; }
function yamllint() {
        echo -e "\nChecking yml files in current directory tree\n";for i in $(find . -name '*.yml' -o -name '*.yaml'); do ruby -e "require 'yaml';YAML.load_file(\"$i\")"; done
}
# Useful for converting between Graphite metrics and file paths
function dottoslash() {
        echo $1 | sed 's/\./\//g'
}
function slashtodot() {
        echo $1 | sed 's/\//\./g'
}

# Colorized man pages, from:
# http://boredzo.org/blog/archives/2016-08-15/colorized-man-pages-understood-and-customized
# See man terminfo \
function man() {
        export LESS=-JFiRe
        env \
                LESS_TERMCAP_md=$(printf "\e[1;36m") \
                LESS_TERMCAP_me=$(printf "\e[0m") \
                LESS_TERMCAP_se=$(printf "\e[0m") \
                LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
                LESS_TERMCAP_ue=$(printf "\e[0m") \
                LESS_TERMCAP_us=$(printf "\e[1;32m") \
                man "$@"
        export LESS=-JFiXeR
}

# alias git='hub'
function GITSTATUS () { echo -e "The symbols are as follows:

- Local Status Symbols
  - ``✔ ``: repository clean
  - ``✘ ``: repository dirty
  - ``♨ ``: repository ready to commit

  - ``●n``: there are ``n`` staged files
  - ``✖n``: there are ``n`` files with merge conflicts
  - ``✖-n``: there are ``n`` staged files waiting for removal
  - ``✚n``: there are ``n`` changed but *unstaged* files
  - ``…n``: there are ``n`` untracked files
  - ``⚑n``: there are ``n`` stash entries

- Branch Tracking Symbols
  - ``↑n``: ahead of remote by ``n`` commits  (via git remote update)
  - ``↓n``: behind remote by ``n`` commits  (via git remote update)
  - ``m⇃↾n``: branches diverged, other by ``m`` commits, yours by ``n`` commits
  - ``(L)``: local branch, not remotely tracked
  - ``\ue725 ``: remotely tracked branch

To populate repo local git configs

        __GIT-SIGNET() and __GIT-AL()

Commands
        tig - text-mode interface for Git

" ; }

export HELM_HOME="$HOME/.helm"
# gc () { gcc -g -Wall $1 -o $(echo $1 | cut -d . -f 1) && ./$(echo $1 | cut -d . -f 1) ; }

# source $HOME/.cargo/env   # Rustc path
export GOPATH="$HOME/Arnold/Scripts/Code/Go"
export GOHOME="$GOPATH/src/github.com/a12o"
export PATH="":"/usr/local/sbin/":$PATH
export PATH=$PATH:"$GOPATH/bin"

# # https://github.com/vmware/govmomi/tree/master/govc
# # govc is a vSphere CLI built on top of govmomi
# # https://github.com/vmware/govmomi/blob/master/govc/USAGE.md

alias govc='govc_darwin_amd64'
export GOVC_URL="https://ESXI_OR_VCENTER_HOSTNAME"
export GOVC_USERNAME=""
export GOVC_PASSWORD=""
# # Use path separator to specify multiple files:
# export GOVC_TLS_CA_CERTS=~/ca-certificates/bar.crt:~/ca-certificates/foo.crt
export GOVC_TLS_CA_CERTS=""
export GOVC_TLS_KNOWN_HOSTS=~/.govc_known_hosts
# # govc about.cert -u host -k -thumbprint | tee -a $GOVC_TLS_KNOWN_HOSTS
# # govc about -u user:pass@host

# # added by Anaconda3 5.2.0 installer
# # export PATH="$HOME/anaconda3/bin:$PATH"

## Python, Pyenv, Pipenv

## Using pyenv to manage python environment
## pyenv versions         ## shows installed python versions in $HOME/.pyenv/version
## pyenv global system    ## switches to using system python 3.7.XX
## pyenv global 3.6.0     ## switches to using 3.6.0 python in pyenv
## pyenv install -l       ## list available python runtimes to install in $HOME/.pyenv/version
## pyenv install 3.6.6    ## to install local python 3.6.6
## eval "$(pyenv init -)"

function pyenv-init() {
    eval "$( command pyenv init - )"
    pyenv versions
    echo "\nEnabling Pyenv\n"
    python --version
}

function pipU() {
  ##
  ## Note to future self use
  ## pipenv --site-packages --python 3.7 or --python path/to/python
  ## to create py3.7 env with site packages from system acct
  ##

  if [[ -n $VIRTUAL_ENV ]]; then
    echo -n "\n\tUPDATING Local Packages in \n\t$(pipenv --where)\n\n"
    pip list --local
    echo "\n"
    pip list --local --format freeze | cut -d"=" -f1| xargs -n1 pip install -U
  else
    echo -n "\n\t Not a Python Virtual Env\n\t run pipenv shell\n\t in the appropriate directory under\n\t $HOME/Arnold/Scripts/Code/Venv/\n\n"
    unset do_local_pip
    echo "\n\033[1;36mContinue \033[1;33mLinux Brew or PyEnv \033[1;36mpip Update?\033[0m\n"
    for i in {15..1}
    do
        echo -n "waiting for \033[1;33m$i\033[0m seconds, (y/N)[n] : \r"
        read -s -t 1 -q do_local_pip
        if [[ -n "$do_local_pip" ]] then break
        fi
    done
    do_local_pip=${do_local_pip:-n}   # set default value to n
    echo "\n"
    echo "\033[1;32mResponse was $do_local_pip\033[0m\n"
    if [[ $do_local_pip == "y" ]] then
        echo "Updating your Linux Brew or PyEnv pip installation instead\n\n"
        pip list --local
        echo "\n"
        pip list -l --format freeze | cut -d"=" -f1| xargs -n1 pip install -U
    fi
  fi
}
## Decorating pipenv in arnold.aliases.zsh to allow for setting VIRTUAL_ENV_DIR_NAME for Prompt in theme
function AL-pipenv() {
  unset VIRTUAL_ENV_DIR_NAME
  export VIRTUAL_ENV_DIR_NAME=$(basename $(pipenv --where))
  pipenv "$@"
}

function py() {
  source $HOME/Arnold/Tools/launch_pipenv.sh
}
## Python and Pipenv

# use fg - to switch to 1st bg job
fg() {
  if [[ $# -eq 1 && $1 = - ]]; then
    fg %-
  else
    builtin fg "$@"
  fi
}

# Because I want to keep my ID out of Global Git config
function __GIT-AL() {
  \git config --local user.email "Arnold.Lasrado@gmail.com"
  \git config --local user.name "a12o"
}
function __GIT-SIGNET() {
  \git config --local user.email "Arnold.Lasrado@signetjewelers.com"
  \git config --local user.name "Arnold Lasrado"
}
function AL-XPS-UPDATE() {
  if [[ $(uname) == "Linux" ]] then
    echo "\n\n Updating System APT \n\n"
    \sudo bash -c "apt update && apt -y upgrade"
    echo "\n\n Udating linuxBrew \n\n"
    \brew upgrade
    # echo "\n\n Updating NPM \n\n"
    # \npm -g update
    echo "\n\n Updating Gem \n\n"
    \gem update
  fi
}

export PATH="$HOME/Library/Python/3.7/bin:$PATH"


# ncurses is keg-only, which means it was not symlinked into /usr/local,
# because macOS already provides this software and installing another version in
# parallel can cause all kinds of trouble.
#
# If you need to have ncurses first in your PATH run:
export PATH="/usr/local/opt/ncurses/bin:$PATH"
export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/Homebrew/Library/Homebrew/vendor/portable-ruby/current/bin:$PATH"
# Adding Ruby and GEM path to mac
export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/2.6.0/bin:$PATH"

export PATH="$HOME/Arnold/Tools:$PATH"      ## Place my custom scripts like ptpython here
export PATH="$HOME/.local/bin:$PATH"      ## Place my pip install --user python packages here

export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"    ## GNU "make" installed as "gmake"

# For compilers to find ncurses you may need to set:
export LDFLAGS="-L/usr/local/opt/ncurses/lib"
export CPPFLAGS="-I/usr/local/opt/ncurses/include"

# For pkg-config to find ncurses you may need to set:
export PKG_CONFIG_PATH="/usr/local/opt/ncurses/lib/pkgconfig"

# using vi mode
# set -o vi
