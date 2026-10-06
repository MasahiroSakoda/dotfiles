# Tests: bats-core test suite

Tests are written with [bats-core](https://github.com/bats-core/bats-core) (Bash Automated Testing System).

## Running Tests

Run tests automatically before committing using `lefthook`'s pre-commit

## Directory Structure

```text
tests/
├── helpers/
│   ├── chezmoi_helper.sh  # chezmoi related helper (validate attributes, etc...)
│   ├── test_helper.sh     # common setup
│   ├── validate_json.sh   # JSON validator
│   ├── validate_shell.sh  # Shell validator
│   ├── validate_toml.sh   # TOML validator
│   └── validate_yaml.sh   # YAML validator
├── install/
│   ├── common/            # Test for cross-platform environment
│   ├── darwin/            # Test for macOS environment
│   └── linux/             # Test for Linux environment
└── AGENTS.md              # This file
```

## Test Strategy

- Check the existence of a directories / files
- Verify that the template is rendered correctly
- Verify the file / directory attributes (`private_`, `readonly_`, `executable_`, `symlink_` , etc...)
- Leave the lint and formatting to `lefthook`
