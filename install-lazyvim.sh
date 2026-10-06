#!/usr/bin/env bash

set -e

echo "==> Installing dependencies..."
sudo apt update
sudo apt install -y \
    git \
    curl \
    unzip \
    build-essential \
    ripgrep \
    fd-find

echo "==> Installing fd command..."
mkdir -p "$HOME/.local/bin"
ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"

if ! grep -q '\$HOME/.local/bin' "$HOME/.bashrc"; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
fi

echo "==> Installing latest Neovim..."

cd /tmp

curl -L -o nvim-linux-x86_64.tar.gz \
    https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz

sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

if ! grep -q "/opt/nvim-linux-x86_64/bin" "$HOME/.bashrc"; then
    echo 'export PATH="/opt/nvim-linux-x86_64/bin:$PATH"' >> "$HOME/.bashrc"
fi

export PATH="/opt/nvim-linux-x86_64/bin:$HOME/.local/bin:$PATH"

echo "==> Neovim version:"
nvim --version | head -n 1

echo "==> Backing up existing Neovim configuration..."

if [ -d "$HOME/.config/nvim" ]; then
    BACKUP="$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
    mv "$HOME/.config/nvim" "$BACKUP"
    echo "Existing config moved to: $BACKUP"
fi

if [ -d "$HOME/.local/share/nvim" ]; then
    BACKUP="$HOME/.local/share/nvim.backup.$(date +%Y%m%d_%H%M%S)"
    mv "$HOME/.local/share/nvim" "$BACKUP"
    echo "Existing Neovim data moved to: $BACKUP"
fi

if [ -d "$HOME/.local/state/nvim" ]; then
    BACKUP="$HOME/.local/state/nvim.backup.$(date +%Y%m%d_%H%M%S)"
    mv "$HOME/.local/state/nvim" "$BACKUP"
    echo "Existing Neovim state moved to: $BACKUP"
fi

if [ -d "$HOME/.cache/nvim" ]; then
    BACKUP="$HOME/.cache/nvim.backup.$(date +%Y%m%d_%H%M%S)"
    mv "$HOME/.cache/nvim" "$BACKUP"
    echo "Existing Neovim cache moved to: $BACKUP"
fi

echo "==> Installing LazyVim..."

git clone https://github.com/LazyVim/starter "$HOME/.config/nvim"

rm -rf "$HOME/.config/nvim/.git"

echo
echo "======================================"
echo " LazyVim installation complete!"
echo "======================================"
echo
echo "Neovim:"
nvim --version | head -n 1

echo
echo "Start LazyVim with:"
echo "  nvim"
echo
echo "If 'nvim' is not found in a new terminal, run:"
echo "  source ~/.bashrc"
echo
