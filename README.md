# NixOS Configuration - Dual-Boot with CachyOS

This repository contains my NixOS configuration using Nix Flakes for a dual-boot setup alongside CachyOS.

## System Overview

- **Desktop Environment**: KDE Plasma 6 + Wayland
- **Shell**: Fish (default), Zsh (available)
- **GPU**: NVIDIA RTX 3060 with proprietary drivers
- **Theme**: Dracula everywhere
- **Bootloader**: GRUB with os-prober for dual-boot

## Features

- ✅ KDE Plasma 6 with Wayland support
- ✅ NVIDIA drivers optimized for gaming and Wayland
- ✅ Auto-mount `/dev/sdd1` to `/mnt/data`
- ✅ Fish shell with Dracula theme (Zsh also available)
- ✅ Gaming: Wine, Lutris, Steam (commented out, easy to enable)
- ✅ Development: Node.js, Python, Docker (commented out), Claude Code
- ✅ Modern CLI tools: eza, bat, ripgrep, fzf, zoxide, tldr, etc.
- ✅ Services: Tailscale VPN, Syncthing file sync
- ✅ Terminals: WezTerm, Ghostty
- ✅ Desktop wallpaper: Auto-set from /home/mathias/bgimage

## Directory Structure

```
nix-os/
├── flake.nix                          # Main flake entry
├── flake.lock                         # Locked dependencies
├── README.md                          # This file
├── hosts/
│   └── desktop/
│       ├── default.nix                # Host configuration
│       └── hardware-configuration.nix # Auto-generated during install
└── modules/
    ├── core/
    │   ├── boot.nix                   # GRUB bootloader
    │   ├── filesystems.nix            # Filesystem mounts
    │   ├── locale.nix                 # Localization
    │   ├── shell.nix                  # Fish + Zsh
    │   └── users.nix                  # User configuration
    ├── desktop/
    │   ├── fonts.nix                  # Font configuration
    │   └── plasma.nix                 # KDE Plasma 6
    ├── development/
    │   ├── docker.nix                 # Docker (commented out)
    │   ├── nodejs.nix                 # Node.js
    │   └── python.nix                 # Python
    ├── gaming/
    │   ├── steam.nix                  # Steam (commented out)
    │   └── wine.nix                   # Wine, Lutris
    └── hardware/
        └── nvidia.nix                 # NVIDIA drivers
```

## Installation

### Prerequisites

1. **Backup everything!**
   ```bash
   tar -czf ~/backup-setup-$(date +%Y%m%d).tar.gz ~/Setup/
   tar -czf ~/backup-home-$(date +%Y%m%d).tar.gz ~/.config
   ```

2. **Download NixOS ISO** (unstable for latest packages)

3. **Create bootable USB**

### Installation Steps

1. **Boot from NixOS live USB**

2. **Enable flakes**:
   ```bash
   mkdir -p ~/.config/nix
   echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
   ```

3. **Partition disk** (if needed):
   ```bash
   # Shrink CachyOS partition and create new partition for NixOS
   # See plan.md for detailed instructions
   ```

4. **Mount partitions**:
   ```bash
   sudo mount /dev/nvme0n1p3 /mnt
   sudo mkdir /mnt/boot
   sudo mount /dev/nvme0n1p1 /mnt/boot
   ```

5. **Generate hardware config**:
   ```bash
   nixos-generate-config --root /mnt
   ```

6. **Clone this repo**:
   ```bash
   git clone <your-repo-url> /mnt/etc/nixos
   ```

7. **Copy hardware config to flake**:
   ```bash
   cp /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/nix-os/hosts/desktop/
   ```

8. **Install NixOS**:
   ```bash
   sudo nixos-install --flake /mnt/etc/nixos/nix-os#desktop
   ```

9. **Reboot and enjoy!**

## Post-Installation

1. **Change password**:
   ```bash
   passwd
   ```

2. **Deploy dotfiles** (your existing Stow setup):
   ```bash
   cd ~/Setup
   make setup
   ```

3. **Enable optional modules** (if needed):
   - Uncomment `../../modules/gaming/steam.nix` in `hosts/desktop/default.nix`
   - Uncomment `../../modules/development/docker.nix` in `hosts/desktop/default.nix`
   - Rebuild: `sudo nixos-rebuild switch --flake ~/nix-os#desktop`

## Rebuilding the System

After making changes to the configuration:

```bash
sudo nixos-rebuild switch --flake ~/nix-os#desktop
```

## Testing Before Applying

Test configuration without switching:

```bash
sudo nixos-rebuild test --flake ~/nix-os#desktop
```

## Validation

Check flake syntax:

```bash
cd ~/nix-os
nix flake check
```

## Troubleshooting

### NVIDIA not loading
```bash
lsmod | grep nvidia
nvidia-smi
```

### GRUB doesn't detect CachyOS
```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

### Check Wayland session
```bash
echo $XDG_SESSION_TYPE  # Should output: wayland
```

## Resources

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [NixOS Search](https://search.nixos.org/packages)
- [Plan File](~/.claude/plans/swirling-mixing-horizon.md) - Detailed installation plan

## Notes

- **Docker & Steam** are commented out by default - uncomment in `hosts/desktop/default.nix` to enable
- **Fish** is the default shell, **Zsh** is available (run `zsh` to switch)
- **Dotfiles** are managed via Stow from `~/Setup/` - not via Home Manager
- **KDE configs** from CachyOS will be preserved and work on NixOS
