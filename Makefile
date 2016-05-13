all: R

EXISTING_LINKS := $(wildcard R-*)

all: $(addsuffix /build,$(EXISTING_LINKS))

SVN := svn

-include Makevars

# -- High-level targets -------------------------------------

.PHONY: R-devel update

update cleanup: R
	cd R && $(SVN) $@

R-devel: R/trunk/configure
	rm -f "$@"
	ln -s "$(dir $<)" "$@"

R-%: R/tags/R-%/configure
	rm -f "$@"
	ln -s "$(dir $<)" "$@"

R-%-patched: R/branches/R-%-branch/configure
	rm -f "$@"
	ln -s "$(dir $<)" "$@"


# -- Implementation -----------------------------------------

BOOTSTRAP := $(shell ./bootstrap)

%/configure: %
	cd "$(dir $@)" && \
	$(SVN) update --set-depth=infinity
	touch "$@"

%/Makefile: %/configure
	./configure "$(dir $@)"

%/build: %/Makefile R/.svn/wc.db
	$(MAKE) -C "$(dir $<)"
	touch "$<"

# SVN 1.6 compatibility:
R/.svn/wc.db: R/.svn/all-wcprops
	touch "$<"

.FORCE:

.PRECIOUS: %/configure %/Makefile
