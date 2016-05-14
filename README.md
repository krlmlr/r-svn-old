# Compiling R from source using sparse SVN checkouts [![Build Status](https://travis-ci.org/krlmlr/r-svn.svg?branch=master)](https://travis-ci.org/krlmlr/r-svn)

Check out R-devel, R 3.2.5 and R 3.3-patched from Subversion:

```
make R-devel R-3-2-5 R-3-3-branch
```

Build these three versions of R (triggered only if the sources have been updated since the last build):

```
make
```

Build everything in parallel with low priority [using all processors](http://stackoverflow.com/a/10945430/946850) (requires `nproc`):

```
nice make -j $(nproc)
```

Update the SVN checkout:

```
make update
```

Compilations are cached using `ccache`, which is required. See [`.travis.yml`](.travis.yml) for other dependencies.

It just works, mostly because the R build system just works.  The [`configure` script](configure) is based on the [R-sig-Debian post](https://stat.ethz.ch/pipermail/r-sig-debian/2012-August/001935.html) by Dirk Eddelbuettel.
