{ pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet";
      user = "joris";
    };

    #    default_session = { command = "${pkgs.sway}/bin/sway"; };
  };
}
