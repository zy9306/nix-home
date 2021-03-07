# init nix env
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi

SYS_PATH="$HOME/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/bin"
export PATH="$SYS_PATH:${PATH}"

source $HOME/.shutils

# common
export TERM=xterm-256color

# 没有这行，通过终端打开的程序无法切换中文输入法
export LC_CTYPE="zh_CN.UTF-8"

# zsh config
autoload -Uz compinit && compinit
autoload -U promptinit; promptinit

source $HOME/.zplug/init.zsh

alias -g zplug="LC_MESSAGES=en_US.UTF-8 zplug"


# history settings
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

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
        echo; zplug install
    fi
fi

# zplug load --verbose  # for debug
zplug load


# plugins config

if zplug check b4b4r07/enhancd; then
    # setting if enhancd is available
    export ENHANCD_AWK=awk
    if [[ $(command_exists fzf) == true ]];then
        ENHANCD_FILTER=fzf:fzy:peco:non-existing-filter
        export ENHANCD_FILTER
    else
        echo_red ".zshrc: fzf is not installed enhancd may not working"
    fi
fi


# 务必放在文件最后
# 如果放在文件开头, .env 或 .app 如果有对内置命令的alias操作可能会导致某些问题
# 目前已知放在文件开头会导致的问题: .app 中的 alias cat="bat -p" 会使 pure 不显示 git 版本控制
# 因此等所有zsh配置都完成后再执行以下操作来避免相应问题
source $HOME/.env
source $HOME/.app

if [[ "$HAS_STARSHIP" == true ]]; then
    export STARSHIP_CONFIG=~/.starship
    eval "$(starship init zsh)"
else
    echo_red "!!! starship is not installed see: https://github.com/starship/starship"
fi

# 使用 emacs 键绑定，必要加这句，否则一些快捷键会出问题
bindkey -e
