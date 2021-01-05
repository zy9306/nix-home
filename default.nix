# 此处添加需要使用的包,使用 ci 构建并推到缓存中

let
  sources = import ./nix/sources.nix;
  nixpkgs = import sources."nixpkgs-release-20.09" { };
  nixpkgs-unstable = import sources."nixpkgs-unstable" { };
  nixpkgs-528d35b = import sources."nixpkgs-528d35b" { };

  emacs = import ./nix-emacs;

  extra = import ./extra.nix;

  pkgs = import <nixpkgs> { };
in {
  # shell
  alacritty_0_4_2 = nixpkgs-528d35b.alacritty;
  tmux = nixpkgs.tmux;
  zsh = nixpkgs.zsh;
  starship = nixpkgs.starship;

  # search
  rg = nixpkgs.ripgrep;
  fd = nixpkgs.fd;
  fzf = nixpkgs.fzf;

  # utils
  unzip = nixpkgs.unzip;
  htop = nixpkgs.htop;
  xclip = nixpkgs.xclip;
  gawk = nixpkgs.gawk;
  coreutils-full = nixpkgs.coreutils-full;
  universal-ctags = nixpkgs.universal-ctags;
  global = nixpkgs.global;
  cloc = nixpkgs.cloc;
  pandoc = nixpkgs.pandoc;
  bat = nixpkgs.bat;
  exa = nixpkgs.exa;
  navi = nixpkgs.navi;
  tealdeer = nixpkgs.tealdeer;

  # git
  git = nixpkgs.git;
  git-lfs = nixpkgs.git-lfs;
  delta = nixpkgs.gitAndTools.delta;
  # https://rtyley.github.io/bfg-repo-cleaner/
  bfg = nixpkgs.bfg-repo-cleaner;
  # https://github.com/newren/git-filter-repo
  git-filter-repo = nixpkgs.gitAndTools.git-filter-repo;
  pre-commit = nixpkgs.gitAndTools.pre-commit;

  # network
  curl = nixpkgs.curl;
  wget = nixpkgs.wget;
  aria2 = nixpkgs.aria2;
  proxychains-ng = extra.proxychains-ng;

  # language
  nodejs-14 = nixpkgs.nodejs-14_x;
  python37 = nixpkgs.python37Full;
  python37Pip = nixpkgs.python37Packages.pip;
  go_1_14 = nixpkgs.go_1_14;
  go-1_15 = nixpkgs.go;

  # emacs
  # 27
  emacs = nixpkgs.emacs;
  # gcc
  emacsGcc = emacs.emacsGcc;
  emacsGcc20201217 = emacs.emacsGcc20201217;
  emacsGcc20201017 = emacs.emacsGcc20201017;
  # dev
  emacsGit = emacs.emacsGit;
  emacsUnstable = emacs.emacsUnstable;

  # extra
  q = extra.q;
  nixfmt = nixpkgs.nixfmt;
}
