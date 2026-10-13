# Agent instructions

This repository publishes the alint ruleset Syndai Labs repositories are checked against.

## Repository

- `alint/baseline.yml` is the alint ruleset other repositories extend from `./harness/alint/baseline.yml`.
- `.alint.yml` checks this repository with alint's bundled rulesets, not the baseline: this repository keeps no CHARTER.md or ADRs.

## Commands

- `make install` installs alint from `uv.lock` with uv.
- `make build` installs, then checks that `alint/baseline.yml` loads.
- `make test` checks this repository. Run it before every commit.
- `make dev` applies alint's automatic fixes, then checks.
- `make clean` removes `.venv/`.
- Bump alint by changing its pin in `pyproject.toml` and running `uv lock`; commit both files.

## Changing a rule

- Prefer a bundled alint rule: extend its ruleset in `alint/baseline.yml` and redeclare its id with the fields that change. Write a rule by hand only when no bundled rule covers it, and say why in a comment.
- Write the rule's message as an instruction to the person who sees it.
- Record every change in `CHANGELOG.md`.
- Update `README.md` when the rules it lists change.
