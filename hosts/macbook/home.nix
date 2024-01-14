{ inputs, outputs, pkgs, lib, ... }:

{
  imports = [ outputs.homeManagerModules.default ];

  myHomeManager = {
    alacritty.enable = true;
    bash.enable = true;
    git.enable = true;
    helix.enable = true;
    lf.enable = true;
    pistol.enable = true;
    tmux.enable = true;
  };

  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-hard;

  fonts.fontconfig.enable = true;
  programs.home-manager.enable = true;

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };

  home = {
    username = "jorisvanbreugel";
    homeDirectory = lib.mkDefault "/Users/jorisvanbreugel";
    stateVersion = "23.11";

    packages = with pkgs; [
      (ctpv.overrideAttrs (_: { meta.platforms = lib.platforms.unix; }))

      cmus
      less
      docker
      lazygit
      lazydocker

      # go
      go
      go-migrate
      gotools
      delve
    ];
  };
}

