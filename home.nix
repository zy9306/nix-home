let cachedpkgs = import ./default.nix;
in {
  home.packages = [
    # shell
    cachedpkgs.alacritty_0_4_2
    cachedpkgs.tmux
    cachedpkgs.zsh
    cachedpkgs.starship

    # search
    cachedpkgs.rg
    cachedpkgs.fd
    cachedpkgs.fzf

    # utils
    cachedpkgs.unzip
    cachedpkgs.htop
    cachedpkgs.xclip
    cachedpkgs.gawk
    cachedpkgs.coreutils-full
    cachedpkgs.universal-ctags
    cachedpkgs.global
    cachedpkgs.cloc
    cachedpkgs.pandoc
    cachedpkgs.bat
    cachedpkgs.exa
    cachedpkgs.navi
    cachedpkgs.tealdeer

    # git
    cachedpkgs.git
    cachedpkgs.git-lfs
    cachedpkgs.delta
    cachedpkgs.bfg
    cachedpkgs.git-filter-repo
    cachedpkgs.pre-commit

    # network
    cachedpkgs.curl
    cachedpkgs.wget
    cachedpkgs.aria2

    # language
    cachedpkgs.nodejs-14
    # install pip
    # curl https://bootstrap.pypa.io/get-pip.py | python3.7
    cachedpkgs.python37
    cachedpkgs.go-1_15

    # extra
    cachedpkgs.nixfmt
    cachedpkgs.q

    # emacs
    cachedpkgs.emacs
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # https://rycee.gitlab.io/home-manager/options.html#opt-home.file

  home.file = {
    ".alacritty.yml".source = ./dotfiles/alacritty/.alacritty.yml;

    ".config/yapf/style".source = ./dotfiles/yapf/style;

    ".pip/pip.conf".source = ./dotfiles/pip/pip.conf;

    ".globalrc".source = ./dotfiles/gtags/.globalrc;

    # private
    # NOTE: .navi-cheat is a directory.
    ".navi-cheat".source = ./private/navi-cheat;
  };
}
