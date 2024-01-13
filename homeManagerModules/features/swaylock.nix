{ config, ... }:

{
  programs.swaylock = {
    enable = true;
    settings = with config.colorScheme.colors; {
      ignore-empty-password = true;
      disable-caps-lock-text = true;
      font = "Iosevka Nerd Font Mono";

      indicator-radius = 120;
      indicator-thickness = 20;

      color = "${base00}";
      ring-color = "${base01}";
      key-hl-color = "${base0E}";
      line-color = "${base00}";
      separator-color = "${base01}";
      inside-color = "${base01}";
      bs-hl-color = "${base0E}";
      layout-bg-color = "${base01}";
      layout-border-color = "${base03}";
      layout-text-color = "${base04}";
      text-color = "${base04}";
    };
  };
}
