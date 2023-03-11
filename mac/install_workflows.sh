#!/bin/bash

cd Workflows/Services || exit 1

for workflow in */
do
  workflow=${workflow%/}
  full_path=$(pwd)/"$workflow"
  ln -s -F -f "$full_path" "$HOME/Library/Services/$workflow"
done
