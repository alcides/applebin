brew install hlint
brew install haskell-platform
brew cask install visual-studio-code

code --install-extension jcanero.hoogle-vscode
code --install-extension justusadam.language-haskell
code --install-extension hoovercj.haskell-linter
code --install-extension dramforever.vscode-ghc-simple
code --install-extension meowcolm024.has-go
code --install-extension ms-vsliveshare.vsliveshare


echo "alias ghc=\"stack ghc\"" >> ~/.zsh_local
echo "alias ghci=\"stack ghci\"" >> ~/.zsh_local
echo "alias runhaskell=\"stack runhaskell\"" >> ~/.zsh_local