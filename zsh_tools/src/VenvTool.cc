module;

import std_module;

export module VenvTool;

namespace fs = std::filesystem;

export auto GetVenvVersion() -> std::optional<std::string> {
  auto venv_root = fs::path(std::getenv("VIRTUAL_ENV"));
  auto pyvenv_cfg = venv_root / "pyvenv.cfg";
  if (fs::exists(pyvenv_cfg)) {
    auto file = std::ifstream(pyvenv_cfg);
    std::string line;
    while (std::getline(file, line)) {
      if (line.find("version_info") != std::string::npos) {
        return line.substr(15);
      }
    }
  }
  return std::nullopt;
}
