#!/bin/sh -e

gitroot="$(git -C "$(dirname "$0")" rev-parse --show-toplevel)"
cd "$gitroot"

if [ ! -d .venv ]; then
  python3 -m venv .venv
fi
# shellcheck disable=SC1091
. ./.venv/bin/activate
pip install -qr requirements.txt

"${gitroot}"/mk/private-build-plans.toml.sh

pbp_sha256="$(sha256sum "${gitroot}"/private-build-plans.toml | cut -d ' ' -f 1)"

vars="$(mktemp)"
nt2json -s "${gitroot}"/vars.types.nt "${gitroot}"/vars.nt >"$vars"

build_webfonts="$(yaml-get -p build_webfonts "$vars")"
upstream_branch="$(yaml-get -p branch "$vars")"

yaml-get -p 'spacings.*' "$vars" | while read -r spacing; do

  folder="${gitroot}/pkgs/ttf-iosevka-${spacing}${spacing:+-}custom-git"
  mkdir -p "$folder"

  cp "${gitroot}"/private-build-plans.toml "${folder}"/private-build-plans.toml.example

  wheezy.template "${gitroot}"/templates/PKGBUILD.wz "$(
    printf '%s\n' '{}' | \
    yaml-set -g spacing -a "$spacing" | \
    yaml-set -g pbp_sha256 -a "$pbp_sha256" | \
    yaml-set -g build_webfonts -a "$build_webfonts" | \
    yaml-set -g branch -a "$upstream_branch" | \
    yaml-get -p .
  )" >"${folder}"/PKGBUILD

  printf '%s\n' "Wrote ${folder}/PKGBUILD"

  if command -v makepkg >/dev/null; then
    cd "${folder}"
    makepkg --printsrcinfo >.SRCINFO
    printf '%s\n' "Wrote ${folder}/.SRCINFO"
  fi

  printf '%s\n' \
    '/*.pkg.*' '/src' '/pkg' '/Iosevka' \
  >"${folder}/.gitignore"

done
