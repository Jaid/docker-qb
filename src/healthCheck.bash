#!/usr/bin/env bash

curl --silent --show-error --fail --retry 3 --head "localhost:$webPort"
