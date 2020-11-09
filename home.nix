let
  sources = import ./nix/sources.nix;
  nixpkgs = import sources."nixpkgs-release-20.09" {};
  nixpkgs-unstable = import sources."nixpkgs-unstable" {};
  nixpkgs-528d35b = import sources."nixpkgs-528d35b" {};

  cachedpkgs = import ./default.nix;

  # buildin
  pkgs = import <nixpkgs> {};
in
{
  home.packages = [
    nixpkgs.tmux
    nixpkgs.zsh
    nixpkgs.unzip
    nixpkgs.fd
    nixpkgs.ripgrep
    nixpkgs.bat
    nixpkgs.exa
    nixpkgs.fzf
    nixpkgs.aria2
    nixpkgs.git
    nixpkgs.git-lfs
    nixpkgs.gitAndTools.delta
    nixpkgs.bfg-repo-cleaner  # https://rtyley.github.io/bfg-repo-cleaner/
    nixpkgs.gitAndTools.git-filter-repo  # https://github.com/newren/git-filter-repo
    nixpkgs.curl
    nixpkgs.wget
    nixpkgs.htop
    nixpkgs.navi
    nixpkgs.tealdeer  # tldr rust impl
    nixpkgs.starship
    nixpkgs.xclip
    nixpkgs.gawk  # TODO replace awk
    nixpkgs.coreutils-full
    nixpkgs.universal-ctags

    cachedpkgs.emacsGcc

    # languages
    nixpkgs.nodejs-14_x
    nixpkgs.python37Full
    nixpkgs.python37Packages.pip
    # nixpkgs.go_1_14
    nixpkgs.go  # go-1.15.2

    nixpkgs-528d35b.alacritty  # 0.4.2
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
