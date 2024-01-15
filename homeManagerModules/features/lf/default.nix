{ lib, pkgs, config, ... }:

{
  config = {
    xdg.configFile."lf/icons".source = ./icons;

    programs.lf = {
      enable = true;

      settings = {
        preview = true;
        hidden = true;
        drawbox = true;
        icons = true;
        ignorecase = true;
      };

      commands = {
        editor-open = "${pkgs.helix}/bin/hx $f";
        mkdir = ''
          ''${{
            printf "Directory name: "
            read DIR
            mkdir $DIR
          }}
        '';

        mkfile = ''
          ''${{
            printf "File: "
            read FILE
            touch $FILE
            }}
        '';
      };

      keybindings = {
        "<enter>" = "open";
        "c" = "mkdir";
        "n" = "mkfile";
        "gh" = "cd";
        "g/" = "/";
      };

      previewer = {
        keybinding = "i";
        source = "${
            (pkgs.ctpv.overrideAttrs
              (_: { meta.platforms = pkgs.lib.platforms.unix; }))
          }/bin/ctpv";
      };
      extraConfig = ''
        &${
          (pkgs.ctpv.overrideAttrs
            (_: { meta.platforms = pkgs.lib.platforms.unix; }))
        }/bin/ctpv -s $id
        cmd on-quit %${
          (pkgs.ctpv.overrideAttrs
            (_: { meta.platforms = pkgs.lib.platforms.unix; }))
        }/bin/ctpv -e $id
        set cleaner ${
          (pkgs.ctpv.overrideAttrs
            (_: { meta.platforms = pkgs.lib.platforms.unix; }))
        }/bin/ctpvclear
      '';
    };
  };
}
