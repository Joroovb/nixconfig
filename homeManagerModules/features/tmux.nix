{ ... }:

{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    disableConfirmationPrompt = true;
    escapeTime = 0;
    historyLimit = 2000;
    keyMode = "vi";
    mouse = true;
    newSession = true;
    prefix = "C-a";
    sensibleOnTop = true;
    terminal = "screen-256color";
    aggressiveResize = true;

    extraConfig = ''
      set -g status-interval 2
      set -g status-left '🏠 #S'
      set -g status-left-length 200
      set -g status-right-length 60
      set -g status-right '%H:%M %d-%m-%y'
      set -g status-position top

      # renumber windows on kill
      set-option -g renumber-windows on

      # Colors
      set -g pane-active-border-style fg='#eeff44'
      set -g status-bg '#181818'
      set -g status-fg '#e4e4ef'

      set -g window-status-current-format '#[fg=#ffdd33]*#I-#W'
      set -g window-status-format '#I-#W'
      set-option -g status-justify centre

      bind-key -N "Kill the current window" & kill-window
      bind-key -N "Kill the current pane" x kill-pane
      bind-key C command-prompt -p "Name of new window: " "new-window -n '%%'"

      # set window split
      bind-key v split-window -h
      bind-key b split-window

      # easy reload config
      bind-key r source-file ~/.config/tmux/tmux.conf \; display-message "~/.config/tmux/tmux.conf reloaded."
    '';
  };
}
