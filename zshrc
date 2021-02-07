# Zplug
if [ -d $HOME/.zplug ]; then
    export ZPLUG_HOME=$HOME/.zplug
else
    if [ -d /usr/local/opt/zplug ]; then
        export ZPLUG_HOME=/usr/local/opt/zplug
    else
        exit 1
    fi
fi

source $ZPLUG_HOME/init.zsh

zplug "sorin-ionescu/prezto"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
# zplug load --verbose
zplug load

# Source Prezto.
if [ ! -d $HOME/.zprezto ]; then
    ln -s $ZPLUG_HOME/repos/sorin-ionescu/prezto $HOME/.zprezto
fi
export ZPREZTODIR=$ZPLUG_HOME/repos/sorin-ionescu/prezto

## prezto-contrib
if [ ! -d $ZPREZTODIR/contrib ]; then
    git clone --recurse-submodules https://github.com/belak/prezto-contrib $ZPREZTODIR/contrib
fi

## prezto config files
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  if [ ! -f "${ZDOTDIR:-$HOME}/.${rcfile:t}" ]; then
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  fi
done
unsetopt EXTENDED_GLOB


if [[ -s "$HOME/.zprezto/init.zsh" ]]; then
  source "$HOME/.zprezto/init.zsh"
fi

# Customize to your needs...

# Common
export XDG_CONFIG_HOME=$HOME/.config
alias vim=nvim
export EDITOR=nvim

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.history

# Machine depend
if [[ -s "${HOME}/.zshrc_machine.zsh" ]]; then
  source "${HOME}/.zshrc_machine.zsh"
fi
