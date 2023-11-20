import std_module;
import PathTool;
import GitTool;
import PyenvTool;

namespace fs = std::filesystem;

auto main(int argc, char *argv[]) -> int {
  if (argc < 2) {
    std::cerr << "Please pass the argument\n";
  }
  if (std::strcmp(argv[1], "git_branch") == 0) {
    auto git_branch = GitBranch();
    if (git_branch.has_value()) {
      std::print(" ({})", git_branch.value());
      return 0;
    }
    return 0;
  }
  if (std::strcmp(argv[1], "pyenv_version") == 0) {
    auto pyenv_version = PyenvVersion();
    if (pyenv_version.has_value()) {
      std::print(" {}", pyenv_version.value());
      return 0;
    }
    return 0;
  }
  return 1;
}
