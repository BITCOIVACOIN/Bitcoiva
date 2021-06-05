#!/usr/bin/env sh

##
## Input parameters
##
BINARY=/bitcoivad/${BINARY:-bitcoivad}
ID=${ID:-0}
LOG=${LOG:-bitcoivad.log}

##
## Assert linux binary
##
if ! [ -f "${BINARY}" ]; then
	echo "The binary $(basename "${BINARY}") cannot be found. Please add the binary to the shared folder. Please use the BINARY environment variable if the name of the binary is not 'bitcoivad' E.g.: -e BINARY=bitcoivad_my_test_version"
	exit 1
fi
BINARY_CHECK="$(file "$BINARY" | grep 'ELF 64-bit LSB executable, x86-64')"
if [ -z "${BINARY_CHECK}" ]; then
	echo "Binary needs to be OS linux, ARCH amd64"
	exit 1
fi

##
## Run binary with all parameters
##
export BITCOIVADHOME="/bitcoivad/node${ID}/bitcoivad"

if [ -d "`dirname ${BITCOIVADHOME}/${LOG}`" ]; then
  "$BINARY" --home "$BITCOIVADHOME" "$@" | tee "${BITCOIVADHOME}/${LOG}"
else
  "$BINARY" --home "$BITCOIVADHOME" "$@"
fi

chmod 777 -R /bitcoivad

