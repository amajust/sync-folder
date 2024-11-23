#!/bin/bash

# Step 1: Install archlinux-xdg-menu
echo "Installing archlinux-xdg-menu..."
sudo pacman -S --noconfirm archlinux-xdg-menu

# Step 2: Regenerate the menu cache
echo "Regenerating XDG menu cache..."
XDG_MENU_PREFIX=arch- kbuildsycoca6

# Step 3: Add the necessary environment variable to Hyprland configuration
HYPR_CONFIG="$HOME/.config/hypr/hyprland.conf"
ENV_LINE="env = XDG_MENU_PREFIX,arch-"

echo "Adding environment variable to Hyprland config..."
if ! grep -Fxq "$ENV_LINE" "$HYPR_CONFIG"; then
    echo "$ENV_LINE" >> "$HYPR_CONFIG"
    echo "Environment variable added to Hyprland config."
else
    echo "Environment variable already exists in Hyprland config."
fi

# Step 4: Notify the user
echo "Process complete. Please reload Hyprland for changes to take effect."

# Optional: Restart Hyprland (uncomment the following line if you want to restart Hyprland automatically)
# hyprctl reload

