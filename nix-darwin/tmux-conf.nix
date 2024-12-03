{ shell }:
{
  enable = true;
  escapeTime = 5;
  baseIndex = 1;
  prefix = "C-s";
  mouse = true;
  shell = shell;
  historyLimit = 10000;
  extraConfig = ''
    set-option -g status-justify "centre"
    set-option -g status-left-length 40
    set-option -g status-right-length 40
    set-option -g status-interval 1

    TMUX_STATUS_FG=#cdcecf
    TMUX_STATUS_DARKFG=#71839b
    TMUX_STATUS_BG=#393b44
    TMUX_STATUS_BLUE=#719cd6
    TMUX_STATUS_BG_BLACK=#192330
    TMUX_STATUS_GREEN=#81b29a

    set-option -g status-style bg=default

    set -g status-left "#[fg=$TMUX_STATUS_BLUE,bold,underscore]#S#[fg=$TMUX_STATUS_GREEN,nobold,nounderscore]       "
    set -g window-status-format " #[fg=$TMUX_STATUS_BG,bold]#I #[fg=$TMUX_STATUS_BG,nobold]#W"
    set -g window-status-current-format " #[fg=$TMUX_STATUS_BLUE,bold,underscore]#I #[fg=$TMUX_STATUS_BLUE,nobold]#W"
    set -g status-right "#[fg=$TMUX_STATUS_BLUE,bold,underscore]%m/%d %H:%M:%S"


    set-option -g status-position bottom
    set -g pane-border-style fg=color236
    set -g pane-active-border-style "fg=magenta"

    set-window-option -g mode-keys vi
    bind -T copy-mode-vi v send -X begin-selection
    bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"

    bind-key -n C-S-Left swap-window -t -1
    bind-key -n C-S-Right swap-window -t +1
    bind-key k select-pane -U
    bind-key j select-pane -D
    bind-key h select-pane -L
    bind-key l select-pane -R

    set-option -g focus-events on
  '';
}
