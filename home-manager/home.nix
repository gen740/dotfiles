{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "gen";
  home.homeDirectory = "/Users/gen";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
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

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/gen/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.fd.enable = true;
  programs.fzf.enable = true;
  programs.gh.enable = true;
  programs.home-manager.enable = true;
  programs.neovim.enable = true;
  programs.ripgrep.enable = true;
  programs.starship.enable = true;

  programs = {

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
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };

    bash.enable = true; # see note on other shells below
  };

}
