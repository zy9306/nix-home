let
  sources = import nix/sources.nix;
  emacs-overlay = sources."emacs-overlay";
  pkgs = import sources."nixpkgs-unstable" {
    overlays =
      [ (import (builtins.fetchTarball { url = emacs-overlay.url; })) ];
  };

  latest = import <nixpkgs> { };
in
{
  niv = pkgs.niv;
  nixfmt = pkgs.nixfmt;
  nixpkgs-fmt = pkgs.nixpkgs-fmt;
  starship = pkgs.starship;
  ripgrep = pkgs.ripgrep;
  fd = pkgs.fd;
  fzf = pkgs.fzf;
  unzip = pkgs.unzip;
  htop = pkgs.htop;
  xclip = pkgs.xclip;
  gawk = pkgs.gawk;
  universal-ctags = pkgs.universal-ctags;
  cloc = pkgs.cloc;
  pandoc = pkgs.pandoc;
  bat = pkgs.bat;
  exa = pkgs.exa;
  navi = pkgs.navi;
  tealdeer = pkgs.tealdeer;
  git-lfs = pkgs.git-lfs;
  delta = pkgs.gitAndTools.delta;
  bfg-repo-cleaner = pkgs.bfg-repo-cleaner;
  git-filter-repo = pkgs.gitAndTools.git-filter-repo;
  curl = pkgs.curl;
  wget = pkgs.wget;
  aria2 = pkgs.aria2;
  stern = pkgs.stern;

  # emacsGcc = pkgs.emacsGcc.overrideAttrs (old: {
  #   configureFlags = old.configureFlags ++ [ "--program-transform-name='s/^ctags$/ctags.emacs/'" ];
  # });

  inherit pkgs latest;
}

# nix-env -iA nixpkgs.git
# nix-env -i -f default.nix
# nix-env -iA pkgs.nixpkgs-fmt -f default.nix
