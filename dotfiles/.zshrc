# Setup
SCRIPT_PATH=$0:A

ssh-add  --apple-use-keychain  #-K

# Locations:
export DOTFILES=$(dirname $SCRIPT_PATH)
export APPLEBIN=$DOTFILES/..
export DESKTOP=~/Desktop

# Configurations
export PATH=$PATH:$APPLEBIN/bin
test -d "$HOME/bin" && PATH="$HOME/bin:$PATH"

if [[ `uname` == 'Darwin' ]]; then
    export EDITOR='mate -w'
else
    export EDITOR='vim'
fi
export TERM=xterm-color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1

# Utility Shortcuts
alias up='cd ..'
alias ls='ls -G'
alias sugo='sudo'
alias e='$EDITOR'
alias untar='tar xvf'
alias sizeof='du -h --max-depth=1'
alias fn='find . -name'
alias internet='./sshuttle -r alcides@vps:80 0.0.0.0/0 –L 127.0.0.1:443 -vv'
alias funmount='fusermount -u'

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
    export JAVA_HOME=$(/usr/libexec/java_home -v $1)
}
