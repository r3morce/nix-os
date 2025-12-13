{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Wine Staging (latest features)
    wineWowPackages.staging
    winetricks

    # Lutris (game launcher)
    lutris

    # Additional dependencies for games
    dxvk
    vkd3d

    # Vulkan support
    vulkan-tools
    vulkan-loader
    vulkan-validation-layers
  ];

  # Enable 32-bit support for Wine (already enabled in nvidia.nix)
  # hardware.opengl.driSupport32Bit = true;
}
