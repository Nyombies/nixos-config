#!/usr/bin/env bash
CONFIG_DIR="$HOME/nixos-config/config"
TARGET_DIR="$HOME/.config"

mkdir -p "$TARGET_DIR"

for item in "$CONFIG_DIR"/*; do
  name=$(basename "$item")
  ln -sf "$item" "$TARGET_DIR/$name"
done

echo "All configs in $CONFIG_DIR have been symlinked to $TARGET_DIR"
