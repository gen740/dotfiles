module;

import std_module;
import PathTool;

export module GitTool;

namespace fs = std::filesystem;

export auto GitBranch() -> std::optional<std::string> {
  const std::regex head_regex("refs/heads/(.+)");
  const std::regex git_dir_regex("gitdir: (.+)");
  std::smatch matches;

  auto root = FindRoot(".git");
  if (!root.has_value()) {
    return std::nullopt;
  }

  if (fs::is_directory(root.value())) {
    auto content = GetFileOneLineContent(root.value() / "HEAD");
    if (std::regex_search(content, matches, head_regex)) {
      return std::format("{}", matches[1].str());
    }
    for (const auto &tag :
         fs::directory_iterator(root.value() / "refs" / "tags")) {
      if (GetFileOneLineContent(tag) == content) {
        return std::format("#{}", tag.path().filename().string());
      }
    }

    return std::format("@{}", content.substr(0, 8));
  }

  auto content = GetFileOneLineContent(root.value());
  if (std::regex_search(content, matches, git_dir_regex)) {
    auto root_dir = root.value().parent_path() / fs::path(matches[1]);
    auto ref_file = root_dir / "HEAD";
    auto content = GetFileOneLineContent(ref_file);

    if (std::regex_search(content, matches, head_regex)) {
      return std::format("{}", matches[1].str());
    }

    for (const auto &tag : fs::directory_iterator(root_dir / "refs" / "tags")) {
      if (GetFileOneLineContent(tag) == content) {
        return std::format("#{}", tag.path().filename().string());
      }
    }

    return std::format("@{}", content.substr(0, 8));
  }

  return std::nullopt;
}
