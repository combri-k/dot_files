# /usr/share/doc/bash/examples/startup-files for examples

# garbage
# append to the history file, don't overwrite it
shopt -s histappend
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
# if not running interactively: don't do anything
if [[ -n "$PS1" ]] ;then
  [ -z "$PS1" ] && return
fi

# sources
source /home/ck/.colors
source /home/ck/.git_bash_completion

# prompt
# PS1="${Purple}\u${C}${Red}@${C}${Blue}\w${C}${Red}~>${C} "
# PS1='${debian_chroot:+($debian_chroot)}\[\033[00;35m\]\u@\h\[\033[00m\]\033[01;30m@\033[00m\[\033[01;31m\]\w\[\033[00m\]\$ '
# PS1="\u@\w~> "
# PS1="${BPurple}See You Space Cowboy... ~>${C} "
export PS1="\[${BRed}\]\w\[${C}\]\$(__git_ps1 '#\[${BPurple}\]%s\[${C}\]')\n\[${BBlue}\]See You Space Cowboy... ~>\[${C}\] "
# export PS1="${BRed}\t${C} ${BCyan}\w${C}\$(__git_ps1 '#${BPurple}%s${C}')\n${BBlue}See You Space Cowboy... ~>${C} "
# export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'

# aliases
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias v='vim'
alias j='jobs'
alias h='date +%H:%M\ %d/%m'
alias ..='cd ..'

# exports
export EDITOR='vim'
export BROWSER='opera'
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTCONTROL=ignoredups:ignorespace
export GEM_HOME=~/gems
export GEM_PATH=~/gems
export GOROOT=~/go
export GOPATH=~/go/bin
#export GIT_PS1_SHOWDIRTYSTATE=true
#export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM="auto"
# paths
export PATH=/home/ck/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
export PATH=$PATH:~/.cabal/bin
export PATH=$PATH:~/.rbenv/bin:~/.rbenv/shims
export PATH=$PATH:~/gems/bin
export PATH=$PATH:~/scala/bin:~/play-2.0-beta
export PATH=$PATH:~/go/bin

# functions
head-of-all() {
  #if [ $# == 1 && "$1" == +([0-9]) ]
  #then
    for i in `(ls)`
    do
      if [ -f $i ]
      then
        echo -e "\n\t\t$Red=============================\t$i$C: $Blue$1$C\t$Red=============================$C\n"
        head -n $1 $i
      fi
    done
  #else
  #  echo "Argument error."
  #fi
}

clear_history() {
  export HISTSIZE=0
  export HISTFILESIZE=0
  source /home/ck/.bashrc
}

gccgo() {
  bin=$1
  file=$bin.go
  object=$bin.8
  8g $file && 8l -o $bin $object && ./$bin
  rm $object $bin
}

h2h() {
  erb_file_name=$1
  remove=$2
  haml_file_name="`expr match $erb_file_name "\(.*\)\.erb$"`.haml"
  html2haml $erb_file_name $haml_file_name
  if [ -n "$remove" ]
  then
    if [ $remove == '-r' ]
      then rm $erb_file_name
    else echo "Second arg must be -r to remove .erb file after conversion."
    fi
  fi
  echo "Done."
}
