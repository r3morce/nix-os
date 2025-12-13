# 🐧 NixOS Configuration - Quick Start

> Fresh NixOS install with KDE Plasma 6, NVIDIA gaming, and all your dotfiles auto-configured!

## 🚀 What You Get

- 🖥️ **KDE Plasma 6** + Wayland
- 🎮 **NVIDIA RTX 3060** gaming ready
- 🐚 **Fish shell** (with Dracula theme)
- 🎨 **All dotfiles** auto-symlinked
- 🔧 **Dev tools**: Node.js, Python, Claude Code, Git
- 📦 **Apps**: Firefox, Vesktop, KeePassXC, Double Commander

## 📀 Prepare USB (Before Installation)

### Create Bootable USB

1. Download NixOS ISO from https://nixos.org/download
2. Flash to USB with Balena Etcher

### Copy Config to USB

After flashing, the USB will have two partitions. Copy this repo to the data partition:

```bash
# Find your USB device
lsblk

# Mount the second partition (usually the larger one)
sudo mkdir -p /mnt/usb
sudo mount /dev/sdb2 /mnt/usb  # Adjust sdb2 to your USB

# Copy this repo to USB
sudo cp -r ~/nix-os /mnt/usb/

# Unmount
sudo umount /mnt/usb
```

Now your USB has both the NixOS installer and your configuration! 🎉

---

## ⚡ Installation (Copy & Paste)

### 1️⃣ Boot from USB

Reboot → Press `F12` or `Del` → Select USB → Boot

### 2️⃣ Partition & Mount Your Disk

**Do this yourself with your preferred tool (GParted, parted, etc.)**

You need:
- EFI partition (512MB, FAT32) mounted at `/mnt/boot`
- Root partition (rest of disk, ext4) mounted at `/mnt`

Check with:
```bash
lsblk
mount | grep /mnt
```

### 3️⃣ Enable Flakes

```bash
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
```

### 4️⃣ Get Configuration

**Option A: From USB (if you copied repo to USB)**

```bash
# Mount USB
mkdir -p /mnt/usb
mount /dev/sdb1 /mnt/usb  # Adjust sdb1 to your USB device

# Copy repo
cp -r /mnt/usb/nix-os /tmp/nix-os
umount /mnt/usb
```

**Option B: Clone from GitHub**

```bash
git clone https://github.com/r3morce/nix-os /tmp/nix-os
```

### 5️⃣ Prepare Configuration

```bash
# Generate hardware config
nixos-generate-config --root /mnt

# Copy repo to install location
cp -r /tmp/nix-os /mnt/etc/nixos

# Move generated hardware config to correct location
mv /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/hosts/desktop/hardware-configuration.nix
```

### 6️⃣ Install NixOS

```bash
nixos-install --root /mnt --flake /mnt/etc/nixos#desktop
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

### 🎯 System
- Auto-mount `/dev/sdd1` → `/mnt/data` (your data drive)
- Wallpaper from `/home/mathias/bgimage`
- German locale, Europe/Berlin timezone
- GRUB bootloader

### 📦 Apps
- Firefox, Vesktop (Discord), KeePassXC
- WezTerm, Ghostty (terminals)
- Double Commander
- Neovim, Claude Code

### 🛠️ CLI Tools
- `eza` (better ls)
- `bat` (better cat)
- `ripgrep` (better grep)
- `fzf` (fuzzy finder)
- `zoxide` (smart cd)
- `tldr` (simple man pages)
- `fastfetch` (system info)

### 🌐 Services
- Tailscale VPN
- Syncthing (file sync)

### 🎮 Gaming (Optional)
- Steam + Proton
- Wine, Lutris
- GameMode, MangoHud

## 📂 Your Dotfiles

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

## 🔗 Links

- 📖 [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- 🔍 [Package Search](https://search.nixos.org/packages)
- 💻 [GitHub Repo](https://github.com/r3morce/nix-os)

---

**Made with 🤖 Claude Code**
