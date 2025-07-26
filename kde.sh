#!/bin/bash

nmtui

sudo vim /etc/pacman.conf

sudo pacman -Sy 

mkdir ~/.setup
cd ~/.setup
curl https://mirror.cachyos.org/cachyos-repo.tar.xz -o cachyos-repo.tar.xz
tar xvf cachyos-repo.tar.xz && cd cachyos-repo
sudo ./cachyos-repo.sh

sudo pacman -S cachyos-rate-mirrors
sudo cachyos-rate-mirrors
sudo vim /etc/pacman.d/mirrorlist
sudo vim /etc/pacman.d/cachyos-mirrorlist
sudo vim /etc/pacman.d/cachyos-v3-mirrorlist
sudo vim /etc/pacman.d/cachyos-v4-mirrorlist

cd ~/.setup
git clone https://aur.archlinux.org/paru-bin
cd paru-bin
makepkg -si

paru -S mesa lib32-mesa vulkan-intel lib32-vulkan-intel

paru -S findutils archlinux-keyring base-devel jq qt6ct yad btop fastfetch pacman-contrib yt-dlp imagemagick qt6-sv qt5ct wayland qt5-wayland qt6-wayland xorg-xwayland xwaylandvideobridge plasma-meta gtk-engine-murrine adobe-source-code-pro-fonts noto-fonts-emoji otf-font-awesome ttf-droid ttf-fira-code ttf-fantasque-nerd ttf-jetbrains-mono ttf-jetbrains-mono-nerd ttf-victor-mono noto-fonts bluez bluez-utils kate ark dolphin dolphin-plugins okular pipewire wireplumber pipewire-audio pipewire-alsa pipewire-pulse sof-firmware ffmpegthumbs kdeconnect partitionmanager kdialog kitty flatpak-kcm p7zip unrar unzip sddm firefox

systemctl --user disable --now pulseaudio.socket pulseaudio.service
systemctl --user enable --now pipewire.socket pipewire-pulse.socket wireplumber.service 
systemctl --user enable --now pipewire.service
sudo systemctl enable --now bluetooth.service

sudo groupadd input
sudo usermod -aG input "$(whoami)"

sudo systemctl enable sddm
