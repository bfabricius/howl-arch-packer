#!/usr/bin/bash -x

set -eu

# env vars set by povisioning system
# ARM_TLC_AR=/tmp/arm-tlc.tar.bz2
# ARM_TLC_TGT=/opt/howl-tlc
# FWSNDR_BIN=/tmp/firmwaresender
# FWSNDR_TGT=/usr/local/bin

# CONFIG VARS
OWL_PROGRAM_GIT=https://github.com/pingdynasty/OwlProgram.git

## TEMPORARY CODE: TO BE REMOVED
if [[ -d /home/vagrant/source ]]; then
	rm -rf /home/vagrant/source
fi

# extend path
echo '==> Extending path'
echo "source ${EXPORTS_SH}" >> ${HOME}/.bashrc
echo "alias ll='ls -alh --color=auto'" >> ${HOME}/.bashrc

echo "==> Installing OWL Program Source"
/usr/bin/mkdir /home/vagrant/source
cd /home/vagrant/source
/usr/bin/git clone ${OWL_PROGRAM_GIT}
cd OwlProgram

echo "==> Building OWL patch binary"
TOOLROOT='${TLC_TOOLROOT}/' /usr/bin/make patch && make clean

echo "==> Changing ownershipt of source folder"
chown -R vagrant:vagrant /home/vagrant/source

echo "==> Howl User SW installation done"

# echo '==> Howl SW installation complete!'
# /usr/bin/sleep 3
# /usr/bin/systemctl reboot