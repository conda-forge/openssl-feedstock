#!/bin/bash

# Check whether there are dlls for openssl on the system path that would gets
# picked up by the windows loader before those in the conda environment.
# If yes, warn that the environment is potentially vulnerable.

LIBSSL_PATH=/c/Windows/System32/libssl-1_1-x64.dll
LIBCRYPTO_PATH=/c/Windows/System32/libcrypto-1_1-x64.dll

HAS_SYS_LIBS=F
HAS_SYS_SSL=F
HAS_SYS_CRYPTO=F
if [ -f "$LIBSSL_PATH" ]; then
  HAS_SYS_LIBS=T
  HAS_SYS_SSL=T
fi
if [ -f "$LIBCRYPTO_PATH" ]; then
  HAS_SYS_LIBS=T
  HAS_SYS_CRYPTO=T
fi

# The carets are used for escaping brackets, which would otherwise be interpreted (and fail).
if [ $HAS_SYS_LIBS == "T" ]; then
                                      echo "WARNING: Your system contains (potentially) outdated libraries under:"
  if [ $HAS_SYS_SSL == "T" ];    then echo "WARNING: $LIBSSL_PATH"; fi
  if [ $HAS_SYS_CRYPTO == "T" ]; then echo "WARNING: $LIBCRYPTO_PATH"; fi
                                      echo "WARNING: These libraries will be linked before those in the conda"
                                      echo "WARNING: environment and might make your installation vulnerable!"
fi
