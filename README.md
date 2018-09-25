# Bootstrapping

## Windows

1. In an elevated PowerShell, enable the Windows ssh-agent service
    ```powershell
    Set-Service ssh-agent -StartupType Automatic
    Start-Service ssh-agent
    ```
1. In a normal PowerShell session, install [scoop](https://github.com/lukesampson/scoop)
    ```powershell
    iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
    ```
1. Install git
    ```powershell
    scoop install git
    ```
1. Configure git to use the bundled Windows OpenSSH
    ```powershell
    [Environment]::SetEnvironmentVariable('GIT_SSH', (Resolve-Path (scoop which ssh)), 'USER')
    ```
1. Add a key to the agent (note: you only have to do this _once_; Windows saves it in the hopefully-secure Windows Credential Manager -- yet another reason to lock your workstation)
    ```powershell
    ssh-add <path-to-private-key>
    ```
1. Clone this repository
    ```powershell
    git clone git@github.com:wjrogers/dotfiles.git
    cd dotfiles
    git submodule update --recursive --init
    ```
1. Open an elevated Command Prompt and run `install.bat` to complete the remaining setup steps. (Administrator privileges are still required to creat symbolic links.)

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

1. Install packages
    ```sh
    sudo apt update
    sudo apt upgrade
    sudo apt install ruby tig
    ```
1. Make a symlink to the repository cloned in your Windows user profile
    ```sh
    ln -s /mnt/c/Users/will/dotfiles/ .dotfiles
    cd .dotfiles
    ```
1. Run `install.rb` to complete setup
    ```sh
    ruby install.rb <path-to-private-key>
    ```
1. Choose a [base16 theme](http://chriskempson.com/projects/base16/)
    ```sh
    base16_solarflare
    ```
