#!/bin/bash

# Vars

backupDirectory=~/Documents/dotfiles
DATE=$(date +"%Y-%m-%d")
COMMIT_MESSAGE="Backup of dotfiles on $DATE"

# Check if the shell is bash
if [ -n "$BASH_VERSION" ]; then
  # Bash is enabled, do nothing
  echo "Bash is enabled."
else
  # Bash is not enabled, exit with a non-zero status
  echo "Bash is not enabled on this machine."
  exit 1
fi

# Files to backup.
# Hyperland Backup
cp -R ~/.config/hypr $backupDirectory/.config/
cp -R ~/.config/waybar $backupDirectory/.config/
cp -R ~/.config/wlogout $backupDirectory/.config/
# Terminal backup
cp -R ~/.config/kitty $backupDirectory/.config/
# ssh keys backup
cp -R ~/.ssh $backupDirectory/

cp -R ~/.bashrc $backupDirectory/.bashrc
cp -R ~/.vimrc $backupDirectory/.vimrc
cp -R ~/.zshrc $backupDirectory/.zshrc
cp -R ~/.zsh_history $backupDirectory/.zsh_history
cp -R ~/.config/remmina $backupDirectory/.config/
cp -R ~/.oh-my-zsh $backupDirectory/.oh-my-zsh
cp -R ~/powerlevel10k $backupDirectory/

#backup browser

cp -r ~/.mozilla $backupDirectory/

# Add all changes to staging
git add --all

# Commit changes with the provided message
git commit -m "$COMMIT_MESSAGE"

# Push changes to the remote repository
git push

# Check if the push was successful
if [ $? -eq 0 ]; then
  echo "Changes have been successfully pushed."
else
  echo "Failed to push changes."
  exit 1
fi
