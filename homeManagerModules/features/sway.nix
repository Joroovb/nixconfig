{ config, lib, pkgs, ... }:
let
  idleCmd = ''
    swayidle -w \
        timeout 300 '${pkgs.swaylock}/bin/swaylock --daemonize' \
        timeout 600 '${pkgs.sway}/bin/swaymsg "output * dpms off"' \
             resume '${pkgs.sway}/bin/swaymsg "output * dpms on"' \
        before-sleep '${pkgs.swaylock}/bin/swaylock --daemonize'
  '';

  screenshot = pkgs.writeShellScript "screenshot" ''
    mkdir -p "''${HOME}/screenshots"
    ${pkgs.grim}/bin/grim "''${HOME}/screenshots/screenshot-$(date '+%s').png"
  '';

  screenshotArea = pkgs.writeShellScript "screenshot-area" ''
    mkdir -p "''${HOME}/screenshots"
    ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" "''${HOME}/screenshots/screenshot-$(date '+%s').png"
  '';

  wallsetter = pkgs.writeShellScriptBin "wallsetter" ''
    NEWWALLPAPER=$(find $HOME/Pictures/Wallpapers -type l | shuf -n 1)

    ${pkgs.swww}/bin/swww img $NEWWALLPAPER --transition-type wave --transition-angle 120 --transition-step 30
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

      colors = with config.colorScheme.colors; {
        focused = {
          background = "${base02}";
          border = "${base02}";
        };

        unfocused = {
          background = "${base02}";
          border = "${base01}";
        };
      };

      keybindings = let mod = config.wayland.windowManager.sway.config.modifier;
      in lib.mkOptionDefault {
        "${mod}+Return" = "${pkgs.alacritty}/bin/alacritty";
        "${mod}+Shift+e" = "exit";
        "${mod}+Shift+q" = "kill";
        "${mod}+Shift+l" = "${pkgs.swaylock}/bin/swaylock";
        "${mod}+Shift+f" = "exec ${pkgs.firefox}/bin/firefox";

        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        "${mod}+f" = "fullscreen toggle";

        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";
        "${mod}+8" = "workspace number 8";
        "${mod}+9" = "workspace number 9";

        "${mod}+Shift+1" = "move container to workspace number 1";
        "${mod}+Shift+2" = "move container to workspace number 2";
        "${mod}+Shift+3" = "move container to workspace number 3";
        "${mod}+Shift+4" = "move container to workspace number 4";
        "${mod}+Shift+5" = "move container to workspace number 5";
        "${mod}+Shift+6" = "move container to workspace number 6";
        "${mod}+Shift+7" = "move container to workspace number 7";
        "${mod}+Shift+8" = "move container to workspace number 8";
        "${mod}+Shift+9" = "move container to workspace number 9";

        "${mod}+Shift+minus" = "move scratchpad";
        "${mod}+minus" = "scratchpad show";

        "${mod}+F12" = "exec ${screenshot}/bin/screenshot";
        "${mod}+Shift+F12" = "exec ${screenshotArea}/bin/screenshot-area";

        "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
        "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
        "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";
        "XF86AudioRaiseVolume" =
          "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" =
          "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" =
          "exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86MonBrightnessDown" = "exec ${pkgs.light}/bin/light -U 5%";
        "XF86MonBrightnessUp" = "exec ${pkgs.light}/bin/light -A 5%";
      };

      startup = [
        { command = "${pkgs.swww}/bin/swww init"; }
        { command = "${idleCmd}"; }
        { command = "${wallsetter}/bin/wallsetter"; }
      ];
    };
  };
}
