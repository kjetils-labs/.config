#!/bin/bash

fileName=".zshrc"

echo "Adding zsh aliases at .config/aliases to $fileName"

if ! grep -q 'source $HOME/.config/aliases' "$HOME/$fileName"; then
	echo -e '\nsource $HOME/.config/aliases' >> $HOME/$fileName
fi

# ZSH sytax highlighting
echo "Make sure 'zsh-syntax-highlighting' is installed"

if grep -q 'ls ~/.oh-my-zsh/custom/plugins' "zsh-autosuggestions"; then 
    echo "Installing zsh-autosuggestions"
    echo "git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
fi

echo "sourcing"
zsh

# TMUX
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
tmux source  ~/.config/tmux/tmux.conf 
