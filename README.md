# Bootstrapping

## Windows

1. Enable developer mode in Windows Settings. This allows you to create symbolic links without elevation.

1. Install the [latest release](https://github.com/PowerShell/PowerShell/releases/latest) of PowerShell.

1. Install [Windows Terminal](https://aka.ms/windowsterminal) from the Microsoft Store.

1. Install [JetBrains Mono](https://www.jetbrains.com/lp/mono/) and any other desired fonts (e.g. Hack, Fira Code).

1. Open Windows Terminal and execute the install script from this repository.

    ```powershell
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/wjrogers/dotfiles/master/install.ps1')
    ```

> **NOTE:** The current version of these scripts *disables* the sshd and ssh-agent services. The author is using 1Password's integrated SSH Agent.

## Windows Subsystem for Linux

[How to install Linux on Windows with WSL](https://learn.microsoft.com/en-us/windows/wsl/install)

1. In an elevated PowerShell, run the installation command:

    ```powershell
    wsl --install
    ```

> **NOTE:** In recent Windows versions, this command is a one-stop shop that installs the latest WSL and Ubuntu. Use the included Windows Terminal profile; it's better than wsltty now.

## Linux

1. Clone this repository

    ```sh
    git clone https://github.com/wjrogers/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    git submodule update --init
    git remote set-url origin git@github.com:wjrogers/dotfiles.git
    ```

1. Run `install.sh` to complete setup

    ```sh
    ./install.sh
    ```
