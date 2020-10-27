# https://lazamar.co.uk/nix-versions/
# niv add NixOS/nixpkgs -n nixpkgs-unstable -b nixpkgs-unstable
# niv add NixOS/nixpkgs -n nixpkgs-528d35b -r 528d35bec0cb976a06cc0e8487c6e5136400b16b


let
  sources = import ./nix/sources.nix;
  nixpkgs = import sources."nixpkgs-release-20.09" {};
  nixpkgs-unstable = import sources."nixpkgs-unstable" {};
  nixpkgs-528d35b = import sources."nixpkgs-528d35b" {};

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
    nixpkgs.curl
    nixpkgs.wget
    nixpkgs.htop
    nixpkgs.navi
    nixpkgs.tealdeer  # tldr rust impl
    nixpkgs.starship
    nixpkgs.xclip

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
