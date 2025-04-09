#!/bin/bash
echo "Starting NixOS installation script..."
cd "${0%/*}"

# Get installation device
echo
echo "- Attached storage devices -"
sudo fdisk -l
echo
read -p "Please enter the device name (e.g. /dev/sda) to install the OS: " DEVICE
echo
read -r -p "Should a swap partition be created (y/N): " SWAP_CONFIG

if [[ "$SWAP_CONFIG" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    read -p "Please enter the swap size in GiB (e.g. 8): " SWAP

    # Partition the device
    echo
    echo "Partitioning the device..."
    sudo parted --script $DEVICE -- \
        mklabel gpt \
        mkpart root ext4 512MB -${SWAP}G \
        mkpart swap linux-swap -${SWAP}G 100% \
        mkpart ESP fat32 1MB 512MB \
        set 3 esp on \

    # Format the partitions
    echo
    echo "Formatting the partitions..."
    sudo mkfs.ext4 -L nixos ${DEVICE}1
    sudo mkswap -L swap ${DEVICE}2
    sudo swapon ${DEVICE}2
    sudo mkfs.fat -F 32 -n boot ${DEVICE}3
else
    # Partition the device
    echo
    echo "Partitioning the device..."
    sudo parted --script $DEVICE -- \
        mklabel gpt \
        mkpart root ext4 512MB 100% \
        mkpart ESP fat32 1MB 512MB \
        set 2 esp on \

    # Format the partitions
    echo
    echo "Formatting the partitions..."
    sudo mkfs.ext4 -L nixos ${DEVICE}1
    sudo mkfs.fat -F 32 -n boot ${DEVICE}2
fi

# Mount the partitions
echo
echo "Mounting the partitions..."
sudo mount /dev/disk/by-label/nixos /mnt
sudo mkdir -p /mnt/boot
sudo mount -o umask=077 /dev/disk/by-label/boot /mnt/boot

# Generate NixOS configuration
echo
echo "Generating NixOS configuration..."
sudo nixos-generate-config --root /mnt
sudo rm /mnt/etc/nixos/configuration.nix

sudo git clone https://github.com/lucie-sharpe/LCos.git /mnt/etc/nixos/.tracked_config
sudo ln -srf /mnt/etc/nixos/.tracked_config/flake.nix /mnt/etc/nixos/flake.nix
sudo ln -srf /mnt/etc/nixos/.tracked_config/hosts/ /mnt/etc/nixos/hosts
sudo ln -srf /mnt/etc/nixos/.tracked_config/modules/ /mnt/etc/nixos/modules

# Install NixOS
echo
echo "Installing NixOS..."
read -p "Press Enter to contiue with install:" NULL
export NIX_CONFIG="experimental-features = nix-command flakes"
sudo nixos-install --flake /mnt/etc/nixos#laptop

# Reboot the system
echo
echo "NixOS installation complete. Rebooting..."
read -p "Press Enter to reboot..." NULL
reboot