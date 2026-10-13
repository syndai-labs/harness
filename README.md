# harness

Shared repository rules for Syndai Labs, checked by [alint](https://github.com/asamarts/alint).

`alint/baseline.yml` requires every repository to have:

- `.editorconfig`, `.gitattributes` (normalizing line endings), `README.md`, `LICENSE`, `CHANGELOG.md`, and `CHARTER.md` at the root;
- a `SECURITY.md` of at least 200 bytes, at the root, in `.github/`, or in `docs/`;
- a root `Makefile` with `install`, `clean`, `build`, `test`, and `dev` targets;
- `AGENTS.md` that links `CHARTER.md`, and a `CLAUDE.md` that imports it with `@AGENTS.md`;
- `docs/adr/` with `README.md` (the index), `template.md`, and ADR-0001;
- ADRs named `NNNN-kebab-title.md`, opening with `# ADR-NNNN: Title`, `- Status:`, and `- Date:`, with Context, Decision, Consequences, and Alternatives considered sections in that order, each listed in the index;
- final newlines, LF line endings, no trailing whitespace, and space indentation in source and config files.

A root `NOTICE` is optional: alint reports a missing one as `info`, which does not fail the check.

`alint/baseline.yml` extends alint's bundled `oss-baseline`, `tooling/editorconfig`, `compliance/apache-2` (its NOTICE rule only), `docs/adr`, `ci/github-actions`, `agent-context`, and `agent-hygiene` rulesets. It raises the bundled README, LICENSE, SECURITY.md, AGENTS.md, `.editorconfig`, `.gitattributes`, final-newline, trailing-whitespace, ADR filename, and ADR Context and Decision rules to errors and narrows their paths. It turns off `adr-has-status-section`, since a Syndai ADR keeps its status in a `- Status:` line, not a `## Status` section, and keeps the agent-context 10-line floor off `CLAUDE.md`, a one-line `@AGENTS.md` import. The other bundled rules keep their own levels: merge-conflict markers and bidi controls are errors, the GitHub Actions and agent-hygiene checks are warnings, and the Dependabot, CODEOWNERS, code-of-conduct, `.gitignore`, agent-file size, and stale-path nudges are `info`. CHARTER.md, CHANGELOG.md, the Makefile, the CLAUDE.md import, the AGENTS.md link to CHARTER.md, the ADR header, sections, and index, LF line endings, and space indentation have no bundled equivalent.

## Use

Add this repository as a git submodule at `harness/`, which pins it to a commit:

```bash
git submodule add https://github.com/syndai-labs/harness harness
```

Extend the baseline from the repository's `.alint.yml`:

```yaml
version: 1
extends:
  - ./harness/alint/baseline.yml
```

alint refuses `extends:` inside a ruleset fetched over `https://`, so the baseline is read from the submodule, where it can extend the bundled rulesets itself. The baseline ignores `harness/`, so the submodule's own files are not checked as the repository's. CI checks out submodules before running alint, for example with `submodules: true` on `actions/checkout`.

Install alint 0.18.2 or later from PyPI with any of:

```bash
uvx alint check
pipx run alint check
uv tool install alint
pipx install alint
pip install alint
```

An extended ruleset cannot run commands; repository-specific checks that need a script belong in the repository's own `.alint.yml`.

Override a rule by redeclaring its `id` with only the fields that change:

```yaml
rules:
  - id: adr-sections
    paths:
      - "docs/adr/[0-9][0-9][0-9][0-9]-*.md"
      - "!docs/adr/0028-*.md"
```

## Develop

This repository is checked with alint's bundled rulesets (`.alint.yml`), not the baseline it publishes: it keeps no CHARTER.md or ADRs. [AGENTS.md](AGENTS.md) says how to work on it.

This is a Python project only to pin its tools: `pyproject.toml` pins alint as a dev dependency, and `uv.lock` records the hash of every alint wheel. The targets need [uv](https://docs.astral.sh/uv/).

- `make install` installs alint from `uv.lock` into `.venv/`.
- `make build` installs, then checks that `alint/baseline.yml` loads.
- `make test` checks this repository; it is the default target.
- `make dev` applies alint's automatic fixes, then checks.
- `make clean` removes `.venv/`.

Set `ALINT` to use another alint binary, for example `make test ALINT=alint`.

## Change a rule

Edit `alint/baseline.yml`, then run `make test`. Repositories move to the new rules by checking out the new commit in `harness/` and committing the submodule update:

```bash
git -C harness fetch && git -C harness checkout <commit>
git add harness
```
