import std_module;
import PathTool;
import GitTool;
import PyenvTool;
import VenvTool;

namespace fs = std::filesystem;

auto main(int argc, char *argv[]) -> int {
  if (argc < 2) {
    std::cerr << "Please pass the argument\n";
    return 1;
  }
  if (std::strcmp(argv[1], "git_branch") == 0) {
    return GitBranchZshStatus();
  }
  if (std::strcmp(argv[1], "git_branch_nvim") == 0) {
    return GitBranchNvimStatus();
  }
  if (std::strcmp(argv[1], "pyenv_version") == 0) {
    auto pyenv_version = PyenvVersion();
    if (pyenv_version.has_value()) {
      std::print("({})", pyenv_version.value());
      return 0;
    }
    return 0;
  }
  if (std::strcmp(argv[1], "venv_version") == 0) {
    auto venv_version = GetVenvVersion();
    if (venv_version.has_value()) {
      std::print(" ({})", venv_version.value());
      return 0;
    }
  }
  return 1;
}
