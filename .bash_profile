DESKTOP=/Users/alcides/Desktop
EDITOR='mate -w'

export APPLEBIN='/Users/alcides/Code/Support/applebin'

# sudo
complete -cf sudo

# shortcuts
alias up='cd ..'
alias cpp='pwd | pbcopy'
alias lock='/System/Library/CoreServices/"Menu Extras"/User.menu/Contents/Resources/CGSession -suspend'

alias git-stats='git log --numstat | awk -f $APPLEBIN/git-author-commits.awk'
alias clone='git clone'
alias commit='git commit'
alias push='git push'
alias st='git status -s'
alias sup='svn up'

alias syncdb='python manage.py syncdb'
alias runserver='python manage.py runserver'
alias nomediarunserver='python manage.py runserver --adminmedia=./static/adminmedia/'

alias sugo='sudo'
alias e='$EDITOR'
alias untar='tar xvf'

source git-completion.sh
source .bash_prompt
