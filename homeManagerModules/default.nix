{ config, lib, helpers, ... }:
let
  cfg = config.myHomeManager;

  # Taking all modules in ./features and adding enables to them
  features = helpers.extendModules (name: {
    extraOptions = {
      myHomeManager.${name}.enable =
        lib.mkEnableOption "enable my ${name} configuration";
    };

    configExtension = config: (lib.mkIf cfg.${name}.enable config);
  }) (helpers.filesIn ./features);

  # Taking all module bundles in ./bundles and adding bundle.enables to them
  bundles = helpers.extendModules (name: {
    extraOptions = {
      myHomeManager.bundles.${name}.enable =
        lib.mkEnableOption "enable ${name} module bundle";
    };

    configExtension = config: (lib.mkIf cfg.bundles.${name}.enable config);
  }) (helpers.filesIn ./bundles);
in { imports = [ ] ++ features ++ bundles; }
