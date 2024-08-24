# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load 
ZSH_THEME="agnoster"

# Add wisely, as too many plugins slow down shell startup.
plugins=(
  docker
  docker-compose
  git
  node
  python
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Update path variable to add local binaries in the environment
export PATH=$HOME/.local/bin:$PATH
# Prioritize yarn global binaries and make them available globally
export PATH=$HOME/.yarn/bin:$PATH

source $ZSH/oh-my-zsh.sh
