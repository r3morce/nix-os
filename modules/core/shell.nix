{ config, pkgs, ... }:

{
  # Enable Fish shell system-wide
  programs.fish.enable = true;

  # Enable Zsh (available but not default)
  programs.zsh.enable = true;

  # Fish shell configuration with Dracula theme
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # Dracula theme for Fish
      # Background
      set -g fish_color_normal normal

      # Syntax highlighting
      set -g fish_color_command bd93f9        # Purple - commands
      set -g fish_color_quote f1fa8c          # Yellow - strings
      set -g fish_color_redirection ffb86c   # Orange - redirections
      set -g fish_color_end 50fa7b            # Green - process separators
      set -g fish_color_error ff5555          # Red - errors
      set -g fish_color_param ff79c6          # Pink - parameters
      set -g fish_color_comment 6272a4        # Comment gray
      set -g fish_color_match --background=brblue
      set -g fish_color_selection white --bold --background=brblack
      set -g fish_color_search_match bryellow --background=brblack
      set -g fish_color_history_current --bold
      set -g fish_color_operator 00a6b2
      set -g fish_color_escape 00a6b2
      set -g fish_color_cwd green
      set -g fish_color_cwd_root red
      set -g fish_color_valid_path --underline
      set -g fish_color_autosuggestion 6272a4
      set -g fish_color_user brgreen
      set -g fish_color_host normal
      set -g fish_color_cancel -r

      # Pager colors
      set -g fish_pager_color_completion normal
      set -g fish_pager_color_description B3A06D yellow
      set -g fish_pager_color_prefix white --bold --underline
      set -g fish_pager_color_progress brwhite --background=cyan
    '';
  };

  # System packages for shell enhancement
  environment.systemPackages = with pkgs; [
    # Fish plugins can be installed via home-manager or manually
    # For now, users can manage Fish plugins via their dotfiles
  ];
}
