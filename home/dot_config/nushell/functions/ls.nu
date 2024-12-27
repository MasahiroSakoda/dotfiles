# -*-mode:nu-*- vim:ft=nu

# "ls -s
export def l  [...args: glob] {
    if ($args | is-empty) {
        ls --short-names | select type name size
    } else {
        ls --short-names ...$args | select type name size
    }
}

# "ls-al
export def la [...args: glob] {
    if ($args | is-empty) {
        ls --all --short-names | select type name size modified | table
    } else {
        ls --all --short-names ...$args | select type name size modified | table
    }
}

# "ls-al"
export def ll [...args: glob] {
    if ($args | is-empty) {
        ls --all --long | select type name user group mode size modified | table
    } else {
        ls --all --long ...$args | select type name user group mode size modified | table
    }
}

# ls -alrt
export def lt [...args: glob] {
    if ($args | is-empty) {
        ls --all --long | select type name user group mode size modified | sort-by modified | table
    } else {
        ls --all --long ...$args | select type name user group mode size modified | sort-by modified | table
    }
}