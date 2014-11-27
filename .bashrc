if [ -f /etc/bash_completion ]; then
	    . /etc/bash_completion
fi

xhost +local:root > /dev/null 2>&1

complete -cf sudo

shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dotglob
shopt -s expand_aliases
shopt -s extglob
shopt -s histappend
shopt -s hostcomplete
shopt -s nocaseglob

export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=ignoreboth

alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias grep='grep --color=tty -d skip'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano PKGBUILD'

# ex - archive extractor
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# prompt
PS1='[\u@\h \W]\$ '


#JoaoPatricio Addons
alias mount_saturno='sudo sshfs -p 14022 joao.patricio@saturno.cscm-lx.pt:/home/joao.patricio/ /home/joao.patricio/Saturno -o allow_other'
alias connect_saturno='ssh joao.patricio@saturno.cscm-lx.pt -p 14022'
alias brightness_full='xbacklight -set 100'
alias brightness_medium='xbacklight -set 50'
alias brightness_low='xbacklight -set 25'
alias 2monitors='xrandr --output LVDS1 --right-of VGA1'
alias sti_configure_monitors='2monitors ; brightness_full; sudo touchpad_disable;'
alias touchpad_disable='sudo rmmod psmouse'
alias touchpad_enable='sudo modprobe psmouse'
alias 4g_start='sudo usb_modeswitch -v 12d1 -p 1505 -V 12d1 -P 1505 -W -M "55534243123456780000000000000011062000000100000000000000000000";'
alias lock_screen='gnome-screensaver-command --lock'
alias composer='/usr/local/bin/composer.phar'
alias feature='git flow feature'
alias release='git flow release'
alias hotfix='git flow hotfix'
complete -F __git_flow_feature feature
complete -F __git_flow_release release
complete -F __git_flow_hotfix hotfix

# http://henrik.nyh.se/2008/12/git-dirty-prompt
# http://www.simplisticcomplexity.com/2008/03/13/show-your-git-branch-name-in-your-prompt/
#   username@Machine ~/dev/dir[master]$   # clean working directory
#   username@Machine ~/dev/dir[master*]$  # dirty working directory

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}
export PS1='\u|\[\033[1;33m\]\w\[\033[0m\] $(parse_git_branch)$ '

