#!/bin/sh -e

gitroot="$(git -C "$(dirname "$0")" rev-parse --show-toplevel)"
cd "$gitroot"

if [ ! -d .venv ]; then
  python3 -m venv .venv
fi
# shellcheck disable=SC1091
. ./.venv/bin/activate
pip install -qr requirements.txt

wheezy.template "${gitroot}"/templates/private-build-plans.toml.wz \
  "$(yaml-get -p . "${gitroot}"/vars.yml)" \
>"${gitroot}"/private-build-plans.toml

printf '%s\n' "Wrote ${gitroot}/private-build-plans.toml"
git status --short "${gitroot}/private-build-plans.toml"
