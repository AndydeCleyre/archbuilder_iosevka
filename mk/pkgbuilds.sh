#!/bin/sh -e

gitroot="$(git -C "$(dirname "$0")" rev-parse --show-toplevel)"

"${gitroot}"/mk/private-build-plans.toml.sh

pbp_sha256="$(sha256sum "${gitroot}"/private-build-plans.toml | cut -d ' ' -f 1)"

if [ "$(yaml-get -p build_webfonts "${gitroot}"/vars.yml)" = yes ]; then
  build_webfonts=true
else
  build_webfonts=false
fi

upstream_branch="$(yaml-get -p branch "${gitroot}"/vars.yml)"

yaml-get -p 'spacings.*' "${gitroot}"/vars.yml | while read -r spacing; do

  folder="${gitroot}/pkgs/ttf-iosevka-${spacing}${spacing:+-}custom-git"
  mkdir -p "$folder"

  cp "${gitroot}"/private-build-plans.toml "${folder}"/private-build-plans.toml.example

  wheezy.template "${gitroot}"/templates/PKGBUILD.wz '{
    "spacing":       "'"$spacing"'",
    "pbp_sha256":    "'"$pbp_sha256"'",
    "build_webfonts": '"$build_webfonts"',
    "branch":        "'"$upstream_branch"'"
  }' >"${folder}"/PKGBUILD

  if command -v makepkg >/dev/null; then
    cd "${folder}"
    makepkg -os
    makepkg --printsrcinfo >.SRCINFO
  fi

  printf '%s\n' \
    '/*.pkg.*' '/src' '/pkg' '/Iosevka' \
  >"${folder}/.gitignore"

done
