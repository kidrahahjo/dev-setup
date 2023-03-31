# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load 
ZSH_THEME="agnoster"

# Add wisely, as too many plugins slow down shell startup.
plugins=(
  docker
  docker-compose
  emoji
  git
  golang
  jira
  minikube
  node
  npm
  poetry
  pylint
  python
  terraform
  tmux
  rust
  vscode
  yarn
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

