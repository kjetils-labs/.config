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

# NVIM

baseNvimPath = "/opt"
nvimPath = "${baseNvimPath}/nvim"

echo nvimPath

if [ ! -d $nvimPath ]; then
    echo "nvim could not be found, attempting install from latest prebuild at $nvimPath"
    echo "curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"
    echo "sudo tar -C $baseNvimPath -xzf nvim-linux-x86_64.tar.gz"    
    echo "installed"
fi

echo "Adding nvim path to PATH"
if ! grep -q 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin' "$HOME/$fileName"; then
	echo -e '\nexport PATH="$PATH:/opt/nvim-linux-x86_64/bin' >> $HOME/$fileName
fi

# TMUX
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
tmux source  ~/.config/tmux/tmux.conf 
