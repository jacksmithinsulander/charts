# Use Homebrew libpq for PostgreSQL headers/libs (macOS)
export CPATH := /opt/homebrew/opt/libpq/include:$(CPATH)
export LIBRARY_PATH := /opt/homebrew/opt/libpq/lib:$(LIBRARY_PATH)

.PHONY: build check diagnose
# Full build. If it sits at "Starting especialize1'...." for >20 min, kill it (Ctrl+C)—likely a compiler hang.
build:
	urweb -verbose app

# Type-check only, no C compile (~2s). Use this to verify code without building.
check:
	urweb -tc app

# Stop after corify (before especialize). Finishes in ~5s; confirms the hang is in especialize or later.
# Full IR dump goes to diagnose.log (not the terminal). Exit 0 = front-end OK.
diagnose:
	@urweb -verbose -stop corify app > diagnose.log 2>&1; \
	echo "Diagnose done: compiler stopped after corify. Full output in diagnose.log"; \
	exit 0

