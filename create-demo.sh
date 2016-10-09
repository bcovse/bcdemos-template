#!/usr/bin/env bash

PROGNAME=${0##*/}
VERSION="0.1"

usage() {
  echo "Usage: ${PROGNAME} [-h|--help ] [-d|--dir] [-r|--repo] [-u|--user]"
}

help_message() {
  cat <<- _EOF_
  ${PROGNAME} ${VERSION}
  Demo site code generator

  $(usage)

  Options:

  -h, --help    Display this help message and exit.
  -d, --dir     Full system path to the directory where you would like the demo template code placed
  -r, --repo    Name of the github repo to create (will be prepended with "bcdemos-")
  -u, --user    GitHub username (you'll be prompted for your password)

_EOF_
}

while test $# -gt 0; do
  case "$1" in
    -h|--help)
      help_message
      exit 0
      ;;
    -u|--user)
      shift
      if test $# -gt 0; then
        UNAME="$1"
      else
        echo "No github username provided"
        exit 1
      fi
      shift
      ;;
    -r|--repo)
      shift
      if test $# -gt 0; then
        REPONAME="$1"
      else
        echo "No repository name specified"
        exit 1
      fi
      shift
      ;;
    -d|--dir)
      shift
      if test $# -gt 0; then
        LOCALDIR="$1"
      else
        echo "No directory specified"
        exit 1
      fi
      shift
      ;;
    *)
      break
      ;;
  esac
done

if [[ -z "${REPONAME// }" ]]; then
  echo "Repository name requred"
  exit 1
fi

if [[ -z "${LOCALDIR// }" ]]; then
  echo "Local directory requred"
  exit 1
fi

if [[ -z "${UNAME// }" ]]; then
  echo "GitHub username requred"
  exit 1
fi

echo "Copying files to $LOCALDIR..."
mkdir $LOCALDIR
cp -R . $LOCALDIR
rm -rf $LOCALDIR/create-demo.sh
cd $LOCALDIR

echo "Initializing local git repo and adding core lib submodule..."
git init
git submodule add https://github.com/cfuller/bcdemos-lib.git lib/
rm -rf bcdemos-lib

echo "Creating remote repo..."
curl -u $UNAME  --data "{\"name\":\"bcdemos-$REPONAME\"}" https://api.github.com/user/repos
git remote add origin https://github.com/cfuller/bcdemos-$REPONAME.git

echo "Synching repos..."
git add .
git commit -m "initial commit"
git push origin master

echo "Cleaning up..."

echo "Done"
exit 0
