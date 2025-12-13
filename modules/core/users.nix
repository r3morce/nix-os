{ config, pkgs, ... }:

{
  # Define user account
  users.users.mathias = {
    isNormalUser = true;
    description = "Mathias";
    extraGroups = [
      "networkmanager"  # Network management
      "wheel"           # sudo access
      "video"           # GPU access
      "audio"           # Audio devices
      "input"           # Input devices
      "gamemode"        # Gaming optimizations
      # "docker" is added when Docker module is enabled
    ];

    # Use Fish as default shell
    shell = pkgs.fish;

    # Set initial password (change after first login)
    initialPassword = "changeme";
  };

  # Enable sudo without password for wheel group (optional - comment out for more security)
  # security.sudo.wheelNeedsPassword = false;
}
