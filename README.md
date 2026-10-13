# harness

Shared repository rules for Syndai Labs, checked by [alint](https://github.com/asamarts/alint).

`baseline.yml` requires every repository to have:

- `.editorconfig`, `.gitattributes` (normalizing line endings), `README.md`, `LICENSE`, and `CHANGELOG.md` at the root;
- `AGENTS.md`, and a `CLAUDE.md` that imports it with `@AGENTS.md`;
- `docs/adr/` with `README.md` (the index), `template.md`, and ADR-0001;
- ADRs named `NNNN-kebab-title.md`, opening with `# ADR-NNNN: Title`, `- Status:`, and `- Date:`, with Context, Decision, Consequences, and Alternatives considered sections in that order, each listed in the index;
- final newlines, LF line endings, no trailing whitespace, and space indentation in source and config files.

## Use

Extend the baseline from the repository's `.alint.yml`, pinned to a commit of this repository and to the SHA-256 of the file:

```yaml
version: 1
extends:
  - https://raw.githubusercontent.com/syndai-labs/harness/<commit>/baseline.yml#sha256-<hex>
```

Compute the hash of the pinned file:

```bash
curl -fsSL https://raw.githubusercontent.com/syndai-labs/harness/<commit>/baseline.yml | shasum -a 256
```

alint refuses an `https://` ruleset without the hash, or one whose bytes do not match it. A fetched ruleset cannot run commands; repository-specific checks that need a script belong in the repository's own `.alint.yml`.

Override a rule by redeclaring its `id` with only the fields that change:

```yaml
rules:
  - id: adr-sections
    paths: ["docs/adr/[0-9][0-9][0-9][0-9]-*.md", "!docs/adr/0028-*.md"]
```

## Change a rule

Edit `baseline.yml`, then check it loads with `alint validate-config -c baseline.yml`. Repositories move to the new rules by updating the commit and hash in their `extends:` entry.
