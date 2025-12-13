{ config, pkgs, ... }:

{
  # Enable Docker
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;

    # Use NVIDIA runtime for GPU access in containers
    enableNvidia = true;

    # Storage driver (overlay2 is default and recommended)
    storageDriver = "overlay2";
  };

  # Docker Compose
  environment.systemPackages = with pkgs; [
    docker-compose
    lazydocker  # Docker TUI
  ];

  # Add user to docker group (already configured in users.nix)
  # users.users.mathias.extraGroups = [ "docker" ];
}
