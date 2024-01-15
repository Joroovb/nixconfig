{ pkgs, ... }:

{
  programs.pistol = {
    enable = true;
    associations = [
      {
        fpath = ".*.md$";
        command = "${pkgs.glow}/bin/glow -s dark %pistol-filename%";
      }
      {
        mime = "text/*";
        command =
          "${pkgs.bat}/bin/bat --paging=never --color=always %pistol-filename%";
      }
    ];
  };
}
