#!/bin/bash
# Run this after you mount target disk to /mnt and EFI to /mnt/efi

#set -x

# Check is /mnt is mounted, quit if not
if mountpoint -q /mnt; then
    echo "Starting install..."
else
    echo "Please mount the target disk to /mnt and its efi to /mnt/efi"
    exit
fi

read -p 'Hostname: ' HOSTNAME
read -p 'Username: ' USERNAME

pacstrap /mnt base linux linux-firmware vim sudo zsh grml-zsh-config neofetch networkmanager intel-ucode

# Generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

# Set local time
arch-chroot /mnt ln -sf /usr/share/zoneinfo/Japan /etc/localtime
arch-chroot /mnt hwclock --systohc

# Generate locale
sed -i 's/#en_US.UTF-8/en_US.UTF-8/g' /mnt/etc/locale.gen
sed -i 's/#ja_JP.UTF-8/ja_JP.UTF-8/g' /mnt/etc/locale.gen
arch-chroot /mnt locale-gen

# Set hostname and hosts file
echo $HOSTNAME > /mnt/etc/hostname

echo 127.0.0.1	localhost >> /mnt/etc/hosts
echo ::1		localhost >> /mnt/etc/hosts
echo 127.0.1.1	$HOSTNAME.localdomain	$HOSTNAME >> /mnt/etc/hosts

# Enable NetworkManager
arch-chroot /mnt systemctl enable NetworkManager

# Copy boot files to EFI
mkdir /mnt/efi/arch
cp /mnt/boot/* /mnt/efi/arch/

# Installing and configuring systemd-boot
arch-chroot /mnt bootctl install --no-variables
echo 'title	Arch Linux
linux	arch/vmlinuz-linux
initrd	arch/intel-ucode.img
initrd	arch/initramfs-linux.img
options	root="LABEL=arch" intel_iommu=on iommu=pt rw' >> /mnt/efi/loader/entries/arch.conf
echo 'default	arch.conf
console-mode	max' >> /mnt/efi/loader/loader.conf

# Labeling the boot drive
e2label $(df /mnt/ | awk 'END{print $1}') arch

# Configure admin user
arch-chroot /mnt useradd -m -s /usr/bin/zsh $USERNAME
arch-chroot /mnt usermod -aG wheel $USERNAME

# Edit sudoers file and add user to group wheel
echo '%wheel ALL=(ALL:ALL) ALL' > /mnt/etc/sudoers.d/wheel

# Set password for the admin user
arch-chroot /mnt passwd $USERNAME