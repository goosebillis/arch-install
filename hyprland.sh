#!/bin/bash

nmtui

sudo vim /etc/pacman.conf

mkdir ~/.setup
cd ~/.setup
curl https://mirror.cachyos.org/cachyos-repo.tar.xz -o cachyos-repo.tar.xz
tar xvf cachyos-repo.tar.xz && cd cachyos-repo
sudo ./cachyos-repo.sh

sudo pacman -Syu 

sudo pacman -S cachyos-rate-mirrors ungoogled-chromium-bin
sudo cachyos-rate-mirrors
sudo vim /etc/pacman.d/mirrorlist
sudo vim /etc/pacman.d/cachyos-mirrorlist
sudo vim /etc/pacman.d/cachyos-v3-mirrorlist
sudo vim /etc/pacman.d/cachyos-v4-mirrorlist

cd ~/.setup
git clone --depth=1 https://github.com/JaKooLit/Arch-Hyprland.git ~/.setup/Arch-Hyprland
cd ~/.setup/Arch-Hyprland
cp ~/arch-install/nvidia.sh ~/.setup/Arch-Hyprland/install-scripts/
chmod +x ~/.setup/Arch-Hyprland/install-scripts/nvidia.sh
chmod +x install.sh
./install.sh
