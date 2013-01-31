# Setup
SCRIPT_PATH="${BASH_SOURCE[0]}";
if([ -h "${SCRIPT_PATH}" ]) then
    while([ -h "${SCRIPT_PATH}" ]) do SCRIPT_PATH=`readlink "${SCRIPT_PATH}"`;
    done
fi
pushd . > /dev/null
cd `dirname ${SCRIPT_PATH}` > /dev/null
SCRIPT_PATH=`pwd`;
popd  > /dev/null

# Locations:
export DOTFILES=$SCRIPT_PATH
export APPLEBIN=$DOTFILES/..
export DESKTOP=~/Desktop

# External options
source $DOTFILES/.bash_colors.sh
source $DOTFILES/git-completion.sh

source $DOTFILES/.bash_prompt.sh
export PS1="\[\033[G\]$PS1" 
# This is superimportant to avoid mismatch between cursor and input by 2 spaces.

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

# AutoCompletion
complete -cf sudo

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# Utility Shortcuts
alias up='cd ..'
alias ls='ls -G'
alias sugo='sudo'
alias e='$EDITOR'
alias untar='tar xvf'
alias sizeof='du -h --max-depth=1'
alias fn='find . -name'
alias internet='./sshuttle -r alcides@vps:80 0.0.0.0/0 –L 127.0.0.1:443 -vv'

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

# Python/Django
alias syncdb='python manage.py syncdb'
alias runserver='python manage.py runserver'
alias nomediarunserver='python manage.py runserver --adminmedia=./static/adminmedia/'
alias m='python manage.py'

