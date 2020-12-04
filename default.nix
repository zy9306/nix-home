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
  emacsGcc = emacs.emacsGcc;
  emacsGit = emacs.emacsGit;
  emacsUnstable = emacs.emacsUnstable;

  q = extra.q;

  tmux = nixpkgs.tmux;
  zsh = nixpkgs.zsh;
  unzip = nixpkgs.unzip;
  fd = nixpkgs.fd;
  ripgrep = nixpkgs.ripgrep;
  bat = nixpkgs.bat;
  exa = nixpkgs.exa;
  fzf = nixpkgs.fzf;
  aria2 = nixpkgs.aria2;
  git = nixpkgs.git;
  git-lfs = nixpkgs.git-lfs;
  gitAndTools_delta = nixpkgs.gitAndTools.delta;
  bfg-repo-cleaner = nixpkgs.bfg-repo-cleaner;
  gitAndTools_git-filter-repo = nixpkgs.gitAndTools.git-filter-repo;
  gitAndTools_pre-commit = nixpkgs.gitAndTools.pre-commit;
  curl = nixpkgs.curl;
  wget = nixpkgs.wget;
  htop = nixpkgs.htop;
  navi = nixpkgs.navi;
  tealdeer = nixpkgs.tealdeer;
  starship = nixpkgs.starship;
  xclip = nixpkgs.xclip;
  gawk = nixpkgs.gawk;
  coreutils-full = nixpkgs.coreutils-full;
  universal-ctags = nixpkgs.universal-ctags;
  global = nixpkgs.global;

  nodejs-14_x = nixpkgs.nodejs-14_x;
  python37Full = nixpkgs.python37Full;
  python37Packages_pip = nixpkgs.python37Packages.pip;
  go_1_14 = nixpkgs.go_1_14;
  go-1_15_2 = nixpkgs.go;

  python-language-server = (nixpkgs.python-language-server.overrideAttrs
    (super: {
      meta = with nixpkgs.stdenv.lib; {
        description = "Microsoft Language Server for Python";
        homepage = "https://github.com/microsoft/python-language-server";
        license = licenses.asl20;
        maintainers = with maintainers; [ thomasjm ];
        platforms = [ "x86_64-linux" "x86_64-darwin" ];
      };
    }));

  nixfmt = nixpkgs.nixfmt;

  alacritty_0_4_2 = nixpkgs-528d35b.alacritty;
}
