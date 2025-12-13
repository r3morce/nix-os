{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    # Core modules
    ../../modules/core/boot.nix
    ../../modules/core/locale.nix
    ../../modules/core/users.nix
    ../../modules/core/filesystems.nix
    ../../modules/core/shell.nix

    # Hardware
    ../../modules/hardware/nvidia.nix

    # Desktop Environment
    ../../modules/desktop/plasma.nix
    ../../modules/desktop/fonts.nix

    # Gaming (Steam commented out - uncomment to enable)
    # ../../modules/gaming/steam.nix
    # ../../modules/gaming/wine.nix

    # Development (Docker commented out - uncomment to enable)
    # ../../modules/development/docker.nix
    # ../../modules/development/nodejs.nix
    # ../../modules/development/python.nix
  ];

  # System hostname
  networking.hostName = "nixos-desktop";

  # Enable networking
  networking.networkmanager.enable = true;

  # System state version (don't change after installation)
  system.stateVersion = "24.11";
}
