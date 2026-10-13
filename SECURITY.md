# Security policy

## Reporting a vulnerability

Report a vulnerability privately through GitHub's private vulnerability reporting on [syndai-labs/harness](https://github.com/syndai-labs/harness/security/advisories/new). If you cannot use GitHub, email [security@syndai.com](mailto:security@syndai.com). Do not open a public issue.

Include the commit of `alint/baseline.yml` you use, what a rule lets through or blocks that it should not, and a minimal repository that shows it.

## Scope

A weakness here is a rule that lets a repository pass while missing what the baseline requires, or a way for the baseline to affect a repository beyond reporting on it. Weaknesses in alint itself go to [asamarts/alint](https://github.com/asamarts/alint/security).

## Supported versions

Only the latest commit on `main` is supported. Repositories pin a commit through the submodule, so a fix reaches them when they move it.
