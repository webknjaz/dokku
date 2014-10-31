#!/usr/bin/env bash
set -eo pipefail

export EMERGE_DEFAULT_OPTS="-v"
export DOKKU_REPO=${DOKKU_REPO:-"https://github.com/webknjaz/dokku.git"}

emerge -vu git make curl ca-certificates dev-python/dbus-python dev-python/pygobject dev-python/pycurl sys-apps/man-db

cd ~ && test -d dokku || git clone $DOKKU_REPO
cd dokku
git fetch origin

if [[ -n $DOKKU_BRANCH ]]; then
  git checkout origin/$DOKKU_BRANCH
elif [[ -n $DOKKU_TAG ]]; then
  git checkout $DOKKU_TAG
fi

make install

echo
echo "Almost done! For next steps on configuration:"
echo "  https://github.com/webknjaz/dokku#configuring"
