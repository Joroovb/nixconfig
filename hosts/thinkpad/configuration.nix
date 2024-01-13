{ outputs, ... }:

{
  imports = [ outputs.nixosModules.default ./hardware-configuration.nix ];

  myNixOS = {
    bundles.general-desktop.enable = true;
    bundles.home-manager.enable = true;

    userName = "joris";
    userConfig = ./home.nix;
    userNixosSettings = {
      extraGroups = [ "networkmanager" "wheel" "docker" ];
    };
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "thinkpad";
  networking.firewall.enable = true;
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;

  # Enable docker
  virtualisation.docker.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  security.pam.services.swaylock = { };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "euro";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.11"; # DO NOT TOUCH
}
