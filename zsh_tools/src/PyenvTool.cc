module;

export module PyenvTool;

import std_module;
import PathTool;

namespace fs = std::filesystem;

auto SearchPythonVersion(const fs::path &pyenv_root, const std::string &name)
    -> std::optional<std::string> {
  auto versions_file = pyenv_root / "versions";
  try {
    for (const auto &version : fs::directory_iterator(versions_file)) {
      if (version.path().filename() == name) {
        if (fs::is_symlink(version)) {
          return fs::read_symlink(version)
              .parent_path()
              .parent_path()
              .filename();
        }
      }
    }
  } catch (fs::filesystem_error e) {
    // File not found
    return std::nullopt;
  }
  return std::nullopt;
}

export auto PyenvVersion() -> std::optional<std::string> {
  auto pyenv_root = fs::path(std::getenv("PYENV_ROOT"));
  {
    auto *pyenv_version = std::getenv("PYENV_VERSION");
    if (pyenv_version != nullptr && std::strcmp(pyenv_version, "") != 0) {
      return std::format(
          "{} {}", std::string(pyenv_version),
          SearchPythonVersion(pyenv_root, pyenv_version).value_or(""));
    }
  }

  auto root = FindRoot(".python-version");
  if (!root.has_value()) {
    auto version_name = GetFileOneLineContent(pyenv_root / "version");
    return std::format(
        "{} {}", version_name,
        SearchPythonVersion(pyenv_root, version_name).value_or(""));
  }
  auto version_name = GetFileOneLineContent(root.value());
  return std::format(
      "{} {}", version_name,
      SearchPythonVersion(pyenv_root, version_name).value_or(""));
}
