{
  enable = true;
  enableZshIntegration = true;
  settings = {
    add_newline = true;
    format = "(blue)$directory$git_branch$git_state$git_status$python$direnv\n[>](blue) ";
    right_format = "$git_metrics";
    command_timeout = 300;
    git_branch = {
      format = "[\($symbol$branch(:$remote_branch)\)]($style) ";
      symbol = "";
      style = "green";
    };
    git_metrics = {
      disabled = false;
    };
    directory = {
      truncation_length = 5;
      truncate_to_repo = false;
      style = "blue bold";
    };
    python = {
      format = "[\${pyenv_prefix}(\${version} )(\\($virtualenv\\) )]($style)";
    };
    direnv = {
      disabled = false;
    };
  };
}
