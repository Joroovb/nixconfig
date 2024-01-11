{ pkgs, ... }:

{
  imports = [
    ../../modules/alacritty.nix
    ../../modules/bash.nix
    ../../modules/git.nix
    ../../modules/helix.nix
    ../../modules/lf.nix
    ../../modules/pistol.nix
    ../../modules/tmux.nix
  ];

  home.packages = with pkgs; [
    cmus
    less
    tree
    docker

    # go
    go
    go-migrate
    gotools
    delve
  ];

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
}

