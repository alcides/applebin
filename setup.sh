export APPLEBIN=`pwd`

if [ -f ~/.bash_profile ];then
    USERNAME=`cat ~/.bash_profile | grep $APPLEBIN`
    if [ "$?" -ne "0" ]; then
        mv -i ~/.bash_profile ~/.bash_local
    fi
fi

touch ~/.bash_local
echo "source $APPLEBIN/dotfiles/.bash_profile" > ~/.bash_profile
echo "source ~/.bash_local" >> ~/.bash_profile

rm -rf ~/.vim*
rm -rf ~/.screenrc
rm -rf ~/.ackrc
rm -rf ~/.gitignore
rm -rf ~/.gitconfig

ln -s $APPLEBIN/dotfiles/.vimrc ~/.vimrc
ln -s $APPLEBIN/dotfiles/.vim ~/.vim
ln -s $APPLEBIN/dotfiles/.gitignore ~/.gitignore
ln -s $APPLEBIN/dotfiles/.gitconfig ~/.gitconfig
ln -s $APPLEBIN/dotfiles/.screenrc ~/.screenrc
ln -s $APPLEBIN/dotfiles/.ackrc ~/.ackrc
ln -s $APPLEBIN/dotfiles/.wgetrc ~/.wgetrc

if [[ `uname` == 'Darwin' ]]; then
	source $APPLEBIN/osx/osx_setup.sh
fi


git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qall
