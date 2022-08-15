#!/bin/sh -e
gitroot="$(git -C "$(dirname "$0")" rev-parse --show-toplevel)"
cd "$gitroot"

if [ ! -d .venv ]; then
  python3 -m venv .venv
fi
# shellcheck disable=SC1091
. ./.venv/bin/activate
pip install -qr requirements.txt

wheezy.template "${gitroot}"/templates/buildpkg.yml.wz \
  "$(yaml-get -p . "${gitroot}"/vars.yml)" \
>"${gitroot}"/.github/workflows/buildpkg.yml

printf '%s\n' "Wrote ${gitroot}/.github/workflows/buildpkg.yml"
git status --short "${gitroot}/.github/workflows/buildpkg.yml"
