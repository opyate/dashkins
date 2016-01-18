#!/usr/bin/env bash
# An example .da.sh file.
# Returns an atom, or JSON.

# The parent script doesn't provide quotes, so you have to:
#echo '"stringy"'

# Extracting JSON across many *nix platforms?
#APP_VERSION=$(cat package.json | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["version"]')
#printf '{"version":"'$APP_VERSION'"}'

# JSON is easy with printf
printf '{"version": "1.1.3"}'
