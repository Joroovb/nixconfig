{
  description = "NixOS setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { nixpkgs, home-manager, darwin, ... }@inputs:
    let helpers = import ./helpers/default.nix { inherit inputs; };
    in with helpers; {
      nixosConfigurations = {
        thinkpad = mkSystem ./hosts/thinkpad/configuration.nix;
        desktop = mkSystem ./hosts/desktop/configuration.nix;
      };

      darwinConfigurations = {
        macbook = mkDarwin "aarch64-darwin" ./hosts/macbook/configuration.nix;
      };

      homeConfigurations = {
        "joris@workstation" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [ ./home.nix ];
        };
      };

      homeManagerModules.default = ./homeManagerModules;
      nixosModules.default = ./nixosModules;
      darwinModules.default = ./darwinModules;
    };
}
