{ ... }:

{
  # Remember to enable services.udisks2 in nixos configuration, otherwise this will not work.
  services.udiskie = { enable = true; };
}
