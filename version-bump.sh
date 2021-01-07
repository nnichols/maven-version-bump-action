#!/bin/bash

#
# Takes a version number, and the mode to bump it, and increments/resets
# the proper components so that the result is placed in the variable
# `NEW_VERSION`.
#
# $1 = mode (major, minor, patch)
# $2 = version (x.y.z)
#
function bump {
  local mode="$1"
  local old="$2"
  local parts=( ${old//./ } )
  case "$1" in
    major)
      local bv=$((parts[0] + 1))
      NEW_VERSION="${bv}.0.0"
      ;;
    minor)
      local bv=$((parts[1] + 1))
      NEW_VERSION="${parts[0]}.${bv}.0"
      ;;
    patch)
      local bv=$((parts[2] + 1))
      NEW_VERSION="${parts[0]}.${parts[1]}.${bv}"
      ;;
    esac
}

git config --global user.email $EMAIL
git config --global user.name $NAME
export GITHUB_TOKEN=$TOKEN

cd $POMPATH

CURRENT_VERSION=$(cat pom.xml | grep "<version>.*</version>" | head -1 | awk -F'[><]' '{print $3}')
BRANCH_COMMITS=$(git log $BRANCH.. --pretty='%B')

BUMP_MODE='none'
if echo $BRANCH_COMMITS | grep '#major'
then
  BUMP_MODE='major'
elif echo $BRANCH_COMMITS | grep '#minor'
then
  BUMP_MODE='minor'
elif echo $BRANCH_COMMITS | grep '#patch'
then
  BUMP_MODE='patch'
fi

if [[ $BUMP_MODE -eq 'none' ]]
then
  echo "No matching commit tags found."
  echo "pom.xml at" $POMPATH "will remain at" $CURRENT_VERSION
else
  echo $BUMP_MODE "version bump detected"
  bump $BUMP_MODE $CURRENT_VERSION
  echo "pom.xml at" $POMPATH "will be bumped from" $CURRENT_VERSION "to" $NEW_VERSION
  mvn versions:set -DnewVersion="${NEW_VERSION}"
fi
