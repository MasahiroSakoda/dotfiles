-- -*-mode:lua-*- vim:ft=lua
local ls = require("luasnip")
---@diagnostic disable-next-line: unused-local
local s, t, i, c, r, f, sn =
  ls.snippet,ls.text_node, ls.insert_node, ls.choice_node, ls.restore_node, ls.function_node, ls.snippet_node
---@diagnostic disable-next-line: unused-local
local fmt, fmta = require("luasnip.extras.fmt").fmt, require("luasnip.extras.fmt").fmta
---@diagnostic disable-next-line: unused-local
local conds, condse = require("luasnip.extras.conditions"), require("luasnip.extras.conditions.expand")
---@diagnostic disable-next-line: unused-local
local rep = require("luasnip.extras").rep

local snippets = {
  s("readme", fmt([[
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
      Contributions are welcome! Please follow the [contribution guidelines](CONTRIBUTING.md) before making any pull requests.

      ## License
      {} is released under the [MIT license](LICENSE)

    ]], { i(1, "name"), i(2, "shorthand"), i(3, "todo1"), i(4, "todo2"), i(5, "todo3"), rep(1) })
  ),
  s("security", fmt([[
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
  s("contributing", fmt([[
      # Contributing Guidlines

      ## Type of Contributions
      1. **Report Bugs**: [Report Bug](https://github.com/{}/issues)
      2. **Request Features**: [Request Feature](https://github.com/{}/issues)
      3. **Improve Documentation**: Create an issue with the `documentation` label
      6. **Report Security Issues**: [Security](https://github.com/{}/security)

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

  s("osbadge", fmt([[
      ![{}](https://img.shields.io/badge/{}%20-yellow.svg?style=flat-square&logo={}&logoColor=black)
    ]], { i(1, "os"), rep(1), rep(1) })
  ),

  s("sh",   fmt('```sh\n{}\n```{}',         { i(1, "code"), i(0, "") })),
  s("bash", fmt('```bash\n{}\n```{}',       { i(1, "code"), i(0, "") })),
  s("py",   fmt('```python\n{}\n```{}',     { i(1, "code"), i(0, "") })),
  s("rb",   fmt('```ruby\n{}\n```{}',       { i(1, "code"), i(0, "") })),
  s("lua",  fmt('```lua\n{}\n```{}',        { i(1, "code"), i(0, "") })),
  s("js",   fmt('```javascript\n{}\n```{}', { i(1, "code"), i(0, "") })),
  s("ts",   fmt('```typescript\n{}\n```{}', { i(1, "code"), i(0, "") })),
  s("cpp",  fmt('```c++\n{}\n```{}',        { i(1, "code"), i(0, "") })),
  s("rs",   fmt('```rust\n{}\n```{}',       { i(1, "code"), i(0, "") })),
  s("go",   fmt('```go\n{}\n```{}',         { i(1, "code"), i(0, "") })),
}
return snippets
