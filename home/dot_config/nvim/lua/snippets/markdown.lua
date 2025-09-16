-- -*-mode:lua-*- vim:ft=lua
---@diagnostic disable: unused-local
local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node
local c  = ls.choice_node
-- local d  = ls.dynamic_node
-- local r  = ls.restore_node
-- local f  = ls.function_node
-- local sn = ls.snippet_node
local extras = require("luasnip.extras")
local rep    = extras.rep
-- local m      = extras.m
-- local l      = extras.l
local fmt     = require("luasnip.extras.fmt").fmt
-- local fmta    = require("luasnip.extras.fmt").fmta
-- local postfix = require("luasnip.extras.postfix").postfix
-- local conds   = require("luasnip.extras.conditions")
-- local condse  = require("luasnip.extras.conditions.expand")

-- local util = require("utils.snippet")

local snippets = {
  s({ trig = "README", name = "README.md", dscr = "README.md template" },
    fmt([[
      # {}
      {}

      ## Table of Contents

      - [Features](#features)
      - [Getting Started](#getting-started)
      - [Usage](#usage)
      - [ToDo](#todo)
      - [Contributing](#contributing)
      - [License](#license)

      ## Features

      ## Getting Started

      ## Usage

      ## ToDO
      - [ ] {}
      - [ ] {}
      - [ ] {}

      ## Contributing

      Contributions are welcome!
      Please follow the [contribution guidelines](CONTRIBUTING.md) before making any pull requests.

      ## License

      {} is released under the [MIT license](LICENSE)

    ]], { i(1, "name"), i(2, "shorthand"), i(3, "todo1"), i(4, "todo2"), i(5, "todo3"), rep(1) })
  ),
  s({ trig = "SECURITY", name = "SECURITY.md", dscr = "SECURITY.md template" },
    fmt([[
      # Security Policy

      ## Reporting a Vulnerability

      - If you find vulnerability, please contact with [security issue][new-sec-issue]
      - Do not submit a normal issue or pull request in my public repository.

      ## Contact

      If you have any questions, please reach out directly by [creating an issue][new-issue].
      you can also [report in discussions][new-discussion].

      [new-issue]: https://github.com/{}/issues/new/choose
      [new-sec-issue]: https://github.com/{}/security/advisories/new
      [new-discussion]: https://github.com/{}/discussions
    ]], { i(1, "repo"), rep(1), rep(1) })
  ),
  s({ trig = "CONTRIBUTING", name = "CONTRIBUTING.md", dscr = "CONTRIBUTING.md template" },
    fmt([[
      # Contributing Guidlines

      ## Type of Contributions

      1. **Report Bugs**: [Report Bug](https://github.com/{}/issues)
      2. **Request Features**: [Request Feature](https://github.com/{}/issues)
      3. **Improve Documentation**: Create an issue with the `documentation` label
      4. **Report Security Issues**: [Security](https://github.com/{}/security)

      ## Issues

      ### Find existing issues:

      We welcome you to use the GitHub issue tracker to report bugs or suggest features.

      Before submitting issue, please check [existing issue](https://github.com/{}/issues),
      or [recently closed](https://github.com/{}/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aclosed%20),
      issue to make sure someone else hasn't already.

      ### Opening an issue:

      ## Pull Request

      ### Step 1: Fork this repository

      - Fork this repository by clicking on the fork button at the top of this page.

      ### Step 2: Clone the repository

      - Keep reference to the original project in `upstream` remote.
      ```sh
      git clone forked_repo_url
      cd project_name
      git remote add upstream https://github.com/{}
      ````

      ### Step 2: Create a branch

      ```sh
      git checkout -b branch_name
      ```

      ### Step 3: Commit your changes

      Commit your changes using [Conventiional Commits](https://www.conventionalcommits.org/en/v1.0.0/)

      ### Step 4: Push changes to GitHub

      Push your changes to prepare Pull Request.
      ```sh
      git push origin -u branch_name
      ```

      ### Step 5: Submit your changes for review

      - Go to your repo in browser and click on `Compare and Pull Requests`.
      - Then fill title & description to your PR that explain contribution.
      - Your PR will be reviewed by the moderators and merged.

      ## Licensing
      See the [LICENSE](https://github.com/{}/blob/main/LICENSE) file for this project licensing.
    ]], { i(1, "repo"), rep(1), rep(1), rep(1), rep(1), rep(1), rep(1) })
  ),

  s({ trig = "!badge", name = "README.md badge", dscr = "README.md badge template" },
    fmt([[
      [[![{}](https://img.shields.io/badge/-{}-{}?style={}&logo={}&logoColor={})
    ]], {
      i(1, "alt text"),
      i(2, "Display name"),
      i(3, "The background color for the text, either a hex without `#` or a string"),
      c(4, { t("flat"), t("flat-square"), t("plastic"), t("for-the-badge"), t("soocial") }),
      i(5, "Logo icon from Simple Icons (https://simpleicons.org)"),
      i(6, "RGB / RGBA / HSL / HSLA / Color Name"),

    })
  ),

  -- Prompt engineering
  s({ trig = "ptag", name = "predefined XML tag", dscr = "predefined tag to structurize context" },
    fmt('<{}>\n{}\n</{}>', {
      c(1, { t("thinking"), t("text"), t("instructions"), t("examples"), t("answer"), t("result") }), i(0), rep(1)
    })
  ),
  s({ trig = "ctag", name = "XML tag", dscr = "tag to structurize context" },
    fmt('<{}>{}</{}>', { i(1, "tag"), i(0, "context"), rep(1) })
  ),
}
return snippets
