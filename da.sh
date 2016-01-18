#!/usr/bin/env bash
# Sends all known information about a job/app to a location defined by $CURL_KV
# Said KV service can be used to drive a dashboard.
set -e

CURL_KV=${@:-$CURL_KV}

if [ "${CURL_KV}x" == "x" ] ; then
  echo "no CURL_KV set"
  exit 1
fi

# if app defines an executable script called ".da.sh" in the root,
# run it and capture its' value.
APP=null
if [ -e .da.sh ] && [ -x .da.sh ] ; then
  echo ".da.sh exists and is exec. Executing..."
  APP=$(./.da.sh)
fi

NOW=$(date -u "+%Y-%m-%dT%H:%M:%S%z")
# hash below could be $(git rev-parse HEAD)
# variables below as per https://wiki.jenkins-ci.org/display/JENKINS/Building+a+software+project#Buildingasoftwareproject-JenkinsSetEnvironmentVariables
curl \
  --silent --output /dev/null \
  -X POST \
  -H 'Content-Type: application/json' \
  $CURL_KV -d @- <<REQUESTBODY
{
  "app": $APP,
  "at": "$NOW",
  "scm": {
    "hash": "$GIT_COMMIT",
    "url": {
      "ssh": "$GIT_URL"
    },
    "branch": "$GIT_BRANCH"
  },
  "build": {
    "number": $BUILD_NUMBER,
    "name": "$JOB_NAME",
    "id": $BUILD_ID,
    "url": "$BUILD_URL",
    "tag": "$BUILD_TAG"
  }
}
REQUESTBODY
