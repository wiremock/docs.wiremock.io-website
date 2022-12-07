#!/usr/bin/env bash

npm run build:all
rbenv exec bundle exec jekyll build
