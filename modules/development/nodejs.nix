{ config, pkgs, ... }:

{
  # Install Node.js system-wide
  environment.systemPackages = with pkgs; [
    nodejs_22  # Node.js 22 (LTS)
    nodePackages.npm
    nodePackages.pnpm
    nodePackages.yarn

    # Note: You can keep using nvm from your Stow dotfiles
    # NixOS won't interfere with ~/.config/nvm or ~/.nvm
  ];
}
