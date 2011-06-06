export APPLEBIN=`pwd`

USERNAME=`cat ~/.bash_profile | grep $APPLEBIN`
if [ "$?" -ne "0" ]; then
	mv -i ~/.bash_profile ~/.bash_local
	echo "source $APPLEBIN/dotfiles/.bash_profile" > ~/.bash_profile
	echo "source ~/.bash_local" >> ~/.bash_profile
fi

rm -rf ~/.vim*
rm -rf ~/.screenrc
rm -rf ~/.gitignore
rm -rf ~/.gitconfig

ln -s $APPLEBIN/dotfiles/.vimrc ~/.vimrc
ln -s $APPLEBIN/dotfiles/.vim ~/.vim
ln -s $APPLEBIN/dotfiles/.gitignore ~/.gitignore
ln -s $APPLEBIN/dotfiles/.gitconfig ~/.gitconfig
ln -s $APPLEBIN/dotfiles/.screenrc ~/.screenrc
