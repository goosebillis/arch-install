#!/bin/bash
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc
vim /etc/locale.gen
locale-gen
echo "LANG=en_GB.UTF-8" >> /etc/locale.conf
echo "KEYMAP=uk" >> /etc/vconsole.conf
echo "theb3ast" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 theb3ast.localdomain theb3ast" >> /etc/hosts
echo root:[PASSWORD] | chpasswd

useradd -mG wheel david
echo david:[PASSWORD] | chpasswd
EDITOR=vim visudo

echo "david ALL=(ALL) ALL" >> /etc/sudoers.d/david

mkinitcpio -P linux

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable firewalld
systemctl enable acpid

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
