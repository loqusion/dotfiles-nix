#!/usr/bin/env bash
set -euo pipefail

cd -- "$(dirname "$(realpath "$0")")"

nix flake update
home-manager switch
git commit -v --message "chore: update lockfile" -- ./flake.lock
git push -v
