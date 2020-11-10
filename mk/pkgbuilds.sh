#!/bin/sh -e
cd "$(dirname "$0")"
gitroot="$(git rev-parse --show-toplevel)"

"${gitroot}"/mk/private-build-plans.toml.sh
pbp_sha256="$(sha256sum "${gitroot}"/private-build-plans.toml | cut -d' ' -f 1)"

yaml-get -p 'spacings[. =~ //]' "${gitroot}"/vars.yml | while read spacing; do

  folder="${gitroot}/pkgs/ttf-iosevka-${spacing}${spacing:+-}custom-git"

  mkdir -p "$folder"
  cp "${gitroot}"/private-build-plans.toml "${folder}"/private-build-plans.toml.example
  wheezy.template "${gitroot}"/templates/PKGBUILD.wz \
    '{"spacing": "'$spacing'", "pbp_sha256": "'$pbp_sha256'"}' \
  >"${folder}"/PKGBUILD

  printf '%s\n' \
    '/*.pkg.*' '/src' '/pkg' '/Iosevka' \
  >"${folder}/.gitignore"
done
