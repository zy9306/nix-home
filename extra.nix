let
  pkgs = import <nixpkgs> { };
  stdenv = pkgs.stdenv;
in {
  q = stdenv.mkDerivation {
    name = "q";
    src = ./.;
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out/bin
      cp ${./utils/q.sh} $out/bin/q
    '';
  };
}
