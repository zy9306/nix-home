# install this file:
# nix-env -i -f default.nix

# lock channel
# nix-channel --add https://github.com/NixOS/nixpkgs/archive/78c4d33c16092e535bc4ba1284ba49e3e138483a.tar.gz pkgs
# nix-channel --update
# nix-env -iA pkgs.nixpkgs-fmt

let
  nixpkgs = import <nixpkgs> { };
in
{
  aria2 = nixpkgs.aria2;
  bat = nixpkgs.bat;
  cloc = nixpkgs.cloc;
  curl = nixpkgs.curl;
  delta = nixpkgs.gitAndTools.delta;
  exa = nixpkgs.exa;
  fd = nixpkgs.fd;
  fzf = nixpkgs.fzf;
  gawk = nixpkgs.gawk;
  git-filter-repo = nixpkgs.gitAndTools.git-filter-repo;
  git-lfs = nixpkgs.git-lfs;
  htop = nixpkgs.htop;
  navi = nixpkgs.navi;
  nixfmt = nixpkgs.nixfmt;
  nixpkgs-fmt = nixpkgs.nixpkgs-fmt;
  pandoc = nixpkgs.pandoc;
  ripgrep = nixpkgs.ripgrep;
  shfmt = nixpkgs.shfmt;
  starship = nixpkgs.starship;
  stern = nixpkgs.stern;
  tealdeer = nixpkgs.tealdeer;
  universal-ctags = nixpkgs.universal-ctags;
  unzip = nixpkgs.unzip;
  wget = nixpkgs.wget;
  xclip = nixpkgs.xclip;
}
