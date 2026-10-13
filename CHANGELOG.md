# Changelog

All notable changes to this repository are recorded here. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

### Added

- Require `CHARTER.md`, a link to it from `AGENTS.md`, `SECURITY.md`, and a `Makefile` with `install`, `clean`, `build`, `test`, and `dev` targets; report a missing `NOTICE` as `info`.
- Extend alint's bundled `oss-baseline`, `tooling/editorconfig`, `compliance/apache-2` (NOTICE only), `docs/adr`, `ci/github-actions`, `agent-context`, and `agent-hygiene` rulesets from the baseline.
- Check this repository with alint's bundled rulesets, with a `Makefile` that runs alint from PyPI, pinned in `pyproject.toml` and hash-locked in `uv.lock`.
- `NOTICE`, `CODE_OF_CONDUCT.md`, `.github/CODEOWNERS`, and a Dependabot configuration that keeps alint up to date.

### Changed

- Repositories extend the baseline from a git submodule at `harness/` instead of a pinned `https://` URL, so the baseline can extend the bundled rulesets itself: alint refuses `extends:` in a fetched ruleset.
- README, LICENSE, `.editorconfig`, `.gitattributes`, AGENTS.md, final-newline, trailing-whitespace, and ADR filename rules are the bundled rules, tightened, instead of hand-written ones.
- Move `baseline.yml` to `alint/baseline.yml`.

## 2026-10-13

### Added

- `baseline.yml`, requiring the root files, agent instructions, and ADR layout every Syndai Labs repository keeps, the ADR file format, and text hygiene.
