{ lib, config, pkgs, inputs, outputs, helpers, ... }:
let cfg = config.myDarwin;
in {
  options.myDarwin = {
    userName = lib.mkOption {
      default = "joris";
      description = ''
        username
      '';
    };

    userConfig = lib.mkOption {
      default = ./../../home-manager/work.nix;
      description = ''
        home-manager config path
      '';
    };

    userDarwinSettings = lib.mkOption {
      default = { };
      description = ''
        Darwin user settings
      '';
    };
  };

  config = {
    home-manager = {
      extraSpecialArgs = {
        inherit inputs;
        inherit helpers;
        outputs = inputs.self.outputs;
        sharedSettings = cfg.sharedSettings;
      };
      users = {
        ${cfg.userName} = { ... }: {
          imports =
            [ (import cfg.userConfig) outputs.homeManagerModules.default ];
        };
      };
    };

    users.users.${cfg.userName} = {
      shell = pkgs.bashInteractive;
      home = "/Users/${cfg.userName}";
    } // cfg.userDarwinSettings;
  };
}
