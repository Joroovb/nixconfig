{ inputs, lib, pkgs, outputs, ... }:

{
  imports = [
    outputs.homeManagerModules.default
    inputs.nix-index-database.hmModules.nix-index
  ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-hard;
  home.file."Pictures/Wallpapers" = {
    source = ../../wallpapers;
    recursive = true;
  };

  myHomeManager = {
    sway.enable = true;
    alacritty.enable = true;
    git.enable = true;
    helix.enable = true;
    lf.enable = true;
    pistol.enable = true;
    tmux.enable = true;
  };

  home = {
    username = "joris";
    homeDirectory = lib.mkDefault "/home/joris";
    stateVersion = "23.11";

    packages = with pkgs; [
      cmus
      less
      docker

      # Needed for sway config
      # TODO find a way to enable this in sway config
      swww

      # go
      go
      go-migrate
      gotools
      delve
    ];
  };

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

