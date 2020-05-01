:: Check whether there are dlls for openssl on the system path that would gets
:: picked up by the windows loader before those in the conda environment.
:: If yes, warn that the environment is potentially vulnerable.

@echo off

set "LIBSSL_PATH=C:\Windows\System32\libssl-1_1-x64.dll"
set "LIBCRYPTO_PATH=C:\Windows\System32\libcrypto-1_1-x64.dll"

set "HAS_SYS_LIBS=F"
set "HAS_SYS_SSL=F"
set "HAS_SYS_CRYPTO=F"
if exist %LIBSSL_PATH% (
  set "HAS_SYS_LIBS=T"
  set "HAS_SYS_SSL=T"
)
if exist %LIBCRYPTO_PATH% (
  set "HAS_SYS_LIBS=T"
  set "HAS_SYS_CRYPTO=T"
)

:: The carets are used for escaping brackets, which would otherwise be interpreted (and fail).
if "%HAS_SYS_LIBS%"=="T" (
                             ECHO WARNING: Your system contains ^(potentially^) outdated libraries under:
  if "%HAS_SYS_SSL%"=="T"    ECHO WARNING: %LIBSSL_PATH%
  if "%HAS_SYS_CRYPTO%"=="T" ECHO WARNING: %LIBCRYPTO_PATH%
                             ECHO WARNING: These libraries will be linked before those in the conda
                             ECHO WARNING: environment and might make your installation vulnerable!
)
