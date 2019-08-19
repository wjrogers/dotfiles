# Bootstrapping

## Windows

1. In a normal PowerShell session, execute the install script from this repository.

    ```powershell
    Invoke-Expression (Invoke-WebRequest https://raw.githubusercontent.com/wjrogers/dotfiles/master/install.ps1)
    ```

1. Add a key to the agent (note: you only have to do this _once_; Windows saves it in the hopefully-secure Windows Credential Manager -- yet another reason to lock your workstation)

    ```powershell
    ssh-add <path-to-private-key>
    ```

## Windows Subsystem for Linux

[Install Windows Subsystem for Linux (WSL) on Windows 10](https://docs.microsoft.com/en-us/windows/wsl/install-win10)

1. In an elevated PowerShell, enable the feature

    ```powershell
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
    ```

1. Reboot when prompted
1. Install [Ubuntu](https://www.microsoft.com/store/p/ubuntu/9nblggh4msv6) from the Microsoft Store
1. Install [wsltty](https://github.com/mintty/wsltty)
1. (Optional) Install preferred fonts e.g. Deja Vu, Fira Code, Hack

## Linux

1. (WSL v1) Make a symlink to the repository cloned in your Windows user profile

    ```sh
    ln -s /mnt/c/Users/will/dotfiles/ ~/.dotfiles
    cd ~/.dotfiles
    ```

1. (Linux) Clone this repository

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
