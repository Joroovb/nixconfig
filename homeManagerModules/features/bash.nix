{ pkgs, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;

    initExtra = ''
      __bash_prompt() {
      local userpart='`export XIT=$? \
          && echo -n " \[\033[0;96m\]\u@\[\033[0;33m\]\h "`'
      local gitbranch='`\
        export BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null); \
          if [ "$BRANCH" != "" ]; then \
              echo -n "\[\033[0;36m\](\[\033[1;31m\]$BRANCH" \
              && if git ls-files --error-unmatch -m --directory --no-empty-directory -o --exclude-standard ":/*" > /dev/null 2>&1; then \
                      echo -n " \[\033[1;33m\]✗"; \
                  fi \
                  && echo -n "\[\033[0;36m\]) "; \
          fi`'
          local lightblue='\[\033[1;34m\]'
          local removecolor='\[\033[0m\]'
          PS1="[$userpart $lightblue\w $gitbranch$removecolor]\$ "
          unset -f __bash_prompt
      }
      __bash_prompt
    '';

    bashrcExtra = ''
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
    '';

    shellAliases = {
      cp = "cp -r";
      rm = "rm -r";

      lg = "${pkgs.lazygit}/bin/lazygit";
      lv = "${pkgs.lazydocker}/bin/lazydocker";

      cat = "${pkgs.bat}/bin/bat";
      grep = "${pkgs.ripgrep}/bin/rg";
      ls =
        "${pkgs.eza}/bin/eza --long --grid --header --classify --icons=always --git";
      tree =
        "${pkgs.eza}/bin/eza  --long --grid --header --classify --icons=always --git -T";
    };
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };
}
