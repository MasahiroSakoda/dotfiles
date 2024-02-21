// -*-mode:javascript-*- vim:ft=javascript
module.exports = {
  type: [
    { value: "feat",     name: "✨ feat:     A new feature" },
    { value: "fix",      name: "🐛 fix:      A bug fix" },
    { value: "docs",     name: "📚 docs:     Documentation only changes" },
    { value: "style",    name: "🎨 style:    Changes that do not affect the meaning of the code\n            (white-space, formatting, missing semi-colons, etc)" },
    { value: "refactor", name: "📦 refactor: A code change that neither fixes a bug nor adds a feature" },
    { value: "perf",     name: "🚀 perf:     A code change that improves performance" },
    { value: "test",     name: "🚨 test:     Adding missing tests" },
    { value: "chore",    name: "chore:    Changes to the build process or auxiliary tools\n            and libraries such as documentation generation" },
    { value: "revert",   name: "🗑 revert:   Revert to a commit" },
    { value: "WIP",      name: "WIP:      Work in progress" },

  ],
  scopes: [
    // Repository
    { name: "ci" },
    { name: "deps" },
    { name: "issue" },
    { name: "pr" },
    { name: "chezmoi" },
    // Security
    { name: "age" },
    { name: "ssh" },
    { name: "gpg" },
    // CLI
    { name: "homebrew" },
    { name: "fish" },
    // Terminal
    { name: "alacritty" },
    { name: "wezterm" },
    // Multi-plexer
    { name: "tmux" },
    { name: "zellij" },
    // Editor/IDE
    { name: "neovim" },
    { name: "vscode" },
    // Runtime
    { name: "mise" },
    { name: "rust" },
    { name: "go" },
    { name: "node" },
    { name: "pnpm" },
    { name: "python" },
    { name: "ruby" },
    // Git
    { name: "git" },
    { name: "gh" },
    { name: "lazygit" },
    { name: "commitizen" },
    { name: "yt-dlp" },
    { name: "newsboat" },
  ],
  usePreparedCommit: false, // to re-use commit from ./.git/COMMIT_EDITMSG
  allowCustomScopes: true,
  allowTicketNumber: true,
  isTicketNumberRequired: false,
  allowBreakingChanges: ["feat", "fix"],
  subjectLimit: 100,
  // skip any questions you want
  skipQuestions: ['scope', 'body'],

  messages: {
    type: "Select the type of change that you're committing: (Use arrow keys)",
    scope: "\nWhat is the scope of this change (e.g. component or file name): (press enter to skip)",
    customScope: "Denote the SCOPE of this change:\n",
    subject: "Write a short, imperative tense description of the change (max 100 chars):\n",
    body: "Provide a longer description of the change: (press enter to skip)\n",
    breaking: "Are there any breaking changes? (y/N)\n",
    footer: "Does this change affect any open issues? (y/N)\n",
    confirmCommit: 'Are you sure you want to proceed with the commit above?',
  }
};
