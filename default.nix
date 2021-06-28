let
  sources = import ./nix/sources.nix;

  nixpkgs = import sources."nixpkgs-unstable" { };

  pkgs = import <nixpkgs> { };

in { inherit nixpkgs pkgs ; }
