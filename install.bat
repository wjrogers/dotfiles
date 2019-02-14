@ECHO OFF

REM Variables
SETLOCAL
SET BASE=%~dp0.

REM Create directories we need below
MKDIR "%APPDATA%\Code\User"
MKDIR "%APPDATA%\mintty"

REM Symlinks
MKLINK "%APPDATA%\Code\User\settings.json" "%BASE%\code.json"
MKLINK "%APPDATA%\mintty\config" "%BASE%\minttyrc"
MKLINK "%USERPROFILE%\.gitconfig" "%BASE%\gitconfig"
MKLINK "%USERPROFILE%\.tidyrc" "%BASE%\tidyrc"
MKLINK "%USERPROFILE%\.vimrc" "%BASE%\vimrc"
MKLINK /D "%USERPROFILE%\.vim" "%BASE%\vim"
MKLINK /D "%USERPROFILE%\vimfiles" "%BASE%\vim"

REM Symlinks to externally-stored files
MKLINK "%APPDATA%\ConEmu.xml" "%USERPROFILE%\Dropbox\Applications\ConEmu.xml"
MKLINK "%USERPROFILE%\.hyper.js" "%USERPROFILE%\Dropbox\.hyper.js"

REM Delete old environment variables
REG DELETE HKCU\Environment /V HOME /F
REG DELETE HKCU\Environment /V GITHUB_USER /F
REG DELETE HKCU\Environment /V GITHUB_TOKEN /F
REG DELETE HKCU\Environment /V TERM /F

REM Configure environment
SetX HTML_TIDY "%USERPROFILE%\.tidyrc"
