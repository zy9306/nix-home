let
  pkgs = import <nixpkgs> { };
  stdenv = pkgs.stdenv;
  fetchFromGitHub = pkgs.fetchFromGitHub;
in {
  i = stdenv.mkDerivation {
    name = "i";
    src = ./.;
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out/bin
      cp ${./i.sh} $out/bin/i
    '';
  };

  s = stdenv.mkDerivation {
    name = "s";
    src = ./.;
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out/bin
      cp ${./s.sh} $out/bin/s
    '';
  };

  # 无法使用，一些程序会报错
  # proxychains-ng = stdenv.mkDerivation rec {
  #   name = "proxychains-ng";
  #   version = "4.14";
  #   src = fetchFromGitHub {
  #     owner = "rofl0r";
  #     repo = "proxychains-ng";
  #     rev = "v${version}";
  #     sha256 = "03wk2xpxwc7kwlq6z9jf9df1vlh6p0dn0kf826fh1k7nfaa8c4py";
  #   };
  # };
}
