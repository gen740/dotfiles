{
  enable = true;
  userName = "gen740";
  userEmail = "54583542+gen740@users.noreply.github.com";
  ignores = [
    ".DS_Store"
    "flake.nix"
    "flake.lock"
    ".envrc"
    ".direnv"
  ];
  aliases = {
    subup = "submodule update --init --recursive";
    pl =
      "log --graph --oneline --decorate --all --date=short --pretty='format:%C(bold magenta)%h%C(reset) - %C(green)%ad%C(reset)%C(auto)%d%C(reset) %C(ul brightmagenta)%s%C(reset) %C(yellow)@%an%C(reset)'";
    ps = "status --short --branch --show-stash  --untracked-files=all";
  };
  extraConfig = {
    diff = {
      colorMoved = "default";
      tool = "nvimdiff";
    };
    "difftool \"nvimdiff\"" = {
      prompt = true;
      cmd = ''nvim -R -d -c "wincmd l" -d "$LOCAL" "$REMOTE"'';
    };
    merge = {
      conflictstyle = "diff3";
      tool = "nvimdiff";
    };
    mergeTool = {
      cmd = ''
        nvim -d -c "4wincmd w | wincmd J" "$LOCAL" "$BASE" "$REMOTE"  "$MERGED"'';
      keepBackup = false;
    };
    safe = { directory = "/opt/homebrew"; };
    help = { autocorrect = 20; };
    commit = { verbose = true; };
  };
}
