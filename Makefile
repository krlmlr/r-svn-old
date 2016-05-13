all: R/trunk

-include Makefile.all

# -- High-level targets -------------------------------------

.PHONY: R-devel

R-devel:
	$(MAKE) R/trunk/bin/R
	ln -fs "$$(dirname $$(dirname '$<'))" "$@"


# -- Implementation -----------------------------------------

R:
	svn co --depth=immediates https://svn.r-project.org/R && \
	cd R &&	svn update --set-depth=immediates branches tags

R/%/configure: R
	cd "$(dir $@)" && \
	svn update --set-depth=infinity
	touch "$@"

R/%/Makefile: R/%/configure
	./configure "$(dir $@)"

R/%/bin/R: R/%/Makefile R/.svn/wc.db
	$(MAKE) -C "$(dir $<)"

.FORCE:

.PRECIOUS: R/%/configure R/%/Makefile
