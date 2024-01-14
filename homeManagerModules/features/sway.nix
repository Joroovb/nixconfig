{ lib, pkgs, ... }:
let
  idleCmd = ''
    swayidle -w \
        timeout 300 '${pkgs.swaylock}/bin/swaylock --daemonize' \
        timeout 600 '${pkgs.sway}/bin/swaymsg "output * dpms off"' \
             resume '${pkgs.sway}/bin/swaymsg "output * dpms on"' \
        before-sleep '${pkgs.swaylock}/bin/swaylock --daemonize'
  '';

in {
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

      startup = [{ command = "${idleCmd}"; }];
    };
  };
}
