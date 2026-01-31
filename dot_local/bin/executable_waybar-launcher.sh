#!/bin/bash

# Waybar Launcher Script
# Kills existing waybar instances and starts a new one

echo " Restarting waybar..."

# Kill existing waybar instances
if pgrep -x waybar > /dev/null; then
    echo " Stopping existing waybar instances..."
    pkill waybar
    sleep 1
else
    echo " No existing waybar instances found"
fi

# Check if config files exist
if [[ ! -f "$HOME/.config/waybar/config.json" ]]; then
    echo " Error: waybar config file not found!"
    exit 1
fi

if [[ ! -f "$HOME/.config/waybar/style.css" ]]; then
    echo " Error: waybar style file not found!"
    exit 1
fi

# Start waybar with custom configuration
echo " Starting waybar with custom configuration..."
waybar -c "$HOME/.config/waybar/config.json" -s "$HOME/.config/waybar/style.css" > /dev/null 2>&1 &

# Check if waybar started successfully
sleep 2
if pgrep -x waybar > /dev/null; then
    echo " Waybar launched successfully!"
else
    echo " Error: Failed to start waybar. Check configuration files."
    exit 1
fi