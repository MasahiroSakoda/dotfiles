function __gh_starred_repository --description "Browse starred repository"
  gh api -X GET /user/starred --paginate --cache 24h | \
    jq -r '["", "", "", "", ""], (.[] | [.full_name, .language // "-", .stargazers_count, .open_issues_count, (.topics[0:3] | join(","))]) | @tsv' | \
      column -t -s (printf '\t') | \
      fzf --ansi --prompt "  " --highlight-line \
        --with-nth=1,2,3,4,5 \
        --preview "gh repo view {1} | bat --color=always --style=plain --language=md" \
        --border --border-label "Browse starred repository" --border-label-pos 0 \
        --header-lines 1 \
        --footer "<c-p>: Toggle Preview, <c-u>: Page Up, <c-d>: Page Down" \
        --bind "ctrl-u:preview-up,ctrl-d:preview-down,ctrl-p:toggle-preview" \
        --bind "ctrl-i:execute-silent:gh issue view https://github.com/{1}/issues" \
        --bind "ctrl-o:execute-silent:gh browse --repo {1}" \
        --exit-0 | awk '{print $1}' | read -l repo
  [ -n "$repo" ]; and echo "$repo"
  commandline -f repaint
end
# -*-mode:fish-*- vim:ft=fish
