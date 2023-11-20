module;

import std_module;
import PathTool;

export module GitTool;

namespace fs = std::filesystem;

export enum class GitHeadKind : int { Tag, Branch, Hash, None, Invalid };

export struct GitHead {
  std::string name;
  GitHeadKind kind;
};

/*!
 * Determine GihHead Type according to content of HEAD file
 *
 *   - Branch
 *   - Tag
 *   - Hash
 *
 * @return GitHead
 */
auto DetermineGitHead(const fs::path &git_dir, const std::string &content)
    -> GitHead {
  const std::regex head_regex("refs/heads/(.+)");
  std::smatch matches;

  if (std::regex_search(content, matches, head_regex)) {
    return {.name = std::format("{}", matches[1].str()),
            .kind = GitHeadKind::Branch};
  }
  for (const auto &tag : fs::directory_iterator(git_dir / "refs" / "tags")) {
    if (GetFileOneLineContent(tag) == content) {
      return {.name = std::format("{}", tag.path().filename().string()),
              .kind = GitHeadKind::Tag};
    }
  }
  return {.name = std::format("{}", content.substr(0, 8)),
          .kind = GitHeadKind::Hash};
}

/*!
 *  Get the git branch
 *
 *  @return GitHead
 */
export auto GitBranch() -> GitHead {
  const auto dot_git = FindRoot(".git");

  // Not inside the git repository
  if (!dot_git.has_value()) {
    return {.name = "", .kind = GitHeadKind::None};
  }

  // if .git is directory
  if (fs::is_directory(dot_git.value())) {
    auto content = GetFileOneLineContent(dot_git.value() / "HEAD");
    return DetermineGitHead(dot_git.value(), content);
  }

  auto content = GetFileOneLineContent(dot_git.value());
  const std::regex git_dir_regex("gitdir: (.+)");
  std::smatch matches;

  // if .git is `gitdir: path/to/dir`
  if (std::regex_search(content, matches, git_dir_regex)) {
    const auto git_dir = dot_git.value().parent_path() / fs::path(matches[1]);
    auto content = GetFileOneLineContent(git_dir / "HEAD");
    return DetermineGitHead(git_dir, content);
  }

  // Invalid .git
  return {.name = "", .kind = GitHeadKind::Invalid};
}

export auto GitBranchZshStatus() -> int {
  auto git_branch = GitBranch();
  switch (git_branch.kind) {
  case GitHeadKind::Branch:
    std::print(" ({})", git_branch.name);
    return 0;
  case GitHeadKind::Tag:
    std::print(" (#{})", git_branch.name);
    return 0;
  case GitHeadKind::Hash:
    std::print(" (@{})", git_branch.name);
    return 0;
  case GitHeadKind::None:
    return 0;
  case GitHeadKind::Invalid:
    std::print(" invalid");
    return 0;
  }
}

export auto GitBranchNvimStatus() -> int {
  auto git_branch = GitBranch();
  switch (git_branch.kind) {
  case GitHeadKind::Branch:
    std::print(" {}", git_branch.name);
    return 0;
  case GitHeadKind::Tag:
    std::print("#{}", git_branch.name);
    return 0;
  case GitHeadKind::Hash:
    std::print("@{}", git_branch.name);
    return 0;
  case GitHeadKind::None:
    return 0;
  case GitHeadKind::Invalid:
    std::print("invalid");
    return 0;
  }
}
