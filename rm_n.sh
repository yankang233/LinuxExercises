#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <dir> <n>" 1>&2
  exit 1
fi

DIR=$1
SIZE=$2

if [ ! -d "$DIR" ]; then
  echo "Error: Directory $DIR does not exist." 1>&2
  exit 1
fi

find "$DIR" -type f -size +"$SIZE"c -exec rm -f {} \;