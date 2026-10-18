# nstars (Asciiverse packaging)

Philip J Freeman's stars repository; we build and ship only nstars, the
ncurses starfield with an IRC-style command line (C); GPL-3.0-or-later;
packaged for the Asciiverse catalog as a demo (kind `art`). Not our code:
keep changes small, list every one in PATCHES.md, and offer fixes
upstream.

- Remotes: `upstream` is github.com/ph1l/stars (branch `master`, quiet
  since 2020), `origin` is github.com/theasciiverse/nstars.
- Branch `asciiverse` = upstream master plus our commits.
- Release: tag `v<version>-av.<n>` (now `v2020.05.12-av.1`) and push only
  that tag; the workflow runs on `*-av.*` tags.
- av starts it as `nstars -c 256`.
- Build: `asciiverse/build.sh` (nstars only; upstream's Makefile builds
  the SDL and X11 versions too). Static, in a copy of the tree: `docker run
  --rm --cpus 4 --memory 8g -v "$PWD":/src -w /src alpine:3.22 sh -c 'apk
  add build-base ncurses-dev ncurses-static && LIBS=-lncursesw
  LDFLAGS="-static -s" asciiverse/build.sh'`.
- Preview: `asciiverse/record-preview.sh out/nstars raw.cast`, then
  `asciiverse/cast-cap-fps.py raw.cast asciiverse/nstars.cast 30` (pyte).
