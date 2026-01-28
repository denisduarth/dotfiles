#!/bin/bash
set -e

if [[ $EUID -eq 0 ]]; then
  echo "Não execute este script como root!"
  exit 1
fi

echo "Primeira atualização do sistema..."
sudo apt update && sudo apt upgrade -y

echo "Adicionando PPA fastfetch..."
sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch

echo "Adicionando PPA ULauncher..."
sudo add-apt-repository -y universe
sudo add-apt-repository -y ppa:agornostal/ulauncher

echo "Segundo update para os pacotes PPA"
sudo apt update

APT_PROGRAMS=(
  git
  gparted
  vlc
  build-essential
  python3
  python3-pip
  flatpak
  vulkan-tools
  fastfetch
  zsh
  bat
  ulauncher
  mangohud
  gamemoderun
  fonts-cascadia-code
  fonts-firacode
  fonts-inconsolata
  zram-tools
)

echo "Instalando pacotes APT..."
sudo apt install -y "${APT_PROGRAMS[@]}"

echo "Instalando Brave..."
curl -fsS https://dl.brave.com/install.sh | sh

echo "Instalando Zed..."
curl -fsS https://zed.dev/install.sh | sh

echo "Instalando NVM + Node LTS..."
curl -fsS https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"
nvm install --lts

echo "Definindo Zsh como shell padrão..."
if command -v zsh >/dev/null; then
  chsh -s "$(which zsh)"
else
  echo "Zsh não encontrado!"
fi

echo "Gerando arquivo .zsh_aliases e configurando aliases..."
ALIAS_FILE="$HOME/.zsh_aliases"

ALIASES=(
  "alias ls='ls -lah'"
  "alias updt='sudo apt update && sudo apt upgrade'"
  "alias disks='df -h'"
  "alias ff='fastfetch'"
  "alias bios='sudo systemctl reboot --firmware-setup'"
  "alias cat='batcat'"
  "alias mkdir='mkdir -pv'"
  "alias touch='touch -v'"
)

touch "$ALIAS_FILE"
sed -i -e '$a\' "$ALIAS_FILE"

for a in "${ALIASES[@]}"; do
  grep -Fxq "$a" "$ALIAS_FILE" || echo "$a" >> "$ALIAS_FILE"
done

echo "Configurando .zshrc para carregar .zsh_aliases..."
ZSHRC="$HOME/.zshrc"
LINE='[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases'
touch "$ZSHRC"
grep -qxF "$LINE" "$ZSHRC" || echo "$LINE" >> "$ZSHRC"

echo "Instalando OhMyZsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Definindo Swappiness em 10 e resetando /etc/sysctl.conf..."
echo "vm.swappiness=10" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

echo "Configuração aplicada. Abra um novo terminal ou execute: source ~/.zshrc"
echo "Setup finalizado!"
echo "Reinicie a sessão ou abra um novo terminal para aplicar o Zsh e os aliases."
