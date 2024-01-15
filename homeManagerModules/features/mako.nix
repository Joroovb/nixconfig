{ config, ... }:

{
  services.mako = with config.colorScheme.colors; {
    enable = true;
    font = "Iosevka Nerd Font Mono 12";

    defaultTimeout = 5000;

    backgroundColor = "#${base01}";
    borderColor = "#${base05}";
    textColor = "#${base04}";

    margin = "20,20";
    padding = "20,10";

    borderSize = 4;
    borderRadius = 2;
  };
}
