#!/usr/bin/bash

# Project root directory absolute path (minus the "/mnt" part, so Docker volumes work)
export CWD_NO_MNT="$(pwd | sed 's/^\/mnt//')"
