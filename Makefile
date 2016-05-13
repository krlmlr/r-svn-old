all: R

R:
	svn co --depth=immediates https://svn.r-project.org/R
	cd R &&	svn update --set-depth=immediates branches tags

R/%: .FORCE
	cd $@ && \
	svn update --set-depth=infinity && \
	if ! make clean; then true; fi && \
	tools/rsync-recommended && \
	./configure && \
	make && \
	true

.FORCE:
