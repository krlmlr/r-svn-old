all: R

EXISTING_LINKS := $(wildcard R-*)

all: $(addsuffix /bin/R,$(EXISTING_LINKS))

# -- High-level targets -------------------------------------

.PHONY: R-devel update

update cleanup: R
	cd R && svn $@

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

BOOTSTRAP := $(shell bootstrap)

%/configure:
	cd "$(dir $@)" && \
	svn update --set-depth=infinity
	touch "$@"

%/Makefile: %/configure
	./configure "$(dir $@)"

%/bin/R: %/Makefile R/.svn/wc.db
	$(MAKE) -C "$(dir $<)"

.FORCE:

.PRECIOUS: %/configure %/Makefile
