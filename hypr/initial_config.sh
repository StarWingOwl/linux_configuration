# DISCLAIMER : NO IDEA IF THIS SHIT WORKS
# I SUCK ASS AT CODING
# I HAVE LEFT COMMENTS ON WHAT EVERYTHING DOES
# PLEASE LOOK AT IT YOURSELF BEFORE RUNNING

#==============================================#

#!/usr/bin/env bash
set -euo pipefail

# If something goes wrong
log_info() { echo "[INFO] $1"; }
log_warn() { echo "[WARN] $1"; }
log_error() { echo "[ERROR] $1"; }

# Ensure paru is installed
install_paru() {
  log_info "Installing paru..."

  if ! command -v git &>/dev/null; then
    log_info "Installing git and base-devel..."
    sudo pacman -S --needed --noconfirm base-devel git
  fi

  local tmpdir
  tmpdir=$(mktemp -d)
  pushd "$tmpdir" >/dev/null

  git clone https://aur.archlinux.org/paru.git
  cd paru
  makepkg -si --noconfirm

  popd >/dev/null
  rm -rf "$tmpdir"

  log_info "paru installed successfully."
}

if ! command -v paru &>/dev/null; then
  log_warn "paru not found. Installing paru from AUR..."
  install_paru
fi

PKG_MANAGER="paru"

# Update package databases
log_info "Updating package databases..."
sudo $PKG_MANAGER -Syu --noconfirm

# Official repositories
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
  networkmanagerapplet
  playerctl
  swww
  rofi
  nwg-displays
)

# AUR packages
AUR=(
  helium-browser
  spotify-launcher
  signal-desktop
  torbrowser-launcher
  vicinae
  noctalia-qs-git
)

# Install official packages
if [[ ${#OFFICIAL[@]} -gt 0 ]]; then
  log_info "Installing official repo packages (${#OFFICIAL[@]} packages)..."
  sudo $PKG_MANAGER -S --noconfirm "${OFFICIAL[@]}"
fi

# Install AUR packages
if [[ ${#AUR[@]} -gt 0 ]]; then
  log_info "Installing AUR packages (${#AUR[@]} packages)..."
  sudo $PKG_MANAGER -S --noconfirm "${AUR[@]}"
fi

echo ""
log_info "===== Installation complete! =====" # hopefully
