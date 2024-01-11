{ pkgs, outputs, ... }:

{
  imports = [ outputs.darwinModules.default ];

  myDarwin = {
    bundles.general.enable = true;
    bundles.home-manager.enable = true;
    services.karabiner.enable = true;
    userName = "jorisvanbreugel";
    userConfig = ./home.nix;
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };

    casks = [
      "hammerspoon"
      "amethyst"
      "alfred"
      "logseq"
      "discord"
      "iina"
      "alacritty"
    ];
  };

  system = {
    defaults = {
      NSGlobalDomain = {
        "com.apple.mouse.tapBehavior" = 1;
        AppleKeyboardUIMode = 3;
        ApplePressAndHoldEnabled = true;
        InitialKeyRepeat = 10;
        KeyRepeat = 1;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
        _HIHideMenuBar = true;
      };

      screencapture.location = "/tmp";

      dock = {
        autohide = true;
        mru-spaces = false;
        orientation = "bottom";
        showhidden = true;
        static-only = true;
      };

      finder = {
        AppleShowAllFiles = true;
        AppleShowAllExtensions = true;
        QuitMenuItem = true;
        FXEnableExtensionChangeWarning = false;
      };

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = false;
      };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
  };

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [ (nerdfonts.override { fonts = [ "Iosevka" ]; }) ];
}
