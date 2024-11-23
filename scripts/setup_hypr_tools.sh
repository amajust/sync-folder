#!/bin/bash

# Remove swayidle and swaylock if they exist
echo "Checking and removing swayidle and swaylock, if present..."
if pacman -Qs swayidle > /dev/null; then
    echo "Removing swayidle..."
    sudo pacman -Rns --noconfirm swayidle
else
    echo "swayidle is not installed."
fi

if pacman -Qs swaylock > /dev/null; then
    echo "Removing swaylock..."
    sudo pacman -Rns --noconfirm swaylock
else
    echo "swaylock is not installed."
fi

# Install Hypridle
echo "Installing Hypridle..."
sudo pacman -S --noconfirm hypridle

# Install Hyprlock
echo "Installing Hyprlock..."
sudo pacman -S --noconfirm hyprlock

echo "Hypridle and Hyprlock installation complete, and any existing swayidle/swaylock has been removed if they were installed."

