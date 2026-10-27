# Changes from upstream

This is the Asciiverse packaging of nstars, the ncurses front end of
[stars](https://github.com/ph1l/stars) by Philip J Freeman: a flight
through a starfield, with an IRC-style command line at the bottom (C,
ncurses). Only nstars is built and shipped; sstars (SDL), xstars (X11) and
the CUnit tests stay in the tree, untouched. Upstream is the `upstream`
remote; the `asciiverse` branch carries the changes below.

Built from upstream `master` at `def7514` (2020-05-12), its last commit.
Upstream has no tags or versions, so the version here is 2020.05.12.

## Licence

GPL-3.0-or-later: `nstars.c` and `starslib.c` (the two files nstars is
built from) say "either version 3 of the License, or (at your option) any
later version", and COPYING is the GPL version 3 text (checked
2026-10-18).

## Code

- **starslib: no read after free.** `kill_point()` freed the star it was
  looking for and then read that star's `next` pointer to carry on the
  loop. It happened for every star that left the screen;
  AddressSanitizer stopped nstars on the first one. It now stops at the
  star it freed. Worth offering upstream.
- **Quitting without typing `/quit`.** Upstream quit only on `/quit` and
  Enter, and `raw()` turned Ctrl+C into a character in the command line.
  Now, while the command line is empty, any key quits except `/` (which
  starts a command) and Up and Down (the command history); Ctrl+C and Esc
  quit at any time. The status line says "/ for a command, any other key
  quits". `/quit`, `/sleep`, `/char` and `/colormode` work as before.
- **Resizing.** The windows and the sky were sized once at the start; on
  `KEY_RESIZE` they take the new size. A terminal under three lines gave
  the sky zero lines and a division by zero in `new_point()`; the sky is
  now at least one line high.

## Packaging

- `asciiverse/build.sh` and `asciiverse/package.sh` build and pack nstars
  for one target; the compiler and curses library come from the
  environment.
- `asciiverse/win32/ncurses.h`, Windows builds only: includes PDCurses'
  `<curses.h>` under the name nstars asks for, and supplies `strndup()`,
  which MinGW's C library lacks.
- `.github/workflows/release.yml`: av archives for Linux (static musl,
  x86-64 and ARM64), macOS (x86-64 and ARM64, system ncurses) and Windows
  (x86-64, MinGW and wide PDCurses 3.9), plus SHA256SUMS. Runs on our tags
  only (`*-av.*`).
- `asciiverse/record-preview.sh` records the catalog preview: 20 seconds
  of `nstars -c 256` at 100x30, ended by SIGTERM. nstars redraws a few
  hundred times a second (15 MB raw), so `asciiverse/cast-cap-fps.py`
  (from the tarts packaging, needs pyte) re-encodes it at 30 fps as
  `asciiverse/nstars.cast`.

av starts it as `nstars -c 256`: stars brighten from dark grey to white as
they come near.

## Checked

- Linux, native (glibc) and static (Alpine 3.22) builds, in tmux at
  100x30: q, x, Space, Esc and Ctrl+C quit with status 0 and the terminal
  settings put back, `/sleep 20000` then `/quit` work, SIGTERM quits
  through curses; TERM xterm-256color, screen and linux all draw; an ASan
  and UBSan build resized to 80x24, 40x12, 10x5, 3x3, 2x2, 1x1, 100x30 and
  31x8 runs clean (only the universe left unfreed at exit, as upstream).
- Windows: cross-built with MinGW against PDCurses 3.9 (wincon, wide) and
  run under Wine, mono and `-c 256`: stars drawn, q quits with status 0.
  Resizing there is unchecked.
- macOS: not built here.

## Ours

- **How to play it, at the top of README.md.** A short note on installing and
  starting it with av, or from a release archive; the original text follows
  unchanged.
