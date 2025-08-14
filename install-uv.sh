#!/bin/bash

set -euxo pipefail

UV_PKG=$(readlink -f ~/.cache/uv.tar.gz)
curl -fSL# -z "$UV_PKG" -o "$UV_PKG" https://github.com/astral-sh/uv/releases/download/0.8.10/uv-x86_64-unknown-linux-gnu.tar.gz
tar -C ~/.local/bin -xzf "$UV_PKG" --strip-components=1 
