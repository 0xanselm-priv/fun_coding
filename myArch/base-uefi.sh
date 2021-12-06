#!/bin/bash

ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=de_DE-latin1" >> /etc/vconsole.conf
echo "FILLMEIN" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain FILLMEIN" >> /etc/hosts
echo root:password | chpasswd


pacman -S --noconfirm efibootmgr dialog iwd reflector base-devel linux-headers avahi nfs-utils inetutils dnsutils openssh acpi acpi_call tlp terminus-font zsh zsh-completions zsh-theme-powerlevel10k-git

systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable tlp # You can comment this command out if you didn't install tlp, see above
systemctl enable reflector.timer
systemctl enable fstrim.timer

useradd -m r
echo r:password | chpasswd

echo "r ALL=(ALL) ALL" >> /etc/sudoers.d/r
echo "Think about oh-my-zsh-git and chsh -s /usr/bin/zsh"
printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
# chmod +x base-uefi.sh
