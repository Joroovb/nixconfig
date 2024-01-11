{ pkgs, config, ... }:

{

  home.packages = [ (pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; }) ];
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        decorations = "Full";
        dynamic_padding = true;
        padding = {
          x = 10;
          y = 10;
        };

      };

      shell = { program = "${pkgs.bashInteractive}/bin/bash"; };
      env = { TERM = "xterm-256color"; };
      cursor = {
        style = "Block";
        unfocused_hollow = true;
      };

      font = {
        size = 12.0;
        normal = {
          family = "Iosevka Nerd Font Mono";
          style = "Regular";
        };

        bold = {
          family = "Iosevka Nerd Font Mono";
          style = "Bold";
        };

        italic = {
          family = "Iosevka Nerd Font Mono";
          style = "Italic";
        };
      };

      colors = {
        primary = {
          background = "0x${config.colorScheme.colors.base00}";
          foreground = "0x${config.colorScheme.colors.base05}";
        };

        cursor = {
          cursor = "0x${config.colorScheme.colors.base0A}";
          text = "0x${config.colorScheme.colors.base00}";
        };

        normal = {
          black = "0x${config.colorScheme.colors.base00}";
          blue = "0x${config.colorScheme.colors.base09}";
          cyan = "0x${config.colorScheme.colors.base0C}";
          green = "0x${config.colorScheme.colors.base0B}";
          magenta = "0x${config.colorScheme.colors.base0E}";
          red = "0x${config.colorScheme.colors.base08}";
          white = "0x${config.colorScheme.colors.base05}";
          yellow = "0x${config.colorScheme.colors.base0A}";
        };
      };
    };
  };
}
