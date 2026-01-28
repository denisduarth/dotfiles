#!/bin/bash
set -e

DOTFILES="$HOME/dotfiles"

echo "Criando links simbólicos..."

ln -sf "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES/zsh/.zsh_aliases" "$HOME/.zsh_aliases"

echo "Rodando bootstrap..."
bash "$DOTFILES/scripts/bootstrap.sh"

echo "Clonando repositórios de plugins para Oh My Zsh..."
bash "$DOTFILES/scripts/oh_my_zsh_plugins.sh"

echo "Pronto! Abra um novo terminal."
