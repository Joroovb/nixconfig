{ pkgs, inputs, config, lib, ... }:

let
  createDirs = pkgs.writeShellScriptBin "createDirs" ''
    echo "Creating folders..."
    [ -d ${config.home.homeDirectory}/Code ] || mkdir ${config.home.homeDirectory}/Code
    echo "Done creating folders..."
  '';

in {
  imports = [ inputs.nix-colors.homeManagerModules.default ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      experimental-features = "nix-command flakes";
    };
  };

  programs.home-manager.enable = true;

  home.activation.name = lib.hm.dag.entryAfter [ "writeBoundary" ]
    "bash ${createDirs}/bin/createDirs";

  home.packages = with pkgs; [
    nil
    file
    git
    p7zip
    unzip
    zip

    ffmpeg
    wget

    yt-dlp
    tree-sitter
  ];
}
