{ config, pkgs, ... }:

{
  # Home Manager configuration for user dotfiles
  # This creates symlinks just like Stow does

  home.username = "mathias";
  home.homeDirectory = "/home/mathias";

  # Don't change this - it's the Home Manager release version
  home.stateVersion = "24.11";

  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  # Dotfiles - symlinked from ./dotfiles/
  # Each package is structured like Stow packages

  # Neovim configuration
  home.file.".config/nvim" = {
    source = ./dotfiles/neovim/.config/nvim;
    recursive = true;
  };

  # WezTerm configuration
  home.file.".wezterm.lua" = {
    source = ./dotfiles/wezterm/.wezterm.lua;
  };

  # Zellij configuration
  # Note: Original structure has files directly in .config/, we reorganize them properly here
  home.file.".config/zellij/config.kdl" = {
    source = ./dotfiles/zellij/.config/config.kdl;
  };

  home.file.".config/zellij/layouts" = {
    source = ./dotfiles/zellij/.config/layouts;
    recursive = true;
  };

  # Zsh configuration
  home.file.".zshrc" = {
    source = ./dotfiles/zsh/.zshrc;
  };

  home.file.".p10k.zsh" = {
    source = ./dotfiles/zsh/.p10k.zsh;
  };

  # Fish configuration (to be created)
  # Uncomment when you create fish dotfiles
  # home.file.".config/fish" = {
  #   source = ./dotfiles/fish/.config/fish;
  #   recursive = true;
  # };

  # btop Dracula theme
  home.file.".config/btop/btop.conf" = {
    text = ''
      color_theme = "dracula"
      theme_background = False
    '';
  };

  # Ghostty Dracula theme
  home.file.".config/ghostty/config" = {
    text = ''
      theme = dracula
      font-family = "FiraCode Nerd Font"
    '';
  };

  # Wallpaper
  home.file."bgimage" = {
    source = ./bgimage;
  };

  # Yazi Dracula theme
  home.file.".config/yazi/theme.toml" = {
    text = ''
      # Dracula theme for Yazi
      [manager]
      cwd = { fg = "#bd93f9" }

      [status]
      separator_style = { fg = "#6272a4", bg = "#6272a4" }

      [filetype]
      rules = [
        { mime = "image/*", fg = "#ffb86c" },
        { mime = "video/*", fg = "#ff79c6" },
        { mime = "audio/*", fg = "#f1fa8c" },
        { mime = "application/zip", fg = "#bd93f9" },
        { mime = "application/gzip", fg = "#bd93f9" },
      ]

      [colors]
      bg = "#282a36"
      fg = "#f8f8f2"
      selection = "#44475a"
      comment = "#6272a4"
      cyan = "#8be9fd"
      green = "#50fa7b"
      orange = "#ffb86c"
      pink = "#ff79c6"
      purple = "#bd93f9"
      red = "#ff5555"
      yellow = "#f1fa8c"
    '';
  };
}
