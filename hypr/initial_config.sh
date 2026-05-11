# DISCLAIMER : NO IDEA IF THIS SHIT WORKS
# I SUCK ASS AT CODING
# I HAVE LEFT COMMENTS ON WHAT EVERYTHING DOES
# PLEASE LOOK AT IT YOURSELF BEFORE RUNNING

#==============================================#

#!/bin/bash
set -euo pipefail

sudo pacman -S cargo

install_paru() {
  echo "Installing paru..."

  echo "Installing git and base-devel..."
  sudo pacman -S --needed --noconfirm base-devel git

  git clone https://aur.archlinux.org/paru.git
  cd paru
  makepkg -si --noconfirm

  echo "paru installed successfully."
}

if ! command -v paru &>/dev/null; then
  echo "paru not found. Installing paru from AUR..."
  install_paru
fi

PKG_MANAGER="paru"

echo "Updating package databases..."
sudo pacman -Syu --noconfirm

OFFICIAL=(
  hyprland
  waybar
  hypridle
  polkit-gnome
  kitty
  nautilus
  grim
  slurp
  swappy
  hyprshot
  cliphist
  wl-clipboard
  easyeffects
  swaync
  blueman
  networkmanager
  playerctl
  awww
  rofi
  nwg-displays
)

AUR=(
  helium-browser
  spotify-launcher
  signal-desktop
  torbrowser-launcher
  vicinae
  noctalia-qs-git
)

for i in "${OFFICIAL[@]}"; do
  sudo pacman -S $i --noconfirm
done

for aur in "${AUR[@]}"; do
  paru -S $aur
done

echo "===== Installation complete! =====" # hopefully
echo "This has only installed the necessary dependecies, you still need to put the files in the .config/hypr and various other directories yourself."
