#!/bin/sh
# Builds nstars (only nstars: not sstars, xstars or the tests) into out/.
# The compiler and curses library come from the environment, so one script
# serves every target (see .github/workflows/release.yml):
#
#   asciiverse/build.sh                                          # Linux, macOS
#   LIBS=-lncursesw LDFLAGS="-static -s" asciiverse/build.sh     # Alpine, static
#   CC=x86_64-w64-mingw32-gcc CFLAGS="-O2 -Iasciiverse/win32 -I$PDC" \
#     LIBS="$PDC/wincon/pdcurses.a" LDFLAGS="-static -s" EXE=.exe asciiverse/build.sh
set -eu
cd "$(dirname "$0")/.."
CC="${CC:-cc}"
CFLAGS="${CFLAGS:--O2}"
LDFLAGS="${LDFLAGS:-}"
LIBS="${LIBS:--lncurses}"
EXE="${EXE:-}"
mkdir -p out
$CC -std=gnu99 $CFLAGS -Wall nstars.c starslib.c $LDFLAGS $LIBS -o "out/nstars$EXE"
echo "built nstars$EXE"
