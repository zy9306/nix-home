# bat config


if [[ $(command_exists bat) == true ]];then
    export BAT_THEME="zenburn"  # use GitHub for white theme.
    alias cat="bat -p"
else
    echo_red "bat is not installed, see: https://github.com/sharkdp/bat"
fi

if [[ ! $(command_exists fd) == true ]];then
    echo_red "fd is not installed, see: https://github.com/sharkdp/fd or download from https://github.com/sharkdp/fd/releases and cp it to /usr/local/bin"
fi

# fzf config https://github.com/junegunn/fzf/wiki/examples

if [[ $(command_exists fzf) == true ]];then
    # https://github.com/junegunn/fzf/issues/223
    # https://github.com/junegunn/fzf/issues/238
    export FZF_DEFAULT_OPTS="--bind ctrl-f:page-down,ctrl-b:page-up --height=50% --no-sort --layout=reverse"
    # --preview='bat --style=full --color=always --theme=GitHub {} 2> /dev/null'

    if [ -f /usr/local/bin/fd ];then
        export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    else
        echo_red ".app: fzf may need fd for FZF_DEFAULT_COMMAND"
    fi

    # command history
    # fhe - find history and execute
    fhe() {
        eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history 0) | fzf +s --tac | sed 's/ *[0-9]* *//')
    }
    # fh - find history but not execute
    fh() {
        print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history 0) | fzf +s --tac | sed 's/ *[0-9]* *//')
    }
else
    echo_red "fzf is not installed see: https://github.com/junegunn/fzf or download from https://github.com/junegunn/fzf-bin/releases and cp it to /usr/local/bin"
fi


# https://stackoverflow.com/questions/7522712/how-to-check-if-command-exists-in-a-shell-script
# or use (maybe can replace &> to >)
# if ! type "thefuck" &> /dev/null; then
#     do something
# else
#     do something
# fi

if [[ $(command_exists thefuck) == false ]]; then
    echo_red "thefuck is not installed see: https://github.com/nvbn/thefuck"
else
    eval $(thefuck --alias)
fi


if [[ $(command_exists rg) == false ]]; then
    echo_red "rg is not installed see: https://github.com/BurntSushi/ripgrep/releases"
else
    alias rg="rg --max-columns 250 --max-columns-preview"
fi


# ### ls config start
if [[ $(command_exists exa) == false ]]; then
    echo_red "exa is not installed see: https://github.com/ogham/exa/releases"

    ls=ls
    if [[ $(uname -s) == 'Darwin' ]];then
        if ! command="$(type -p "gls")" || [[ -z $command ]]; then
            echo_red "gls is not installed, try brew install coreutils"
        else
            ls=gls
        fi
    fi

else
    ls=exa
fi


alias ls="$ls -h --group --group-directories-first --color=always"

alias ll='ls -al'
alias la='ls -a'
alias l='ls -l'
# ### ls config end


if [[ $(command_exists navi) == true ]];then
    alias nax="navi --path ~/Nutstore/linux/navi-cheat"
    alias na="navi --path ~/Nutstore/linux/navi-cheat --print | pbcopy"
else
    echo_red "navi is not installed, see: https://github.com/denisidoro/navi"
fi


if [[ $(command_exists tldr) == true ]];then
    mkdir -p $HOME/.tealdeer_cache
    export TEALDEER_CACHE_DIR=$HOME/.tealdeer_cache
    alias tl="tldr"
else
    echo_red "tldr is not installed, see: https://github.com/dbrgn/tealdeer"
    echo_red "run tldr --update or download https://github.com/tldr-pages/tldr to $HOME/.tealdeer_cache/tldr-master"
fi


e() {
    emacs $@ &
}

alias et="emacs -nw"
