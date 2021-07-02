# TODO 

# https://nixos.wiki/wiki/Development_environment_with_nix-shell

let
  sources = import ./nix/sources.nix;

  nixpkgs = import sources."nixpkgs-unstable" { };

  # pkgs = import <nixpkgs> { };

in {
  _ = nixpkgs.mkShell {
    nativeBuildInputs = [
      nixpkgs.python39Full
      nixpkgs.python38Full
      nixpkgs.python37Full
      nixpkgs.python36Full
    ];
  };
}
