#!/bin/sh -e
cd "$(dirname "$0")"
gitroot="$(git rev-parse --show-toplevel)"

wheezy.template "${gitroot}"/templates/buildpkg.yml.wz \
  "$(yaml-get -p . "${gitroot}"/vars.yml)" \
>"${gitroot}"/.github/workflows/buildpkg.yml
