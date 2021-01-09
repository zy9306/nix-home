let
  sources = import ./nix/sources.nix;

  nixpkgs = import sources."nixpkgs-release-20.09" { };

  nixpkgs-unstable = import sources."nixpkgs-unstable" { };

  pkgs = import <nixpkgs> { };

  extra = import ./nix-extra;
in {
  home.packages = [
    nixpkgs.nixfmt

    # shell
    nixpkgs.tmux
    nixpkgs.starship

    # search
    nixpkgs.ripgrep
    nixpkgs.fd
    nixpkgs.fzf

    # utils
    nixpkgs.unzip
    nixpkgs.htop
    nixpkgs.xclip
    nixpkgs.gawk
    nixpkgs.coreutils-full
    nixpkgs.universal-ctags
    nixpkgs.global
    nixpkgs.cloc
    nixpkgs.pandoc
    nixpkgs.bat
    nixpkgs.exa
    nixpkgs.navi
    nixpkgs.tealdeer

    # git
    nixpkgs.git
    nixpkgs.git-lfs
    nixpkgs.gitAndTools.delta
    nixpkgs.bfg-repo-cleaner
    nixpkgs.gitAndTools.git-filter-repo
    nixpkgs.gitAndTools.pre-commit

    # network
    nixpkgs.curl
    nixpkgs.wget
    nixpkgs.aria2

    # language
    nixpkgs.nodejs-14_x
    # install pip
    # curl https://bootstrap.pypa.io/get-pip.py | python3.7
    nixpkgs.python37Full
    # nixpkgs.go_1_14
    # 1.15.x
    nixpkgs.go

    # extra
    extra.q
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
