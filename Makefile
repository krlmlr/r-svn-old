all: R

R:
	svn co --depth=immediates https://svn.r-project.org/R
	cd R &&	svn update --set-depth=immediates branches tags

R/branches/% R/tags/% R/trunk:
	cd @ && \
	svn update --set-depth=infinity && \
	{ make clean || true } && \
	./configure && \
	tools/rsync-recommended && \
	make && \
	true
