let
  cachedpkgs = import ./default.nix;
in {
  home.packages = [
    cachedpkgs.tmux
    cachedpkgs.zsh
    cachedpkgs.unzip
    cachedpkgs.fd
    cachedpkgs.ripgrep
    cachedpkgs.bat
    cachedpkgs.exa
    cachedpkgs.fzf
    cachedpkgs.aria2
    cachedpkgs.git
    cachedpkgs.git-lfs
    cachedpkgs.gitAndTools_delta
    # https://rtyley.github.io/bfg-repo-cleaner/
    cachedpkgs.bfg-repo-cleaner
    # https://github.com/newren/git-filter-repo
    cachedpkgs.gitAndTools_git-filter-repo
    cachedpkgs.curl
    cachedpkgs.wget
    cachedpkgs.htop
    cachedpkgs.navi
    # tldr rust impl
    cachedpkgs.tealdeer
    cachedpkgs.starship
    cachedpkgs.xclip
    cachedpkgs.gawk
    cachedpkgs.coreutils-full
    cachedpkgs.universal-ctags
    cachedpkgs.global

    cachedpkgs.emacsGcc

    cachedpkgs.nodejs-14_x
    cachedpkgs.python37Full
    cachedpkgs.python37Packages_pip
    # cachedpkgs.go_1_14
    cachedpkgs.go-1_15_2

    cachedpkgs.alacritty_0_4_2

    cachedpkgs.nixfmt

    cachedpkgs.q
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # https://rycee.gitlab.io/home-manager/options.html#opt-home.file

  home.file = {
    ".alacritty.yml".source = ./dotfiles/alacritty/.alacritty.yml;

    ".config/yapf/style".source = ./dotfiles/yapf/style;

    ".pip/pip.conf".source = ./dotfiles/pip/pip.conf;

    ".navi-cheat".source = ./dotfiles/navi-cheat;

    ".globalrc".source = ./dotfiles/gtags/.globalrc;
  };
}
