-- -*-mode:lua-*- vim:ft=lua
local ok, feed = pcall(require, "feed")
if not ok then return end

feed.setup({
  ui = {
    order = { "date", "feed", "tags", "title", "reading_time" },
    reading_time = {
      color  = "Comment",
      format = function(id, db) return require("utils.feed").estimate_time(id, db) end,
    },
    tags  = {
      color  = "String",
      format = function(id, db) return require("utils.feed").format_tag(id, db) end,
    },
  },

  feeds = {
    -- Dev
    { "https://zenn.dev/feed",                name = "Zenn  - Trends",  tags = { "dev" } },
    { "https://zenn.dev/topics/neovim/feed",  name = "Zenn  - NeoVim",  tags = { "dev", "neovim" } },
    { "https://qiita.com/popular-items/feed", name = "Qiita - Popular", tags = { "dev" } },
    { "https://qiita.com/tags/neovim/feed",   name = "Qiita - NeoVim",  tags = { "dev", "neovim" } },

    -- Reddit
    { "r/neovim",      name = "Neovim",      tags = { "reddit", "neovim" } },
    { "r/LocalLLaMA",  name = "Local LLM",   tags = { "reddit", "ai", "llama" } },

    { "https://neovim.io/news.xml",         name = "NeoVim News", tags = { "news", "neovim" } },
    { "https://news.ycombinator.com/rss",   name = "Hacker News", tags = { "news", "tech" } },
    { "https://gigazine.net/news/rss_2.0/", name = "GIGAZINE",    tags = { "news", "tech" } },
    { "https://www.gizmodo.jp/index.xml",   name = "Gizmodo",     tags = { "news", "tech" } },
    { "https://www.publickey1.jp/atom.xml", name = "Publickey",   tags = { "news", "tech" } },

    -- Releases via GitHub
    { "ghostty-org/ghostry/releases", name = "Ghostty Releases",   tags = { "release", "terminal" } },
    { "wezterm/wezterm/releases",     name = "WezTerm Releases",   tags = { "release", "terminal" } },
    { "zellij-org/zellij/releases",   name = "Zellij Releases",    tags = { "release", "terminal" }},
    { "twpayne/chezmoi/releases",     name = "chezmoi Releases",   tags = { "release", "dotfiles" } },
    { "saghen/blink.cmp/releases",    name = "blink.cmp Releases", tags = { "release", "neovim" } },
    { "neo451/feed.nvim/releases",    name = "feed.nvim Releases", tags = { "release", "neovim" } },
    { "ollama/ollama/releases",       name = "Ollama Releases",    tags = { "release", "llama" } },

    -- Security
    { "https://github.com/security-advisories",       name = "Security Advisories", tags = { "security", "github" } },
    { "https://www.ipa.go.jp/security/rss/alert.rdf", name = "IPA Security Alert", tags = { "security" }},

    -- Status
    { "https://www.githubstatus.com/history.rss",  name = "GitHub Status",    tags = { "status", "github" } },
    { "https://www.google.com/appsstatus/rss/ja",  name = "Workspace Status", tags = { "status", "google" } },
    { "https://status.slack.com/feed/rss",         name = "Slack Status",     tags = { "status", "slack" } },
    { "https://discordstatus.com/history.atom",    name = "Discord Status",   tags = { "status", "discord" } },
    { "https://status.datadoghq.com/history.atom", name = "Incident History", tags = { "status", "datadog" } },
    { "https://status.huggingface.co/feed",        name = "Incident History", tags = { "status", "huggingface" } },
    { "https://status.openai.com/history.rss",     name = "OpenAI Status",    tags = { "status", "openai" } },
    { "https://status.anthropic.com/history.rss",  name = "Anthropic Status", tags = { "status", "anthropic" } },

    {
      "https://status.cloud.google.com/feed.atom",
      name = "Google Cloud Status",
      tags = { "status", "googlecloud" },
    },
    {
      "https://azurestatuscdn.azureedge.net/ja-jp/status/feed/",
      name = "Azure Status",
      tags = { "status", "azure" },
    },
    {
      "https://www.cloudflarestatus.com/history.atom",
      name = "Cloudflare Status",
      tags = { "status", "cloudflare" },
    },

    { "https://www.vercel-status.com/history.atom",   name = "Vercel Status",   tags = { "status", "vercel" } },
    { "https://status.firebase.google.com/feed.atom", name = "Firebase Status", tags = { "status", "firebase" } },
    { "https://status.supabase.com/history.rss",      name = "Supabase",        tags = { "status", "supabase" } },
  },
})
