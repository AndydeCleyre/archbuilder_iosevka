#!/bin/sh -e

if [ "$1" ]; then
  printf '%s\n' 'Upgrade what we can in our *requirements.txt files' 'Args: None' 1>&2
  exit 1
fi

gitroot="$(git -C "$(dirname "$0")" rev-parse --show-toplevel)"
cd "$gitroot"

if [ ! -d .venv ]; then
  python3 -m venv .venv
fi
# shellcheck disable=SC1091
. ./.venv/bin/activate
pip install -qU uv

for reqsin in *requirements.in; do
  uv pip compile -U --no-header --annotation-style=line --strip-extras requirements.in -o "${reqsin%in}txt"
  printf '%s\n' "Wrote lockfile for ${reqsin}"
  git status --short "${reqsin}"
done
