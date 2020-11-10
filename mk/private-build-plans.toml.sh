#!/bin/sh -e
cd "$(dirname "$0")"
gitroot="$(git rev-parse --show-toplevel)"

wheezy.template "${gitroot}"/templates/private-build-plans.toml.wz \
  "$(yaml-get -p . "${gitroot}"/vars.yml)" \
>"${gitroot}"/private-build-plans.toml
