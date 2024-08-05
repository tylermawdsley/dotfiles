#!/bin/bash

#!/bin/bash

# List of applications to install
apps=(
    "vim"
    "git"
    "curl"
    "wget"
    "htop"
    "zsh"
    "tmux"
    "python3"
    "python-pip"      # Change from python3-pip to python-pip for Arch
    "hyprlock"
    "hypershot"
    "wlogout"
    "network-manager-applet" # Corrected capitalization
    "neofetch"
    "speedtest-cli"
    "remmina"
    "wofi"
    "putty"
    "ranger"
    "nmap"
    "libncurses5-dev"       # These might be AUR packages
    "libncursesw5-dev"      # These might be AUR packages
    "ruby"
    "ruby-dev"              # Might need correction, see below
    "ruby-colorize"         # Might need correction, see below
    "iperf"
    "nsnake"
    "tldr"
	"firefox"
)

# Update the package database
echo "Updating package database..."
sudo pacman -Syu --noconfirm

# Install each application
for app in "${apps[@]}"; do
    echo "Checking availability of $app..."

    # Check if the package is available in pacman
    if pacman -Si "$app" &> /dev/null; then
        echo "Installing $app with pacman..."
        sudo pacman -S --noconfirm "$app"
    else
        echo "$app not found in pacman repositories, attempting to install with yay..."
        if yay -Si "$app" &> /dev/null; then
            yay -S --noconfirm "$app"
        else
            echo "Package $app not found in any repository."
        fi
    fi
done

# Restore Hyperland configuration
cp -R .config/hypr ~/.config/
cp -R .config/waybar ~/.config/
cp -R .config/wlogout ~/.config/

# Restore terminal configuration
cp -R .config/kitty ~/.config/

# Restore SSH keys
cp -R .ssh ~/

# Restore miscellaneous configuration files
cp -R .bashrc ~/
cp -R .vimrc ~/
cp -R .zshrc ~/
cp -R .zsh_history ~/
cp -R .config/remmina ~/.config/
cp -R .oh-my-zsh ~/
cp -R powerlevel10k ~/

# Restore browser configuration
cp -R .mozilla ~/

echo "Configuration files have been restored to their original locations."

