all: R

EXISTING_LINKS := $(wildcard R-*)

all: $(addsuffix /build,$(EXISTING_LINKS))

SVN := svn

-include Makevars

# -- High-level targets -------------------------------------

.PHONY: R-devel update

update cleanup: R
	cd R && $(SVN) $@

R-devel: R/trunk
	rm -f "$@"
	ln -s "$<" "$@"

R-%: R/tags/R-%
	rm -f "$@"
	ln -s "$<" "$@"

R-%-patched: R/branches/R-%-branch
	rm -f "$@"
	ln -s "$<" "$@"


# -- Implementation -----------------------------------------

BOOTSTRAP := $(shell ./bootstrap)

%/configure:
	cd "$(dir $@)" && \
	$(SVN) update --set-depth=infinity
	touch "$@"

%/Makefile: %/configure
	./configure "$(dir $@)"

%/build: %/Makefile R/.svn/wc.db
	$(MAKE) -C "$(dir $<)"
	touch "$@"

# SVN 1.6 compatibility:
%/build: %/Makefile R/.svn/all-wcprops
	$(MAKE) -C "$(dir $<)"
	touch "$@"

.FORCE:

.PRECIOUS: %/configure %/Makefile
