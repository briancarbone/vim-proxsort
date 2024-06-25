# vim-proxsort

Inspired by [proximity-sort](https://github.com/jonhoo/proximity-sort).

Requires [fzf.vim](https://github.com/junegunn/fzf.vim) and
[fd](https://github.com/sharkdp/fd). Replaces ':Files' with an opinionated
adjustment preferring proximal files and exports a single function, ProxSort,
that takes a reference path and a list of paths in need of sorting.
