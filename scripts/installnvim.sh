#!/bin/bash

set -e  # Exit on any error
set -u  # Treat unset variables as errors

# === Config ===
DOTFILE="$HOME/.zshrc"
INSTALL_DIR="/opt"
NVIM_DIR="${INSTALL_DIR}/nvim-linux-x86_64"
NVIM_TAR="nvim-linux-x86_64.tar.gz"
NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/${NVIM_TAR}"

# === Download and Install Neovim ===
echo "Installing Neovim to ${INSTALL_DIR}..."

curl -LO "${NVIM_URL}"

sudo tar -C "${INSTALL_DIR}" -xzf "${NVIM_TAR}"

echo "✅ Neovim extracted to ${NVIM_DIR}"

# === Add to PATH if not already added ===
echo "🔧 Configuring PATH in ${DOTFILE}..."

NVIM_PATH_LINE="export PATH=\$PATH:${NVIM_DIR}/bin"

if ! grep -Fxq "${NVIM_PATH_LINE}" "${DOTFILE}"; then
    echo -e "\n${NVIM_PATH_LINE}" >> "${DOTFILE}"
    echo "✅ Added Neovim to PATH in ${DOTFILE}"
else
    echo "✔️  Neovim path already present in ${DOTFILE}"
fi

# === Cleanup ===
rm -f "${NVIM_TAR}"

# === Inform user ===
echo -e "\n🎉 Neovim installation complete!"
echo "ℹ️  Please restart your terminal or run: source ${DOTFILE}"
