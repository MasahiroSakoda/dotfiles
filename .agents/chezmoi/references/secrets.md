# Secret Management

Chezmoi supports multiple password managers and encryption methods for secrets.

## Age Encryption

To encrypt whole file not part of file, Use `age` which is easy to manage.

### Setup

```bash
# Generate key
mkdir -p ~/.config/chezmoi
chezmoi age-keygen -o ~/.config/chezmoi/key.txt
```

```toml
# In .chezmoi.toml.tmpl
encryption = "age"
[age]
    identity = "~/.config/chezmoi/key.txt"
    recipient = "age1ql3z7hjy54pw3hyww5ayyfg7zqgvc7w3j2elw8zmrj2kg5sfn9aqmcac8p"
```

### Usage

```bash
chezmoi add --encrypt ~/.ssh/id_rsa
chezmoi edit ~/.ssh/id_rsa  # Decrypts automatically
```

Encrypted files get the `encrypted_` prefix in the source state.


## Best Practices

1. **Never commit unencrypted secrets** to version control
2. **Use `private_` prefix** for files containing secrets (sets 0600 permissions)
3. **Prefer password managers** over encrypted files when possible
4. **Store encryption keys securely** outside the repo
5. **Use environment variables** for CI/CD secrets
