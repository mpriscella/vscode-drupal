#!/bin/bash

# Arguments:
#
# Project
#   The name of the module to generate the patch for. `core` for core.
# Description
#   A description of the change. Defaults to the branch name unless currently checked out to the origin branch.
# Issue Number
#   The d.o issue number.
# Comment Number
#   The comment number.


# Interdiff? Maybe different script.

# Args: $project $description(optional, defaults to branch unless branch matches the core version then nothing)






git stash push composer.json composer.lock composer/
# Generate patch
git diff origin/9.4.x > PATCH_FILE_NAME.patch
# Pop stash
git stash pop
