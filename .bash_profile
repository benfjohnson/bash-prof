#!/bin/bash

parse_git_branch ()
{
    local b="$(git symbolic-ref HEAD 2>/dev/null)";
    if [ -n "$b" ]; then
        printf " [%s]" "${b##refs/heads/}";
    fi
}

# Prompt
#export PS1="(\A) $txtgrn\w$(parse_git_branch) $txtgrn\$$txtrst "
export PS1="(\A) \[\033[0;35m\] \w\[\033[0;31m\]\$(parse_git_branch) \[\033[m\]\$ "
###### EXPORTS ######
#####################

export PATH=/opt/local/bin:/opt/local/sbin:$PATH

export EDITOR=/usr/bin/vim   #default editor. could be pico, nano, vim, or emacs
# export HISTFILESIZE=3000            #size of command history
export HISTCONTROL=ignoredups       #ignore duplicates in history

export PATH="$HOME/bin:$PATH"
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

###### Basic Aliases ######
###########################

# list with colors, omit dots, long format, and / after directory
alias ll='ls -AlGF'

# type "hist [arg]" to search all previous commands that contain arg
alias hist='history | grep $1'

# ping stop at 3, like windows
alias ping='ping -c 3'

# lowercase all files in the current directory
alias lowerfiles='for file in *; do mv $file $(echo $file | tr [[:upper:]] [[:lower:]]); done'

# system-wide removal of all those stupid .DS_Store files created by finder.
alias killdsstore='sudo find / -name ".DS_Store" -depth -exec rm {} \;'

# usage: ruhere [search_string] #searches current dir and all sub-dirs for arg. returns full path!
alias ruhere='find $PWD | grep'

# BEN'S ALIASES

# checkout a git branch (passed as an ARG)
alias co='git checkout $1'

# delete all local branches except for current
alias rmbranches='git branch | grep "^[^*]" | xargs git branch -D'

###### Misc. Scripts ######
###########################

#passphrase encrypt a file.
encrypt()
{
    if [ -z "$1" ];
    then
        echo "usage: encrypt infile [outfile]"
    else
        if [ $# -gt 1 ]; then
            OUTFILE="$2"
        else
            OUTFILE="enc_$1"
        fi
        openssl rc4 -salt -in $1 -out $OUTFILE
    fi
}

#corresponding decryption
decrypt()
{
    if [ -z "$1" ];
    then
        echo "usage: decrypt infile [outfile]"
    else
        if [ $# -gt 1 ]; then
            OUTFILE="$2"
        else
            OUTFILE="dec_$1"
        fi
        openssl rc4 -d -salt -in $1 -out $OUTFILE
    fi
}

# Change Title of a Window
func_title() {
 echo -n -e "\033]0;$1\007"
}

alias title="func_title"

# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

export NVM_DIR="$HOME/.nvm"
. "$(brew --prefix nvm)/nvm.sh"

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH

# Setting PATH for vscode
PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:${PATH}"
export PATH

export NODE_ENV="local"

export PATH="$HOME/.cargo/bin:$PATH"

. ~/.bashrc
