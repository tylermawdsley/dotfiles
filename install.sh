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
cp -R $backupDirectory/.config/hypr ~/.config/
cp -R $backupDirectory/.config/waybar ~/.config/
cp -R $backupDirectory/.config/wlogout ~/.config/

# Restore terminal configuration
cp -R $backupDirectory/.config/kitty ~/.config/

# Restore SSH keys
cp -R $backupDirectory/.ssh ~/

# Restore miscellaneous configuration files
cp -R $backupDirectory/.bashrc ~/
cp -R $backupDirectory/.vimrc ~/
cp -R $backupDirectory/.zshrc ~/
cp -R $backupDirectory/.zsh_history ~/
cp -R $backupDirectory/.config/remmina ~/.config/
cp -R $backupDirectory/.oh-my-zsh ~/
cp -R $backupDirectory/powerlevel10k ~/

# Restore browser configuration
cp -R $backupDirectory/.mozilla ~/

echo "Configuration files have been restored to their original locations."

