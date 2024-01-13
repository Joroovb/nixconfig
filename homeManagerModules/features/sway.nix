{ lib, pkgs, ... }:

{
  myHomeManager.waybar.enable = lib.mkDefault true;
  myHomeManager.swaylock.enable = lib.mkDefault true;
  myHomeManager.mako.enable = lib.mkDefault true;

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;

    config = {
      modifier = "Mod4";
      terminal = "${pkgs.alacritty}/bin/alacritty";

      bars = [{ command = "${pkgs.waybar}/bin/waybar"; }];

      window.titlebar = false;

      gaps = {
        inner = 4;
        outer = 4;
        top = 4;
        bottom = 4;
        smartGaps = true;
        smartBorders = "on";
      };
    };
  };
}
