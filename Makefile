all: R/trunk

-include Makefile.all

R:
	svn co --depth=immediates https://svn.r-project.org/R

R/trunk: R
	cd R &&	svn update --set-depth=immediates branches tags

R/%/configure: R
	cd "$(dir $@)" && \
	svn update --set-depth=infinity
	touch "$@"

R/%/Makefile: R/%/configure
	./configure "$(dir $@)"

R/%/bin/R: R/%/Makefile R/.svn/wc.db
	make -C "$(dir $<)"

.FORCE:

.PRECIOUS: R/%/configure R/%/Makefile
