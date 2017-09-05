@ECHO OFF
SET BASE=%~dp0.

REM Symlinks
MKDIR "%APPDATA%\mintty"
MKLINK "%APPDATA%\mintty\config" "%BASE%\minttyrc"
MKLINK "%USERPROFILE%\.gitconfig" "%BASE%\gitconfig"
MKLINK "%USERPROFILE%\.tidyrc" "%BASE%\tidyrc"
MKLINK "%USERPROFILE%\.vimrc" "%BASE%\vimrc"
MKLINK /D "%USERPROFILE%\vimfiles" "%BASE%\vim"

REM Configure environment
SetX HTML_TIDY "%USERPROFILE%\.tidyrc"

REM Delete old environment variables
REG DELETE HKCU\Environment /V GIT_SSH /F
REG DELETE HKCU\Environment /V GITHUB_USER /F
REG DELETE HKCU\Environment /V GITHUB_TOKEN /F
REG DELETE HKCU\Environment /V TERM /F
