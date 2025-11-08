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
    dev = {
      { "https://neovim.io/news.xml",           name = "NeoVim News",     tags = { "nvim" } },
      { "https://zenn.dev/feed",                name = "Zenn - Trends",   tags = {} },
      { "https://qiita.com/popular-items/feed", name = "Qiita - Popular", tags = {} },
      { "https://vim-jp.org/ekiden/rss.xml",    name = "Vim駅伝",         tags = { "nvim" } },
    },

    reddit = {
      { "r/neovim",     name = "Neovim",     tags = { "nvim" } },
      { "r/LocalLLaMA", name = "LocalLLaMA", tags = { "ai" } },
    },

    tech = {
      { "https://gigazine.net/news/rss_2.0/", name = "GIGAZINE",    tags = {} },
      { "https://www.gizmodo.jp/index.xml",   name = "Gizmodo",     tags = {} },
      { "https://www.publickey1.jp/atom.xml", name = "Publickey",   tags = {} },
    },

    security = {
      { "https://github.com/security-advisories",       name = "Security Advisories", tags = { "github" } },
      { "https://www.ipa.go.jp/security/rss/alert.rdf", name = "IPA Security Alert",  tags = {} },
    },

    status = {
      { "https://www.githubstatus.com/history.rss",  name = "GitHub Status",    tags = { "github" } },
      { "https://www.google.com/appsstatus/rss/ja",  name = "Workspace Status", tags = { "google" } },
      { "https://status.slack.com/feed/rss",         name = "Slack Status",     tags = { "slack" } },
      { "https://discordstatus.com/history.atom",    name = "Discord Status",   tags = { "discord" } },
      { "https://status.datadoghq.com/history.atom", name = "Datadog Status",   tags = { "datadog" } },
      { "https://status.huggingface.co/feed",        name = "hf Status",        tags = { "ai" } },
      { "https://status.openai.com/history.rss",     name = "OpenAI Status",    tags = { "ai" } },
      { "https://status.anthropic.com/history.rss",  name = "Anthropic Status", tags = { "ai" } },

      { "https://status.cloud.google.com/feed.atom",         name = "Google Cloud Status", tags = { "gcloud" } },
      { "https://azurestatuscdn.azureedge.net/status/feed/", name = "Azure Status",        tags = { "azure" } },
      { "https://www.cloudflarestatus.com/history.atom",     name = "Cloudflare Status",   tags = { "cloudflare" } },

      { "https://www.vercel-status.com/history.atom", name = "Vercel Status", tags = { "vercel" } },
      { "https://status.supabase.com/history.rss",    name = "Supabase",      tags = { "supabase" } },
    },
  },
})
