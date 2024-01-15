{ inputs, outputs, pkgs, lib, ... }:

{
  imports = [
    outputs.homeManagerModules.default
    inputs.nix-index-database.hmModules.nix-index
  ];

  myHomeManager = {
    alacritty.enable = true;
    bash.enable = true;
    git.enable = true;
    helix.enable = true;
    lf.enable = true;
    pistol.enable = true;
    tmux.enable = true;
    firefox.enable = true;
    zathura.enable = true;
    sway.enable = true;

    services.udiskie.enable = true;
  };

  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-hard;

  home.file."Pictures/Wallpapers" = {
    source = ./../../wallpapers;
    recursive = true;
  };

  home = {
    username = "joris";
    homeDirectory = lib.mkDefault "/home/joris";
    stateVersion = "23.11";

    packages = with pkgs; [
      cmus
      less
      docker

      foot
      glow

      # go
      go
      go-migrate
      gotools
      delve
    ];
  };
}
