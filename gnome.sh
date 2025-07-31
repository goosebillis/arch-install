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

paru -S --needed mesa lib32-mesa vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader vkd3d lib32-vkd3d vulkan-tools vulkan-mesa-layers lib32-vulkan-mesa-layers

paru -S --needed --noconfirm linux-zen linux-zen-headers

paru -S --needed findutils archlinux-keyring base-devel jq qt6ct yad btop fastfetch pacman-contrib yt-dlp imagemagick qt6-svg qt5ct wayland qt5-wayland qt6-wayland xorg-xwayland xorg-xwayland xorg-xlsclients glfw-wayland gnome gnome-tweaks nautilus-sendto gnome-nettool gnome-usage gnome-multi-writer adwaita-icon-theme xdg-user-dirs-gtk fwupd arc-gtk-theme gdm adobe-source-code-pro-fonts noto-fonts-emoji otf-font-awesome ttf-droid ttf-fira-code ttf-fantasque-nerd ttf-jetbrains-mono ttf-jetbrains-mono-nerd ttf-victor-mono noto-fonts bluez bluez-utils pipewire wireplumber pipewire-audio pipewire-alsa pipewire-pulse sof-firmware ffmpegthumbs alacritty flatpak-kcm p7zip unrar unzip firefox zram-generator npm nodejs caddy

paru -S --needed wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal fontconfig lib32-fontconfig v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader dialog dosbox dxvk-bin speedtest-cli steam hwloc lutris m4 usbutils make zenity winetricks gst-editing-services

echo -e "abi.vsyscall32 = 0" | sudo tee -a /etc/sysctl.d/99-swappiness.conf
sudo sed -i -e 's/^#DefaultLimitNOFILE/DefaultLimitNOFILE/' /etc/systemd/system.conf

paru -S --needed schedtool minq-ananicy-git gamemode lib32-gamemode gamescope mangohud lib32-mangohud goverlay thermald tuned

sudo systemctl enable --now cronie.service
sudo systemctl enable --now tuned.service
sudo systemctl enable --now ananicy.service
sudo tuned-adm profile throughput-performance

systemctl --user disable --now pulseaudio.socket pulseaudio.service
systemctl --user enable --now pipewire.socket pipewire-pulse.socket wireplumber.service 
systemctl --user enable --now pipewire.service
sudo systemctl enable --now bluetooth.service

sudo groupadd input
sudo usermod -aG input "$(whoami)"

sudo systemctl enable gdm

sudo sed -Ei 's/^(MODULES=\([^\)]*)\)/\1 i915.force_probe=!e20b xe.force_probe=e20b)/' /etc/mkinitcpio.conf

sudo /etc/mkinitcpio.conf

sudo grub-mkconfig -o /boot/grub/grub.cfg
