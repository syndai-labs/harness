# alint is a dev dependency pinned in pyproject.toml; uv.lock records the hash
# of every wheel. Set ALINT to use another binary, e.g. `make test ALINT=alint`.
UV ?= uv
ALINT ?= $(UV) run --locked alint

.DEFAULT_GOAL := test
.PHONY: install clean build test dev

# Install alint from uv.lock into .venv/.
install:
	$(UV) sync --locked

# Remove the uv environment.
clean:
	rm -rf .venv

# Check that alint/baseline.yml loads after the bundled rulesets it tightens.
build: install
	$(ALINT) validate-config -c alint/example.yml

# Check this repository.
test: build
	$(ALINT) check

# Apply alint's automatic fixes, then check.
dev: build
	$(ALINT) fix
	$(ALINT) check
