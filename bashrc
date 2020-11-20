# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples


if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi



# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
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
#My Options
#Terminal Bar
parse_git_branch() {
   git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/{\1}/'
}

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
    return 1
 else
    for n in $@
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}


export PS1="\[\033[36m\]\u\[\033[0;31m\]$(parse_git_branch)\[\033[m\]@\[\033[32m\]\h:\[\033[33;2m\]\w\[\033[m\]$"
export PATH=/home/vasilis/local/murphi/cmurphi/src:$PATH

export GROMACS_PATH=/home/vasilis/Documents/CAR/assignment1/benchmarks/435.gromacs/run_base_ref_amd64-m64-gcc41-nn.0000
export GOBMK_PATH=/home/vasilis/Documents/CAR/assignment1/benchmarks/445.gobmk/run_base_ref_amd64-m64-gcc41-nn.0000
export SJENG_PATH=/home/vasilis/Documents/CAR/assignment1/benchmarks/458.sjeng/run_base_ref_amd64-m64-gcc41-nn.0000
export BP_EXAMPLE=/home/vasilis/Documents/CAR/assignment1/tools/pin-3.5-97503-gac534ca30-gcc-linux/source/tools/BPExample
export CAR=/home/vasilis/Documents/CAR/

export PREF_EXAMPLE=/home/vasilis/Documents/CAR/assignment2/new_assignment2/tools/pin-3.5-97503-gac534ca30-gcc-linux/source/tools/PrefetchExample
#Tmux
alias tmux='tmux -2'
#Script appended commands'
alias output-check='/home/vasilis/Documents/inf2cs/marking-inf2cs/vasilis/bin/output-check.sh'
alias move-student='/home/vasilis/Documents/inf2cs/marking-inf2cs/vasilis/bin/move-student.sh'
alias next-student='source /home/vasilis/Documents/inf2cs/marking-inf2cs/vasilis/bin/next-student.sh'
alias run-student='source /home/vasilis/Downloads/run_students.sh'
#Script appended commands'
alias open-pdf='/home/vasilis/Documents/CAR/assignment1/open-pdf.sh'
alias open-cpp='/home/vasilis/Documents/CAR/assignment1/open-cpp.sh'
alias output-check='/home/vasilis/Documents/CAR/assignment1/output-check.sh'
alias move-student='/home/vasilis/Documents/CAR/assignment1/move-student.sh'
alias next-student='source /home/vasilis/Documents/CAR/assignment1/next-student.sh'
#Script appended commands'
alias open-pdf='/home/vasilis/Documents/CAR/bin/open-pdf.sh'
alias open-cpp='/home/vasilis/Documents/CAR/bin/open-cpp.sh'
alias output-check='/home/vasilis/Documents/CAR/bin/output-check.sh'
alias move-student='/home/vasilis/Documents/CAR/bin/move-student.sh'
alias next-student='source /home/vasilis/Documents/CAR/bin/next-student.sh'

#Printing
alias copy_and_ssh_to_dice='/home/vasilis/Documents/print-scripts/copy-to-dice.sh'
#Git
alias git-log='git log --all --graph --decorate --oneline'
# SSH
alias sshfs-houston='~/dotfiles/bin/create_houston_sshfs.sh'
