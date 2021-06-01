let
  sources = import ./nix/sources.nix;

  nixpkgs = import sources."nixpkgs-unstable" { };

  pkgs = import <nixpkgs> { };

  extra = import ./nix-extra;
  test = import ./test;
in { inherit nixpkgs pkgs extra test; }
