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

`alint/baseline.yml` tightens alint's bundled `oss-baseline`, `tooling/editorconfig`, `compliance/apache-2` (its NOTICE rule only), `docs/adr`, `ci/github-actions`, `agent-context`, and `agent-hygiene` rulesets. It raises the bundled README, LICENSE, SECURITY.md, AGENTS.md, `.editorconfig`, `.gitattributes`, final-newline, trailing-whitespace, ADR filename, and ADR Context and Decision rules to errors and narrows their paths. It turns off `adr-has-status-section`, since a Syndai ADR keeps its status in a `- Status:` line, not a `## Status` section, and keeps the agent-context 10-line floor off `CLAUDE.md`, a one-line `@AGENTS.md` import. The other bundled rules keep their own levels: merge-conflict markers and bidi controls are errors, the GitHub Actions and agent-hygiene checks are warnings, and the Dependabot, CODEOWNERS, code-of-conduct, `.gitignore`, agent-file size, and stale-path nudges are `info`. CHARTER.md, CHANGELOG.md, the Makefile, the CLAUDE.md import, the AGENTS.md link to CHARTER.md, the ADR header, sections, and index, LF line endings, and space indentation have no bundled equivalent.

## Use

Extend the baseline from the repository's `.alint.yml` by its raw URL, pinned to a commit and to the file's SHA-256, after the bundled rulesets it tightens. Copy the block from [alint/example.yml](alint/example.yml):

```yaml
version: 1
extends:
  - alint://bundled/oss-baseline@v1
  - alint://bundled/tooling/editorconfig@v1
  - url: alint://bundled/compliance/apache-2@v1
    only:
      - apache-2-notice-file-exists
  - alint://bundled/docs/adr@v1
  - alint://bundled/ci/github-actions@v1
  - alint://bundled/agent-context@v1
  - alint://bundled/agent-hygiene@v1
  - https://raw.githubusercontent.com/syndai-labs/harness/<commit>/alint/baseline.yml#sha256-<hex>
```

Get the digest with:

```bash
curl -fsSL https://raw.githubusercontent.com/syndai-labs/harness/<commit>/alint/baseline.yml | shasum -a 256
```

alint caches the file by its digest and refuses it if the bytes differ. It also refuses `extends:` inside a ruleset fetched over `https://`, so the baseline extends nothing and each repository lists the bundled rulesets itself; they must come before the baseline, whose rules redeclare some of their ids.

Install alint 0.18.2 or later with cargo-binstall, which downloads the release binary, or from PyPI:

```bash
cargo binstall alint
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

Edit `alint/baseline.yml`, then run `make test`. If the change extends another bundled ruleset, add it to `alint/example.yml` and to the block above. Repositories move to the new rules by updating the commit and the digest in their URL, and any bundled rulesets the change added.
