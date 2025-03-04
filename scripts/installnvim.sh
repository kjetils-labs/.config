#!/bin/bash


dotFileName=".zshrc"
basePath="/opt"
nvimPath="${basePath}"

echo "nvim could not be found, attempting install from latest prebuild at $nvimPath"
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo tar -C ${nvimPath} -xzf nvim-linux-x86_64.tar.gz
echo "installed"

echo "Adding nvim path to PATH"
if ! grep -q "export PATH=\"$PATH:${nvimPath}/nvim-linux-x86_64/bin\"" "$HOME/$dotFileName"; then
        echo -e "\nexport PATH=\"$PATH:${nvimPath}/nvim-linux-x86_64/bin\"" >> $HOME/$dotFileName
fi

rm nvim-linux-x86_64.tar.gz

zsh
