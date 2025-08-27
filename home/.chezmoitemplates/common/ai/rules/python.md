# Python Rules

- **Runtime Version**: Use `.mise.toml` to manage `python` runtime version locally.
- **Package Manager**: Use [`uv`](https://docs.astral.sh/uv/) as package management instead of old fashioned tools like `poetry`, `pip` or `easy_install`.
  - Project dependencies managed via `pyproject.toml` and `uv.lock` instead of `requirements.txt`
  - Make sure that there is a `pyproject.toml` file in the root directory. If there isn't a `pyproject.toml` file, create one using `uv` by running `uv init`.
- **Virtual Environment**: Use [`uv venv`](https://docs.astral.sh/uv/reference/cli/#uv-venv)
- **Linter & Formatter**: Use [`ruff`](https://docs.astral.sh/ruff/) instead of `black` or `mypy`
- **Testing**: Use [pytest](https://docs.pytest.org/en/stable/)
- **Logging**: Use Python's built-in logging module
- **Import Order**: Group by standard library, third-party, then project-specific with blank lines
- **Coding Style**: Follow [Google Python Style Guide](https://google.github.io/styleguide/pyguide.html)
