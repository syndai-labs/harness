# Agent instructions

This repository publishes the alint ruleset Syndai Labs repositories are checked against.

## Repository

- `alint/baseline.yml` is the alint ruleset other repositories extend by its raw URL, pinned to a commit and its SHA-256. It must not use `extends:`: alint refuses it in a fetched ruleset.
- `alint/example.yml` is the `extends:` block those repositories copy: the bundled rulesets the baseline tightens, then the baseline.
- `.alint.yml` checks this repository with alint's bundled rulesets, not the baseline: this repository keeps no CHARTER.md or ADRs.

## Commands

- `make install` installs alint from `uv.lock` with uv.
- `make build` installs, then checks that `alint/example.yml` loads.
- `make test` checks this repository. Run it before every commit.
- `make dev` applies alint's automatic fixes, then checks.
- `make clean` removes `.venv/`.
- Bump alint by changing its pin in `pyproject.toml` and running `uv lock`; commit both files.

## Changing a rule

- Prefer a bundled alint rule: add its ruleset to `alint/example.yml` (and to the README) and redeclare its id in `alint/baseline.yml` with the fields that change. Write a rule by hand only when no bundled rule covers it, and say why in a comment.
- Write the rule's message as an instruction to the person who sees it.
- Record every change in `CHANGELOG.md`.
- Update `README.md` when the rules it lists change.
