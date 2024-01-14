{ ... }:

{
  programs.git = {
    enable = true;
    userEmail = "jorisvanbreugel@mailbox.org";
    userName = "Joris van Breugel";

    extraConfig = { init.defaultBranch = "main"; };
  };
}
