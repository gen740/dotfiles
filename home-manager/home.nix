{ config, pkgs, ... }:

{
  home.username = "gen";
  home.homeDirectory = "/Users/gen";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  #environment.
  home.packages = [
    pkgs.vscode-langservers-extracted
    pkgs.nixd
    pkgs.trash-cli
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs = {
    fd = {
      enable = true;
    };

    fzf = {
      enable = true;
    };

    gh = {
      enable = true;
    };

    home-manager = {
      enable = true;
    };

    neovim = {
      enable = true;
    };

    ripgrep = {
      enable = true;
    };

    starship = {
      enable = true;
    };

    tmux = {
      enable = true;
      escapeTime = 0;
      baseIndex = 1;
      prefix = "C-s";
      mouse = false;
      shell = "/bin/zsh";
      historyLimit = 10000;
      extraConfig = ''
        set-option -g status-justify "centre"
        set-option -g status-left-length 40
        set-option -g status-right-length 40
        set-option -g status-interval 10

        TMUX_STATUS_FG=#cdcecf
        TMUX_STATUS_DARKFG=#71839b
        TMUX_STATUS_BG=#393b44
        TMUX_STATUS_BLUE=#719cd6
        TMUX_STATUS_BG_BLACK=#192330
        TMUX_STATUS_GREEN=#81b29a

        set-option -g status-style bg=default

        set -g status-left "\
         #[fg=$TMUX_STATUS_BLUE,bold,underscore]#S#[fg=$TMUX_STATUS_GREEN,nobold,nounderscore]  "
        set -g window-status-format " #[fg=$TMUX_STATUS_BG,bold]#I #[fg=$TMUX_STATUS_BG,nobold]#W"
        set -g window-status-current-format " #[fg=$TMUX_STATUS_BLUE,bold,underscore]#I #[fg=$TMUX_STATUS_BLUE,nobold]#W"
        set -g status-right ""

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
    };

    git = {
      enable = true;
      userName = "gen740";
      userEmail = "54583542+gen740@users.noreply.github.com";
      aliases = {
        subup = "submodule update --init --recursive";
        pl = "log --graph --oneline --decorate --all --date=short --pretty='format:%C(bold magenta)%h%C(reset) - %C(green)%ad%C(reset)%C(auto)%d%C(reset) %C(ul brightmagenta)%s%C(reset) %C(yellow)@%an%C(reset)'";
        ps = "status --short --branch --show-stash  --untracked-files=all";
      };
      extraConfig = {
        diff = {
          colorMoved = "default";
          tool = "nvimdiff";
        };
        "difftool \"nvimdiff\"" = {
          prompt = true;
          cmd = "nvim -R -d -c \"wincmd l\" -d \"$LOCAL\" \"$REMOTE\"";
        };
        merge = {
          conflictstyle = "diff3";
          tool = "nvimdiff";
        };
        mergeTool = {
          cmd = "nvim -d -c \"4wincmd w | wincmd J\" \"$LOCAL\" \"$BASE\" \"$REMOTE\"  \"$MERGED\"";
          keepBackup = false;
        };
        safe = {
          directory = "/opt/homebrew";
        };
        help = {
          autocorrect = 20;
        };
        commit = {
          verbose = true;
        };
      };
    };

    lazygit = {
      enable = true;
      settings = {
        gui = {
          border = "single";
          nerdFontsVersion = "3";
          showBottomLine = false;
        };
      };
    };

    direnv = {
      enable = true;
      enableZshIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };

    jq = {
      enable = true;
    };
  };
}
