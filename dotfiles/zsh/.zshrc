# -*- mode: sh -*-

export TERM=xterm-256color

export LC_CTYPE="zh_CN.UTF-8"

autoload -Uz compinit && compinit
autoload -U promptinit
promptinit

source $HOME/.zplug/init.zsh

alias -g zplug="LC_MESSAGES=en_US.UTF-8 zplug"

# HISTORY START
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt HIST_BEEP
# HISTORY END

# plugins
zplug "mafredri/zsh-async", from:github, use:async.zsh
zplug "b4b4r07/enhancd", from:github, use:init.sh
zplug "zsh-users/zsh-syntax-highlighting", from:github
zplug "zsh-users/zsh-autosuggestions", from:github
zplug "rupa/z", from:github, use:z.sh

# 主题: 使用starship
if [[ $(command_exists starship) == false ]]; then
  zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
else
  HAS_STARSHIP=true
fi

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo
    zplug install
  fi
fi

# zplug load --verbose  # for debug
zplug load

# plugins config

if zplug check b4b4r07/enhancd; then
  # setting if enhancd is available
  export ENHANCD_AWK=awk
  if [[ $(command_exists fzf) == true ]]; then
    ENHANCD_FILTER=fzf:fzy:peco:non-existing-filter
    export ENHANCD_FILTER
  else
    echo_red ".zshrc: fzf is not installed enhancd may not working"
  fi
fi

# 务必放在文件最后
# 如果放在文件开头, 如果有对内置命令的alias操作可能会导致某些问题
# 目前已知放在文件开头会导致的问题: .app 中的 alias cat="bat -p" 会使 pure 不显示 git 版本控制
# 因此等所有zsh配置都完成后再执行以下操作来避免相应问题
source $HOME/.app

if [[ "$HAS_STARSHIP" == true ]]; then
  export STARSHIP_CONFIG=~/.starship
  eval "$(starship init zsh)"
else
  echo_red "!!! starship is not installed see: https://github.com/starship/starship"
fi

. $HOME/.zshenv

# 使用 emacs 键绑定，必要加这句，否则一些快捷键会出问题
bindkey -e
