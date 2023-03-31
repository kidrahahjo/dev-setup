# Upgrade the system
sudo apt upgrade

# Install ZSH
sudo apt install zsh

echo "Installed version $(zsh --version)"

# Make ZSH your default terminal using change shell (chsh)
chsh -h $(which zsh)

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install poweline fonts to be able to set them from preferences
sudo apt-get install fonts-powerline

# TODO: Add code to clone and replace .zshrc and .bashrc

source ~/.bashrc
source ~/.zshrc

