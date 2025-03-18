# Development Setup 

### GitHub setup

Set github config

```bash
git config --global user.name "First Last"
git config --global user.email "youremail@example.com"
```

If you are working on a NFTS partition (maybe using a symbolic link), you may face permission issues with WSL trying to access some files.
See: https://askubuntu.com/questions/1115564/wsl-ubuntu-distro-how-to-solve-operation-not-permitted-on-cloning-repository

### SSH Key Setup

Setup SSH keys to avoid entering passwords everytime on push. First generate a ssh key.

```bash
# Generate SSH Key
ssh-keygen -t ecdsa-sk -C "youremail@example.com"
```

After generating copy the public key and set it up under GitHub settings


### Development Setup

To initialize your local development setup, run the `init.sh` script.

### Setting up Neovim

To setup the neovim in your machine, run the following command `./nvim.sh`. 

I use [vim-plug](https://github.com/junegunn/vim-plug) to manage my extensions.

Please note that we use [AppImage](https://appimage.org/) to run neovim, and it required to setup [FUSE](https://github.com/libfuse/libfuse) to run.
You can install fuse using the following command `sudo apt-get install fuse`

#### Setting up file explorer fonts

File explorer uses [nerd fonts](https://www.nerdfonts.com/font-downloads) to display icons.

Download and install [BlexMono Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/IBMPlexMono.zip) and restart your terminal after configuring it to use those fonts.
