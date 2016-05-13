all: R/trunk

-include Makefile.all

# -- High-level targets -------------------------------------

.PHONY: R-devel update

update cleanup: R
	cd R && svn $@

R-devel:
	$(MAKE) R/trunk/bin/R
	ln -fs "$$(dirname $$(dirname '$<'))" "$@"

R-%:
	$(MAKE) R/tags/$@/bin/R
	ln -fs "$$(dirname $$(dirname '$<'))" "$@"

R-%-patched:
	$(MAKE) R/branches/$(subst patched,branch,$@)/bin/R
	ln -fs "$$(dirname $$(dirname '$<'))" "$@"


# -- Implementation -----------------------------------------

R:
	svn co --depth=immediates https://svn.r-project.org/R && \
	cd R &&	\
	cd branches && svn update --set-depth=immediates && cd .. && \
	cd tags && svn update --set-depth=immediates && cd .. && \
	true

R/.svn/wc.db: R

R/%/configure: R R/%
	cd "$(dir $@)" && \
	svn update --set-depth=infinity
	touch "$@"

R/%/Makefile: R/%/configure
	./configure "$(dir $@)"

R/%/bin/R: R/%/Makefile R/.svn/wc.db
	$(MAKE) -C "$(dir $<)"

.FORCE:

.PRECIOUS: R/%/configure R/%/Makefile
