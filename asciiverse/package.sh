#!/bin/sh
# Packs the build into dist/nstars-<target>.tar.gz (.zip for Windows) for
# av: the binary at the top beside README, COPYING and PATCHES.md.
#
#   asciiverse/package.sh x86_64-unknown-linux-musl
set -eu
cd "$(dirname "$0")/.."
target="$1"
case "$target" in *windows*) exe=.exe ;; *) exe= ;; esac
stage=stage/nstars
rm -rf "$stage" && mkdir -p "$stage" dist
cp "out/nstars$exe" README.md COPYING PATCHES.md "$stage/"
if [ -n "$exe" ]; then
  (cd "$stage" && zip -qr "../../dist/nstars-$target.zip" .)
else
  tar -czf "dist/nstars-$target.tar.gz" -C "$stage" .
fi
ls dist
