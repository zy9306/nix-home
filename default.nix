let
  sources = import ./nix/sources.nix;

  nixpkgs = import sources."nixpkgs-release-20.09" { };

  nixpkgs-unstable = import sources."nixpkgs-unstable" { };

  pkgs = import <nixpkgs> { };

  extra = import ./nix-extra;
in { inherit nixpkgs nixpkgs-unstable pkgs extra; }
