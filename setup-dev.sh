#!/bin/sh

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

set -e

sudo apt-get -y install pcscd
sudo apt-get -y install scdaemon
sudo apt-get -y install pcsc-tools
sudo apt-get -y install gnupg
sudo killall ssh-agent gpg-agent || echo "Nothing to kill"

gpg-agent --daemon --enable-ssh-support > "${HOME}/.gpg-agent-info"

cat >> "${HOME}/.bashrc" <<EOF
if [ -f "${HOME}/.gpg-agent-info" ]; then
  . "${HOME}/.gpg-agent-info"
fi
EOF
