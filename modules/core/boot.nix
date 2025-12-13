{ config, pkgs, ... }:

{
  # Use GRUB for dual-boot with CachyOS
  boot.loader.grub = {
    enable = true;
    device = "nodev";  # EFI mode
    efiSupport = true;
    useOSProber = true;  # Auto-detect CachyOS and other operating systems
    configurationLimit = 10;  # Keep only 10 most recent configurations
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  # Kernel parameters
  boot.kernelParams = [
    "quiet"
    "splash"
    # NVIDIA-specific parameters
    "nvidia-drm.modeset=1"  # Enable NVIDIA DRM kernel mode setting
  ];

  # Use latest kernel for best hardware support
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
