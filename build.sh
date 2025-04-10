#!/bin/bash
set -e

echo "[Build] Start full build..."
make clean || true
make all
