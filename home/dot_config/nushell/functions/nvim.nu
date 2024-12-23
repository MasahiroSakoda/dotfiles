# -*-mode:nu-*- vim:ft=nu

export def openNvimPlugin [] -> string {
    let repo = (fd . ($env.XDG_DATA_HOME | path join "nvim" "lazy") |
                fzf --preview "bat --color=always {}/README.md || echo 'No README.md'"
                    --bind "ctrl-u:preview-up,ctrl-d:preview-down" --exit-0)
    cd $'(ghq root)/$(repo)'
    vim
}