# Setup

if [ -n "$BASH_VERSION" ]; then
  SCRIPT_PATH="${BASH_SOURCE[0]}"
else
  SCRIPT_PATH=$0:A
fi
  if [ -h "${SCRIPT_PATH}" ]; then
      while [ -h "${SCRIPT_PATH}" ]; do 
        SCRIPT_PATH=`readlink "${SCRIPT_PATH}"`;
      done;
  fi
  pushd . > /dev/null
  cd `dirname ${SCRIPT_PATH}` > /dev/null
  SCRIPT_PATH=`pwd`
  popd  > /dev/null

#ssh-add -K

# Locations:
export DOTFILES=$SCRIPT_PATH
export APPLEBIN=$DOTFILES/..
export DESKTOP=~/Desktop


powerstat() {
    b=$(system_profiler SPPowerDataType)
    amp=$(echo "$b" | grep 'Amperage (mA):' | cut -d ':' -f 2 | xargs)
    volt=$(echo "$b" | grep 'Voltage (mV):' | cut -d ':' -f 2 | xargs)
    power=$(($amp * $volt / 1000))
    echo "$b" | grep --color=never -A 1 'Battery Information:'
    echo "$b" | grep --color=never -A 1 'Amperage (mA)'
    echo "      Total Power (mW): $power"
    echo ""
    echo "$b" | grep --color=never -A 99 'AC Charger Information:'
}


# Configurations
export PATH=$PATH:$APPLEBIN/bin
test -d "$HOME/bin" && PATH="$HOME/bin:$PATH"

if [[ `uname` == 'Darwin' ]]; then
    export EDITOR='mate -w'
else
    export EDITOR='vim'
fi


#if [ -n "$ZSH_VERSION" ]; then
   # assume Zsh
   #fi
if [ -n "$BASH_VERSION" ]; then
   # assume Bash
  export TERM=xterm-color
  export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
  export CLICOLOR=1

  source $DOTFILES/.bash_colors.sh
  source $DOTFILES/.bash_prompt.sh
  
  # AutoCompletion
  source $DOTFILES/git-completion.sh
  complete -cf sudo
  # Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
  [ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh
  
  export PS1="\[\033[G\]$PS1" 
  # This is superimportant to avoid mismatch between cursor and input by 2 spaces.
fi




# Utility Shortcuts
alias up='cd ..'
alias ls='ls -G'
alias ll='ls -la'
alias sugo='sudo'
alias e='$EDITOR'
alias untar='tar xvf'
alias sizeof='du -h --max-depth=1'
alias fn='find . -name'
alias internet='./sshuttle -r alcides@vps:80 0.0.0.0/0 –L 127.0.0.1:443 -vv'
alias funmount='fusermount -u'

alias hideicons='defaults write com.apple.finder CreateDesktop -bool false && killall Finder'
alias showicons='defaults write com.apple.finder CreateDesktop -bool true && killall Finder'


# Mac-Specific
if [[ `uname` == 'Darwin' ]]; then
  alias cpp='pwd | pbcopy'
  alias lock='/System/Library/CoreServices/"Menu Extras"/User.menu/Contents/Resources/CGSession -suspend'
fi

# Git
alias git-stats='git log --numstat | awk -f $APPLEBIN/bin/git-author-commits.awk'
alias clone='git clone'
alias commit='git commit'
alias push='git push'
alias st='git status -s'
alias ca='git commit -a -m'
alias sup='svn up'

alias brewup='brew update; brew upgrade; brew prune; brew cleanup; brew doctor'

# Python/Django
alias syncdb='python manage.py syncdb'
alias runserver='python manage.py runserver'
alias nomediarunserver='python manage.py runserver --adminmedia=./static/adminmedia/'
alias m='python manage.py'

export LANG="en_US.UTF-8"  
export LC_COLLATE="en_US.UTF-8"  
export LC_CTYPE="en_US.UTF-8"  
export LC_MESSAGES="en_US.UTF-8"  
export LC_MONETARY="en_US.UTF-8"  
export LC_NUMERIC="en_US.UTF-8"  
export LC_TIME="en_US.UTF-8"  
export LC_ALL="en_US.UTF-8"

setjdk() {
    unset JAVA_HOME
    export JAVA_HOME=$(/usr/libexec/java_home -v $1)
}

export SQUEUE_FORMAT="%.18i %.9P %.30j %.8u %.8T %.10M %.9l %.6D %R"

