#!/usr/bin/env bash
set -e

TOOL_NAME=$1
TOOL_DIR=$HOME/.asdf/toolset/$TOOL_NAME
mkdir $TOOL_DIR/plugin-repo

asdf plugin-add $TOOL_NAME $(< $TOOL_DIR/plugin-repo)
source $TOOL_DIR/build-env
echo "${TOOL_NAME} $(< $TOOL_DIR/version)" >> .tool-versions
asdf install
