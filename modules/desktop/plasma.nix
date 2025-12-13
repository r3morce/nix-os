{ config, pkgs, ... }:

{
  # Enable X11 (required for SDDM and Plasma)
  services.xserver.enable = true;

  # Enable SDDM display manager with Wayland support
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Enable KDE Plasma 6
  services.desktopManager.plasma6.enable = true;

  # Default session (Plasma on Wayland)
  services.displayManager.defaultSession = "plasma";

  # Enable sound with PipeWire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;  # Required for 32-bit applications
    pulse.enable = true;       # PulseAudio compatibility
    jack.enable = true;        # JACK audio support
  };

  # KDE/Plasma packages and tools
  environment.systemPackages = with pkgs; [
    # KDE Applications
    kdePackages.dolphin          # File manager
    kdePackages.konsole          # Terminal (though you'll use WezTerm)
    kdePackages.kate             # Text editor
    kdePackages.spectacle        # Screenshot tool
    kdePackages.kdeconnect-kde   # Phone integration
    kdePackages.plasma-systemmonitor
    kdePackages.partitionmanager

    # Wayland utilities
    wl-clipboard                 # Clipboard for Wayland

    # Applications
    firefox                      # Web browser
    vesktop                      # Discord client with Wayland support
    keepassxc                    # Password manager
    doublecmd                    # Dual-pane file manager

    # Terminal & Tools
    wezterm                      # Your preferred terminal
    ghostty                      # Fast GPU-accelerated terminal
    zellij                       # Terminal multiplexer

    # Modern CLI Tools
    eza                          # ls replacement
    bat                          # cat replacement
    ripgrep                      # grep replacement
    fd                           # find replacement
    fzf                          # Fuzzy finder
    zoxide                       # Smart cd
    tldr                         # Simplified man pages

    # Development tools
    git
    gh                           # GitHub CLI
    lazygit                      # Git TUI
    neovim                       # Editor
    claude-code                  # Claude AI CLI

    # System utilities
    btop                         # System monitor
    htop                         # Process viewer
    fastfetch                    # System information tool
    tree                         # Directory tree
    jq                           # JSON processor
    wget
    curl
    unzip
    zip

    # Dracula themes
    dracula-theme                # GTK theme
  ];

  # Enable dbus for desktop applications
  services.dbus.enable = true;

  # Enable location service (for redshift/Night Color)
  services.geoclue2.enable = true;

  # Enable Tailscale VPN
  services.tailscale.enable = true;

  # Enable Syncthing for file synchronization
  services.syncthing = {
    enable = true;
    user = "mathias";
    dataDir = "/home/mathias/.syncthing";
    configDir = "/home/mathias/.config/syncthing";
    openDefaultPorts = true;
  };

  # Set desktop wallpaper on login
  systemd.user.services.set-wallpaper = {
    description = "Set KDE Plasma wallpaper";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.libsForQt5.plasma-workspace}/bin/plasma-apply-wallpaperimage /home/mathias/bgimage";
      Restart = "no";
    };
  };

  # Dracula theme configuration
  environment.sessionVariables = {
    BAT_THEME = "Dracula";           # Bat uses Dracula theme
    GTK_THEME = "Dracula";           # GTK apps use Dracula
  };

  # Note: For KDE Plasma Dracula theme, install from KDE Store or configure manually:
  # System Settings -> Appearance -> Global Theme -> Get New Global Themes -> Search "Dracula"
}
