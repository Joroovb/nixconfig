{ pkgs, lib, ... }: {
  #  myNixOS.sddm.enable = lib.mkDefault true;
  #myNixOS.xremap-user.enable = lib.mkDefault true;
  #myNixOS.system-controller.enable = lib.mkDefault true;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  # Enable sound with pipewire.
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  fonts.packages = with pkgs; [
    (pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; })
    cm_unicode
    corefonts
    font-awesome
  ];

  fonts.enableDefaultPackages = true;
  fonts.fontconfig = {
    defaultFonts = {
      monospace = [ "Iosevka Nerd Font Mono" ];
      sansSerif = [ "Iosevka Nerd Font" ];
      serif = [ "Iosevka Nerd Font" ];
    };
  };

  # battery
  services.upower.enable = true;
}
