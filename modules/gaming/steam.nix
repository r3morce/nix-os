{ config, pkgs, ... }:

{
  # Enable Steam
  programs.steam = {
    enable = true;

    # Enable Proton-GE and other compatibility tools
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];

    # Remote play support
    remotePlay.openFirewall = true;

    # Dedicated server support
    dedicatedServer.openFirewall = true;
  };

  # GameMode for performance optimization
  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        renice = 10;
      };
      custom = {
        start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
        end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
      };
    };
  };

  # Gaming-related packages
  environment.systemPackages = with pkgs; [
    # Proton tools
    protontricks
    protonup-qt

    # Performance monitoring
    mangohud
    goverlay

    # Controller support
    antimicrox
  ];

  # Enable controller support
  hardware.steam-hardware.enable = true;
}
