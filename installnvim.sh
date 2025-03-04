#!/bin/bash


dotFileName=".zshrc"
basePath="/opt"
nvimPath="${basePath}/nvim"

echo "nvim could not be found, attempting install from latest prebuild at $nvimPath"
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo mkdir nvimPath
sudo tar -C $nvimPath -xzf nvim-linux-x86_64.tar.gz
echo "installed"

echo "Adding nvim path to PATH"
if ! grep -q 'export PATH="$PATH:/opt/nvim/nvim-linux-x86_64/bin"' "$HOME/$dotFileName"; then
        echo -e '\nexport PATH="$PATH:/opt/nvim/nvim-linux-x86_64/bin"' >> $HOME/$dotFileName
fi

rm nvim-linux-x86_64.tar.gz

source "$HOME/$dotFileName"
