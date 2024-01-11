{ pkgs, config, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "gruvbox_dark_hard";
      editor = {
        mouse = true;
        auto-format = true;
        true-color = true;
        gutters = [ "diagnostics" "line-numbers" "spacer" ];
        idle-timeout = 0;

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        statusline = {
          left = [ "mode" "spinner" "file-modification-indicator" ];
          center = [ "file-name" ];
          right = [
            "total-line-numbers"
            "version-control"
            "file-encoding"
            "file-type"
          ];
          mode.normal = "NORMAL";
          mode.insert = "INSERT";
          mode.select = "SELECT";
        };

        soft-wrap.enable = true;
      };
    };

    languages = {
      language-server.nil = { command = "${pkgs.nil}/bin/nil"; };

      language = [
        {
          name = "go";
          formatter = { command = "${pkgs.gotools}/bin/goimports"; };
          auto-format = true;
        }

        {
          name = "nix";
          formatter = { command = "${pkgs.nixfmt}/bin/nixfmt"; };
          auto-format = true;
        }
      ];
    };

    themes = {
      myTheme = {
        "attributes" = "#${config.colorScheme.colors.base09}";
        "comment" = {
          fg = "#${config.colorScheme.colors.base03}";
          modifiers = [ "italic" ];
        };
        "constant" = "#${config.colorScheme.colors.base09}";
        "constant.character.escape" = "#${config.colorScheme.colors.base0C}";
        "constant.numeric" = "#${config.colorScheme.colors.base09}";
        "constructor" = "#${config.colorScheme.colors.base0D}";
        "debug" = "#${config.colorScheme.colors.base03}";
        "diagnostic" = { modifiers = [ "underlined" ]; };
        "diff.delta" = "#${config.colorScheme.colors.base09}";
        "diff.minus" = "#${config.colorScheme.colors.base08}";
        "diff.plus" = "#${config.colorScheme.colors.base0B}";
        "error" = "#${config.colorScheme.colors.base08}";
        "function" = "#${config.colorScheme.colors.base0D}";
        "hint" = "#${config.colorScheme.colors.base03}";
        "info" = "#${config.colorScheme.colors.base0D}";
        "keyword" = "#${config.colorScheme.colors.base0E}";
        "label" = "#${config.colorScheme.colors.base0E}";
        "namespace" = "#${config.colorScheme.colors.base0E}";
        "operator" = "#${config.colorScheme.colors.base05}";
        "special" = "#${config.colorScheme.colors.base0D}";
        "string" = "#${config.colorScheme.colors.base0B}";
        "type" = "#${config.colorScheme.colors.base0A}";
        "variable" = "#${config.colorScheme.colors.base08}";
        "variable.other.member" = "#${config.colorScheme.colors.base0B}";
        "warning" = "#${config.colorScheme.colors.base09}";

        "markup.bold" = {
          fg = "#${config.colorScheme.colors.base0A}";
          modifiers = [ "bold" ];
        };
        "markup.heading" = "#${config.colorScheme.colors.base0D}";
        "markup.italic" = {
          fg = "#${config.colorScheme.colors.base0E}";
          modifiers = [ "italic" ];
        };
        "markup.link.text" = "#${config.colorScheme.colors.base08}";
        "markup.link.url" = {
          fg = "#${config.colorScheme.colors.base09}";
          modifiers = [ "underlined" ];
        };
        "markup.list" = "#${config.colorScheme.colors.base08}";
        "markup.quote" = "#${config.colorScheme.colors.base0C}";
        "markup.raw" = "#${config.colorScheme.colors.base0B}";
        "markup.strikethrough" = { modifiers = [ "crossed_out" ]; };

        "diagnostic.hint" = { underline = { style = "curl"; }; };
        "diagnostic.info" = { underline = { style = "curl"; }; };
        "diagnostic.warning" = { underline = { style = "curl"; }; };
        "diagnostic.error" = { underline = { style = "curl"; }; };

        "ui.background" = { bg = "#${config.colorScheme.colors.base00}"; };
        "ui.bufferline.active" = {
          fg = "#${config.colorScheme.colors.base00}";
          bg = "#${config.colorScheme.colors.base03}";
          modifiers = [ "bold" ];
        };
        "ui.bufferline" = {
          fg = "#${config.colorScheme.colors.base04}";
          bg = "#${config.colorScheme.colors.base00}";
        };
        "ui.cursor" = {
          fg = "#${config.colorScheme.colors.base0A}";
          modifiers = [ "reversed" ];
        };
        "ui.cursor.insert" = {
          fg = "#${config.colorScheme.colors.base0A}";
          modifiers = [ "revsered" ];
        };
        "ui.cursorline.primary" = {
          fg = "#${config.colorScheme.colors.base05}";
          bg = "#${config.colorScheme.colors.base01}";
        };
        "ui.cursor.match" = {
          fg = "#${config.colorScheme.colors.base0A}";
          modifiers = [ "reversed" ];
        };
        "ui.cursor.select" = {
          fg = "#${config.colorScheme.colors.base0A}";
          modifiers = [ "reversed" ];
        };
        "ui.gutter" = { bg = "#${config.colorScheme.colors.base00}"; };
        "ui.help" = {
          fg = "#${config.colorScheme.colors.base06}";
          bg = "#${config.colorScheme.colors.base01}";
        };
        "ui.linenr" = {
          fg = "#${config.colorScheme.colors.base03}";
          bg = "#${config.colorScheme.colors.base00}";
        };
        "ui.linenr.selected" = {
          fg = "#${config.colorScheme.colors.base04}";
          bg = "#${config.colorScheme.colors.base01}";
          modifiers = [ "bold" ];
        };
        "ui.menu" = {
          fg = "#${config.colorScheme.colors.base05}";
          bg = "#${config.colorScheme.colors.base01}";
        };
        "ui.menu.scroll" = {
          fg = "#${config.colorScheme.colors.base03}";
          bg = "#${config.colorScheme.colors.base01}";
        };
        "ui.menu.selected" = {
          fg = "#${config.colorScheme.colors.base01}";
          bg = "#${config.colorScheme.colors.base04}";
        };
        "ui.popup" = { bg = "#${config.colorScheme.colors.base01}"; };
        "ui.selection" = { bg = "#${config.colorScheme.colors.base02}"; };
        "ui.selection.primary" = {
          bg = "#${config.colorScheme.colors.base02}";
        };
        "ui.statusline" = {
          fg = "#${config.colorScheme.colors.base04}";
          bg = "#${config.colorScheme.colors.base01}";
        };
        "ui.statusline.inactive" = {
          bg = "#${config.colorScheme.colors.base01}";
          fg = "#${config.colorScheme.colors.base03}";
        };
        "ui.statusline.insert" = {
          fg = "#${config.colorScheme.colors.base00}";
          bg = "#${config.colorScheme.colors.base0B}";
        };
        "ui.statusline.normal" = {
          fg = "#${config.colorScheme.colors.base00}";
          bg = "#${config.colorScheme.colors.base03}";
        };
        "ui.statusline.select" = {
          fg = "#${config.colorScheme.colors.base00}";
          bg = "#${config.colorScheme.colors.base0F}";
        };
        "ui.text" = "#${config.colorScheme.colors.base05}";
        "ui.text.focus" = "#${config.colorScheme.colors.base05}";
        "ui.virtual.indent-guide" = {
          fg = "#${config.colorScheme.colors.base03}";
        };
        "ui.virtual.inlay-hint" = {
          fg = "#${config.colorScheme.colors.base01}";
        };
        "ui.virtual.ruler" = { bg = "#${config.colorScheme.colors.base01}"; };
        "ui.window" = { bg = "#${config.colorScheme.colors.base01}"; };

      };
    };
  };
}
