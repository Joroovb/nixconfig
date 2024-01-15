{ pkgs, outputs, ... }:

{
  imports = [ outputs.nixosModules.default ./hardware-configuration.nix ];

  myNixOS = {
    bundles.general-desktop.enable = true;
    bundles.home-manager.enable = true;
    power-management.enable = true;

    services.greetd.enable = true;

    userName = "joris";
    userConfig = ./home.nix;
    userNixosSettings = {
      extraGroups = [ "networkmanager" "wheel" "docker" ];
    };
  };

  environment.systemPackages = [ pkgs.cifs-utils ];

  fileSystems."/mnt/nas" = {
    device = "//192.168.1.113/Public";
    fsType = "cifs";
    options = [ "credentials=/home/joris/nix/smb-secrets,uid=1000,gid=100" ];
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set Hostname, enable firewall and network manager
  networking.hostName = "thinkpad";
  networking.firewall.enable = true;
  networking.networkmanager.enable = true;

  # Enable bluetooth 
  hardware.bluetooth.enable = true;

  # Enable docker
  virtualisation.docker.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Needed to allow swaylock to unlock
  # TODO find a way to move this into sway home-manager configuration
  security.pam.services.swaylock = { };

  # Enable auto-mounting storage devices.
  # Needed for udiskie
  # TODO find a way to enable this in home-manager configuration
  services.udisks2.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "euro";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # DO NOT TOUCH
  system.stateVersion = "23.11";
}
