SHELL=/bin/bash

export project_root=$(realpath .)
project_name = "demo"
project_version = $(shell cat version.txt)

components = $(addprefix ${project_root}/, \
		cltl-combot \
		cltl-requirements \
		cltl-deme \
		cltl-demo-component)

dependencies = $(addsuffix /makefile.d, $(components))


target ?= install
.DEFAULT_GOAL := build


$(info Run $(target) for $(project_name), version: $(project_version), in $(project_root))


.PHONY: clean
clean:
	$(MAKE) target=clean

.PHONY: install
install:
	$(MAKE) target=install

.PHONY: build
build: $(components)

.PHONY: $(components)
$(components):
	$(MAKE) --directory=$@ $(target)

.PHONY: depend
depend: $(dependencies)

$(dependencies):
	$(MAKE) --directory=$(dir $@) depend

include $(dependencies)
