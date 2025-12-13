# 🐧 NixOS Configuration - Quick Start

> Fresh NixOS install with KDE Plasma 6, NVIDIA gaming, and all your dotfiles auto-configured!

## 🚀 What You Get

- 🖥️ **KDE Plasma 6** + Wayland
- 🎮 **NVIDIA RTX 3060** gaming ready
- 🐚 **Fish shell** (with Dracula theme)
- 🎨 **All dotfiles** auto-symlinked
- 🔧 **Dev tools**: Node.js, Python, Claude Code, Git
- 📦 **Apps**: Firefox, Vesktop, KeePassXC, Double Commander

## ⚡ Installation (Copy & Paste)

### 1️⃣ Boot from USB

Reboot → Press `F12` or `Del` → Select USB → Boot

### 2️⃣ Enable Flakes

```bash
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
```

### 3️⃣ Partition Disk

**Fresh SSD install - wipes everything!**

```bash
# Check your disks
lsblk

# Partition the disk (replace sdX with your SSD, e.g., nvme0n1)
sudo parted /dev/sdX -- mklabel gpt
sudo parted /dev/sdX -- mkpart ESP fat32 1MiB 512MiB
sudo parted /dev/sdX -- set 1 esp on
sudo parted /dev/sdX -- mkpart primary 512MiB 100%

# Format partitions
sudo mkfs.fat -F 32 -n EFI /dev/sdX1
sudo mkfs.ext4 -L NixOS /dev/sdX2
```

### 4️⃣ Mount Everything

```bash
# Mount root
sudo mount /dev/sdX2 /mnt

# Mount boot
sudo mkdir -p /mnt/boot
sudo mount /dev/sdX1 /mnt/boot
```

### 5️⃣ Get Configuration

```bash
# Generate hardware config
sudo nixos-generate-config --root /mnt

# Clone this repo
git clone https://github.com/r3morce/nix-os /mnt/etc/nixos

# Copy hardware config
sudo cp /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/hosts/desktop/
```

### 6️⃣ Install NixOS

```bash
sudo nixos-install --flake /mnt/etc/nixos#desktop
```

Enter root password when asked, then:

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
