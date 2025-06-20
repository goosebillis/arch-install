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

paru -S nvidia-open-dkms nvidia-settings nvidia-utils libva libva-nvidia-driver

# add NVIDIA to mkinitcpio.conf
sudo sed -Ei 's/^(MODULES=\([^\)]*)\)/\1 nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf

# Additional Nvidia steps
sudo echo -e "options nvidia_drm modeset=1 fbdev=1" | sudo tee -a /etc/modprobe.d/nvidia.conf

# Blacklist nouveau
echo "blacklist nouveau" | sudo tee -a /etc/modprobe.d/nouveau.conf
echo "install nouveau /bin/true" | sudo tee "/etc/modprobe.d/blacklist.conf"

# Add GRUB Entries
sudo sed -i -e 's/\(GRUB_CMDLINE_LINUX_DEFAULT=".*\)"/\1 nvidia_drm.fbdev=1"/' /etc/default/grub

sudo mkinitcpio -P
sudo grub-mkconfig -o /boot/grub/grub.cfg

paru -S findutils archlinux-keyring base-devel jq qt6ct yad btop fastfetch pacman-contrib yt-dlp imagemagick qt6-sv qt5ct wayland qt5-wayland qt6-wayland xorg-xwayland xwaylandvideobridge plasma-meta gtk-engine-murrine adobe-source-code-pro-fonts noto-fonts-emoji otf-font-awesome ttf-droid ttf-fira-code ttf-fantasque-nerd ttf-jetbrains-mono ttf-jetbrains-mono-nerd ttf-victor-mono noto-fonts bluez bluez-utils kate ark dolphin dolphin-plugins okular pipewire wireplumber pipewire-audio pipewire-alsa pipewire-pulse sof-firmware ffmpegthumbs kdeconnect partitionmanager kdialog kitty flatpak-kcm p7zip unrar unzip sddm firefox

systemctl --user disable --now pulseaudio.socket pulseaudio.service
systemctl --user enable --now pipewire.socket pipewire-pulse.socket wireplumber.service 
systemctl --user enable --now pipewire.service
sudo systemctl enable --now bluetooth.service

sudo groupadd input
sudo usermod -aG input "$(whoami)"

sudo systemctl enable sddm
