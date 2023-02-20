#!/bin/bash

${BASH_SOURCE%/*}/set_env_local.sh
bundle
bundle exec jekyll serve --drafts --force_polling --livereload
${BASH_SOURCE%/*}/set_env_ghpages.sh
