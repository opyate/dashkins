#!/usr/bin/env bash
# An example .da.sh file.
# Returns an atom, or JSON.

# The parent script doesn't provide quotes, so you have to:
#echo '"stringy"'

# JSON is easy with printf
printf '{"version": "1.1.3"}'
