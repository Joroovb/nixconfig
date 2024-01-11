{ pkgs, ... }:

let
  cpugovenor = pkgs.writeShellScriptBin "cpugovenor" ''
      if [ `cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor`="performance" ]; then
    	echo '{"text": "perf", "alt": "perf", "class": "performance", "tooltip": "<b>Governor</b> Performance"}'
    elif [ `cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor`="schedutil" ]; then
    	echo '{"text": "sched", "class": "schedutil", "tooltip": "<b>Governor</b> Schedutil"}'
    fi
  '';

  gpumonitor = pkgs.writeShellScriptBin "gpumonitor" ''
    raw_clock=$(cat /sys/class/drm/card0/device/pp_dpm_sclk | egrep -o '[0-9]{0,4}Mhz \W' | sed "s/Mhz \*//")
    clock=$(echo "scale=1;$raw_clock/1000" | bc | sed -e 's/^-\./-0./' -e 's/^\./0./')

    raw_temp=$(cat /sys/class/drm/card0/device/hwmon/hwmon5/temp1_input)
    temperature=$(($raw_temp/1000))
    busypercent=$(cat /sys/class/hwmon/hwmon5/device/gpu_busy_percent)
    deviceinfo=$(glxinfo -B | grep 'Device:' | sed 's/^.*: //')
    driverinfo=$(glxinfo -B | grep "OpenGL version")

    echo '{"text": "'$clock'GHz |   '$temperature'°C <span color=\"darkgray\">| '$busypercent'%</span>", "class": "custom-gpu", "tooltip": "<b>'$deviceinfo'</b>\n'$driverinfo'"}'
  '';

in {

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {

        layer = "top";
        position = "top";
        height = 36;

        modules-left = [
          "clock"
          "sway/language"
          "custom/scratchpad-indicator"
          "sway/mode"
          "idle_inhibitor"
          "custom/media"
        ];
        modules-center = [ "sway/workspaces" ];
        modules-right = [
          "custom/cpugovernor"
          "cpu"
          "temperature"
          "custom/gpu"
          "pulseaudio"
          "bluetooth"
          "network"
          "tray"
        ];

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{icon}";
          format-icons = {
            "1" = ''<span color="#D8DEE9"></span>'';
            "2" = ''<span color="#88C0D0"></span>'';
            "3" = ''<span color="#A3BE8C"></span>'';
            "4" = ''<span color="#D8DEE9"></span>'';
            urgent = "";
            focused = "";
            default = "";
          };
        };

        "sway/mode" = { format = ''<span style="italic">{}</span>''; };
        "sway/window" = {
          "format" = "{}";
          "max-length" = 50;
          "tooltip" = false;
        };
        "bluetooth" = {
          interval = 30;
          format = "{icon}";
          format-icons = {
            enabled = "";
            disabled = "";
          };
          on-click = "${pkgs.blueberry}/bin/blueberry";
        };
        "sway/language" = {
          format = "<big></big> {}";
          max-length = 5;
          min-length = 5;
        };
        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
          tooltip = true;
        };
        "tray" = { spacing = 5; };
        "clock" = {
          format = "  {=%H=%M   %e %b}";
          tooltip-format = ''
            <big>{=%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
          today-format = "<b>{}</b>";
          on-click = "${pkgs.gnome.gnome-calendar}/bin/gnome-calendar";
        };
        "cpu" = {
          interval = 1;
          format =
            ''  {max_frequency}GHz <span color="darkgray">| {usage}%</span>'';
          "max-length" = 13;
          "min-length" = 13;
          "on-click" =
            "${pkgs.alacritty}/bin/alacritty -e ${pkgs.htop}/bin/htop --sort-key PERCENT_CPU";
          "tooltip" = false;
        };
        "temperature" = {
          interval = 4;
          hwmon-path = "/sys/class/hwmon/hwmon3/temp1_input";
          critical-threshold = 74;
          format-critical = "  {temperatureC}°C";
          format = "{icon}  {temperatureC}°C";
          format-icons = [ "" "" "" ];
          max-length = 7;
          min-length = 7;
        };
        "network" = {
          #"interface"= "wlan0"; // (Optional) To force the use of this interface;
          format-wifi = "  {essid}";
          format-ethernet = "{ifname}: {ipaddr}/{cidr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
          family = "ipv4";
          tooltip-format-wifi = ''
              {ifname} @ {essid}
            IP: {ipaddr}
            Strength: {signalStrength}%
            Freq: {frequency}MHz
             {bandwidthUpBits}  {bandwidthDownBits}'';
          tooltip-format-ethernet = ''
             {ifname}
            IP: {ipaddr}
             {bandwidthUpBits}  {bandwidthDownBits}'';
        };
        "pulseaudio" = {
          scroll-step = 3; # %; can be a float
          format = "{icon} {volume}% {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          #"format-source"= "{volume}% ";
          #"format-source-muted"= "";
          format-source = "";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
          on-click-right =
            "${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        };
        "custom/weather" = {
          exec = "${pkgs.curlMinimal}/bin/curl 'https=//wttr.in/?format=1'";
          interval = 3600;
        };
        "custom/gpu" = { # DOESNT WORK NOW
          exec = "${gpumonitor}/bin/gpumonitor";
          return-type = "json";
          format = "  {}";
          interval = 2;
          tooltip = "{tooltip}";
          max-length = 19;
          min-length = 19;
          on-click = "powerupp"; # NOT PACKAGED YET
        };
        "custom/cpugovernor" = {
          format = "{icon}";
          interval = 30;
          return-type = "json";
          exec = "${cpugovenor}/bin/cpugovenor";
          min-length = 2;
          max-length = 2;
          format-icons = {
            perf = "";
            sched = "";
          };
        };

        "custom/media" = {
          format = "{icon} {}";
          return-type = "json";
          max-length = 40;
          format-icons = {
            spotify = "";
            default = "🎜";
          };
          escape = true;
          exec =
            "$HOME/.config/waybar/mediaplayer.py 2> /dev/null"; # Script in resources folder;
        };

        # NIXIFY THIS SCRIPT
        "custom/scratchpad-indicator" = {
          interval = 3;
          return-type = "json";
          exec =
            "swaymsg -t get_tree | jq --unbuffered --compact-output '( select(.name == \"root\") | .nodes[] | select(.name == \"__i3\") | .nodes[] | select(.name == \"__i3_scratch\") | .focus) as $scratch_ids | [..  | (.nodes? + .floating_nodes?) // empty | .[] | select(.id |IN($scratch_ids[]))] as $scratch_nodes | { text= \"\\($scratch_nodes | length)\"; tooltip= $scratch_nodes | map(\"\\(.app_id // .window_properties.class) (\\(.id))= \\(.name)\") | join(\"\\n\") }'";
          format = "{} 􏠜";
          on-click = "exec swaymsg 'scratchpad show'";
          on-click-right = "exec swaymsg 'move scratchpad'";
        };
      };
    };
  };
}
