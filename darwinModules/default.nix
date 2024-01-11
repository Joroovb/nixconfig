{ config, lib, inputs, helpers, ... }:
let
  cfg = config.myDarwin;

  # Taking all modules in ./features and adding enables to them
  features = helpers.extendModules (name: {
    extraOptions = {
      myDarwin.${name}.enable =
        lib.mkEnableOption "enable my ${name} configuration";
    };

    configExtension = config: (lib.mkIf cfg.${name}.enable config);
  }) (helpers.filesIn ./features);

  # Taking all module bundles in ./bundles and adding bundle.enables to them
  bundles = helpers.extendModules (name: {
    extraOptions = {
      myDarwin.bundles.${name}.enable =
        lib.mkEnableOption "enable ${name} module bundle";
    };

    configExtension = config: (lib.mkIf cfg.bundles.${name}.enable config);
  }) (helpers.filesIn ./bundles);

  # Taking all module services in ./services and adding services.enables to them
  services = helpers.extendModules (name: {
    extraOptions = {
      myDarwin.services.${name}.enable =
        lib.mkEnableOption "enable ${name} service";
    };

    configExtension = config: (lib.mkIf cfg.services.${name}.enable config);
  }) (helpers.filesIn ./services);
in {
  imports = [ inputs.home-manager.darwinModules.home-manager ] ++ features
    ++ bundles ++ services;

  #  inputs.home-manager.useGlobalPkgs = true;
  # inputs.home-manager.useUserPackages = true;

  #config = {
  #  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  #   programs.nix-ld.enable = true;
  #    nixpkgs.config.allowUnfree = true;
  # };
}
