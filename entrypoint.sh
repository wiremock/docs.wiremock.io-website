#!/usr/bin/env bash

set -euo pipefail

cd /sources
npm run watch:all &
bundle exec jekyll serve
