#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$HOME/nixos-config"
CONFIG_DIR="$REPO_DIR/nix-dotfiles"
TARGET_CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.config_backup_$(date +%Y%m%d_%H%M%S)"

echo "Step 1: Building NixOS config (installs packages)..."
sudo nixos-rebuild build --flake "$REPO_DIR#nyombies"

echo "Step 2: Backing up existing config files and linking dotfiles..."
mkdir -p "$BACKUP_DIR"
mkdir -p "$TARGET_CONFIG_DIR"

# Only link specific config files, not whole dirs
declare -A CONFIG_FILES=(
  ["hypr"]="hypr/hyprland.conf"
  ["hyprpaper"]="hyprpaper/config"
  ["kitty"]="kitty/kitty.conf"
  ["starship"]="starship.toml"
  ["waybar"]="waybar/config"
  ["wofi"]="wofi/config"
  ["dunst"]="dunst/dunstrc"
  ["neofetch"]="neofetch/config.conf"
)

for key in "${!CONFIG_FILES[@]}"; do
  src="$CONFIG_DIR/${CONFIG_FILES[$key]}"
  dest="$TARGET_CONFIG_DIR/$key"

  # Create target subdir if needed (e.g. ~/.config/hypr)
  dest_dir=$(dirname "$dest")
  mkdir -p "$dest_dir"

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    echo "Backing up $dest to $BACKUP_DIR"
    mv "$dest" "$BACKUP_DIR/"
  fi

  ln -sf "$src" "$dest"
  echo "Linked $src -> $dest"
done

# Special case: wallpapers shouldn't go in ~/.config
if [ -e "$TARGET_CONFIG_DIR/wallpapers" ] || [ -L "$TARGET_CONFIG_DIR/wallpapers" ]; then
  echo "Removing legacy wallpapers link from ~/.config..."
  rm -rf "$TARGET_CONFIG_DIR/wallpapers"
fi

echo "Step 3: Switching to new NixOS configuration..."
sudo nixos-rebuild switch --flake "$REPO_DIR#nyombies"

echo "Setup complete!"
