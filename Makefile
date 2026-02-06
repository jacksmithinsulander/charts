# Use Homebrew libpq for PostgreSQL headers/libs (macOS)
export CPATH := /opt/homebrew/opt/libpq/include:$(CPATH)
export LIBRARY_PATH := /opt/homebrew/opt/libpq/lib:$(LIBRARY_PATH)

.PHONY: build
build:
	urweb main
