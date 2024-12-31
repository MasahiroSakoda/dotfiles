# -*-mode:nu-*- vim:ft=nu

export def zld [] {
    zellij --layout default
}

export def zlc [] {
    zellij --layout config
}

export def zlj [] {
    zellij --layout jsdev
}

export def zlm [] {
    zellij --layout monitor
}

export def zls [] {
    zellij attach (zellij list-sessions | fzf --ansi | awk 'print $1')
}

export def zll [] {
    let layout = (fd . $'($env.XDG_CONFIG_HOME)/zellij/layouts' --full-path --min-depth=1 --max-depth=1 --extension kdl | fzf --ansi)
    zellij --layout $layout
}