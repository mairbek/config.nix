{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tmux-mem-cpu-load
  ];

  programs.tmux = {
    enable  = true;
    prefix  = "C-a";               # pulled from your file
    terminal = "screen-256color";  # idem

    extraConfig = ''
      # enable activity monitoring
      setw -g monitor-activity on
      set -g visual-activity on

      # colour setup
      set -g default-terminal "screen-256color"
      set -g status-style bg=colour235,fg=colour136,default
      set -g window-style fg=colour244,bg=default,dim
      set -g window-status-style fg=colour166,bg=default,bright
      set -g pane-border-style fg=colour235
      set -g pane-active-border-style fg=colour240
      set -g message-style bg=colour235,fg=colour166

      # pane-number display
      set-option -g display-panes-active-colour colour33
      set-option -g display-panes-colour colour166

      # clock colour
      set-window-option -g clock-mode-colour green

      # status bar
      set -g status-interval 1
      set -g status-justify centre
      set -g status-left-length 20
      set -g status-right-length 140
      set -g status-left  '#[fg=black,bg=white]#(echo " You")#[fg=white,bg=red]#(echo "Tube ")'
      set -g status-right '#[fg=green,bg=default,bright]#(tmux-mem-cpu-load --colors --interval 10) #[fg=red,dim,bg=default]#(uptime | cut -f 4-5 -d " " | cut -f 1 -d ",") #[fg=white,bg=default]%a%l:%M:%S %p#[default] #[fg=blue]%Y-%m-%d'

      # pane traversal & quality-of-life bindings
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # command prompt for new window
      bind C command-prompt -p "Name of new window: " "new-window -n '%%'"

      # reload conf manually
      # bind R source-file ~/.tmux.conf \; display-message "[tmux configuration reloaded]"
    '';
  };
}
