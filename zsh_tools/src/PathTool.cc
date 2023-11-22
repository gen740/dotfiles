module;

import std_module;

export module PathTool;

namespace fs = std::filesystem;

export auto FindRoot(const std::string &match) -> std::optional<fs::path> {
  auto cwd = fs::current_path();
  try {
    for (int i = 0; i < 10; i++) {
      for (const auto &file : fs::directory_iterator(cwd)) {
        if (file.path().filename() == match) {
          return file.path();
        }
      }
      if (cwd == "/") {
        return std::nullopt;
      }
      cwd = cwd.parent_path();
    }
  } catch (fs::filesystem_error e) {
    // File not found
    return std::nullopt;
  }
  return std::nullopt;
}

export auto GetFileOneLineContent(const fs::path &file_name) -> std::string {
  auto file = std::ifstream(file_name);
  auto content = std::string("");
  std::getline(file, content);
  return content;
}
