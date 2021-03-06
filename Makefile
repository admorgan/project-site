export PROJECT_SITE_ROOT := $(shell pwd)
INPUT_DIR := share/src

include $(PROJECT_SITE_ROOT)/share/.vars.mk

HOME_FILE := www/src/index.md

include $(PROJECT_SITE_ROOT)/share/.rules.mk

builder-build:
	make -C builder/$(PROJECT_SITE_BUILDER) build

www:
	$(call add-branch-dir,$@)
	( \
	    temp=$$(mktemp); \
	    ( \
		grep -B999 '\---' "$(HOME_FILE)"; \
		cat ReadMe.md; \
	    ) > "$$temp"; \
	    mv "$$temp" "$(HOME_FILE)" \
	)

clean::
	rm -fr base-* www
