#!/bin/bash

fileName=".zshrc"

echo "Adding zsh aliases at .config/aliases to $fileName"

if ! grep -q 'source $HOME/.config/aliases' "$HOME/$fileName"; then
	echo 'source $HOME/.config/aliases' >> $HOME/$fileName
fi


echo "sourcing"
zsh


