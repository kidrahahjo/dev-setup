# Setup Backup Directories
echo "Backing up existing files"
BACKUP_DIR=$HOME/vim-install-backup
rm -rf $BACKUP_DIR && mkdir $BACKUP_DIR
NVIM_DIR=$HOME/.local/bin/nvim
[ -f $NVIM_DIR ] && mv $NVIM_DIR $BACKUP_DIR
RG_DIR=$HOME/.local/bin/rg
[ -f $RG_DIR ] && mv $RG_DIR $BACKUP_DIR
CONFIG_DIR=$HOME/.config/nvim
[ -f $CONFIG_DIR ] && mv $CONFIG_DIR $BACKUP_DIR

echo "Installing nvim..."
curl --silent -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
mv nvim.appimage $NVIM_DIR
chmod u+x $NVIM_DIR

echo "Installing ripgrep for search...."
curl --silent -LO 'https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep-14.1.0-x86_64-unknown-linux-musl.tar.gz'
tar xf ripgrep-14.1.0-x86_64-unknown-linux-musl.tar.gz
mv ripgrep-14.1.0-x86_64-unknown-linux-musl/rg $RG_DIR
rm -rf ripgrep-14.1.0-x86_64-unknown-linux-musl.tar.gz  ripgrep-14.1.0-x86_64-unknown-linux-musl

echo "Copying config files..."
cp -r ./config/nvim $CONFIG_DIR

echo "Installing vim-plug to manage extensions..."
curl --silent -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Installing all plugins..."
nvim +PlugUpdate +qall

echo "If something goes wrong in this installation, you can find your backup at $BACKUP_DIR"
