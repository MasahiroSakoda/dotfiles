# -*-mode:nu-*- vim:ft=nu

export def openGhqProject [] {
    let repo = (ghq list --full-path | fzf --preview "bat --color=always {}/README.md || echo 'No README.md'" --bind "ctrl-u:preview-up,ctrl-d:preview-down" --exit-0)
    cd $'(ghq root)/$(repo)'
    vim
}