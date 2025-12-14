# 🐧 NixOS Configuration - Quick Start

## ⚡ Installation

### 1️⃣ Boot from USB

### 2️⃣ Partition & Format Your Disk

```bash
# Check your disk
lsblk

# Partition /dev/sdb
sudo parted /dev/sdb -- mklabel gpt
sudo parted /dev/sdb -- mkpart ESP fat32 1MiB 512MiB
sudo parted /dev/sdb -- set 1 esp on
sudo parted /dev/sdb -- mkpart primary 512MiB 100%

# Format partitions
sudo mkfs.fat -F 32 -n EFI /dev/sdb1
sudo mkfs.ext4 -L NixOS /dev/sdb2

# Mount everything
sudo mount /dev/sdb2 /mnt
sudo mkdir -p /mnt/boot
sudo mount /dev/sdb1 /mnt/boot

# Verify
mount | grep /mnt
```

### 3️⃣ Enable Flakes

```bash
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
```

### 4️⃣ Get Configuration

```bash
git clone https://github.com/r3morce/nix-os /tmp/nix-os
```

### 5️⃣ Prepare Configuration

```bash
# Generate hardware config to temp location
nixos-generate-config --root /mnt --dir /tmp

# Copy repo to install location
cp -r /tmp/nix-os /mnt/etc/nixos

# Move generated hardware config to correct location
mv /tmp/hardware-configuration.nix /mnt/etc/nixos/hosts/desktop/hardware-configuration.nix
```

### 6️⃣ Install NixOS

```bash
nixos-install --flake /mnt/etc/nixos#desktop
```

Set root password when asked, then:

```bash
reboot
```

## 🎉 After First Boot

### Change Password

```bash
passwd
```

### Enable Steam (Optional)

Edit this file:
```bash
sudo nano /etc/nixos/hosts/desktop/default.nix
```

Uncomment this line:
```nix
# ../../modules/gaming/steam.nix  ← Remove the #
```

Rebuild:
```bash
sudo nixos-rebuild switch --flake /etc/nixos#desktop
```

### Enable Docker (Optional)

Same process - uncomment:
```nix
# ../../modules/development/docker.nix  ← Remove the #
```

Then rebuild.

## 📝 Quick Commands

### Update System

```bash
sudo nixos-rebuild switch --flake /etc/nixos#desktop
```

### Update Flake Inputs

```bash
cd /etc/nixos
sudo nix flake update
sudo nixos-rebuild switch --flake .#desktop
```

### Edit Configuration

```bash
cd /etc/nixos
nano hosts/desktop/default.nix
```

## 🔧 What's Included

- Auto-mount `/dev/sdd1` → `/mnt/data` (your data drive)
- Wallpaper from `/home/mathias/bgimage`
- German locale, Europe/Berlin timezone
- GRUB bootloader
- Apps
- CLI Tools
- Services
- Gaming (Optional)
- Dotfiles

All in `dotfiles/` - automatically symlinked by Home Manager:
- Neovim config
- WezTerm config
- Zellij config
- Zsh + Powerlevel10k

## ❓ Troubleshooting

### NVIDIA not working?

```bash
nvidia-smi
```

Should show your GPU. If not:

```bash
sudo nixos-rebuild switch --flake /etc/nixos#desktop
```

### Check if Wayland is running

```bash
echo $XDG_SESSION_TYPE
```

Should output: `wayland`

### Rebuild broke something?

```bash
# Boot into previous generation from GRUB
# Then fix your config and rebuild
```
