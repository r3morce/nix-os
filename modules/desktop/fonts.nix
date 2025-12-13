{ config, pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      # Your current fonts from CachyOS
      fira-code
      fira-code-symbols
      jetbrains-mono
      meslo-lgs-nf
      font-awesome

      # Nerd Fonts
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.meslo-lg

      # Additional fonts
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk-sans
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Fira Code" "JetBrains Mono" ];
        sansSerif = [ "Noto Sans" ];
        serif = [ "Noto Serif" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
