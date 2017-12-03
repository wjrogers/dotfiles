@ECHO OFF

REM Variables
SETLOCAL
SET BASE=%~dp0.

REM Create directories we need below
MKDIR "%APPDATA%\mintty"

REM Symlinks
MKLINK "%APPDATA%\mintty\config" "%BASE%\minttyrc"
MKLINK "%USERPROFILE%\.gitconfig" "%BASE%\gitconfig"
MKLINK "%USERPROFILE%\.tidyrc" "%BASE%\tidyrc"
MKLINK "%USERPROFILE%\.vimrc" "%BASE%\vimrc"
MKLINK /D "%USERPROFILE%\vimfiles" "%BASE%\vim"

REM Delete old environment variables
REG DELETE HKCU\Environment /V HOME /F
REG DELETE HKCU\Environment /V GITHUB_USER /F
REG DELETE HKCU\Environment /V GITHUB_TOKEN /F
REG DELETE HKCU\Environment /V TERM /F

REM Configure environment
SetX GIT_SSH "%USERPROFILE%\Dropbox\Applications\putty\plink.exe"
SetX HTML_TIDY "%USERPROFILE%\.tidyrc"