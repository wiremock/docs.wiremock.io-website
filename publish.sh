#!/usr/bin/env bash

set -euo pipefail

rbenv exec bundle exec jekyll build

pushd ../docs.wiremock.io-website
git reset --hard origin/gh-pages
git pull
cp -rf ../docs.wiremock.io-sources/_site/* .
git checkout CNAME
git add -A
git commit -m "Updated"
git push
popd
