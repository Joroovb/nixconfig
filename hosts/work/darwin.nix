{ pkgs, ... }:

{
  users.users = {
    jorisvanbreugel = {
      description = "Joris van Breugel";
      home = "/Users/jorisvanbreugel";
    };
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # Home manager
  home-manager.users.jorisvanbreugel.home.stateVersion = "23.11";
  home-manager.users.jorisvanbreugel = { imports = [ ./home.nix ]; };
}
