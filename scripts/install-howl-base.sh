#!/usr/bin/bash -x

set -eu

# env vars set by povisioning system
# ARM_TLC_AR=/tmp/arm-tlc.tar.bz2
# ARM_TLC_TGT=/opt/howl-tlc
# FWSNDR_BIN=/tmp/firmwaresender
# FWSNDR_TGT=/usr/local/bin

# CONFIG VARS
OWL_PROGRAM_GIT=https://github.com/pingdynasty/OwlProgram.git

echo "==> Installing libasound2"
/usr/bin/pacman -S alsa-lib --noconfirm
echo "==> Installing git"
/usr/bin/pacman -S git --noconfirm

# vagrant user needs to be in audio group
echo "==> Adding vagrant user to audio group"
/usr/bin/usermod --append --groups audio vagrant

## TEMPORARY CODE: TO BE REMOVED
if [[ -d ${ARM_TLC_TGT} ]]; then
	rm -rf ${ARM_TLC_TGT}
fi
if [[ -f ${ARM_TLC_TGT} ]]; then
	rm -rf ${ARM_TLC_TGT}
fi

# install arm toolchain -> the arm tlc must be file provisioned to /tmp for this to work
echo "==> Provisioning system with Howl ARM Toolchain"
if [[ -f ${ARM_TLC_AR} ]]; then
	mkdir -p ${ARM_TLC_TGT}
	cp ${ARM_TLC_AR} ${ARM_TLC_TGT}
	cd ${ARM_TLC_TGT} && tar xjvf ${ARM_TLC_AR} && rm ${ARM_TLC_PKG} && cd
	echo "[INFO] Provisoined system with Howl ARM Toolchain."
else
	echo "[ERROR] Could not locate ARM Toolchain source package at ${ARM_TLC_AR}."
	exit 1
fi

# # install howl firmwaresender -> the firmwaresender binary must be file provisioned to /tmp for this to work
echo "==> Provisioning system with Howl Firmwaresender Tool"
if [[ -f ${FWSNDR_BIN} ]]; then
	mkdir -p ${FWSNDR_TGT}
	cp ${FWSNDR_BIN} ${FWSNDR_TGT} && cd
	echo "[INFO] Provisoined system with Howl Firmwaresender."	
else
	echo "[ERROR] Could not locate ARM Toolchain source package ${FWSNDR_BIN}."
	exit 1
fi

echo "==> Howl SW installation done"

# echo '==> Howl SW installation complete!'
# /usr/bin/sleep 3
# /usr/bin/systemctl reboot