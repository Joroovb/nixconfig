{ inputs, outputs, pkgs, lib, ... }:

{
  imports = [ outputs.homeManagerModules.default ];

  myHomeManager = {
    alacritty.enable = true;
    bash.enable = true;
    eza.enable = true;
    git.enable = true;
    helix.enable = true;
    lf.enable = true;
    pistol.enable = true;
    tmux.enable = true;
    firefox.enable = true;
    zathura.enable = true;
  };

  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-hard;

  home = {
    username = "joris";
    homeDirectory = lib.mkDefault "/home/joris";
    stateVersion = "23.11";

    packages = with pkgs; [
      cmus
      less
      docker

      glow

      # go
      go
      go-migrate
      gotools
      delve
    ];
  };
}
