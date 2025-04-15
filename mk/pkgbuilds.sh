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

hinted="$(yaml-get -p hinted "$vars")"
build_webfonts="$(yaml-get -p build_webfonts "$vars")"
upstream_branch="$(yaml-get -p branch "$vars")"
use_custom_name="$(yaml-get -p use_custom_name "$vars")"
custom_name="$(yaml-get -p custom_name "$vars")"

yaml-get -p 'spacings.*' "$vars" | while read -r spacing; do

  if [ "$spacing" = normal ]; then
    folder="${gitroot}/pkgs/ttf-iosevka-custom-git"
  else
    folder="${gitroot}/pkgs/ttf-iosevka-${spacing}-custom-git"
  fi
  mkdir -p "$folder"

  cp "${gitroot}"/private-build-plans.toml "${folder}"/private-build-plans.toml.example

  wheezy.template "${gitroot}"/templates/PKGBUILD.wz "$(
    printf '%s\n' '{}' | \
    yaml-set -g spacing -a "$spacing" | \
    yaml-set -g pbp_sha256 -a "$pbp_sha256" | \
    yaml-set -g hinted -a "$hinted" | \
    yaml-set -g build_webfonts -a "$build_webfonts" | \
    yaml-set -g branch -a "$upstream_branch" | \
    yaml-set -g use_custom_name -a "$use_custom_name" | \
    yaml-set -g custom_name -a "$custom_name" | \
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
