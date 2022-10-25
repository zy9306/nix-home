# nix-shell shell.nix

let nixpkgs = import <nixpkgs> { };

in {
  _ = nixpkgs.mkShell {
    nativeBuildInputs = [
      nixpkgs.go_1_18
    ];
  };
}
