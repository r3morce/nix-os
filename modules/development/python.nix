{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Python 3.13 (matching your current CachyOS setup)
    python313
    python313Packages.pip
    python313Packages.virtualenv

    # Python development tools
    python313Packages.setuptools
    python313Packages.wheel

    # Alternatively, use pyenv for version management
    # pyenv
  ];
}
