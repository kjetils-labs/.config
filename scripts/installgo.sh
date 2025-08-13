#!/bin/bash

set -e

INSTALL_DIR="/usr/local"
GO_PATH_LINE='export PATH=$PATH:/usr/local/go/bin'
ZSHRC="$HOME/.zshrc"

# Fetch only the first line (the version string)
echo "Fetching latest Go version..."
LATEST_VERSION=$(curl -s https://go.dev/VERSION?m=text | head -n 1)
GO_TARBALL="${LATEST_VERSION}.linux-amd64.tar.gz"
DOWNLOAD_URL="https://go.dev/dl/${GO_TARBALL}"

TMP_DIR=$(mktemp -d)

echo "Downloading ${GO_TARBALL} from ${DOWNLOAD_URL}..."
curl -L -o "${TMP_DIR}/${GO_TARBALL}" "${DOWNLOAD_URL}"

if [ -d "${INSTALL_DIR}/go" ]; then
  echo "Removing old Go installation..."
  sudo rm -rf "${INSTALL_DIR}/go"
fi

echo "Extracting Go to ${INSTALL_DIR}..."
sudo tar -C "${INSTALL_DIR}" -xzf "${TMP_DIR}/${GO_TARBALL}"

sudo rm -rf "${TMP_DIR}"

# Add Go to PATH in .zshrc if not already present
if [ -f "$ZSHRC" ]; then
  if grep -Fxq "$GO_PATH_LINE" "$ZSHRC"; then
    echo "Go PATH already present in $ZSHRC"
  else
    echo "$GO_PATH_LINE" >> "$ZSHRC"
    echo "Added Go to PATH in $ZSHRC"
  fi
else
  echo "$ZSHRC not found. Creating and adding Go to PATH."
  echo "$GO_PATH_LINE" >> "$ZSHRC"
fi

echo "Go ${LATEST_VERSION} installed in ${INSTALL_DIR}/go"
echo "Please restart your terminal or run: source ~/.zshrc"
