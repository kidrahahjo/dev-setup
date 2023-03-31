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

1. To initialize your local development setup, run the `init.sh` script.
2. Python: `python-setup.sh` 
3. Rust: `rust-setup.sh`
4. Node: `node-setup.sh`
5. React: `react-setup.sh` 

