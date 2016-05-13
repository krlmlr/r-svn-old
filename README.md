# Compiling R from source using sparse SVN checkouts

Check out R-devel, R 3.2.5 and R 3.3-patched from Subversion:

```
make R-devel R-3-2-5 R-3-3-branch
```

Build everything:

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
