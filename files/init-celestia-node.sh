#!/bin/sh
# $1 argument: celestia-node home directory (default: ~/.celestia-node)

echo "Init celestia node store folder"

mkdir -p $1/data
mkdir -p $1/keys
