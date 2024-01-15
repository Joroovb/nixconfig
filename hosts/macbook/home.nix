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

  programs.direnv = {
    enable = true;
    enableBashIntegration = true; # see note on other shells below
    nix-direnv.enable = true;
  };

  home.file."Pictures/Wallpapers" = {
    source = ./../../wallpapers;
    recursive = true;
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

      weechat

      (pkgs.writeShellScriptBin "flakify" ''
        if [ ! -e flake.nix ]; then
          nix flake new -t github:nix-community/nix-direnv .
        elif [ ! -e .envrc ]; then
          echo "use flake" > .envrc
        fi
          ''${EDITOR:-nano} flake.nix
          ${pkgs.direnv}/bin/direnv allow
      '')
    ];
  };
}

