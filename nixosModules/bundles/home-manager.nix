{ lib, config, inputs, outputs, helpers, pkgs, ... }:
let cfg = config.myNixOS;
in {
  options.myNixOS = {
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

    userNixosSettings = lib.mkOption {
      default = { };
      description = ''
        NixOS user settings
      '';
    };
  };

  config = {
    programs.zsh.enable = true;

    programs.hyprland.enable = cfg.sharedSettings.hyprland.enable;
    # programs.hyprland.enableNvidiaPatches = cfg.sharedSettings.hyprland.enable;

    services.xserver = lib.mkIf cfg.sharedSettings.hyprland.enable {
      displayManager = { defaultSession = "hyprland"; };
    };

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
      isNormalUser = true;
      initialPassword = "12345";
      description = cfg.userName;
      shell = pkgs.bashInteractive;
      extraGroups = [ "docker" "networkmanager" "wheel" ];
    } // cfg.userNixosSettings;
  };
}
