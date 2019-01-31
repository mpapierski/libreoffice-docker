#!/usr/bin/env bash
set -e

export PATH="/opt/libreoffice/program/:$PATH"

function cleanup {
  if [ -e /tmp/hsperfdata_libreoffice ]; then
    rm -rf /tmp/hsperfdata_libreoffice
  fi
}

trap cleanup EXIT

soffice $@
