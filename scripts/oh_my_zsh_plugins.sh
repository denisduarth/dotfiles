#Os plugins do Oh My Zsh em /scripts/.zshrc não vão funcionar se os repositórios não forem instalados corretamente.

echo "Clonando repositório ZSH-Autocomplete..."
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions

echo "Clonando repositório ZSH-Syntax-highlighting..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

echo "Clonando repositório ZSH-Autocomplete..."
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete
