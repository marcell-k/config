function pynew --description "Create a new uv package project with my ruff/ty defaults"
    if test (count $argv) -ne 1
        echo "usage: pynew <project-name>"
        return 1
    end

    set name $argv[1]
    set pkg (string replace -a -- - _ (string lower $name))

    uv init --package --python 3.15 $name
    and cd $name
    and uv add --dev pytest ruff ty
    and mkdir -p tests
    and touch tests/__init__.py
    and printf '' > src/$pkg/__init__.py
    and printf '%s\n' \
        '"""Application entry point."""' \
        '' \
        '' \
        'def main() -> None:' \
        '    """Run the application."""' \
        '    print("Hello from '$name'!")  # noqa: T201' \
        '' \
        '' \
        'if __name__ == "__main__":' \
        '    main()' > src/$pkg/main.py
    and string replace -- "$pkg:main\"" "$pkg.main:main\"" < pyproject.toml > pyproject.toml.tmp
    and mv pyproject.toml.tmp pyproject.toml
    and printf '%s\n' \
        '' \
        '[tool.ruff]' \
        'line-length = 100' \
        '' \
        '[tool.ruff.lint]' \
        'select = ["ALL"]' \
        'ignore = [' \
        '  "CPY001",' \
        '  "COM812",' \
        '  "D104",' \
        '  "D105",' \
        '  "D107",' \
        '  "D203",' \
        '  "D213",' \
        '  "FIX002",' \
        '  "S311",' \
        '  "TD002",' \
        '  "TD003",' \
        ']' \
        '' \
        '[tool.ruff.lint.per-file-ignores]' \
        '"tests/**/*.py" = ["ERA001", "D100", "D103", "S101"]' \
        '' \
        '[tool.ty.environment]' \
        'python-version = "3.15"' \
        '' \
        '[tool.ty.src]' \
        'include = ["src", "tests"]' >> pyproject.toml
    and uv sync
    and uv run ruff format
end
