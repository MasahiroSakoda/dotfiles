-- -*-mode:lua-*- vim:ft=lua
local ok, feed = pcall(require, "feed")
if not ok then return end

local util = require("utils.feed")

feed.setup({
  ui = {
    order = { "date", "feed", "tags", "title", "reading_time" },
    reading_time = {
      color  = "Comment",
      format = function(id, db) return util.estimate_time(id, db) end,
    },
    tags  = {
      color  = "String",
      format = function(id, db) return util.format_tag(id, db) end,
    },
  },

  search = {
    default_query = "@2-weeks-ago +unread ",
    backend       = "snacks.pick",
    sort_order    = "descending",
  },

  keys = {
    index = {
      -- { "q",      "<cmd>Feed quit<cr>" },
      -- { "?",      "<cmd>Feed hints<cr>" },
      -- { ".",      "<cmd>Feed dot<cr>" },
      -- { "u",      "<cmd>Feed undo<cr>" },
      -- { "<C-r>",  "<cmd>Feed redo<cr>" },
      -- { "<M-CR>", "<cmd>Feed split<cr>" },
      -- { "b",      "<cmd>Feed browser<cr>" },
      -- { "r",      "<cmd>Feed refresh<cr>" },
      -- { "R",      "<cmd>Feed update<cr>" },
      -- { "/",      "<cmd>Feed search<cr>" },
      -- { "Y",      "<cmd>Feed yank_url<cr>" },
      -- { "-",      "<cmd>Feed untag<cr>" },
      -- { "+",      "<cmd>Feed tag<cr>" },
      -- { "<cr>",   "<cmd>Feed entry<cr>" },

      { "p",      util.play_podcast },
      { "@",      util.show_in_w3m },
      { "<C-CR>", util.show_in_glow },
    },
    entry = {
      -- { "q", "<cmd>Feed quit<cr>" },
      -- { "?", "<cmd>Feed hints<cr>" },
      -- { "Y", "<cmd>Feed yank_url<cr>" },
      -- { "b", "<cmd>Feed browser<cr>" },
      -- { "}", "<cmd>Feed next<cr>" },
      -- { "{", "<cmd>Feed prev<cr>" },
      -- { "/", "<cmd>Feed search<cr>" },
      -- { "-", "<cmd>Feed untag<cr>" },
      -- { "+", "<cmd>Feed tag<cr>" },
      -- { "f", "<cmd>Feed full<cr>" },
      -- { "r", "<cmd>Feed urlview<cr>" },
    },
  },

  date = { locale = "ja_JP.utf8" },
  zen  = { enabled = true, width = 90 },

  feeds = {
    dev = {
      -- { "https://neovim.io/news.xml",           name = "NeoVim News",     tags = { "nvim" } },
      { "https://feeds.feedburner.com/TheHackersNews", name = "The Hackers News", tags = { "dev" } },
      { "https://cyberpress.org/feed/",                name = "Cyper Press",      tags = { "Security" } },
      { "https://zenn.dev/feed",                       name = "Zenn - Trends",    tags = { "dev" } },
      { "https://qiita.com/popular-items/feed",        name = "Qiita - Popular",  tags = { "dev" } },
      { "https://vim-jp.org/ekiden/rss.xml",           name = "Vim駅伝",          tags = { "nvim" } },
    },

    reddit = {
      { "r/neovim",     name = "Neovim",     tags = { "nvim" } },
      -- { "r/LocalLLaMA", name = "LocalLLaMA", tags = { "ai" } },
      { "r/opencodCLI", name = "OpenCode",   tags = { "ai" } },
      { "r/GeminiCLI",  name = "Gemini CLI", tags = { "ai" } },
    },

    tech = {
      { "https://gigazine.net/news/rss_2.0/", name = "GIGAZINE",    tags = { "tech" } },
      { "https://www.gizmodo.jp/index.xml",   name = "Gizmodo",     tags = { "tech" } },
      { "https://www.publickey1.jp/atom.xml", name = "Publickey",   tags = { "tech" } },
    },

    security = {
      { "https://github.com/security-advisories",       name = "The GitHub Blog: Security", tags = { "security" } },
      { "https://blog.cloudflare.com/tag/security/rss", name = "Cloudflare Blog: Security", tags = { "security" } },
      { "https://www.stepsecurity.io/blog/rss.xml",     name = "Step Security Blog",        tags = { "security" } },
      { "https://jp.aikido.dev/blog/rss.xml",           name = "Aikido Security",           tags = { "security" } },
      { "https://socket.dev/api/blog/feed.atom",        name = "Socket",                    tags = { "security" } },
      { "https://blog.flatt.tech/rss",                  name = "GMO Flatt Security Blog",   tags = { "security" } },
      { "https://www.ipa.go.jp/security/rss/alert.rdf", name = "IPA Security Alert",        tags = { "security" } },
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
