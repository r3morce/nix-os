{ config, pkgs, lib, ... }:

{
  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;  # Required for 32-bit games (Steam)
  };

  # Load NVIDIA driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Use proprietary driver (not open source)
    # RTX 3060 works better with proprietary drivers
    open = false;

    # Enable nvidia-settings tool
    nvidiaSettings = true;

    # Use production driver (stable)
    package = config.boot.kernelPackages.nvidiaPackages.production;

    # Modesetting is required for Wayland
    modesetting.enable = true;

    # Power management (usually not needed for desktops)
    powerManagement.enable = false;
    powerManagement.finegrained = false;
  };

  # Environment variables for NVIDIA + Wayland
  environment.sessionVariables = {
    # Fix cursor issues on Wayland
    WLR_NO_HARDWARE_CURSORS = "1";

    # Hardware acceleration
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";

    # Enable Wayland for Electron apps
    NIXOS_OZONE_WL = "1";
  };

  # Kernel modules
  boot.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
}
